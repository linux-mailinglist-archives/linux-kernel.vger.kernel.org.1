Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AEA2FE7E3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbhAUKpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:45:24 -0500
Received: from m12-16.163.com ([220.181.12.16]:33315 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729468AbhAUKlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:41:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=11lFq4wlWzxyZ3u4ZO
        +JThndSZpWISHCwRWP+uZyTQ0=; b=SpA83LbwiDbQTyc90v3doMjNdUNPy5uOxP
        kQYgfNaJdm370IySTU1xz08BcsxYXVA6Li50C0JJZyglF3Ij+gwEinK/AMSw8AbI
        y6H41ZrxLNUjr+OuCuHdbY6GDUaUdaEurvxW3WqubIdtOrKd2pM1LBiA+5LOwS3p
        BmHi6bxD4=
Received: from localhost.localdomain (unknown [119.3.119.20])
        by smtp12 (Coremail) with SMTP id EMCowAC3No+CQwlgD6auYA--.51716S4;
        Thu, 21 Jan 2021 17:04:06 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
Cc:     linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
Subject: [PATCH] memory: ti-aemif: Drop child node when jumping out loop
Date:   Thu, 21 Jan 2021 01:03:59 -0800
Message-Id: <20210121090359.61763-1-bianpan2016@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EMCowAC3No+CQwlgD6auYA--.51716S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrWftF1xXw1rGF1DJr48Crg_yoW8Gw4Dpr
        43CryakrW0gay3Xr4vywnrCFyYkw18KFWFgFWfCas5uFWDJr9xtr18Kry5Xr98JFWrJr15
        t3W7t3W7WFs5Xr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UfxhXUUUUU=
X-Originating-IP: [119.3.119.20]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiDgYhclXly8wFwgAAsr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call of_node_put() to decrement the reference count of the child node
child_np when jumping out of the loop body of
for_each_available_child_of_node(), which is a macro that increments and
decrements the reference count of child node. If the loop is broken, the
reference of the child node should be dropped manually.

Fixes: 5a7c81547c1d ("memory: ti-aemif: introduce AEMIF driver")
Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/memory/ti-aemif.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index 159a16f5e7d6..51d20c2ccb75 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -378,8 +378,10 @@ static int aemif_probe(struct platform_device *pdev)
 		 */
 		for_each_available_child_of_node(np, child_np) {
 			ret = of_aemif_parse_abus_config(pdev, child_np);
-			if (ret < 0)
+			if (ret < 0) {
+				of_node_put(child_np);
 				goto error;
+			}
 		}
 	} else if (pdata && pdata->num_abus_data > 0) {
 		for (i = 0; i < pdata->num_abus_data; i++, aemif->num_cs++) {
@@ -405,8 +407,10 @@ static int aemif_probe(struct platform_device *pdev)
 		for_each_available_child_of_node(np, child_np) {
 			ret = of_platform_populate(child_np, NULL,
 						   dev_lookup, dev);
-			if (ret < 0)
+			if (ret < 0) {
+				of_node_put(child_np);
 				goto error;
+			}
 		}
 	} else if (pdata) {
 		for (i = 0; i < pdata->num_sub_devices; i++) {
-- 
2.17.1


