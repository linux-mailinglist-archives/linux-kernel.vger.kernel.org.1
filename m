Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7859272BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgIUQY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:24:58 -0400
Received: from out28-123.mail.aliyun.com ([115.124.28.123]:42357 "EHLO
        out28-123.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbgIUQY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:24:58 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1922966|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0141755-0.0008202-0.985004;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03278;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.IaJ0p8G_1600705483;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.IaJ0p8G_1600705483)
          by smtp.aliyun-inc.com(10.147.40.44);
          Tue, 22 Sep 2020 00:24:53 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, kishon@ti.com,
        vkoul@kernel.org, paul@crapouillou.net
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        christophe.jaillet@wanadoo.fr, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Subject: [PATCH v5 1/2] USB: PHY: JZ4770: Remove unnecessary function calls.
Date:   Tue, 22 Sep 2020 00:24:16 +0800
Message-Id: <20200921162417.52004-2-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200921162417.52004-1-zhouyanjie@wanyeetech.com>
References: <20200921162417.52004-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary "of_match_ptr()", because Ingenic SoCs all
depend on Device Tree.

Suggested-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v3:
    New patch.
    
    v3->v4:
    No change.
    
    v4->v5:
    Add Paul Cercueil's Reviewed-by.

 drivers/usb/phy/phy-jz4770.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/phy/phy-jz4770.c b/drivers/usb/phy/phy-jz4770.c
index f6d3731581eb..4025da20b3fd 100644
--- a/drivers/usb/phy/phy-jz4770.c
+++ b/drivers/usb/phy/phy-jz4770.c
@@ -350,7 +350,7 @@ static struct platform_driver ingenic_phy_driver = {
 	.probe		= jz4770_phy_probe,
 	.driver		= {
 		.name	= "jz4770-phy",
-		.of_match_table = of_match_ptr(ingenic_usb_phy_of_matches),
+		.of_match_table = ingenic_usb_phy_of_matches,
 	},
 };
 module_platform_driver(ingenic_phy_driver);
-- 
2.11.0

