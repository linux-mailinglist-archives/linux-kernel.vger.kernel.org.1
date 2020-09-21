Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886D2271B12
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 08:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgIUGsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 02:48:05 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35440 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726149AbgIUGsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 02:48:05 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 97BB61E9AEA92E074D6D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 14:48:01 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 14:47:51 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] mailbox: pcc: remove the .owner when using the platform_create_bundle
Date:   Mon, 21 Sep 2020 14:45:26 +0800
Message-ID: <1600670726-24741-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the platform_create_bundle is a macro that implements
__platform_create_bundle has set he parameters module to THIS_MODULE.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/mailbox/pcc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index ef9ecd1..4b1a2d2 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -577,7 +577,6 @@ static struct platform_driver pcc_mbox_driver = {
 	.probe = pcc_mbox_probe,
 	.driver = {
 		.name = "PCCT",
-		.owner = THIS_MODULE,
 	},
 };
 
-- 
2.7.4

