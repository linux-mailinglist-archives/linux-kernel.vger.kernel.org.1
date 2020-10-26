Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0631F29973D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 20:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgJZTmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 15:42:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbgJZTmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:42:01 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D49820878;
        Mon, 26 Oct 2020 19:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603741320;
        bh=mIfaVETSabg91MwqbVtm2b4ynodCXFlMtwDnztI5meU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zv4bVSycCE8I2wHh1gwb5oj3EdCQ0US/CCzuSG9f52ClGLEW8+82mpR63xjohRAnm
         45GEtSA/kKAJW8n3bvLoISe7XUN4l2wy7rtqwo36g69yM6UJekGHH8K3VnckFIWxgA
         ig/wrXSqTSpEEqDbH/qwMlK74EglUUjR8u5+ArEE=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stefan Christ <contact@stefanchrist.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emil Velikov <emil.velikov@collabora.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] drm/gma500: avoid Woverride-init warning
Date:   Mon, 26 Oct 2020 20:41:04 +0100
Message-Id: <20201026194110.3817470-4-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201026194110.3817470-1-arnd@kernel.org>
References: <20201026194110.3817470-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc -Wextra notices that one of the fields in psbfb_roll_ops has two
initializers:

drivers/gpu/drm/gma500/framebuffer.c:185:20: warning: initialized field overwritten [-Woverride-init]

Open-code this instead, leaving out the extraneous initializers for
.fb_pan_display.

Fixes: 3da6c2f3b730 ("drm/gma500: use DRM_FB_HELPER_DEFAULT_OPS for fb_ops")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/gma500/framebuffer.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
index 54d9876b5305..a56a6b53fac6 100644
--- a/drivers/gpu/drm/gma500/framebuffer.c
+++ b/drivers/gpu/drm/gma500/framebuffer.c
@@ -177,7 +177,14 @@ static const struct fb_ops psbfb_ops = {
 
 static const struct fb_ops psbfb_roll_ops = {
 	.owner = THIS_MODULE,
-	DRM_FB_HELPER_DEFAULT_OPS,
+	.fb_check_var = drm_fb_helper_check_var,
+	.fb_set_par = drm_fb_helper_set_par,
+	.fb_setcmap = drm_fb_helper_setcmap,
+	.fb_blank = drm_fb_helper_blank,
+	.fb_debug_enter = drm_fb_helper_debug_enter,
+	.fb_debug_leave = drm_fb_helper_debug_leave,
+	.fb_ioctl = drm_fb_helper_ioctl,
+
 	.fb_setcolreg = psbfb_setcolreg,
 	.fb_fillrect = drm_fb_helper_cfb_fillrect,
 	.fb_copyarea = drm_fb_helper_cfb_copyarea,
-- 
2.27.0

