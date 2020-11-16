Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2C32B45B7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbgKPOT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:19:58 -0500
Received: from out28-170.mail.aliyun.com ([115.124.28.170]:59150 "EHLO
        out28-170.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgKPOTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:19:51 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08245762|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.22616-0.0193576-0.754482;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.IxS0Otf_1605536372;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.IxS0Otf_1605536372)
          by smtp.aliyun-inc.com(10.147.40.7);
          Mon, 16 Nov 2020 22:19:44 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        kishon@ti.com, vkoul@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, paul@crapouillou.net
Subject: [PATCH v9 0/3] Use the generic PHY framework for Ingenic USB PHY.
Date:   Mon, 16 Nov 2020 22:19:03 +0800
Message-Id: <20201116141906.11758-1-zhouyanjie@wanyeetech.com>
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

v8->v9:
Correct the path errors in "ingenic,phy-usb.yaml" and "ingenic,cgu.yaml".

周琰杰 (Zhou Yanjie) (3):
  USB: PHY: JZ4770: Remove unnecessary function calls.
  dt-bindings: USB: Add bindings for Ingenic JZ4775 and X2000.
  PHY: Ingenic: Add USB PHY driver using generic PHY framework.

 .../devicetree/bindings/clock/ingenic,cgu.yaml     |   2 +-
 .../ingenic,phy-usb.yaml}                          |   4 +-
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/ingenic/Kconfig                        |  12 +
 drivers/phy/ingenic/Makefile                       |   2 +
 drivers/phy/ingenic/phy-ingenic-usb.c              | 412 +++++++++++++++++++++
 drivers/usb/phy/phy-jz4770.c                       |   2 +-
 8 files changed, 433 insertions(+), 3 deletions(-)
 rename Documentation/devicetree/bindings/{usb/ingenic,jz4770-phy.yaml => phy/ingenic,phy-usb.yaml} (89%)
 create mode 100644 drivers/phy/ingenic/Kconfig
 create mode 100644 drivers/phy/ingenic/Makefile
 create mode 100644 drivers/phy/ingenic/phy-ingenic-usb.c

-- 
2.11.0

