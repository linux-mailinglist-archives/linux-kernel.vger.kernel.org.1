Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A890272BEA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgIUQZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:25:01 -0400
Received: from out28-172.mail.aliyun.com ([115.124.28.172]:35323 "EHLO
        out28-172.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgIUQY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:24:58 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08949126|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0335908-0.0164095-0.95;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03303;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.IaJ0p8G_1600705483;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.IaJ0p8G_1600705483)
          by smtp.aliyun-inc.com(10.147.40.44);
          Tue, 22 Sep 2020 00:24:52 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, kishon@ti.com,
        vkoul@kernel.org, paul@crapouillou.net
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        christophe.jaillet@wanadoo.fr, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Subject: [PATCH v5 0/2] Use the generic PHY framework for Ingenic USB PHY.
Date:   Tue, 22 Sep 2020 00:24:15 +0800
Message-Id: <20200921162417.52004-1-zhouyanjie@wanyeetech.com>
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

周琰杰 (Zhou Yanjie) (2):
  USB: PHY: JZ4770: Remove unnecessary function calls.
  PHY: Ingenic: Add USB PHY driver using generic PHY framework.

 drivers/phy/Kconfig                   |   1 +
 drivers/phy/Makefile                  |   1 +
 drivers/phy/ingenic/Kconfig           |  12 ++
 drivers/phy/ingenic/Makefile          |   2 +
 drivers/phy/ingenic/phy-ingenic-usb.c | 373 ++++++++++++++++++++++++++++++++++
 drivers/usb/phy/phy-jz4770.c          |   2 +-
 6 files changed, 390 insertions(+), 1 deletion(-)
 create mode 100644 drivers/phy/ingenic/Kconfig
 create mode 100644 drivers/phy/ingenic/Makefile
 create mode 100644 drivers/phy/ingenic/phy-ingenic-usb.c


周琰杰 (Zhou Yanjie) (2):
  USB: PHY: JZ4770: Remove unnecessary function calls.
  PHY: Ingenic: Add USB PHY driver using generic PHY framework.

 drivers/phy/Kconfig                   |   1 +
 drivers/phy/Makefile                  |   1 +
 drivers/phy/ingenic/Kconfig           |  12 ++
 drivers/phy/ingenic/Makefile          |   2 +
 drivers/phy/ingenic/phy-ingenic-usb.c | 372 ++++++++++++++++++++++++++++++++++
 drivers/usb/phy/phy-jz4770.c          |   2 +-
 6 files changed, 389 insertions(+), 1 deletion(-)
 create mode 100644 drivers/phy/ingenic/Kconfig
 create mode 100644 drivers/phy/ingenic/Makefile
 create mode 100644 drivers/phy/ingenic/phy-ingenic-usb.c

-- 
2.11.0

