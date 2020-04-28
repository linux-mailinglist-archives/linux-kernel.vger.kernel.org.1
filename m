Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBF61BB68E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 08:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgD1Gaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 02:30:55 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47194 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725917AbgD1Gay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 02:30:54 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AB858D75664823F5A24B;
        Tue, 28 Apr 2020 14:30:49 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 28 Apr 2020
 14:30:39 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <evan.quan@amd.com>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <David1.Zhou@amd.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] drm/amdgpu/smu10: remove duplicate assignment of smu10_hwmgr_funcs members
Date:   Tue, 28 Apr 2020 14:30:03 +0800
Message-ID: <20200428063003.24687-1-yanaijie@huawei.com>
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

The struct member 'asic_setup' was assigned twice, let's remove one:

static const struct pp_hwmgr_func smu10_hwmgr_funcs = {
	......
	.asic_setup = NULL,
	......
	.asic_setup = smu10_setup_asic_task,
	......
};

This fixes the following coccicheck warning:

drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c:1357:52-53:
asic_setup: first occurrence line 1360, second occurrence line 1388

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
index 1cc30f750c26..4f8c1b85e688 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
@@ -1357,7 +1357,6 @@ static int smu10_asic_reset(struct pp_hwmgr *hwmgr, enum SMU_ASIC_RESET_MODE mod
 static const struct pp_hwmgr_func smu10_hwmgr_funcs = {
 	.backend_init = smu10_hwmgr_backend_init,
 	.backend_fini = smu10_hwmgr_backend_fini,
-	.asic_setup = NULL,
 	.apply_state_adjust_rules = smu10_apply_state_adjust_rules,
 	.force_dpm_level = smu10_dpm_force_dpm_level,
 	.get_power_state_size = smu10_get_power_state_size,
-- 
2.21.1

