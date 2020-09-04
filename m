Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811FB25D29A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 09:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbgIDHol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 03:44:41 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:48588 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbgIDHoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 03:44:16 -0400
Received: from localhost (unknown [192.168.167.223])
        by lucky1.263xmail.com (Postfix) with ESMTP id EE542B2236;
        Fri,  4 Sep 2020 15:44:11 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P15471T140656136742656S1599205448140075_;
        Fri, 04 Sep 2020 15:44:11 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <9a7e37fcb4d78403b256b4ee0b674a65>
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
Subject: [PATCH v3 3/6] clk: rockchip: Export rockchip_register_softrst()
Date:   Fri,  4 Sep 2020 15:44:02 +0800
Message-Id: <20200904074405.24439-4-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904074405.24439-1-zhangqing@rock-chips.com>
References: <20200904074405.24439-1-zhangqing@rock-chips.com>
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
index 5f1ff5e47c4f..caba9055090b 100644
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
+EXPORT_SYMBOL(rockchip_register_softrst);
-- 
2.17.1



