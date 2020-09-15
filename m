Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB472269C4C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 05:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgIODFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 23:05:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41576 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726117AbgIODEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 23:04:54 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 47EA6E680264F1FB98B4;
        Tue, 15 Sep 2020 11:04:52 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Tue, 15 Sep 2020 11:04:42 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
To:     <mchehab+huawei@kernel.org>
CC:     <xuwei5@hisilicon.com>, <linuxarm@huawei.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <john.garry@huawei.com>,
        <salil.mehta@huawei.com>, <shiju.jose@huawei.com>,
        <jinying@hisilicon.com>, <zhangyi.ac@huawei.com>,
        <liguozhu@hisilicon.com>, <tangkunshan@huawei.com>,
        <huangdaode@hisilicon.com>, John Stultz <john.stultz@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] misc: hisi_hikey_usb: fix the uninitialized ret
Date:   Tue, 15 Sep 2020 11:01:01 +0800
Message-ID: <1600138861-187291-1-git-send-email-xuwei5@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uninitialized ret in hisi_hikey_usb_parse_kirin970 is useless.
Simply remove it and return 0 on success to fix the issue reported
by Coverity Scan.

Fixes: d210a0023590 ("misc: hisi_hikey_usb: add support for Hikey 970")
Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
---
 drivers/misc/hisi_hikey_usb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/hisi_hikey_usb.c b/drivers/misc/hisi_hikey_usb.c
index 2ddd4072788d..5759e7209023 100644
--- a/drivers/misc/hisi_hikey_usb.c
+++ b/drivers/misc/hisi_hikey_usb.c
@@ -151,7 +151,6 @@ static int hisi_hikey_usb_parse_kirin970(struct platform_device *pdev,
 					 struct hisi_hikey_usb *hisi_hikey_usb)
 {
 	struct regulator *regulator;
-	int ret;
 
 	regulator = devm_regulator_get(&pdev->dev, "hub-vdd");
 	if (IS_ERR(regulator)) {
@@ -172,7 +171,7 @@ static int hisi_hikey_usb_parse_kirin970(struct platform_device *pdev,
 	if (IS_ERR(hisi_hikey_usb->reset))
 		return PTR_ERR(hisi_hikey_usb->reset);
 
-	return ret;
+	return 0;
 }
 
 static int hisi_hikey_usb_probe(struct platform_device *pdev)
-- 
2.8.1

