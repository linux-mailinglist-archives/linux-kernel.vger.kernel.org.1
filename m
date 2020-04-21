Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F791B1FF2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 09:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgDUHgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 03:36:35 -0400
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:57894 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgDUHge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 03:36:34 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.122])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id 791136662A9;
        Tue, 21 Apr 2020 15:36:28 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH V4] amdgpu: reduce no need mutex_lock area
Date:   Tue, 21 Apr 2020 00:36:21 -0700
Message-Id: <20200421073621.129690-1-bernard@vivo.com>
X-Mailer: git-send-email 2.26.2
Reply-To: 1587181464-114215-1-git-send-email-bernard@vivo.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZTlVIS01LS0tJSElNQk1OSFlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PyI6Fww6SDgrGgNPSDcpMAhO
        OA4wChZVSlVKTkNMT05PTkJKTE1JVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSUlZV1kIAVlBSU5MTzcG
X-HM-Tid: 0a719baab7039373kuws791136662a9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe we could reduce the mutex_lock(&mem->lock)`s protected code area,
and no need to protect pr_debug.

Signed-off-by: Bernard Zhao <bernard@vivo.com>

Changes since V1:
*commit message improve

Changes since V2:
*move comment along with the mutex_unlock

Changes since V3:
*lock protect the if check, there is some possibility of multi-threaded
 racing modify.

Link for V1:
*https://lore.kernel.org/patchwork/patch/1226588/
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 327317c54f7c..549bdb429883 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1289,9 +1289,9 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	mutex_lock(&mem->lock);
 
 	if (mem->mapped_to_gpu_memory > 0) {
+		mutex_unlock(&mem->lock);
 		pr_debug("BO VA 0x%llx size 0x%lx is still mapped.\n",
 				mem->va, bo_size);
-		mutex_unlock(&mem->lock);
 		return -EBUSY;
 	}
 
-- 
2.26.2

