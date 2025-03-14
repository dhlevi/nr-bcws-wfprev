package ca.bc.gov.nrs.wfprev.common.types;

import org.hibernate.type.descriptor.WrapperOptions;
import org.hibernate.type.descriptor.java.JavaType;
import org.hibernate.type.descriptor.jdbc.BasicBinder;
import org.hibernate.type.descriptor.jdbc.BasicExtractor;
import org.hibernate.type.descriptor.jdbc.JdbcType;
import org.postgresql.geometric.PGpolygon;
import org.postgresql.util.PGobject;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;

public class PostgresPolygonType implements JdbcType {
    private static final String POLYGON = "polygon";

    @Override
    public int getJdbcTypeCode() {
        return Types.OTHER;
    }

    @Override
    public <T> BasicBinder<T> getBinder(JavaType<T> javaType) {
        return new BasicBinder<>(javaType, this) {
            @Override
            protected void doBind(PreparedStatement st, T value, int index, WrapperOptions options) throws SQLException {
                if (value instanceof PGpolygon polygon) {
                    PGobject pgo = new PGobject();
                    pgo.setType(POLYGON);
                    pgo.setValue(polygon.getValue());
                    st.setObject(index, pgo);
                } else {
                    st.setNull(index, Types.OTHER);
                }
            }

            @Override
            protected void doBind(CallableStatement st, T value, String name, WrapperOptions options) throws SQLException {
                if (value instanceof PGpolygon polygon) {
                    PGobject pgo = new PGobject();
                    pgo.setType(POLYGON);
                    pgo.setValue(polygon.getValue());
                    st.setObject(name, pgo);
                } else {
                    st.setNull(name, Types.OTHER);
                }
            }
        };
    }

    @Override
    public <T> BasicExtractor<T> getExtractor(JavaType<T> javaType) {
        return new BasicExtractor<>(javaType, this) {
            @Override
            protected T doExtract(ResultSet rs, int index, WrapperOptions options) throws SQLException {
                if (rs != null && rs.getObject(index) != null
                        && rs.getObject(index) instanceof PGobject pgObj && POLYGON.equals(pgObj.getType())) {
                    return javaType.wrap(new PGpolygon(pgObj.getValue()), options);
                }
                return null;
            }

            @Override
            protected T doExtract(CallableStatement statement, int index, WrapperOptions options) throws SQLException {
                if (statement != null && statement.getObject(index) !=null
                        && statement.getObject(index) instanceof PGobject pgObj && POLYGON.equals(pgObj.getType())) {
                    return javaType.wrap(new PGpolygon(pgObj.getValue()), options);
                }
                return null;
            }

            @Override
            protected T doExtract(CallableStatement statement, String name, WrapperOptions options) throws SQLException {
                if (statement != null && statement.getObject(name) != null
                        && statement.getObject(name) instanceof PGobject pgObj && POLYGON.equals(pgObj.getType())) {
                    return javaType.wrap(new PGpolygon(pgObj.getValue()), options);
                }
                return null;
            }
        };
    }
}