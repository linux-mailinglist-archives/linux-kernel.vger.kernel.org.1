Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BF12C3944
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 07:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgKYGqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 01:46:25 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7733 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgKYGqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 01:46:24 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cgrxs0FjzzkfbD;
        Wed, 25 Nov 2020 14:45:53 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Wed, 25 Nov 2020 14:46:12 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH] soundwire: Fix error return code in sdw_compute_port_params
Date:   Wed, 25 Nov 2020 14:50:35 +0800
Message-ID: <20201125065035.154262-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return the error code -EINVAL in sdw_compute_port_params
instead of 0.

Fixes: 9026118f20e2 ("soundwire: Add generic bandwidth allocation algorithm")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/soundwire/generic_bandwidth_allocation.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
index 0bdef38c9..ad857ac62 100644
--- a/drivers/soundwire/generic_bandwidth_allocation.c
+++ b/drivers/soundwire/generic_bandwidth_allocation.c
@@ -283,8 +283,10 @@ static int sdw_compute_port_params(struct sdw_bus *bus)
 	if (ret < 0)
 		return ret;
 
-	if (group.count == 0)
+	if (group.count == 0) {
+		ret = -EINVAL;
 		goto out;
+	}
 
 	params = kcalloc(group.count, sizeof(*params), GFP_KERNEL);
 	if (!params) {
-- 
2.23.0

