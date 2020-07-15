Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9B5220209
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 03:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgGOBvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 21:51:45 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:61614 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOBvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 21:51:45 -0400
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 06F1p74Y092199;
        Wed, 15 Jul 2020 10:51:07 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp);
 Wed, 15 Jul 2020 10:51:07 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 06F1p2pR092141
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 15 Jul 2020 10:51:07 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        George Kennedy <george.kennedy@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com>
Subject: [PATCH v2] fbdev: Detect integer underflow at "struct fbcon_ops"->clear_margins.
Date:   Wed, 15 Jul 2020 10:51:02 +0900
Message-Id: <20200715015102.3814-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <adff5d10-fe35-62d4-74c5-182958c5ada7@i-love.sakura.ne.jp>
References: <adff5d10-fe35-62d4-74c5-182958c5ada7@i-love.sakura.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is reporting general protection fault in bitfill_aligned() [1]
caused by integer underflow in bit_clear_margins(). The cause of this
problem is when and how do_vc_resize() updates vc->vc_{cols,rows}.

If vc_do_resize() fails (e.g. kzalloc() fails) when var.xres or var.yres
is going to shrink, vc->vc_{cols,rows} will not be updated. This allows
bit_clear_margins() to see info->var.xres < (vc->vc_cols * cw) or
info->var.yres < (vc->vc_rows * ch). Unexpectedly large rw or bh will
try to overrun the __iomem region and causes general protection fault.

Also, vc_resize(vc, 0, 0) does not set vc->vc_{cols,rows} = 0 due to

  new_cols = (cols ? cols : vc->vc_cols);
  new_rows = (lines ? lines : vc->vc_rows);

exception. Since cols and lines are calculated as

  cols = FBCON_SWAP(ops->rotate, info->var.xres, info->var.yres);
  rows = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
  cols /= vc->vc_font.width;
  rows /= vc->vc_font.height;
  vc_resize(vc, cols, rows);

in fbcon_modechanged(), var.xres < vc->vc_font.width makes cols = 0
and var.yres < vc->vc_font.height makes rows = 0. This means that

  const int fd = open("/dev/fb0", O_ACCMODE);
  struct fb_var_screeninfo var = { };
  ioctl(fd, FBIOGET_VSCREENINFO, &var);
  var.xres = var.yres = 1;
  ioctl(fd, FBIOPUT_VSCREENINFO, &var);

easily reproduces integer underflow bug explained above.

Of course, callers of vc_resize() are not handling vc_do_resize() failure
is bad. But we can't avoid vc_resize(vc, 0, 0) which returns 0. Therefore,
as a band-aid workaround, this patch checks integer underflow in
"struct fbcon_ops"->clear_margins call, assuming that
vc->vc_cols * vc->vc_font.width and vc->vc_rows * vc->vc_font.heigh do not
cause integer overflow.

[1] https://syzkaller.appspot.com/bug?id=a565882df74fa76f10d3a6fec4be31098dbb37c6

Reported-and-tested-by: syzbot <syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/video/fbdev/core/bitblit.c   | 4 ++--
 drivers/video/fbdev/core/fbcon_ccw.c | 4 ++--
 drivers/video/fbdev/core/fbcon_cw.c  | 4 ++--
 drivers/video/fbdev/core/fbcon_ud.c  | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index ca935c09a261..35ebeeccde4d 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -216,7 +216,7 @@ static void bit_clear_margins(struct vc_data *vc, struct fb_info *info,
 	region.color = color;
 	region.rop = ROP_COPY;
 
-	if (rw && !bottom_only) {
+	if ((int) rw > 0 && !bottom_only) {
 		region.dx = info->var.xoffset + rs;
 		region.dy = 0;
 		region.width = rw;
@@ -224,7 +224,7 @@ static void bit_clear_margins(struct vc_data *vc, struct fb_info *info,
 		info->fbops->fb_fillrect(info, &region);
 	}
 
-	if (bh) {
+	if ((int) bh > 0) {
 		region.dx = info->var.xoffset;
 		region.dy = info->var.yoffset + bs;
 		region.width = rs;
diff --git a/drivers/video/fbdev/core/fbcon_ccw.c b/drivers/video/fbdev/core/fbcon_ccw.c
index dfa9a8aa4509..78f3a5621478 100644
--- a/drivers/video/fbdev/core/fbcon_ccw.c
+++ b/drivers/video/fbdev/core/fbcon_ccw.c
@@ -201,7 +201,7 @@ static void ccw_clear_margins(struct vc_data *vc, struct fb_info *info,
 	region.color = color;
 	region.rop = ROP_COPY;
 
-	if (rw && !bottom_only) {
+	if ((int) rw > 0 && !bottom_only) {
 		region.dx = 0;
 		region.dy = info->var.yoffset;
 		region.height = rw;
@@ -209,7 +209,7 @@ static void ccw_clear_margins(struct vc_data *vc, struct fb_info *info,
 		info->fbops->fb_fillrect(info, &region);
 	}
 
-	if (bh) {
+	if ((int) bh > 0) {
 		region.dx = info->var.xoffset + bs;
 		region.dy = 0;
                 region.height = info->var.yres_virtual;
diff --git a/drivers/video/fbdev/core/fbcon_cw.c b/drivers/video/fbdev/core/fbcon_cw.c
index ce08251bfd38..fd098ff17574 100644
--- a/drivers/video/fbdev/core/fbcon_cw.c
+++ b/drivers/video/fbdev/core/fbcon_cw.c
@@ -184,7 +184,7 @@ static void cw_clear_margins(struct vc_data *vc, struct fb_info *info,
 	region.color = color;
 	region.rop = ROP_COPY;
 
-	if (rw && !bottom_only) {
+	if ((int) rw > 0 && !bottom_only) {
 		region.dx = 0;
 		region.dy = info->var.yoffset + rs;
 		region.height = rw;
@@ -192,7 +192,7 @@ static void cw_clear_margins(struct vc_data *vc, struct fb_info *info,
 		info->fbops->fb_fillrect(info, &region);
 	}
 
-	if (bh) {
+	if ((int) bh > 0) {
 		region.dx = info->var.xoffset;
 		region.dy = info->var.yoffset;
                 region.height = info->var.yres;
diff --git a/drivers/video/fbdev/core/fbcon_ud.c b/drivers/video/fbdev/core/fbcon_ud.c
index 1936afc78fec..e165a3fad29a 100644
--- a/drivers/video/fbdev/core/fbcon_ud.c
+++ b/drivers/video/fbdev/core/fbcon_ud.c
@@ -231,7 +231,7 @@ static void ud_clear_margins(struct vc_data *vc, struct fb_info *info,
 	region.color = color;
 	region.rop = ROP_COPY;
 
-	if (rw && !bottom_only) {
+	if ((int) rw > 0 && !bottom_only) {
 		region.dy = 0;
 		region.dx = info->var.xoffset;
 		region.width  = rw;
@@ -239,7 +239,7 @@ static void ud_clear_margins(struct vc_data *vc, struct fb_info *info,
 		info->fbops->fb_fillrect(info, &region);
 	}
 
-	if (bh) {
+	if ((int) bh > 0) {
 		region.dy = info->var.yoffset;
 		region.dx = info->var.xoffset;
                 region.height  = bh;
-- 
2.18.4

