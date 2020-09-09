Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE05C262FAE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 16:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbgIIOXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 10:23:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57336 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730187AbgIINAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 09:00:39 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4D1EEFE2135306C9AB1B;
        Wed,  9 Sep 2020 21:00:33 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 21:00:27 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH -next 5/8] drm/amd/amdgpu: fix comparison pointer to bool warning in si.c
Date:   Wed, 9 Sep 2020 21:07:17 +0800
Message-ID: <20200909130720.105234-6-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
In-Reply-To: <20200909130720.105234-1-zhengbin13@huawei.com>
References: <20200909130720.105234-1-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

drivers/gpu/drm/amd/amdgpu/si.c:1342:5-10: WARNING: Comparison to bool

Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/si.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 455d5e366c69..e5e336fd9e94 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1339,7 +1339,7 @@ static void si_vga_set_state(struct amdgpu_device *adev, bool state)
 	uint32_t temp;

 	temp = RREG32(CONFIG_CNTL);
-	if (state == false) {
+	if (!state) {
 		temp &= ~(1<<0);
 		temp |= (1<<1);
 	} else {
--
2.26.0.106.g9fadedd

