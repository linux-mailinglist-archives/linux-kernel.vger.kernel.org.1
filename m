Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF135269C43
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 05:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgIODE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 23:04:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12259 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726134AbgIODEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 23:04:05 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 453C7E7913AC087AB982;
        Tue, 15 Sep 2020 11:04:02 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Tue, 15 Sep 2020
 11:03:54 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Evgeniy Polyakov <zbr@ioremap.net>
CC:     <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] w1: ds2490: simplify the return expression of ds_reset()
Date:   Tue, 15 Sep 2020 11:26:32 +0800
Message-ID: <20200915032632.1772725-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the return expression.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/w1/masters/ds2490.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/w1/masters/ds2490.c b/drivers/w1/masters/ds2490.c
index e17c8f70dcd0..d42da8bde06c 100644
--- a/drivers/w1/masters/ds2490.c
+++ b/drivers/w1/masters/ds2490.c
@@ -464,8 +464,6 @@ static int ds_wait_status(struct ds_device *dev, struct ds_status *st)
 
 static int ds_reset(struct ds_device *dev)
 {
-	int err;
-
 	/* Other potentionally interesting flags for reset.
 	 *
 	 * COMM_NTF: Return result register feedback.  This could be used to
@@ -475,11 +473,7 @@ static int ds_reset(struct ds_device *dev)
 	 * COMM_SE which allows SPEED_NORMAL, SPEED_FLEXIBLE, SPEED_OVERDRIVE:
 	 * Select the data transfer rate.
 	 */
-	err = ds_send_control(dev, COMM_1_WIRE_RESET | COMM_IM, SPEED_NORMAL);
-	if (err)
-		return err;
-
-	return 0;
+	return ds_send_control(dev, COMM_1_WIRE_RESET | COMM_IM, SPEED_NORMAL);
 }
 
 #if 0
-- 
2.25.1

