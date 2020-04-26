Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2575C1B8E61
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Apr 2020 11:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgDZJlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 05:41:08 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38992 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726122AbgDZJlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 05:41:08 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 396F241F3037E3850052;
        Sun, 26 Apr 2020 17:41:06 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Sun, 26 Apr 2020
 17:40:59 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] drm/amd/display: remove conversion to bool amdgpu_dm.c
Date:   Sun, 26 Apr 2020 17:40:26 +0800
Message-ID: <20200426094026.22962-1-yanaijie@huawei.com>
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

The '==' expression itself is bool, no need to convert it to bool again.
This fixes the following coccicheck warning:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:7230:16-21: WARNING:
conversion to bool not needed here

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 71309ee3aca3..4051eee86d43 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7242,8 +7242,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			hdcp_update_display(
 				adev->dm.hdcp_workqueue, aconnector->dc_link->link_index, aconnector,
 				new_con_state->hdcp_content_type,
-				new_con_state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED ? true
-													 : false);
+				new_con_state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED);
 	}
 #endif
 
-- 
2.21.1

