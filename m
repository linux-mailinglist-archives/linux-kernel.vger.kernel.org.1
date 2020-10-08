Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E142870B2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 10:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgJHIaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 04:30:03 -0400
Received: from out28-50.mail.aliyun.com ([115.124.28.50]:47485 "EHLO
        out28-50.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgJHIaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 04:30:02 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08470301|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0162693-0.00889103-0.97484;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.Iga.miA_1602145789;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.Iga.miA_1602145789)
          by smtp.aliyun-inc.com(10.147.43.95);
          Thu, 08 Oct 2020 16:29:56 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, kishon@ti.com,
        vkoul@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, paul@crapouillou.net
Subject: [PATCH v7 0/2] Use the generic PHY framework for Ingenic USB PHY.
Date:   Thu,  8 Oct 2020 16:29:25 +0800
Message-Id: <20201008082927.85233-1-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3->v4:
Only add new generic-PHY driver, without removing the old one. Because the
jz4740-musb driver is not ready to use the generic PHY framework. When the
jz4740-musb driver is modified to use the generic PHY framework, the old
jz4770-phy driver can be "retired".

v4->v5:
1.Add an extra blank line between "devm_of_phy_provider_register" and "return".
2.Remove unnecessary "phy_set_drvdata".
3.Add Paul Cercueil's Reviewed-by.

v5->v6:
1.Revert the removal of "phy_set_drvdata" in v5, removing "phy_set_drvdata" will
  cause a kernel panic on CI20.
  Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
2.Rewrite the macro definitions, replace the original code with "FIELD_PREP()"
  and "u32p_replace_bits()" according to Vinod Koul's suggestion.

v6->v7:
1.Remove the stray tab character.
2.Remove unnecessary "platform_set_drvdata".
3.Remove the "dev" field in priv structure, and use &phy->dev instead.

周琰杰 (Zhou Yanjie) (2):
  USB: PHY: JZ4770: Remove unnecessary function calls.
  PHY: Ingenic: Add USB PHY driver using generic PHY framework.

 drivers/phy/Kconfig                   |   1 +
 drivers/phy/Makefile                  |   1 +
 drivers/phy/ingenic/Kconfig           |  12 ++
 drivers/phy/ingenic/Makefile          |   2 +
 drivers/phy/ingenic/phy-ingenic-usb.c | 374 ++++++++++++++++++++++++++++++++++
 drivers/usb/phy/phy-jz4770.c          |   2 +-
 6 files changed, 391 insertions(+), 1 deletion(-)
 create mode 100644 drivers/phy/ingenic/Kconfig
 create mode 100644 drivers/phy/ingenic/Makefile
 create mode 100644 drivers/phy/ingenic/phy-ingenic-usb.c

-- 
2.11.0

