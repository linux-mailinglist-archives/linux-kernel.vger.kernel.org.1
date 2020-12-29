Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCE52E7131
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 14:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgL2NyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 08:54:16 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9697 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgL2NyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 08:54:15 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D4wmM2sWFzkxRR;
        Tue, 29 Dec 2020 21:50:43 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Tue, 29 Dec 2020 21:51:34 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>,
        <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <jani.nikula@linux.intel.com>, <joonas.lahtinen@linux.intel.com>,
        <rodrigo.vivi@intel.com>, Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] drm/i915: Use kzalloc for allocating only one thing
Date:   Tue, 29 Dec 2020 21:52:13 +0800
Message-ID: <20201229135213.23757-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kzalloc rather than kcalloc(1,...)

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
@@

- kcalloc(1,
+ kzalloc(
          ...)
// </smpl>

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/gpu/drm/i915/selftests/i915_gem_evict.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_evict.c b/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
index f88473d396f4..6994b167d0c8 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
@@ -415,7 +415,7 @@ static int igt_evict_contexts(void *arg)
 		struct reserved *r;
 
 		mutex_unlock(&ggtt->vm.mutex);
-		r = kcalloc(1, sizeof(*r), GFP_KERNEL);
+		r = kzalloc(sizeof(*r), GFP_KERNEL);
 		mutex_lock(&ggtt->vm.mutex);
 		if (!r) {
 			err = -ENOMEM;
-- 
2.22.0

