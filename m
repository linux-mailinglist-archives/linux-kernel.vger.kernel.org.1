Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C362C03B6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 11:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgKWKyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 05:54:21 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40618 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbgKWKyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 05:54:21 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kh9U9-0004UE-89; Mon, 23 Nov 2020 10:54:17 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        Chengming Gui <Jack.Gui@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/powerplay: fix spelling mistake "smu_state_memroy_block" -> "smu_state_memory_block"
Date:   Mon, 23 Nov 2020 10:54:17 +0000
Message-Id: <20201123105417.198314-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The struct name smu_state_memroy_block contains a spelling mistake, rename
it to smu_state_memory_block

Fixes: 8554e67d6e22 ("drm/amd/powerplay: implement power_dpm_state sys interface for SMU11")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 7550757cc059..a559ea2204c1 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -99,7 +99,7 @@ struct smu_state_display_block {
 	bool              enable_vari_bright;
 };
 
-struct smu_state_memroy_block {
+struct smu_state_memory_block {
 	bool              dll_off;
 	uint8_t                 m3arb;
 	uint8_t                 unused[3];
@@ -146,7 +146,7 @@ struct smu_power_state {
 	struct smu_state_validation_block             validation;
 	struct smu_state_pcie_block                   pcie;
 	struct smu_state_display_block                display;
-	struct smu_state_memroy_block                 memory;
+	struct smu_state_memory_block                 memory;
 	struct smu_state_software_algorithm_block     software;
 	struct smu_uvd_clocks                         uvd_clocks;
 	struct smu_hw_power_state                     hardware;
-- 
2.28.0

