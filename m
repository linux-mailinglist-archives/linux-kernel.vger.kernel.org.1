Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B590F290A16
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 18:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410964AbgJPQ4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 12:56:45 -0400
Received: from out28-4.mail.aliyun.com ([115.124.28.4]:49825 "EHLO
        out28-4.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410937AbgJPQ4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:56:40 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2491657|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00523538-0.000137636-0.994627;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.IkJvY3r_1602867387;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.IkJvY3r_1602867387)
          by smtp.aliyun-inc.com(10.147.40.26);
          Sat, 17 Oct 2020 00:56:35 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 0/1] Add macro definition for the upcoming new OST driver.
Date:   Sat, 17 Oct 2020 00:56:01 +0800
Message-Id: <20201016165602.55720-1-zhouyanjie@wanyeetech.com>
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

周琰杰 (Zhou Yanjie) (1):
  dt-bindings: timer: Add new OST support for the upcoming new driver.

 include/dt-bindings/clock/ingenic,sysost.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 
2.11.0

