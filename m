Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA042DB4CD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 21:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbgLOUEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 15:04:31 -0500
Received: from out28-218.mail.aliyun.com ([115.124.28.218]:59216 "EHLO
        out28-218.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgLOUEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:04:08 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1431498|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00283635-6.67683e-05-0.997097;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047209;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.J7YTY-B_1608062595;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.J7YTY-B_1608062595)
          by smtp.aliyun-inc.com(10.147.41.187);
          Wed, 16 Dec 2020 04:03:24 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     sboyd@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, mturquette@baylibre.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sihui.liu@ingenic.com, sernia.zhou@foxmail.com,
        paul@crapouillou.net
Subject: [PATCH v2 0/5] Add new clocks and fix bugs for Ingenic SoCs.
Date:   Wed, 16 Dec 2020 04:02:47 +0800
Message-Id: <1608062572-42156-1-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1->v2:
1.Add Paul Cercueil's Reviewed-by for [1/5] & [2/5],
  add Rob Herring's Acked-by for [2/5].
2.Add MACPHY and I2S for X1000, add MACPHY for X1830,
  and fix bugs in MAC clock.
3.Clean up code, remove unnecessary -1 and commas and
  tabs from all the xxxx-cgu.c files.

周琰杰 (Zhou Yanjie) (5):
  clk: JZ4780: Add function for disable the second core.
  dt-bindings: clock: Add missing clocks for Ingenic SoCs.
  clk: Ingenic: Fix problem of MAC clock in Ingenic X1000 and X1830.
  clk: Ingenic: Add missing clocks for Ingenic SoCs.
  clk: Ingenic: Clean up and reformat the code.

 drivers/clk/ingenic/jz4725b-cgu.c     |  50 +++---
 drivers/clk/ingenic/jz4740-cgu.c      |  50 +++---
 drivers/clk/ingenic/jz4770-cgu.c      |  80 ++++-----
 drivers/clk/ingenic/jz4780-cgu.c      | 143 ++++++++-------
 drivers/clk/ingenic/x1000-cgu.c       | 312 ++++++++++++++++++++++++++------
 drivers/clk/ingenic/x1830-cgu.c       | 325 +++++++++++++++++++++++++++-------
 include/dt-bindings/clock/x1000-cgu.h |   5 +
 include/dt-bindings/clock/x1830-cgu.h |   5 +
 8 files changed, 695 insertions(+), 275 deletions(-)

-- 
2.7.4

