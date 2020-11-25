Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273552C420B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 15:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbgKYOSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 09:18:14 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40072 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729847AbgKYOSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 09:18:13 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1khvcU-0001hB-PX; Wed, 25 Nov 2020 14:18:06 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Tao Zhou <tao.zhou1@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amdgpu: Fix sizeof() mismatch in bps_bo kmalloc_array creation
Date:   Wed, 25 Nov 2020 14:18:06 +0000
Message-Id: <20201125141806.1881036-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

An incorrect sizeof() is being used, sizeof((*data)->bps_bo) is not
correct, it should be sizeof(*(*data)->bps_bo).  It just so happens
to work because the sizes are the same.  Fix it.

Addresses-Coverity: ("Sizeof not portable (SIZEOF_MISMATCH)")
Fixes: 5278a159cf35 ("drm/amdgpu: support reserve bad page for virt (v3)")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 2d51b7694d1f..df15d33e3c5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -283,7 +283,7 @@ static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev)
 		return -ENOMEM;
 
 	bps = kmalloc_array(align_space, sizeof((*data)->bps), GFP_KERNEL);
-	bps_bo = kmalloc_array(align_space, sizeof((*data)->bps_bo), GFP_KERNEL);
+	bps_bo = kmalloc_array(align_space, sizeof(*(*data)->bps_bo), GFP_KERNEL);
 
 	if (!bps || !bps_bo) {
 		kfree(bps);
-- 
2.29.2

