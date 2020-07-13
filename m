Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4384521D890
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 16:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbgGMOcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 10:32:45 -0400
Received: from out28-145.mail.aliyun.com ([115.124.28.145]:58087 "EHLO
        out28-145.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbgGMOcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:32:45 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3861802|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00486371-0.00101582-0.99412;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16384;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.I19VHhZ_1594650754;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.I19VHhZ_1594650754)
          by smtp.aliyun-inc.com(10.147.41.158);
          Mon, 13 Jul 2020 22:32:40 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     balbi@kernel.org, robh+dt@kernel.org
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, paul@crapouillou.net
Subject: [PATCH v2 0/3] Add USB PHY support for new Ingenic SoCs.
Date:   Mon, 13 Jul 2020 22:32:08 +0800
Message-Id: <20200713143212.126399-1-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1->v2:
Add support for the JZ4780 SoC.

周琰杰 (Zhou Yanjie) (3):
  dt-bindings: USB: Add bindings for new Ingenic SoCs.
  USB: PHY: JZ4770: Add support for new Ingenic SoCs.
  USB: PHY: JZ4770: Reformat the code to align it.

 .../bindings/usb/ingenic,jz4770-phy.yaml           |   6 +-
 drivers/usb/phy/Kconfig                            |   4 +-
 drivers/usb/phy/phy-jz4770.c                       | 256 ++++++++++++++-------
 3 files changed, 181 insertions(+), 85 deletions(-)

-- 
2.11.0

