Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733D72AD1F6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 10:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbgKJJBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 04:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJJBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 04:01:25 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB71C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 01:01:24 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id qZ1M2300X4C55Sk01Z1Moc; Tue, 10 Nov 2020 10:01:22 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kcPWj-0016f1-HT; Tue, 10 Nov 2020 10:01:21 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kcPWi-00BBu9-N3; Tue, 10 Nov 2020 10:01:20 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] drm/fb_helper: Use min_t() to handle size_t and unsigned long
Date:   Tue, 10 Nov 2020 10:01:19 +0100
Message-Id: <20201110090119.2667326-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm32:

    drivers/gpu/drm/drm_fb_helper.c: In function ‘fb_read_screen_base’:
    include/linux/minmax.h:18:28: warning: comparison of distinct pointer types lacks a cast
    ...
    drivers/gpu/drm/drm_fb_helper.c:2041:22: note: in expansion of macro ‘min’
     2041 |  size_t alloc_size = min(count, PAGE_SIZE);
	  |                      ^~~
    drivers/gpu/drm/drm_fb_helper.c: In function ‘fb_write_screen_base’:
    include/linux/minmax.h:18:28: warning: comparison of distinct pointer types lacks a cast
    ...
    drivers/gpu/drm/drm_fb_helper.c:2115:22: note: in expansion of macro ‘min’
     2115 |  size_t alloc_size = min(count, PAGE_SIZE);
	  |                      ^~~

Indeed, on 32-bit size_t is "unsigned int", not "unsigned long".

Fixes: 222ec45f4c69dfa8 ("drm/fb_helper: Support framebuffers in I/O memory")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Interestingly, the commit log claims v7 changed:

    use min_t(size_t,) (kernel test robot)
---
 drivers/gpu/drm/drm_fb_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 01ba1da285116373..25edf670867c6f79 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -2038,7 +2038,7 @@ static ssize_t fb_read_screen_base(struct fb_info *info, char __user *buf, size_
 				   loff_t pos)
 {
 	const char __iomem *src = info->screen_base + pos;
-	size_t alloc_size = min(count, PAGE_SIZE);
+	size_t alloc_size = min_t(size_t, count, PAGE_SIZE);
 	ssize_t ret = 0;
 	int err = 0;
 	char *tmp;
@@ -2112,7 +2112,7 @@ static ssize_t fb_write_screen_base(struct fb_info *info, const char __user *buf
 				    loff_t pos)
 {
 	char __iomem *dst = info->screen_base + pos;
-	size_t alloc_size = min(count, PAGE_SIZE);
+	size_t alloc_size = min_t(size_t, count, PAGE_SIZE);
 	ssize_t ret = 0;
 	int err = 0;
 	u8 *tmp;
-- 
2.25.1

