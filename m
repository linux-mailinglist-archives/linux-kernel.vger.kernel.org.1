Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBC5273FE4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgIVKvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:51:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14209 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726419AbgIVKvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:51:33 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8E089621D9B13FF0F19A;
        Tue, 22 Sep 2020 18:51:30 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Tue, 22 Sep 2020 18:51:21 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] firmware: ti_sci: Remove unneeded semicolon
Date:   Tue, 22 Sep 2020 18:59:04 +0800
Message-ID: <1600772344-79841-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

./drivers/firmware/ti_sci.c:1759:2-3: Unneeded semicolon
./drivers/firmware/ti_sci.c:2191:2-3: Unneeded semicolon

Fixes: 9c19fb6895be ("firmware: ti_sci: Add support for RM core ops")
Fixes: 68608b5e5063 ("firmware: ti_sci: Add resource management APIs for ringacc, psi-l and udma")
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/firmware/ti_sci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 896f53e..e0c8adf 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -1756,7 +1756,7 @@ static int ti_sci_get_resource_range(const struct ti_sci_handle *handle,
 	} else {
 		*range_start = resp->range_start;
 		*range_num = resp->range_num;
-	};
+	}
 
 fail:
 	ti_sci_put_one_xfer(&info->minfo, xfer);
@@ -2188,7 +2188,7 @@ static int ti_sci_cmd_ring_get_config(const struct ti_sci_handle *handle,
 			*size = resp->size;
 		if (order_id)
 			*order_id = resp->order_id;
-	};
+	}
 
 fail:
 	ti_sci_put_one_xfer(&info->minfo, xfer);
-- 
2.6.2

