Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523B02ADF64
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731820AbgKJTbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731750AbgKJTbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:31:34 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC8DC0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:32 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id s8so6912175wrw.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ya0KOHBj5YEQtB7YNRLKjFwwnQlrRlrUyTmR5vFE0Ms=;
        b=iM7SQKT+43Kp8b2PREMcIXXq6cm29sGsG50wr3Rsh3aEH7Av9D+TiUBErtQWNcLtXu
         KWhzdxVXzoDCE642pA6rkWKWOcuUB830UwNmIg5rI7bKtD0mRnFHwRZ7AYtu+ctpym6k
         Tv4e4S2Y9b82lfK4juqKqwKn6ajT1oJ7QO9ZuT+GEKDlGc7d7bNzT68wq/W+PlmFdEbR
         2b6Yc1zmKfBSPLgkTMmSM5aamjvOh0AJ0bHPv6XqHaIY0V8EgpCpLUb5UZUY4Bft1GhC
         ydBGXYmD6ryT8HLVarK9aWMLDjremqLMcAuMrtFWZ4saFKoTrAKLg3FgYe17JBQ/UHAr
         3Z6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ya0KOHBj5YEQtB7YNRLKjFwwnQlrRlrUyTmR5vFE0Ms=;
        b=oUIJ/4807WmmmBvjsgSqaZMtaudLqQg+MYlOFYxc/d9i+JO2wubzuZXMrpDNWt9TFu
         h/bew0gyUyjarcyjXuIBaJGBVLDaUFWm/JkGhtE032XWFr91rpAJQeDo3ggAOvKtmdPN
         r7113p18wtVzsPLzhccPSDNijQBweZlKDRD01ga3zkOW3qWKb2SA+xzLUtTE42F7WIS8
         gN2WxqmVCihV6iMCctIudHfFzk60nDU3LYdF5OJbN+g76bTXPPuLvnEzf+aypjTooIsR
         MlSfhiWPp/0LdM6iXqUOwA6VzsKJorAkSsX0I6wcVWFGKe1xpDMwshXlWN4ieXp8OrlC
         DyCw==
X-Gm-Message-State: AOAM531g00bGqD7SCU3rJPyPMACyUrWVCSeZh0PscKi01vG0ntO11k6j
        G4rexEU4A8wwNpfeHMuQg/ozZg==
X-Google-Smtp-Source: ABdhPJzP382XBH1NlAJ6O36K2rNNiQPeQjUJa8rCP8i63Tc/A5HrIVfu8F0b1lnD1ViMjslg5lYE7w==
X-Received: by 2002:adf:f644:: with SMTP id x4mr26076211wrp.5.1605036691550;
        Tue, 10 Nov 2020 11:31:31 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:31:30 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 12/30] drm/radeon/radeon_dp_mst: Remove unused variable 'ret' from radeon_mst_encoder_dpms()
Date:   Tue, 10 Nov 2020 19:30:54 +0000
Message-Id: <20201110193112.988999-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110193112.988999-1-lee.jones@linaro.org>
References: <20201110193112.988999-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/radeon_dp_mst.c: In function ‘radeon_mst_encoder_dpms’:
 drivers/gpu/drm/radeon/radeon_dp_mst.c:366:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/radeon_dp_mst.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_dp_mst.c b/drivers/gpu/drm/radeon/radeon_dp_mst.c
index 008308780443c..2c32186c4acd9 100644
--- a/drivers/gpu/drm/radeon/radeon_dp_mst.c
+++ b/drivers/gpu/drm/radeon/radeon_dp_mst.c
@@ -363,7 +363,7 @@ radeon_mst_encoder_dpms(struct drm_encoder *encoder, int mode)
 	struct radeon_connector *radeon_connector;
 	struct drm_crtc *crtc;
 	struct radeon_crtc *radeon_crtc;
-	int ret, slots;
+	int slots;
 	s64 fixed_pbn, fixed_pbn_per_slot, avg_time_slots_per_mtp;
 	if (!ASIC_IS_DCE5(rdev)) {
 		DRM_ERROR("got mst dpms on non-DCE5\n");
@@ -418,10 +418,10 @@ radeon_mst_encoder_dpms(struct drm_encoder *encoder, int mode)
 
 		slots = drm_dp_find_vcpi_slots(&radeon_connector->mst_port->mst_mgr,
 					       mst_enc->pbn);
-		ret = drm_dp_mst_allocate_vcpi(&radeon_connector->mst_port->mst_mgr,
-					       radeon_connector->port,
-					       mst_enc->pbn, slots);
-		ret = drm_dp_update_payload_part1(&radeon_connector->mst_port->mst_mgr);
+		drm_dp_mst_allocate_vcpi(&radeon_connector->mst_port->mst_mgr,
+					 radeon_connector->port,
+					 mst_enc->pbn, slots);
+		drm_dp_update_payload_part1(&radeon_connector->mst_port->mst_mgr);
 
 		radeon_dp_mst_set_be_cntl(primary, mst_enc,
 					  radeon_connector->mst_port->hpd.hpd, true);
@@ -436,9 +436,9 @@ radeon_mst_encoder_dpms(struct drm_encoder *encoder, int mode)
 
 		atombios_dig_encoder_setup2(&primary->base, ATOM_ENCODER_CMD_DP_VIDEO_ON, 0,
 					    mst_enc->fe);
-		ret = drm_dp_check_act_status(&radeon_connector->mst_port->mst_mgr);
+		drm_dp_check_act_status(&radeon_connector->mst_port->mst_mgr);
 
-		ret = drm_dp_update_payload_part2(&radeon_connector->mst_port->mst_mgr);
+		drm_dp_update_payload_part2(&radeon_connector->mst_port->mst_mgr);
 
 		break;
 	case DRM_MODE_DPMS_STANDBY:
@@ -450,7 +450,7 @@ radeon_mst_encoder_dpms(struct drm_encoder *encoder, int mode)
 			return;
 
 		drm_dp_mst_reset_vcpi_slots(&radeon_connector->mst_port->mst_mgr, mst_enc->port);
-		ret = drm_dp_update_payload_part1(&radeon_connector->mst_port->mst_mgr);
+		drm_dp_update_payload_part1(&radeon_connector->mst_port->mst_mgr);
 
 		drm_dp_check_act_status(&radeon_connector->mst_port->mst_mgr);
 		/* and this can also fail */
-- 
2.25.1

