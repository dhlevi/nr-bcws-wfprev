import { ComponentFixture, TestBed } from '@angular/core/testing';
import { MatDialog, MatDialogModule } from '@angular/material/dialog';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';
import { MatTableModule } from '@angular/material/table';
import { ProjectFilesComponent } from './project-files.component';
import { ProjectService } from 'src/app/services/project-services';
import { of, throwError } from 'rxjs';
import { AddAttachmentComponent } from 'src/app/components/add-attachment/add-attachment.component';
import { Messages } from 'src/app/utils/messages';

describe('ProjectFilesComponent', () => {
  let component: ProjectFilesComponent;
  let fixture: ComponentFixture<ProjectFilesComponent>;
  let mockProjectService: jasmine.SpyObj<ProjectService>;
  let mockSnackbar: jasmine.SpyObj<MatSnackBar>;
  let mockDialog: jasmine.SpyObj<MatDialog>;

  beforeEach(async () => {
    mockProjectService = jasmine.createSpyObj('ProjectService', ['uploadDocument']);
    mockSnackbar = jasmine.createSpyObj('MatSnackBar', ['open']);
    mockDialog = jasmine.createSpyObj('MatDialog', ['open']);

    await TestBed.configureTestingModule({
      imports: [ProjectFilesComponent, MatTableModule, MatDialogModule, MatSnackBarModule],
      providers: [
        { provide: ProjectService, useValue: mockProjectService },
        { provide: MatSnackBar, useValue: mockSnackbar },
        { provide: MatDialog, useValue: mockDialog },
      ],
    }).compileComponents();

    fixture = TestBed.createComponent(ProjectFilesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create the component', () => {
    expect(component).toBeTruthy();
  });

  it('should have predefined columns', () => {
    expect(component.displayedColumns).toEqual([    'attachmentType',
      'fileName',
      'fileType',
      'uploadedBy',
      'uploadedDate',
      'polygonHectares',
      'description',
      'download',
      'delete']);
  });

  it('should open file upload modal and call uploadFile if a file is selected', () => {
    const mockFile = new File(['content'], 'test-file.txt', { type: 'text/plain' });
    mockDialog.open.and.returnValue({
      afterClosed: () => of({ file: mockFile }),
    } as any);
    
    spyOn(component, 'uploadFile');

    component.openFileUploadModal();
    expect(mockDialog.open).toHaveBeenCalledWith(AddAttachmentComponent, { width: '1000px' });
    expect(component.uploadFile).toHaveBeenCalledWith(mockFile);
  });

  it('should not call uploadFile if modal is closed without a file', () => {
    mockDialog.open.and.returnValue({
      afterClosed: () => of(null), // Simulating modal closed without selecting a file
    } as any);

    spyOn(component, 'uploadFile');

    component.openFileUploadModal();
    expect(mockDialog.open).toHaveBeenCalled();
    expect(component.uploadFile).not.toHaveBeenCalled();
  });

  it('should call projectService.uploadDocument() and show success message on file upload', () => {
    const mockFile = new File(['content'], 'test-file.txt', { type: 'text/plain' });
    mockProjectService.uploadDocument.and.returnValue(of({ success: true }));

    component.uploadFile(mockFile);

    expect(mockProjectService.uploadDocument).toHaveBeenCalledWith({ file: mockFile });
    expect(mockSnackbar.open).toHaveBeenCalledWith(Messages.fileUploadSuccess, 'OK', {
      duration: 5000,
      panelClass: 'snackbar-success',
    });
  });

  it('should handle file upload error', () => {
    const mockFile = new File(['content'], 'test-file.txt', { type: 'text/plain' });
    mockProjectService.uploadDocument.and.returnValue(throwError(() => new Error('Upload failed')));

    component.uploadFile(mockFile);

    expect(mockProjectService.uploadDocument).toHaveBeenCalledWith({ file: mockFile });
    expect(mockSnackbar.open).not.toHaveBeenCalledWith(Messages.fileUploadSuccess, 'OK', jasmine.any(Object));
  });
});
