Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CEA1AE99C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Apr 2020 05:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgDRDUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 23:20:48 -0400
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:20404 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgDRDUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 23:20:48 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.122])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id 53852662D4B;
        Sat, 18 Apr 2020 11:20:45 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] reserve_bo_and_cond_vms: Remove unnecessary condition check
Date:   Fri, 17 Apr 2020 20:20:36 -0700
Message-Id: <1587180037-113840-1-git-send-email-bernard@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVCSE9LS0tLSk5JTkNMQllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OTY6ORw*NDg3Sw4MHzgUIlYI
        N0oKCgFVSlVKTkNMSkNLS09OTkJDVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSUlZV1kIAVlBSUpJTzcG
X-HM-Tid: 0a718b4d84d09373kuws53852662d4b
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to if check again, maybe we could merge
into the above else branch.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 9dff792..327317c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -735,10 +735,8 @@ static int reserve_bo_and_cond_vms(struct kgd_mem *mem,
 				     false, &ctx->duplicates);
 	if (!ret)
 		ctx->reserved = true;
-	else
+	else {
 		pr_err("Failed to reserve buffers in ttm.\n");
-
-	if (ret) {
 		kfree(ctx->vm_pd);
 		ctx->vm_pd = NULL;
 	}
-- 
2.7.4

