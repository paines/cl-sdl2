(in-package :sdl2)

(defun create-rgb-surface (width height depth
                           &key (r-mask 0) (g-mask 0) (b-mask 0) (a-mask 0)
                           (flags 0))
  (sdl-collect
   (sdl-create-rgb-surface flags width height depth
                           r-mask g-mask b-mask a-mask)
   (lambda (s) (sdl-free-surface s))))

(defun create-rgb-surface-from (pixels width height depth pitch
                                &key (r-mask 0) (g-mask 0) (b-mask 0) (a-mask 0))
  (sdl-collect
   (sdl-create-rgb-surface-from pixels width height depth pitch
                                r-mask g-mask b-mask a-mask)
   (lambda (s) (sdl-free-surface s))))

(defun free-surface (surface)
  (sdl-cancel-collect surface)
  (sdl-free-surface surface)
  (invalidate surface))

(defun load-bmp (filename)
  (sdl-collect
   ;; Note, SDL_LoadBMP is a macro in SDL_surface.h that is exactly this
   (sdl-load-bmp-rw (sdl-rw-from-file filename "rb") 1)
   (lambda (s) (sdl-free-surface s))))

(defun convert-surface-format (surface pixel-format &key (flags 0))
  (sdl-collect
   (check-null
    (sdl-convert-surface-format surface
                                (enum-value '(:enum (sdl-pixel-format)) pixel-format)
                                flags))
   (lambda (s) (sdl-free-surface s))))
