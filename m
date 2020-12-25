Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232032E2C08
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 18:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgLYRf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 12:35:58 -0500
Received: from mail-m963.mail.126.com ([123.126.96.3]:54150 "EHLO
        mail-m963.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgLYRf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 12:35:57 -0500
X-Greylist: delayed 38161 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Dec 2020 12:35:56 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=Vn9E15e7ykS2S6ec+4
        W/tpv3fMxhhJsX6GTrHdLZGxw=; b=USDzUqvTG0rEEt1IkIRcebIUVFxHwy5aIN
        1a/p2we0ZOuqKtmDiPESUg2GHw2EKNj9r2JmzifRjbAhs2DFenbg0oNQyAQdmh/J
        YAthet6CPGWEJxujjE15WTx29GijqhxtBKqurY0TVzjwB8Z5R6ZXhSmkr56EFOJh
        c3MegT1+4=
Received: from localhost.localdomain (unknown [36.112.86.14])
        by smtp8 (Coremail) with SMTP id NORpCgCHlaWiheVftx8KBA--.3451S2;
        Fri, 25 Dec 2020 14:24:35 +0800 (CST)
From:   Defang Bo <bodefang@126.com>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Defang Bo <bodefang@126.com>
Subject: [PATCH] drm/amd/display: avoid null pointer dereference in dm_set_vblank
Date:   Fri, 25 Dec 2020 14:24:27 +0800
Message-Id: <1608877467-2270263-1-git-send-email-bodefang@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: NORpCgCHlaWiheVftx8KBA--.3451S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww4kJrWkuw1xuw17JFW7XFb_yoW8Xr1Upr
        s7JFyYqr1UZF1xW3srA3W09r98Kws3Xa48KrW5Cw1aga45Jwn8Cw1rArW2gr47WFWxC3y3
        JFy7AFW3Z3Wq9w7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRpVbPUUUUU=
X-Originating-IP: [36.112.86.14]
X-CM-SenderInfo: pergvwxdqjqiyswou0bp/1tbi6wMG11pD9alAwgAAs+
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Why]
Similar to commit<dddc0557e>("drm/amd/display: Guard against null crtc in CRC IRQ"),
a null pointer deference can occur if crtc is null in
dm_set_vblank.

[How]

Check that CRTC is non-null before accessing its fields.

Signed-off-by: Defang Bo <bodefang@126.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e2b23486..df23d28 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4875,10 +4875,17 @@ static inline int dm_set_vupdate_irq(struct drm_crtc *crtc, bool enable)
 static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 {
 	enum dc_irq_source irq_source;
-	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
-	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
-	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(crtc->state);
+	struct amdgpu_crtc *acrtc;
+	struct amdgpu_device *adev;
+	struct dm_crtc_state *acrtc_state;
 	int rc = 0;
+
+	if (crtc == NULL)
+		return rc;
+
+	acrtc = to_amdgpu_crtc(crtc);
+	adev = drm_to_adev(crtc->dev);
+	acrtc_state = to_dm_crtc_state(crtc->state);
 
 	if (enable) {
 		/* vblank irq on -> Only need vupdate irq in vrr mode */
-- 
2.7.4

