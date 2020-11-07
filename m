Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838F72AA44A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 10:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgKGJt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 04:49:26 -0500
Received: from out28-51.mail.aliyun.com ([115.124.28.51]:50555 "EHLO
        out28-51.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbgKGJtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 04:49:25 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08042695|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.244406-0.261979-0.493615;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.ItlkgfC_1604742507;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.ItlkgfC_1604742507)
          by smtp.aliyun-inc.com(10.147.41.158);
          Sat, 07 Nov 2020 17:49:20 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, paul@crapouillou.net
Subject: [PATCH v8 0/3] Use the generic PHY framework for Ingenic USB PHY.
Date:   Sat,  7 Nov 2020 17:47:55 +0800
Message-Id: <20201107094758.83291-1-zhouyanjie@wanyeetech.com>
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

v7->v8:
Add support for Ingenic JZ4775 SoC and X2000 SoC.

周琰杰 (Zhou Yanjie) (3):
  USB: PHY: JZ4770: Remove unnecessary function calls.
  dt-bindings: USB: Add bindings for Ingenic JZ4775 and X2000.
  PHY: Ingenic: Add USB PHY driver using generic PHY framework.

 .../ingenic,phy-usb.yaml}                          |   4 +-
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/ingenic/Kconfig                        |  12 +
 drivers/phy/ingenic/Makefile                       |   2 +
 drivers/phy/ingenic/phy-ingenic-usb.c              | 412 +++++++++++++++++++++
 drivers/usb/phy/phy-jz4770.c                       |   2 +-
 7 files changed, 432 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/{usb/ingenic,jz4770-phy.yaml => phy/ingenic,phy-usb.yaml} (89%)
 create mode 100644 drivers/phy/ingenic/Kconfig
 create mode 100644 drivers/phy/ingenic/Makefile
 create mode 100644 drivers/phy/ingenic/phy-ingenic-usb.c

-- 
2.11.0

