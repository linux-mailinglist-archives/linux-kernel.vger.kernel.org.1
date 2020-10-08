Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3352870B0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 10:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgJHIaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 04:30:01 -0400
Received: from out28-122.mail.aliyun.com ([115.124.28.122]:44863 "EHLO
        out28-122.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgJHIaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 04:30:01 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1798292|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0126137-0.000882055-0.986504;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.Iga.miA_1602145789;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.Iga.miA_1602145789)
          by smtp.aliyun-inc.com(10.147.43.95);
          Thu, 08 Oct 2020 16:29:57 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, kishon@ti.com,
        vkoul@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, paul@crapouillou.net
Subject: [PATCH v7 1/2] USB: PHY: JZ4770: Remove unnecessary function calls.
Date:   Thu,  8 Oct 2020 16:29:26 +0800
Message-Id: <20201008082927.85233-2-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201008082927.85233-1-zhouyanjie@wanyeetech.com>
References: <20201008082927.85233-1-zhouyanjie@wanyeetech.com>
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
    
    v5->v6:
    No change.
    
    v6->v7:
    No change.

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

