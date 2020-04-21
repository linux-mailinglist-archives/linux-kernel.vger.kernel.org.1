Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7A61B1C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 04:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgDUCmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 22:42:13 -0400
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:26947 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgDUCmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 22:42:12 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.122])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id CAD0E664EC6;
        Tue, 21 Apr 2020 10:42:05 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH V2] amdgpu: remove unnecessary condition check
Date:   Mon, 20 Apr 2020 19:41:59 -0700
Message-Id: <20200421024159.126753-1-bernard@vivo.com>
X-Mailer: git-send-email 2.26.2
Reply-To: 1587180037-113840-1-git-send-email-bernard@vivo.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZTlVPT05LS0tKTEpNTUpIQ1lXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6K006Kgw6KTgrFgMtAk4qCS5J
        ETpPCS9VSlVKTkNMT0hNQklCSUhIVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSUlZV1kIAVlBSUJDTjcG
X-HM-Tid: 0a719a9d34659373kuwscad0e664ec6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to if check again, maybe we could merge
into the above else branch.

Signed-off-by: Bernard Zhao <bernard@vivo.com>

---
Changes since V1:
*commit message improve
*code style refactoring

Link for V1:
* https://lore.kernel.org/patchwork/patch/1226587/
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 9dff792c9290..a64eeb07bec4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -660,13 +660,15 @@ static int reserve_bo_and_vm(struct kgd_mem *mem,
 
 	ret = ttm_eu_reserve_buffers(&ctx->ticket, &ctx->list,
 				     false, &ctx->duplicates);
-	if (!ret)
-		ctx->reserved = true;
-	else {
+
+	if (ret) {
 		pr_err("Failed to reserve buffers in ttm\n");
 		kfree(ctx->vm_pd);
 		ctx->vm_pd = NULL;
 	}
+	else {
+		ctx->reserved = true;
+	}
 
 	return ret;
 }
@@ -733,15 +735,15 @@ static int reserve_bo_and_cond_vms(struct kgd_mem *mem,
 
 	ret = ttm_eu_reserve_buffers(&ctx->ticket, &ctx->list,
 				     false, &ctx->duplicates);
-	if (!ret)
-		ctx->reserved = true;
-	else
-		pr_err("Failed to reserve buffers in ttm.\n");
 
 	if (ret) {
+		pr_err("Failed to reserve buffers in ttm.\n");
 		kfree(ctx->vm_pd);
 		ctx->vm_pd = NULL;
 	}
+	else {
+		ctx->reserved = true;
+	}
 
 	return ret;
 }
-- 
2.26.2

