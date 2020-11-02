Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26A52A2367
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 04:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgKBDOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 22:14:35 -0500
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:40956 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbgKBDOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 22:14:34 -0500
Received: from ubuntu.localdomain (unknown [58.213.83.157])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id 4A8E148293A;
        Mon,  2 Nov 2020 11:14:30 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Xiaojie Yuan <xiaojie.yuan@amd.com>,
        Changfeng <Changfeng.Zhu@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] drm/amd: move DRM_ERROR log out of the mutex protect area
Date:   Sun,  1 Nov 2020 19:14:17 -0800
Message-Id: <20201102031423.4033-1-bernard@vivo.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZT0seQx4aGEJOTUhKVkpNS09JQ01DTEtNQk9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nz46Pio6PD8vSiFRShgiD04Z
        AxJPCR9VSlVKTUtPSUNNQ0xKSk5OVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlOQ1VJ
        SkhVQ0hVSk5MWVdZCAFZQUlOQkw3Bg++
X-HM-Tid: 0a7586f2f45893bakuws4a8e148293a
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function amdgpu_register_gpu_instance, there is no need to
protect DRM_ERROR in mutex mgpu_info.mutex.
This change is to make the code to run a bit fast.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index efda38349a03..cc61b0a5b8d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -104,8 +104,8 @@ void amdgpu_register_gpu_instance(struct amdgpu_device *adev)
 	mutex_lock(&mgpu_info.mutex);
 
 	if (mgpu_info.num_gpu >= MAX_GPU_INSTANCE) {
-		DRM_ERROR("Cannot register more gpu instance\n");
 		mutex_unlock(&mgpu_info.mutex);
+		DRM_ERROR("Cannot register more gpu instance\n");
 		return;
 	}
 
-- 
2.29.0

