Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8972B7461
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 03:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgKRCwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 21:52:23 -0500
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:3003 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgKRCwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 21:52:23 -0500
X-Greylist: delayed 576 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Nov 2020 21:52:22 EST
Received: from ubuntu.localdomain (unknown [157.0.31.124])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 2449D4E12BC;
        Wed, 18 Nov 2020 10:42:44 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        Bernard Zhao <bernard@vivo.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH] amdgpu/amdgpu_ids: fix kmalloc_array not uses number as first arg
Date:   Tue, 17 Nov 2020 18:42:29 -0800
Message-Id: <20201118024234.102485-1-bernard@vivo.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSkhDSUkdGU5CT0gdVkpNS05NTUxITU9PSUpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P1E6Egw*Sz8fGQ8#Sw0qIRYO
        Ax0KCR1VSlVKTUtOTU1MSE1PQkNIVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSU9ZV1kIAVlBSU9KTjcG
X-HM-Tid: 0a75d93b9e0c9376kuws2449d4e12bc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix check_patch.pl warning:
kmalloc_array uses number as first arg, sizeof is generally wrong.
+fences = kmalloc_array(sizeof(void *), id_mgr->num_ids,
GFP_KERNEL);

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 6e9a9e5dbea0..f2bd4b0e06f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -208,7 +208,7 @@ static int amdgpu_vmid_grab_idle(struct amdgpu_vm *vm,
 	if (ring->vmid_wait && !dma_fence_is_signaled(ring->vmid_wait))
 		return amdgpu_sync_fence(sync, ring->vmid_wait);
 
-	fences = kmalloc_array(sizeof(void *), id_mgr->num_ids, GFP_KERNEL);
+	fences = kmalloc_array(id_mgr->num_ids, sizeof(void *), GFP_KERNEL);
 	if (!fences)
 		return -ENOMEM;
 
-- 
2.29.0

