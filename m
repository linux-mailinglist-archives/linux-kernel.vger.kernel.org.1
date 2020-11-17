Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6703A2B5611
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 02:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731785AbgKQBLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 20:11:08 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7253 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731757AbgKQBLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 20:11:08 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CZntq75HQzkYWc;
        Tue, 17 Nov 2020 09:10:43 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Tue, 17 Nov 2020
 09:10:54 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <Peter.Chen@nxp.com>, <gregkh@linuxfoundation.org>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>
CC:     <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH] usb: chipidea: ci_hdrc_imx: add missing put_device() call in usbmisc_get_init_data()
Date:   Tue, 17 Nov 2020 09:14:30 +0800
Message-ID: <20201117011430.642589-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if of_find_device_by_node() succeed, usbmisc_get_init_data() doesn't have
a corresponding put_device(). Thus add put_device() to fix the exception
handling for this function implementation.

Fixes: commit ef12da914ed6 ("usb: chipidea: imx: properly check for usbmisc")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/usb/chipidea/ci_hdrc_imx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 25c65accf089..d4b1069b86ec 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -138,9 +138,13 @@ static struct imx_usbmisc_data *usbmisc_get_init_data(struct device *dev)
 	misc_pdev = of_find_device_by_node(args.np);
 	of_node_put(args.np);
 
-	if (!misc_pdev || !platform_get_drvdata(misc_pdev))
+	if (!misc_pdev)
 		return ERR_PTR(-EPROBE_DEFER);
 
+	if (!platform_get_drvdata(misc_pdev)) {
+		put_device(&misc_pdev->dev);
+		return ERR_PTR(-EPROBE_DEFER);
+	}
 	data->dev = &misc_pdev->dev;
 
 	/*
-- 
2.25.4

