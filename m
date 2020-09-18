Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D3D26F4CB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 05:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgIRDnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 23:43:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50238 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726420AbgIRDnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 23:43:41 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7257AA7591A4C09F00A5;
        Fri, 18 Sep 2020 11:43:39 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 11:43:32 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <amd-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <alexander.deucher@amd.com>, <yangyingliang@huawei.com>
Subject: [PATCH -next] drm/amd/display: remove unused variable in amdgpu_dm.c
Date:   Fri, 18 Sep 2020 11:42:14 +0800
Message-ID: <20200918034214.2534751-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the compile warning:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:892:26: warning: variable ‘stream’ set but not used [-Wunused-but-set-variable]
  struct dc_stream_state *stream;
                          ^~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bb1bc7f5d149..7d9e8c311879 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -889,7 +889,6 @@ static void amdgpu_check_debugfs_connector_property_change(struct amdgpu_device
 	struct drm_connector_state *conn_state;
 	struct dm_crtc_state *acrtc_state;
 	struct drm_crtc_state *crtc_state;
-	struct dc_stream_state *stream;
 	struct drm_device *dev = adev_to_drm(adev);
 
 	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
@@ -906,8 +905,6 @@ static void amdgpu_check_debugfs_connector_property_change(struct amdgpu_device
 		if (!(acrtc_state && acrtc_state->stream))
 			continue;
 
-		stream = acrtc_state->stream;
-
 		if (amdgpu_dm_connector->dsc_settings.dsc_force_enable ||
 		    amdgpu_dm_connector->dsc_settings.dsc_num_slices_v ||
 		    amdgpu_dm_connector->dsc_settings.dsc_num_slices_h ||
-- 
2.25.1

