Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76552022B0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 10:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgFTIyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jun 2020 04:54:19 -0400
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:1572 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgFTIyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 04:54:18 -0400
Received: from njvxl5505.vivo.xyz (unknown [157.0.31.125])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id 4787E481E89;
        Sat, 20 Jun 2020 16:54:13 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH v2] drm/amd: fix potential memleak in err branch
Date:   Sat, 20 Jun 2020 16:54:06 +0800
Message-Id: <20200620085407.21922-1-bernard@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSxhKGUxKTUxCSx9DVkpOQklNT0hJTkhPQ0xVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ohg6Iyo5UTg1CQI*Cz0UITAi
        PC0wCTlVSlVKTkJJTU9ISU5IQ0JCVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSU5ZV1kIAVlBSU5PSDcG
X-HM-Tid: 0a72d0ef74b893bakuws4787e481e89
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function kobject_init_and_add alloc memory like:
kobject_init_and_add->kobject_add_varg->kobject_set_name_vargs
->kvasprintf_const->kstrdup_const->kstrdup->kmalloc_track_caller
->kmalloc_slab, in err branch this memory not free. If use
kmemleak, this path maybe catched.
These changes are to add kobject_put in kobject_init_and_add
failed branch, fix potential memleak.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
Changes since V1:
*Remove duplicate changed file kfd_topology.c, this file`s fix
already applied to the main line.
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d27221ddcdeb..5ee4d6cfb16d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -124,6 +124,7 @@ void kfd_procfs_init(void)
 	if (ret) {
 		pr_warn("Could not create procfs proc folder");
 		/* If we fail to create the procfs, clean up */
+		kobject_put(procfs.kobj);
 		kfd_procfs_shutdown();
 	}
 }
@@ -428,6 +429,7 @@ struct kfd_process *kfd_create_process(struct file *filep)
 					   (int)process->lead_thread->pid);
 		if (ret) {
 			pr_warn("Creating procfs pid directory failed");
+			kobject_put(process->kobj);
 			goto out;
 		}
 
-- 
2.17.1

