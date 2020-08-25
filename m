Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB307251E5D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 19:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgHYReR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 13:34:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45944 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgHYReD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 13:34:03 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kAcpa-0003xk-Fg; Tue, 25 Aug 2020 17:33:59 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/radeon: Prefer lower feedback dividers
Date:   Wed, 26 Aug 2020 01:33:48 +0800
Message-Id: <20200825173349.24580-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2e26ccb119bd ("drm/radeon: prefer lower reference dividers")
fixed screen flicker for HP Compaq nx9420 but breaks other laptops like
Asus X50SL.

Turns out we also need to favor lower feedback dividers.

Users confirmed this change fixes the regression and doesn't regress the
original fix.

Fixes: 2e26ccb119bd ("drm/radeon: prefer lower reference dividers")
BugLink: https://bugs.launchpad.net/bugs/1791312
BugLink: https://bugs.launchpad.net/bugs/1861554
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/gpu/drm/radeon/radeon_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index e0ae911ef427..7b69d6dfe44a 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -933,7 +933,7 @@ static void avivo_get_fb_ref_div(unsigned nom, unsigned den, unsigned post_div,
 
 	/* get matching reference and feedback divider */
 	*ref_div = min(max(den/post_div, 1u), ref_div_max);
-	*fb_div = DIV_ROUND_CLOSEST(nom * *ref_div * post_div, den);
+	*fb_div = max(nom * *ref_div * post_div / den, 1u);
 
 	/* limit fb divider to its maximum */
 	if (*fb_div > fb_div_max) {
-- 
2.17.1

