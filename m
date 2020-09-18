Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2DD26F9EF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 12:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgIRKJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 06:09:56 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:56663 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgIRKJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:09:52 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N7zRz-1kXDZn1yT5-014yxk; Fri, 18 Sep 2020 12:09:40 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-fbdev@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, hch@lst.de,
        linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/3] fbdev: sbuslib: remove unused FBIOSCURSOR32 helper
Date:   Fri, 18 Sep 2020 12:09:05 +0200
Message-Id: <20200918100926.1447563-2-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200918100812.1447443-1-arnd@arndb.de>
References: <20200918100812.1447443-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zCEZ1DycMvsb//ALcfn5m89NQWj8AUckAwk5TZ8BBN3FNirqRm1
 lHkrRcm1EpL6KtxGvKFg+cKHBbEOiUl+RwkmjXDwLNiBHJ6GxRfDmvvVyixB+3ZgVwFbYvv
 epSrQtR1L1KwUaxXQhS9w5GYuDF1WCu7zyoGC+7m9c8UXq8rxYlKNMQ722i18Xt4g30PpiA
 aHdSceSI8Y3V+gd/RuJgA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:O8xRHO8ssQs=:3Ay+gv9UrlDdmWrSzpvOGd
 2uCUpDfbuHTkpKbJUWEcwNeQ7jtB37wO5lbSiECXgcYb+ksIXyg1By8Aofye55hG0WyCG6Dbl
 2OBkV/bG3CerC0rF3KhoaQBNZdfcUew0oMuyfkjeFRZPegHMmcUgyiF9or50TGWBjvtSIhi08
 ShJCV6H9L7nxrnddcWnJ7zJEriYZYS7RSB6IWnQCblBf7Nc5Xy/lJwIGSmJm4v/n1V+v/0R3k
 PD8GybkRD9AZxFRfAG3QmU+AGBSyDaGKKvDm+0TvXpY/Z9eYw1ypOUjmCf5PxJgFW3KfNksac
 fZmN1HHNU8FWzXe7OlhU8YLn57yuJ2OErIgpyeJYBPZ9P4tja+mUluWoO3G+ADG7Z1hnDBnzw
 syR3xrZIvoXd3mmN9C4vVWmKbSMMihbIvHo3N27HuHxceX622TMYy7ftgZiE1d7ICeLld4bx9
 FsumIZRMTsUSxLJ1wx6GS91Zk5IYDkD4oJQIIjnyFC5w25mR8eqKC5SFBGoA4VbLAwPczJrIh
 9zwKfvwKfTBWEjwU1ImDTAorP60m1jV/A6zhK+zqCcVpdpYWjz4hcWia/m5A9JmGxuEpMNlnC
 7sY1MlszJKFBX8RrC7xaYq3m4sydFuSnLWZK6fbzMjuGSBRW7TZS9/vw9tvuUSzc85wI8uhzN
 YAPtmihVGxkjwGY6QVyQ2v6lgOggVqr/lFsRMNkxWcy8Nu6SxJi61qYBe3dTWj5ZBqdO1dbyZ
 0dgLKIQt67ZYPQYnZy46NaWRb3uIkWuEYKVcKD3ess0Jg2GkuT3bUmPeTcLVFS+mbgh/nSJDR
 p6fVE4fh/KsI5h41v60BdLlJZERIt4tKIqoLqe1NBDrsVuOIpQ3QjUZoBV3psxXebVQmGmR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No driver implements FBIOSCURSOR, so this function has no purpose
and can be removed. Apparently it was added in linux-2.1.44 to handle
compatibility for drivers/sbus/char/sunfb.c but lost its purpose when
that driver got rewritten in linux-2.5.63.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/sbuslib.c | 29 +----------------------------
 1 file changed, 1 insertion(+), 28 deletions(-)

diff --git a/drivers/video/fbdev/sbuslib.c b/drivers/video/fbdev/sbuslib.c
index 01a7110e61a7..f728db9bcff8 100644
--- a/drivers/video/fbdev/sbuslib.c
+++ b/drivers/video/fbdev/sbuslib.c
@@ -214,32 +214,6 @@ static int fbiogetputcmap(struct fb_info *info, unsigned int cmd, unsigned long
 			(unsigned long)p);
 }
 
-static int fbiogscursor(struct fb_info *info, unsigned long arg)
-{
-	struct fbcursor __user *p = compat_alloc_user_space(sizeof(*p));
-	struct fbcursor32 __user *argp =  (void __user *)arg;
-	compat_uptr_t addr;
-	int ret;
-
-	ret = copy_in_user(p, argp,
-			      2 * sizeof (short) + 2 * sizeof(struct fbcurpos));
-	ret |= copy_in_user(&p->size, &argp->size, sizeof(struct fbcurpos));
-	ret |= copy_in_user(&p->cmap, &argp->cmap, 2 * sizeof(int));
-	ret |= get_user(addr, &argp->cmap.red);
-	ret |= put_user(compat_ptr(addr), &p->cmap.red);
-	ret |= get_user(addr, &argp->cmap.green);
-	ret |= put_user(compat_ptr(addr), &p->cmap.green);
-	ret |= get_user(addr, &argp->cmap.blue);
-	ret |= put_user(compat_ptr(addr), &p->cmap.blue);
-	ret |= get_user(addr, &argp->mask);
-	ret |= put_user(compat_ptr(addr), &p->mask);
-	ret |= get_user(addr, &argp->image);
-	ret |= put_user(compat_ptr(addr), &p->image);
-	if (ret)
-		return -EFAULT;
-	return info->fbops->fb_ioctl(info, FBIOSCURSOR, (unsigned long)p);
-}
-
 int sbusfb_compat_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 {
 	switch (cmd) {
@@ -248,6 +222,7 @@ int sbusfb_compat_ioctl(struct fb_info *info, unsigned int cmd, unsigned long ar
 	case FBIOGATTR:
 	case FBIOSVIDEO:
 	case FBIOGVIDEO:
+	case FBIOSCURSOR32:
 	case FBIOGCURSOR32:	/* This is not implemented yet.
 				   Later it should be converted... */
 	case FBIOSCURPOS:
@@ -258,8 +233,6 @@ int sbusfb_compat_ioctl(struct fb_info *info, unsigned int cmd, unsigned long ar
 		return fbiogetputcmap(info, cmd, arg);
 	case FBIOGETCMAP32:
 		return fbiogetputcmap(info, cmd, arg);
-	case FBIOSCURSOR32:
-		return fbiogscursor(info, arg);
 	default:
 		return -ENOIOCTLCMD;
 	}
-- 
2.27.0

