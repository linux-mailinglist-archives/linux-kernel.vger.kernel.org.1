Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2B82E8C7F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 15:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbhACODf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 09:03:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:35872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbhACODe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 09:03:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB6C820C56;
        Sun,  3 Jan 2021 14:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609682574;
        bh=3wcwLP3yhCppf7CmmfZnT9BbP/bxX1BDeFfoAgZD7GE=;
        h=From:To:Cc:Subject:Date:From;
        b=pAcDoGwXTxoLbRuqvjDyDS6otLikwiQMDcc3fODKiZNBVIdSURyBviZh5tjSDBF7K
         8xAOo8d1cVGR7vuCXkZUcfCyTizilb85We8xUkiUFv6t/3oMo4glpbw0LjBjEP1vbg
         /OWW88tRwdwjKHP2GfXw+VRZRY10ez255oYI5FDenFjeDttG5i4nOSbwA360HT4PAt
         +xow4n7CekvVVnSCNER28TiCrgt4dkUGQ9jwSo38efPSG0oc8cO52X4dNMSFLPz9az
         eb8lxL2Zet+qUcrEhqu56CajDJWzrMxzJBopLdACrm7w8w9cpIsblvSPO7FZGSOwPX
         rWht1Y+bvN3Vw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bindu Ramamurthy <bindu.r@amd.com>,
        Wayne Lin <Wayne.Lin@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Simon Ser <contact@emersion.fr>, Eryk Brol <eryk.brol@amd.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Fix unused variable warning
Date:   Sun,  3 Jan 2021 15:02:32 +0100
Message-Id: <20210103140248.3889757-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Some of the newly added code is hidden inside of #ifdef
blocks, but one variable is unused when debugfs is disabled:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8370:8: error: unused variable 'configure_crc' [-Werror,-Wunused-variable]

Change the #ifdef to an if(IS_ENABLED()) check to fix the warning
and avoid adding more #ifdefs.

Fixes: c920888c604d ("drm/amd/display: Expose new CRC window property")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c     | 4 +---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 42b0fdb72e7b..5071b55ad0f6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8379,8 +8379,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			acrtc->dm_irq_params.stream = dm_new_crtc_state->stream;
 			manage_dm_interrupts(adev, acrtc, true);
 		}
-#ifdef CONFIG_DEBUG_FS
-		if (new_crtc_state->active &&
+		if (IS_ENABLED(CONFIG_DEBUG_FS) && new_crtc_state->active &&
 			amdgpu_dm_is_valid_crc_source(dm_new_crtc_state->crc_src)) {
 			/**
 			 * Frontend may have changed so reapply the CRC capture
@@ -8401,7 +8400,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 				amdgpu_dm_crtc_configure_crc_source(
 					crtc, dm_new_crtc_state, dm_new_crtc_state->crc_src);
 		}
-#endif
 	}
 
 	for_each_new_crtc_in_state(state, crtc, new_crtc_state, j)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
index 0235bfb246e5..eba2f1d35d07 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
@@ -46,13 +46,13 @@ static inline bool amdgpu_dm_is_valid_crc_source(enum amdgpu_dm_pipe_crc_source
 }
 
 /* amdgpu_dm_crc.c */
-#ifdef CONFIG_DEBUG_FS
 bool amdgpu_dm_crc_window_is_default(struct dm_crtc_state *dm_crtc_state);
 bool amdgpu_dm_crc_window_changed(struct dm_crtc_state *dm_new_crtc_state,
 					struct dm_crtc_state *dm_old_crtc_state);
 int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 					struct dm_crtc_state *dm_crtc_state,
 					enum amdgpu_dm_pipe_crc_source source);
+#ifdef CONFIG_DEBUG_FS
 int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name);
 int amdgpu_dm_crtc_verify_crc_source(struct drm_crtc *crtc,
 				     const char *src_name,
-- 
2.29.2

