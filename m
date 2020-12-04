Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554F12CF261
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbgLDQwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 11:52:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:58270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729906AbgLDQwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:52:13 -0500
From:   Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        John Clements <john.clements@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: fw_attestation: fix unused function warning
Date:   Fri,  4 Dec 2020 17:51:20 +0100
Message-Id: <20201204165128.3747878-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Without debugfs, the compiler notices one function that is not used at
all:

drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c:123:12: error: unused function 'amdgpu_is_fw_attestation_supported' [-Werror,-Wunused-function]

In fact the static const amdgpu_fw_attestation_debugfs_ops structure is
also unused here, but that warning is currently disabled.

Removing the #ifdef check does the right thing and leads to all of this
code to be dropped without warning.

Fixes: 19ae333001b3 ("drm/amdgpu: added support for psp fw attestation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
index e47bca1c7635..7c6e02e35573 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
@@ -130,7 +130,6 @@ static int amdgpu_is_fw_attestation_supported(struct amdgpu_device *adev)
 
 void amdgpu_fw_attestation_debugfs_init(struct amdgpu_device *adev)
 {
-#if defined(CONFIG_DEBUG_FS)
 	if (!amdgpu_is_fw_attestation_supported(adev))
 		return;
 
@@ -139,5 +138,4 @@ void amdgpu_fw_attestation_debugfs_init(struct amdgpu_device *adev)
 			    adev_to_drm(adev)->primary->debugfs_root,
 			    adev,
 			    &amdgpu_fw_attestation_debugfs_ops);
-#endif
 }
-- 
2.27.0

