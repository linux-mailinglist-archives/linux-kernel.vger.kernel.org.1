Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22D92C46C0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 18:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732776AbgKYR1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 12:27:15 -0500
Received: from out28-219.mail.aliyun.com ([115.124.28.219]:51401 "EHLO
        out28-219.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732763AbgKYR1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 12:27:15 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1100795|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00509026-0.00170274-0.993207;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047208;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.J.BPrxs_1606325224;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.J.BPrxs_1606325224)
          by smtp.aliyun-inc.com(10.147.41.137);
          Thu, 26 Nov 2020 01:27:11 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, mturquette@baylibre.com,
        paul@crapouillou.net
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Subject: [PATCH 0/4] Add new clocks for Ingenic SoCs.
Date:   Thu, 26 Nov 2020 01:26:14 +0800
Message-Id: <20201125172618.112707-1-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.Add "jz4780_core1_disable()" for disable the second core of JZ4780,
  prepare for later commits.
2.Add CIM, AIC, DMIC clocks for the X1000 SoC, and CIM, AIC, DMIC, I2S
  clocks for the X1830 SoC from Ingenic.
3.Fill unused bits in parents in jz4780-cgu.c, x1000-cgu.c, and
  x1830-cgu.c, these bits should be filled with -1.
4.Reformat code, add missing blank lines, remove unnecessary tabs,
  and align code.

周琰杰 (Zhou Yanjie) (4):
  clk: JZ4780: Add function for disable the second core.
  dt-bindings: clock: Add missing clocks for Ingenic SoCs.
  clk: Ingenic: Add missing clocks for Ingenic SoCs.
  clk: Ingenic: Fill unused bits in parents and reformat code.

 drivers/clk/ingenic/jz4780-cgu.c      |  33 ++++-
 drivers/clk/ingenic/x1000-cgu.c       |  39 +++--
 drivers/clk/ingenic/x1830-cgu.c       | 266 +++++++++++++++++++++++++++++-----
 include/dt-bindings/clock/x1000-cgu.h |   3 +
 include/dt-bindings/clock/x1830-cgu.h |   4 +
 5 files changed, 292 insertions(+), 53 deletions(-)

-- 
2.7.4

