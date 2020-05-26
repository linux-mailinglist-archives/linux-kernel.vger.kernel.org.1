Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED271B9FAF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 11:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgD0JUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 05:20:14 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:31132 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726434AbgD0JUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 05:20:14 -0400
Received: from localhost.localdomain ([92.148.159.11])
        by mwinf5d75 with ME
        id XlL5220090F2omL03lL5VT; Mon, 27 Apr 2020 11:20:12 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 27 Apr 2020 11:20:12 +0200
X-ME-IP: 92.148.159.11
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     b.zolnierkie@samsung.com, gregkh@linuxfoundation.org,
        kstewart@linuxfoundation.org, tglx@linutronix.de, arnd@arndb.de,
        jani.nikula@intel.com, akpm@osdl.org, adaplas@pol.net,
        rpurdie@rpsys.net
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] video: fbdev: w100fb: Fix a potential double free.
Date:   Mon, 27 Apr 2020 11:19:45 +0200
Message-Id: <20200427091945.57534-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some memory is vmalloc'ed in the 'suspend' function and freed in the
'resume' function.
However, it is also freed in the remove function.

In order to avoid a potential double free, set the corresponding pointer
to NULL once freed in the 'resume' function.

Fixes: aac51f09d96a ("[PATCH] w100fb: Rewrite for platform independence")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/video/fbdev/w100fb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/w100fb.c b/drivers/video/fbdev/w100fb.c
index 2d6e2738b792..d96ab28f8ce4 100644
--- a/drivers/video/fbdev/w100fb.c
+++ b/drivers/video/fbdev/w100fb.c
@@ -588,6 +588,7 @@ static void w100fb_restore_vidmem(struct w100fb_par *par)
 		memsize=par->mach->mem->size;
 		memcpy_toio(remapped_fbuf + (W100_FB_BASE-MEM_WINDOW_BASE), par->saved_extmem, memsize);
 		vfree(par->saved_extmem);
+		par->saved_extmem = NULL;
 	}
 	if (par->saved_intmem) {
 		memsize=MEM_INT_SIZE;
@@ -596,6 +597,7 @@ static void w100fb_restore_vidmem(struct w100fb_par *par)
 		else
 			memcpy_toio(remapped_fbuf + (W100_FB_BASE-MEM_WINDOW_BASE), par->saved_intmem, memsize);
 		vfree(par->saved_intmem);
+		par->saved_intmem = NULL;
 	}
 }
 
-- 
2.25.1

