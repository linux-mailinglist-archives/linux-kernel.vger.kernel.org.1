Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BD1268287
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 04:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgINCWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 22:22:40 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:54184 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgINCWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 22:22:37 -0400
Received: from localhost (unknown [192.168.167.172])
        by lucky1.263xmail.com (Postfix) with ESMTP id 5B5B3EF47A;
        Mon, 14 Sep 2020 10:22:31 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P4753T140065155360512S1600050147471714_;
        Mon, 14 Sep 2020 10:22:30 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <210df35dbb0fec22d1ad2db6c944835a>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     heiko@sntech.de
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, xxx@rock-chips.com,
        xf@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v4 3/6] clk: rockchip: Export rockchip_register_softrst()
Date:   Mon, 14 Sep 2020 10:22:22 +0800
Message-Id: <20200914022225.23613-4-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914022225.23613-1-zhangqing@rock-chips.com>
References: <20200914022225.23613-1-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is used by the Rockchip clk driver, export it to allow that
driver to be compiled as a module..

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
 drivers/clk/rockchip/softrst.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/rockchip/softrst.c b/drivers/clk/rockchip/softrst.c
index 5f1ff5e47c4f..5d07266745b8 100644
--- a/drivers/clk/rockchip/softrst.c
+++ b/drivers/clk/rockchip/softrst.c
@@ -77,9 +77,9 @@ static const struct reset_control_ops rockchip_softrst_ops = {
 	.deassert	= rockchip_softrst_deassert,
 };
 
-void __init rockchip_register_softrst(struct device_node *np,
-				      unsigned int num_regs,
-				      void __iomem *base, u8 flags)
+void rockchip_register_softrst(struct device_node *np,
+			       unsigned int num_regs,
+			       void __iomem *base, u8 flags)
 {
 	struct rockchip_softrst *softrst;
 	int ret;
@@ -107,3 +107,4 @@ void __init rockchip_register_softrst(struct device_node *np,
 		kfree(softrst);
 	}
 };
+EXPORT_SYMBOL_GPL(rockchip_register_softrst);
-- 
2.17.1



