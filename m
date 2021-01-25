Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E39F30252E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 13:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbhAYMyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 07:54:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:39976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728368AbhAYMtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:49:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CA5022242;
        Mon, 25 Jan 2021 12:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611578935;
        bh=se/FbQzcYysZD1EUhPOo2TaDIwNovBNtkDv0eXU7IjM=;
        h=From:To:Cc:Subject:Date:From;
        b=tOVJ4eqUv2zP/nYVpAo9hE/5oML2JQ3sukeCtcxh2TFGxUbLiVgsQdjAStlse5uIv
         y20U37xqi0PqnPh2CdB85vTeLa20ONJ7Whj2l6ieJ2uBMe5+oxfAIKAzaXuKuMUBf7
         eG+JSnIIcfRMb6yGebqoOK6xPXZmVMEUlPAzxzzO1l1htyPbRp0y2ew9cCUq98002O
         8gRoNVY00FEOFcryKke37/qp9ZTVnA76pUmeDBucC2iWB/7tgIIYdyjFjXdWe5elhD
         cAxnue7V35+6PoW5nYtatrPwXYGcowhky+3NWK9V6n9+dldGZCre4xKaaBHsn780EE
         EDVr/k2qcqpHA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Simon Ser <contact@emersion.fr>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: fix unused variable warning
Date:   Mon, 25 Jan 2021 13:48:43 +0100
Message-Id: <20210125124849.102037-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

After all users of the 'dm' warnings got hidden in an #ifdef,
the compiler started warning about it being unused:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5380:33: error: unused variable 'dm' [-Werror,-Wunused-variable]

Add another such #ifdef.

Fixes: 98ab5f3513f9 ("drm/amd/display: Fix deadlock during gpu reset v3")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a90dc4d31c32..37bf2dd87e1e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5377,7 +5377,9 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
 	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(crtc->state);
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 	struct amdgpu_display_manager *dm = &adev->dm;
+#endif
 	int rc = 0;
 
 	if (enable) {
-- 
2.29.2

