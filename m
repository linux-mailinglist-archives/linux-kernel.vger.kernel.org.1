Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3615D249BEF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 13:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgHSLgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 07:36:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9848 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728063AbgHSLge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:36:34 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 700FE160379AF6C74599;
        Wed, 19 Aug 2020 19:36:22 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Wed, 19 Aug 2020
 19:36:18 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <evan.quan@amd.com>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] drm/amd/powerplay: remove duplicate include
Date:   Wed, 19 Aug 2020 19:34:09 +0800
Message-ID: <20200819113409.10137-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove asic_reg/nbio/nbio_6_1_offset.h which is included more than once

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_inc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_inc.h b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_inc.h
index e6d9e84059e1..0d08c57d3bca 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_inc.h
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_inc.h
@@ -34,7 +34,6 @@
 #include "asic_reg/gc/gc_9_2_1_offset.h"
 #include "asic_reg/gc/gc_9_2_1_sh_mask.h"
 
-#include "asic_reg/nbio/nbio_6_1_offset.h"
 #include "asic_reg/nbio/nbio_6_1_offset.h"
 #include "asic_reg/nbio/nbio_6_1_sh_mask.h"
 
-- 
2.17.1

