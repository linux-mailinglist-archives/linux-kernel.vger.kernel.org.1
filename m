Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA272991B6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784666AbgJZQA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:00:28 -0400
Received: from out28-194.mail.aliyun.com ([115.124.28.194]:54653 "EHLO
        out28-194.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1784632AbgJZP7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:59:16 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1646108|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00466636-0.000126187-0.995207;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.IohI8W7_1603727944;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.IohI8W7_1603727944)
          by smtp.aliyun-inc.com(10.147.40.2);
          Mon, 26 Oct 2020 23:59:11 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        daniel.lezcano@linaro.org, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Subject: [PATCH v3 0/1] Add macro definition for the upcoming new OST driver.
Date:   Mon, 26 Oct 2020 23:58:41 +0800
Message-Id: <20201026155842.10196-1-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new macro definition to "ingenic,sysost.h", exchange the original
ABI values of OST_CLK_PERCPU_TIMER and OST_CLK_GLOBAL_TIMER, prepare
for the upcoming new OST driver.

I'm sure that exchanging the ABI values of OST_CLK_PERCPU_TIMER and
OST_CLK_GLOBAL_TIMER will not affect the existing related drivers and
the SoCs whitch using these drivers, so we should be able to exchange
them safely.

v1->v2:
Rewrite the commit message so that each line is less than 80 characters.

v2->v3:
Add the description of why the exchange of ABI values will not affect
the existing driver into the commit message.

周琰杰 (Zhou Yanjie) (1):
  dt-bindings: timer: Add new OST support for the upcoming new driver.

 include/dt-bindings/clock/ingenic,sysost.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 
2.11.0

