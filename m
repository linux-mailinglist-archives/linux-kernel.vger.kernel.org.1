Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DE71FA8CA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 08:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgFPGcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 02:32:05 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40494 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbgFPGcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:32:03 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9AA5DBC2290480716A2C;
        Tue, 16 Jun 2020 14:32:00 +0800 (CST)
Received: from huawei.com (10.67.174.156) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 16 Jun 2020
 14:31:50 +0800
From:   Chen Tao <chentao107@huawei.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <tom.stdenis@amd.com>, <Jack.Xiao@amd.com>,
        <yttao@amd.com>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <chentao107@huawei.com>
Subject: [PATCH 2/2] drm/amdgpu/debugfs: fix memory leak when amdgpu_virt_enable_access_debugfs failed
Date:   Tue, 16 Jun 2020 14:30:39 +0800
Message-ID: <20200616063039.260990-2-chentao107@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200616063039.260990-1-chentao107@huawei.com>
References: <20200616063039.260990-1-chentao107@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.156]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix memory leak in amdgpu_debugfs_gpr_read not freeing data when
amdgpu_virt_enable_access_debugfs failed.

Fixes: 95a2f917387a2 ("drm/amdgpu: restrict debugfs register accessunder SR-IOV")
Signed-off-by: Chen Tao <chentao107@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index bea8c36a53a4..f66ee4b8f04e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -868,8 +868,10 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 	}
 
 	r = amdgpu_virt_enable_access_debugfs(adev);
-	if (r < 0)
+	if (r < 0) {
+		kfree(data);
 		return r;
+	}
 
 	/* switch to the specific se/sh/cu */
 	mutex_lock(&adev->grbm_idx_mutex);
-- 
2.22.0

