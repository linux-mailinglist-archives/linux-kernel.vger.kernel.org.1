Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D0E229E49
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 19:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgGVRS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 13:18:57 -0400
Received: from out28-98.mail.aliyun.com ([115.124.28.98]:50175 "EHLO
        out28-98.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbgGVRS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:18:57 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2956703|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.054435-0.000271357-0.945294;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03307;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.I6.3qla_1595438306;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.I6.3qla_1595438306)
          by smtp.aliyun-inc.com(10.147.41.138);
          Thu, 23 Jul 2020 01:18:53 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     daniel.lezcano@linaro.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        tglx@linutronix.de, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, paul@crapouillou.net
Subject: [PATCH v11 0/2] Add support for the OST in Ingenic X1000.
Date:   Thu, 23 Jul 2020 01:18:02 +0800
Message-Id: <20200722171804.97559-1-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v10->v11:
Fix typos.

周琰杰 (Zhou Yanjie) (2):
  dt-bindings: timer: Add Ingenic X1000 OST bindings.
  clocksource: Ingenic: Add support for the Ingenic X1000 OST.

 .../devicetree/bindings/timer/ingenic,sysost.yaml  |  63 +++
 drivers/clocksource/Kconfig                        |  12 +-
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/ingenic-sysost.c               | 539 +++++++++++++++++++++
 include/dt-bindings/clock/ingenic,sysost.h         |  12 +
 5 files changed, 626 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
 create mode 100644 drivers/clocksource/ingenic-sysost.c
 create mode 100644 include/dt-bindings/clock/ingenic,sysost.h

-- 
2.11.0

