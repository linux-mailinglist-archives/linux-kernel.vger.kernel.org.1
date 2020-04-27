Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFF21BA38F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 14:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgD0M2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 08:28:15 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:32966 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726589AbgD0M2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 08:28:14 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AE24871CBB5878793B39;
        Mon, 27 Apr 2020 20:28:12 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Mon, 27 Apr 2020 20:28:04 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH] mfd: wcd934x: Drop kfree for memory allocated with devm_kzalloc
Date:   Mon, 27 Apr 2020 12:29:22 +0000
Message-ID: <20200427122922.56643-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200427110805.154447-1-weiyongjun1@huawei.com>
References: <20200427110805.154447-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not necessary to free memory allocated with devm_kzalloc
and using kfree leads to a double free.

Fixes: 6ac7e4d7ad70 ("mfd: wcd934x: Add support to wcd9340/wcd9341 codec")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/mfd/wcd934x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/wcd934x.c b/drivers/mfd/wcd934x.c
index 90341f3c6810..da910302d51a 100644
--- a/drivers/mfd/wcd934x.c
+++ b/drivers/mfd/wcd934x.c
@@ -280,7 +280,6 @@ static void wcd934x_slim_remove(struct slim_device *sdev)
 
 	regulator_bulk_disable(WCD934X_MAX_SUPPLY, ddata->supplies);
 	mfd_remove_devices(&sdev->dev);
-	kfree(ddata);
 }
 
 static const struct slim_device_id wcd934x_slim_id[] = {



