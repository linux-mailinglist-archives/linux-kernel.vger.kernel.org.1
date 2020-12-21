Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C982DFDBC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 16:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgLUPx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 10:53:57 -0500
Received: from out28-52.mail.aliyun.com ([115.124.28.52]:43890 "EHLO
        out28-52.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgLUPx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 10:53:56 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1222173|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0028996-0.000354898-0.996746;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.J9pVTZZ_1608565975;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.J9pVTZZ_1608565975)
          by smtp.aliyun-inc.com(10.147.40.2);
          Mon, 21 Dec 2020 23:53:01 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     sboyd@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, mturquette@baylibre.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sihui.liu@ingenic.com, sernia.zhou@foxmail.com,
        paul@crapouillou.net
Subject: [PATCH v4 0/5] Add new clocks and fix bugs for Ingenic SoCs.
Date:   Mon, 21 Dec 2020 23:52:46 +0800
Message-Id: <1608565971-23895-1-git-send-email-zhouyanjie@wanyeetech.com>
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

v2->v3:
Correct the comment in x1000-cgu.c, change it from
"Custom (SoC-specific) OTG PHY" to "Custom (SoC-specific)",
since there is more than just the "OTG PHY" clock.

v3->v4:
1.The -1 used for placeholders on the unused bits of the
  parents in the custom clock should not be removed.
2.Move "JZ4780_CLK_CORE1" from the "Gate-only clocks"
  class to the "Custom (SoC-specific)" class, because
  it belongs to the custom clock.

周琰杰 (Zhou Yanjie) (5):
  clk: JZ4780: Add function for disable the second core.
  dt-bindings: clock: Add missing clocks for Ingenic SoCs.
  clk: Ingenic: Fix problem of MAC clock in Ingenic X1000 and X1830.
  clk: Ingenic: Add missing clocks for Ingenic SoCs.
  clk: Ingenic: Clean up and reformat the code.

 drivers/clk/ingenic/jz4725b-cgu.c     |  50 ++---
 drivers/clk/ingenic/jz4740-cgu.c      |  50 ++---
 drivers/clk/ingenic/jz4770-cgu.c      |  79 ++++----
 drivers/clk/ingenic/jz4780-cgu.c      | 156 +++++++++-------
 drivers/clk/ingenic/x1000-cgu.c       | 332 +++++++++++++++++++++++++++------
 drivers/clk/ingenic/x1830-cgu.c       | 341 +++++++++++++++++++++++++++-------
 include/dt-bindings/clock/x1000-cgu.h |   5 +
 include/dt-bindings/clock/x1830-cgu.h |   5 +
 8 files changed, 737 insertions(+), 281 deletions(-)

-- 
2.7.4

