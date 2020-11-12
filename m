Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBB22B0677
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgKLNbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:31:06 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7182 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbgKLNbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:31:06 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CX2Y73sV5z15RSS;
        Thu, 12 Nov 2020 21:30:51 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 12 Nov 2020 21:30:50 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <zhenyuw@linux.intel.com>, <intel-gvt-dev@lists.freedesktop.org>,
        <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>, <chenzhou10@huawei.com>
Subject: [PATCH] drm/i915/gvt: return error when failing to take the module reference
Date:   Thu, 12 Nov 2020 21:22:32 +0800
Message-ID: <1605187352-51761-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we fail to take the module reference, we go to the 'undo*' branch and
return. But the returned variable 'ret' has been set as zero by the
above code. Change 'ret' to '-ENODEV' in this situation.

Fixes: 9bdb073464d6 ("drm/i915/gvt: Change KVMGT as self load module")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index ad8a9df..778eb8c 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -829,8 +829,10 @@ static int intel_vgpu_open(struct mdev_device *mdev)
 	/* Take a module reference as mdev core doesn't take
 	 * a reference for vendor driver.
 	 */
-	if (!try_module_get(THIS_MODULE))
+	if (!try_module_get(THIS_MODULE)) {
+		ret = -ENODEV;
 		goto undo_group;
+	}
 
 	ret = kvmgt_guest_init(mdev);
 	if (ret)
-- 
1.7.12.4

