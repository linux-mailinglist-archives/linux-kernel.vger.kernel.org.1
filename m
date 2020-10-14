Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A14928D88C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 04:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgJNCgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 22:36:06 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:43138 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgJNCgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 22:36:04 -0400
Received: from localhost (unknown [192.168.167.69])
        by lucky1.263xmail.com (Postfix) with ESMTP id D032FB5569;
        Wed, 14 Oct 2020 10:28:16 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P18907T140199837284096S1602642493459899_;
        Wed, 14 Oct 2020 10:28:16 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <fbf45e18dd1cbaac3d69411fdd11a126>
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
Subject: [PATCH v4 2/5] clk: rockchip: fix up the frac clk get rate error
Date:   Wed, 14 Oct 2020 10:28:09 +0800
Message-Id: <20201014022812.6733-3-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014022812.6733-1-zhangqing@rock-chips.com>
References: <20201014022812.6733-1-zhangqing@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

support fractional divider with one level and two level parent clock
.i.e:

normal fractional divider is:
                |--\
    ---[GPLL]---|   \                                      |--\
    ---[CPLL]---|mux|--[GATE]--[DIV]-----------------------|   \
    ---[NPLL]---|   /                |                     |mux|--[GATE]--[UART0]
                |--/                 |--[GATE]--[FRACDIV]--|   /
                                                           |--/
but rk3399 uart is special:
                |--\
    ---[GPLL]---|   \                                         |--\
    ---[CPLL]---|mux|--|--[GATE]--[DIV]-----------------------|   \
    ---[NPLL]---|   /  |                |                     |mux|--[GATE]--[UART1]
                |--/   |                |--[GATE]--[FRACDIV]--|   /
                       |                                      |--/
                       |
                       |                                      |--\
                       |--[GATE]--[DIV]-----------------------|   \
                       |                |                     |mux|--[GATE]--[UART2]
                       |                |--[GATE]--[FRACDIV]--|   /
                       |                                      |--/
                       |
                       |                                      |--\
                       |--[GATE]--[DIV]-----------------------|   \
                                        |                     |mux|--[GATE]--[UART3]
                                        |--[GATE]--[FRACDIV]--|   /
                                                              |--/

The special fractional divider, there are two levels of clock between FRACDIV and PLL.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index fac5a4a3f5c3..8f77c3f9fab7 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -190,16 +190,21 @@ static void rockchip_fractional_approximation(struct clk_hw *hw,
 	if (((rate * 20 > p_rate) && (p_rate % rate != 0)) ||
 	    (fd->max_prate && fd->max_prate < p_rate)) {
 		p_parent = clk_hw_get_parent(clk_hw_get_parent(hw));
-		p_parent_rate = clk_hw_get_rate(p_parent);
-		*parent_rate = p_parent_rate;
-		if (fd->max_prate && p_parent_rate > fd->max_prate) {
-			div = DIV_ROUND_UP(p_parent_rate, fd->max_prate);
-			*parent_rate = p_parent_rate / div;
+		if (!p_parent) {
+			*parent_rate = p_rate;
+		} else {
+			p_parent_rate = clk_hw_get_rate(p_parent);
+			*parent_rate = p_parent_rate;
+			if (fd->max_prate && p_parent_rate > fd->max_prate) {
+				div = DIV_ROUND_UP(p_parent_rate,
+						   fd->max_prate);
+				*parent_rate = p_parent_rate / div;
+			}
 		}
 
 		if (*parent_rate < rate * 20) {
-			pr_err("%s parent_rate(%ld) is low than rate(%ld)*20, fractional div is not allowed\n",
-			       clk_hw_get_name(hw), *parent_rate, rate);
+			pr_warn("%s p_rate(%ld) is low than rate(%ld)*20, use integer or half-div\n",
+				clk_hw_get_name(hw), *parent_rate, rate);
 			*m = 0;
 			*n = 1;
 			return;
-- 
2.17.1



