Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456A81B6BC0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 05:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgDXDOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 23:14:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41096 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725790AbgDXDOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 23:14:06 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0D361B37420008873918;
        Fri, 24 Apr 2020 11:14:02 +0800 (CST)
Received: from huawei.com (10.67.174.156) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Fri, 24 Apr 2020
 11:13:51 +0800
From:   ChenTao <chentao107@huawei.com>
To:     <christian.koenig@amd.com>, <David1.Zhou@amd.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <Hawking.Zhang@amd.com>, <evan.quan@amd.com>,
        <andrey.grodzovsky@amd.com>, <Monk.Liu@amd.com>,
        <kent.russell@amd.com>, <linux-kernel@vger.kernel.org>,
        <chentao107@huawei.com>
Subject: [PATCH] drm: amdgpu: Move static inline keyword to the front of declarations
Date:   Fri, 24 Apr 2020 11:13:16 +0800
Message-ID: <20200424031316.61662-1-chentao107@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.156]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warning:

Move the static inline keyword to the front of declarations
amdgpu_device_wreg_no_kiq, and resolve the following
compiler warnings that can be seen when building
with warnings enabled (W=1):

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:344:1:warning:
‘static’ is not at beginning of declaration
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:344:1:warning:
‘inline’ is not at beginning of declaration

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: ChenTao <chentao107@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ad1c66763dc1..d53a5e3f464b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -341,7 +341,7 @@ void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
 		BUG();
 }
 
-void static inline amdgpu_device_wreg_no_kiq(struct amdgpu_device *adev, uint32_t reg,
+static inline void amdgpu_device_wreg_no_kiq(struct amdgpu_device *adev, uint32_t reg,
 					     uint32_t v, uint32_t acc_flags)
 {
 	trace_amdgpu_device_wreg(adev->pdev->device, reg, v);
-- 
2.17.1

