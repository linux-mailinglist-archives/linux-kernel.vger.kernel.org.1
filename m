Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5143267E2A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 08:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgIMGfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 02:35:23 -0400
Received: from out28-171.mail.aliyun.com ([115.124.28.171]:56984 "EHLO
        out28-171.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgIMGfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 02:35:19 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2063323|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0678196-0.0202119-0.911969;FP=0|0|0|0|0|-1|-1|-1;HT=e01l04362;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.IWSCCS3_1599978900;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.IWSCCS3_1599978900)
          by smtp.aliyun-inc.com(10.147.42.16);
          Sun, 13 Sep 2020 14:35:15 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, kishon@ti.com,
        vkoul@kernel.org, paul@crapouillou.net
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: [PATCH v3 0/2] Use the generic PHY framework for Ingenic USB PHY.
Date:   Sun, 13 Sep 2020 14:34:28 +0800
Message-Id: <20200913063430.9622-1-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2->v3:
1.Remove unnecessary "of_match_ptr()" before the move to the generic PHY.
2.Change "depends on (MACH_INGENIC && MIPS) || COMPILE_TEST" to
  "depends on MIPS || COMPILE_TEST".
3.Keep the adjustments of "ingenic_usb_phy_init()" and "ingenic_usb_phu_exit()"
  positions in v2 to make them consistent with the order in "ingenic_usb_phy_ops",
  keep the adjustments to the positions of "ingenic_usb_phy_of_matches[]" in v2
  to keep them consistent with the styles of other USB PHY drivers. And remove
  some unnecessary changes to reduce the diff size.

周琰杰 (Zhou Yanjie) (2):
  USB: PHY: JZ4770: Remove unnecessary function calls.
  USB: PHY: JZ4770: Use the generic PHY framework.

 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/ingenic/Kconfig                        |  12 ++
 drivers/phy/ingenic/Makefile                       |   2 +
 .../phy-jz4770.c => phy/ingenic/phy-ingenic-usb.c} | 211 +++++++++++----------
 drivers/usb/phy/Kconfig                            |   8 -
 drivers/usb/phy/Makefile                           |   1 -
 7 files changed, 129 insertions(+), 107 deletions(-)
 create mode 100644 drivers/phy/ingenic/Kconfig
 create mode 100644 drivers/phy/ingenic/Makefile
 rename drivers/{usb/phy/phy-jz4770.c => phy/ingenic/phy-ingenic-usb.c} (70%)

-- 
2.11.0

