Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DFD229D45
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 18:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbgGVQld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 12:41:33 -0400
Received: from out28-75.mail.aliyun.com ([115.124.28.75]:38662 "EHLO
        out28-75.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgGVQlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 12:41:32 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3527336|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.0131328-0.00532331-0.981544;FP=0|0|0|0|0|-1|-1|-1;HT=e01l04362;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=22;RT=22;SR=0;TI=SMTPD_---.I6-OcxX_1595436029;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.I6-OcxX_1595436029)
          by smtp.aliyun-inc.com(10.147.40.200);
          Thu, 23 Jul 2020 00:41:25 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, mpm@selenic.com,
        herbert@gondor.apana.org.au, robh+dt@kernel.org
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, hadar.gat@arm.com,
        prasannatsmkumar@gmail.com, krzk@kernel.org, masahiroy@kernel.org,
        rdunlap@infradead.org, xuzaibo@huawei.com,
        daniel.thompson@linaro.org, tmaimon77@gmail.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: [PATCH 0/2] Add support for the RNG in Ingenic JZ4780 and X1000.
Date:   Thu, 23 Jul 2020 00:40:05 +0800
Message-Id: <20200722164007.77655-1-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.Add the RNG bindings for the JZ4780 SoC and the X1000 SoC
  from Ingenic.
2.Add JZ4780 SoC and X1000 SoC random number generator driver,
  based on PrasannaKumar Muralidharan's JZ4780 RNG driver.

周琰杰 (Zhou Yanjie) (2):
  dt-bindings: RNG: Add Ingenic RNG bindings.
  crypto: Ingenic: Add hardware RNG for Ingenic JZ4780 and X1000.

 .../devicetree/bindings/rng/ingenic,rng.yaml       |  36 +++++
 drivers/char/hw_random/Kconfig                     |  15 ++
 drivers/char/hw_random/Makefile                    |   1 +
 drivers/char/hw_random/ingenic-rng.c               | 154 +++++++++++++++++++++
 4 files changed, 206 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/ingenic,rng.yaml
 create mode 100644 drivers/char/hw_random/ingenic-rng.c

-- 
2.11.0

