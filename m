Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2E226849A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 08:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgINGNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 02:13:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11827 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726027AbgINGNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 02:13:36 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3487B76404C4321E2EA7;
        Mon, 14 Sep 2020 14:13:32 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 14 Sep 2020 14:13:23 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH -next] macintosh: windfarm: use for_each_child_of_node() macro
Date:   Mon, 14 Sep 2020 14:14:11 +0800
Message-ID: <20200914061411.3356-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use for_each_child_of_node() macro instead of open coding it.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/macintosh/windfarm_smu_sat.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/macintosh/windfarm_smu_sat.c b/drivers/macintosh/windfarm_smu_sat.c
index cb75dc035..e46e1153a 100644
--- a/drivers/macintosh/windfarm_smu_sat.c
+++ b/drivers/macintosh/windfarm_smu_sat.c
@@ -216,8 +216,7 @@ static int wf_sat_probe(struct i2c_client *client,
 
 	vsens[0] = vsens[1] = -1;
 	isens[0] = isens[1] = -1;
-	child = NULL;
-	while ((child = of_get_next_child(dev, child)) != NULL) {
+	for_each_child_of_node(dev, child) {
 		reg = of_get_property(child, "reg", NULL);
 		loc = of_get_property(child, "location", NULL);
 		if (reg == NULL || loc == NULL)
-- 
2.23.0

