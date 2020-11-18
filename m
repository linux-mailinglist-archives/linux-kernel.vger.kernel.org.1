Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8502B7469
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 03:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgKRCzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 21:55:15 -0500
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:16459 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgKRCzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 21:55:13 -0500
Received: from ubuntu.localdomain (unknown [112.80.34.205])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id DD1734E16BE;
        Wed, 18 Nov 2020 10:55:09 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Monk Liu <Monk.Liu@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Yintian Tao <yttao@amd.com>, Dennis Li <Dennis.Li@amd.com>,
        Wenhui Sheng <Wenhui.Sheng@amd.com>,
        chen gong <curry.gong@amd.com>,
        Bokun Zhang <Bokun.Zhang@amd.com>,
        "Stanley.Yang" <Stanley.Yang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] amd/amdgpu: use kmalloc_array to replace kmalloc with multiply
Date:   Tue, 17 Nov 2020 18:55:01 -0800
Message-Id: <20201118025503.102699-1-bernard@vivo.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHUxCS0geH0lCTEIfVkpNS05NTUNKSktPSEhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nww6Kww6Kj8hKw8#SjI0Sy4Q
        TCNPFCpVSlVKTUtOTU1DSkpLQ05NVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKSklV
        Q0tVSE9VSUtOWVdZCAFZQUlCTk43Bg++
X-HM-Tid: 0a75d946ff7f9376kuwsdd1734e16be
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix check_patch.pl warning:
WARNING: Prefer kmalloc_array over kmalloc with multiply
+bps = kmalloc(align_space * sizeof((*data)->bps), GFP_KERNEL);
WARNING: Prefer kmalloc_array over kmalloc with multiply
+bps_bo = kmalloc(align_space * sizeof((*data)->bps_bo),
GFP_KERNEL);
kmalloc_array has multiply overflow check, which will be safer.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index d0aea5e39531..f2a0851c804f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -280,8 +280,8 @@ static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev)
 	if (!*data)
 		return -ENOMEM;
 
-	bps = kmalloc(align_space * sizeof((*data)->bps), GFP_KERNEL);
-	bps_bo = kmalloc(align_space * sizeof((*data)->bps_bo), GFP_KERNEL);
+	bps = kmalloc_array(align_space, sizeof((*data)->bps), GFP_KERNEL);
+	bps_bo = kmalloc_array(align_space, sizeof((*data)->bps_bo), GFP_KERNEL);
 
 	if (!bps || !bps_bo) {
 		kfree(bps);
-- 
2.29.0

