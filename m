Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96DCF1BA1E9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 13:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgD0LG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 07:06:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53212 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726485AbgD0LG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 07:06:57 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7C8E7C60C90427A39914;
        Mon, 27 Apr 2020 19:06:54 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Mon, 27 Apr 2020 19:06:45 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH] mfd: wcd934x: Drop kfree for memory allocated with devm_kzalloc
Date:   Mon, 27 Apr 2020 11:08:05 +0000
Message-ID: <20200427110805.154447-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
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





