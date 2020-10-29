Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81B729E21A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733238AbgJ2CHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:07:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:6986 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbgJ2CHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 22:07:05 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CM82X1zCHzhbTC;
        Thu, 29 Oct 2020 10:07:00 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 29 Oct 2020 10:06:46 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <jani.nikula@linux.intel.com>, <joonas.lahtinen@linux.intel.com>,
        <rodrigo.vivi@intel.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] drm/i915: Remove unused variable ret
Date:   Thu, 29 Oct 2020 10:18:45 +0800
Message-ID: <1603937925-53176-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below warnings reported by coccicheck

./drivers/gpu/drm/i915/i915_debugfs.c:789:5-8: Unneeded variable: "ret". Return "0" on line 1012

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/gpu/drm/i915/i915_debugfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
index ea46916..200f6b8 100644
--- a/drivers/gpu/drm/i915/i915_debugfs.c
+++ b/drivers/gpu/drm/i915/i915_debugfs.c
@@ -786,7 +786,6 @@ static int i915_frequency_info(struct seq_file *m, void *unused)
 	struct intel_uncore *uncore = &dev_priv->uncore;
 	struct intel_rps *rps = &dev_priv->gt.rps;
 	intel_wakeref_t wakeref;
-	int ret = 0;
 
 	wakeref = intel_runtime_pm_get(&dev_priv->runtime_pm);
 
@@ -1009,7 +1008,7 @@ static int i915_frequency_info(struct seq_file *m, void *unused)
 	seq_printf(m, "Max pixel clock frequency: %d kHz\n", dev_priv->max_dotclk_freq);
 
 	intel_runtime_pm_put(&dev_priv->runtime_pm, wakeref);
-	return ret;
+	return 0;
 }
 
 static int i915_ring_freq_table(struct seq_file *m, void *unused)
-- 
2.6.2

