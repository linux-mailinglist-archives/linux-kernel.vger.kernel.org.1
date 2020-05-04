Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5FE1C3823
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 13:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgEDLc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 07:32:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3786 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726445AbgEDLc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 07:32:59 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 82EF5A42CF2971ECF32A;
        Mon,  4 May 2020 19:32:57 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Mon, 4 May 2020
 19:32:50 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] drm/amd/display: remove unused variable 'ret' in dm_suspend()
Date:   Mon, 4 May 2020 19:32:13 +0800
Message-ID: <20200504113213.40403-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:1574:5-8: Unneeded
variable: "ret". Return "0" on line 1586

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9c2a07626d2c..2b7588371170 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1571,7 +1571,6 @@ static int dm_suspend(void *handle)
 {
 	struct amdgpu_device *adev = handle;
 	struct amdgpu_display_manager *dm = &adev->dm;
-	int ret = 0;
 
 	WARN_ON(adev->dm.cached_state);
 	adev->dm.cached_state = drm_atomic_helper_suspend(adev->ddev);
@@ -1583,7 +1582,7 @@ static int dm_suspend(void *handle)
 
 	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
 
-	return ret;
+	return 0;
 }
 
 static struct amdgpu_dm_connector *
-- 
2.21.1

