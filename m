Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C641275D5C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 18:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgIWQ0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 12:26:42 -0400
Received: from out28-101.mail.aliyun.com ([115.124.28.101]:42822 "EHLO
        out28-101.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgIWQ0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 12:26:40 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08793781|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0310931-0.0113857-0.957521;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16378;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.IbH0qkb_1600878388;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.IbH0qkb_1600878388)
          by smtp.aliyun-inc.com(10.147.41.187);
          Thu, 24 Sep 2020 00:26:34 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     vkoul@kernel.org, kishon@ti.com, gregkh@linuxfoundation.org,
        balbi@kernel.org, paul@crapouillou.net
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: [PATCH v6 0/2] Use the generic PHY framework for Ingenic USB PHY.
Date:   Thu, 24 Sep 2020 00:25:58 +0800
Message-Id: <20200923162600.44105-1-zhouyanjie@wanyeetech.com>
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

周琰杰 (Zhou Yanjie) (2):
  USB: PHY: JZ4770: Remove unnecessary function calls.
  PHY: Ingenic: Add USB PHY driver using generic PHY framework.

 drivers/phy/Kconfig                   |   1 +
 drivers/phy/Makefile                  |   1 +
 drivers/phy/ingenic/Kconfig           |  12 ++
 drivers/phy/ingenic/Makefile          |   2 +
 drivers/phy/ingenic/phy-ingenic-usb.c | 378 ++++++++++++++++++++++++++++++++++
 drivers/usb/phy/phy-jz4770.c          |   2 +-
 6 files changed, 395 insertions(+), 1 deletion(-)
 create mode 100644 drivers/phy/ingenic/Kconfig
 create mode 100644 drivers/phy/ingenic/Makefile
 create mode 100644 drivers/phy/ingenic/phy-ingenic-usb.c

-- 
2.11.0

