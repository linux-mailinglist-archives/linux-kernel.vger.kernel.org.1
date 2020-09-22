Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4712274082
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 13:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgIVLLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 07:11:47 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:38435 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgIVLLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 07:11:47 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 495464E17B2;
        Tue, 22 Sep 2020 19:11:45 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] gpu/drm/radeon: fix spellint typo in comments
Date:   Tue, 22 Sep 2020 19:11:37 +0800
Message-Id: <1600773099-32693-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHRgeS09ITUgfGUgeVkpNS0tMTEhKS05NTU1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTo6PAw4Sz8YTw4LSAJKQyIh
        MjoaFBNVSlVKTUtLTExISktNS01OVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKTExCNwY+
X-HM-Tid: 0a74b58327919376kuws495464e17b2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the comment typo: "definately" -> "definitely".

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/gpu/drm/radeon/radeon_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_vm.c b/drivers/gpu/drm/radeon/radeon_vm.c
index f60fae0..3d6e2cd
--- a/drivers/gpu/drm/radeon/radeon_vm.c
+++ b/drivers/gpu/drm/radeon/radeon_vm.c
@@ -188,7 +188,7 @@ struct radeon_fence *radeon_vm_grab_id(struct radeon_device *rdev,
 	    vm_id->last_id_use == rdev->vm_manager.active[vm_id->id])
 		return NULL;
 
-	/* we definately need to flush */
+	/* we definitely need to flush */
 	vm_id->pd_gpu_addr = ~0ll;
 
 	/* skip over VMID 0, since it is the system VM */
-- 
2.7.4

