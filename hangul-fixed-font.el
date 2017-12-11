;;; hangul-fixed-font.el --- 한글 고정폭 설정

;; Author: Kukjin Kang <kj.kang@daum.net>
;; Keywords: convenience

;; 영문(Envy Code R)글꼴, 한글(나눔고딕코딩)글꼴의 폭 실험
;;
;; | 한글 | 테스트 |
;; | ABCD | abcdef |

;;; Code:

(require 'seq)
(require 'faces)

(defvar hangul-fixed-font-ascii
  "Envy Code R"
  "영문 글꼴의 이름을 지정한다.")

(defvar hangul-fixed-font-non-ascii
  "NanumGothicCoding for Powerline"
  "한글 글꼴의 이름을 지정한다.")

(defvar hangul-fixed-font-scale-alist
  '((100 . 1.05)
    (110 . 1.10)
    (120 . 1.05)
    (130 . 1.10)
    (140 . 1.15)
    (150 . 1.10)
    (160 . 1.15)
    (170 . 1.10)
    (180 . 1.15)
    (190 . 1.10)
    (200 . 1.10)
    (210 . 1.05)
    (220 . 1.10)
    (230 . 1.05))
  "Non-ascii 글꼴의 스케일을 지정한다.")

(defvar hangul-fixed-font-default-height
  160
  "글꼴의 기본 크기를 지정한다.")


(defun hangul-fixed-font--get-scale (height)
  "글꼴의 크기(HEIGHT)에 따른 글꼴의 스케일을 반환한다."
  (cdr (car (last (seq-take-while (lambda (x) (<= (car x) height)) hangul-fixed-font-scale-alist)))))

(defun hangul-fixed-font--set-height (height)
  "글꼴의 크기(HEIGHT)를 조정한다."
  (let ((scale (hangul-fixed-font--get-scale height)))
    (message
     "Set font - ascii: %s, non-ascii: %s, height: %d, rescale: %f"
     hangul-fixed-font-ascii
     hangul-fixed-font-non-ascii
     height
     scale)
    (set-face-attribute 'default nil :family hangul-fixed-font-ascii)
    (set-fontset-font t 'hangul (font-spec :name hangul-fixed-font-non-ascii))
    (setq face-font-rescale-alist `((,hangul-fixed-font-non-ascii . ,scale)))
    (set-face-attribute 'default nil :height height)))

;;;###autoload
(defun hangul-fixed-font-increase-height ()
  "글꼴의 크기를 한단계(10) 크게 한다."
  (interactive)
  (let ((height (+ (face-attribute 'default :height) 10)))
    (hangul-fixed-font--set-height height)))

;;;###autoload
(defun hangul-fixed-font-decrease-height ()
  "글꼴의 크기를 한단계(10) 작게 한다."
  (interactive)
  (let ((height (- (face-attribute 'default :height) 10)))
    (hangul-fixed-font--set-height height)))

;;;###autoload
(defun hangul-fixed-font-default ()
  "글꼴의 크기를 기본값으로 지정한다."
  (interactive)
  (hangul-fixed-font--set-height hangul-fixed-font-default-height))

(provide 'hangul-fixed-font)

;;; hangul-fixed-font.el ends here
