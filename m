Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8E9268021
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 18:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgIMQLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 12:11:15 -0400
Received: from out28-101.mail.aliyun.com ([115.124.28.101]:59451 "EHLO
        out28-101.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgIMQLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 12:11:08 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4906068|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.00644634-0.00230636-0.991247;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03302;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=25;RT=25;SR=0;TI=SMTPD_---.IWac2C6_1600013452;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.IWac2C6_1600013452)
          by smtp.aliyun-inc.com(10.147.41.187);
          Mon, 14 Sep 2020 00:10:59 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, mpm@selenic.com,
        herbert@gondor.apana.org.au, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, hadar.gat@arm.com,
        geert+renesas@glider.be, krzk@kernel.org, wahrenst@gmx.net,
        masahiroy@kernel.org, tmaimon77@gmail.com, rdunlap@infradead.org,
        qianweili@huawei.com, daniel.thompson@linaro.org,
        xuzaibo@huawei.com, olivier.sobrie@silexinsight.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: [PATCH 0/2] Add support for the TRNG in Ingenic X1830.
Date:   Mon, 14 Sep 2020 00:10:19 +0800
Message-Id: <20200913161021.120226-1-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.Add the TRNG bindings for the X1830 SoC from Ingenic.
2.Add X1830 SoC digital true random number generator driver.

周琰杰 (Zhou Yanjie) (2):
  dt-bindings: RNG: Add Ingenic TRNG bindings.
  crypto: Ingenic: Add hardware TRNG for Ingenic X1830.

 .../devicetree/bindings/rng/ingenic,trng.yaml      |  43 ++++++
 drivers/char/hw_random/Kconfig                     |  14 ++
 drivers/char/hw_random/Makefile                    |   1 +
 drivers/char/hw_random/ingenic-trng.c              | 161 +++++++++++++++++++++
 4 files changed, 219 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/ingenic,trng.yaml
 create mode 100644 drivers/char/hw_random/ingenic-trng.c

-- 
2.11.0

