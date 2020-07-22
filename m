Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B82228E3F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 04:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbgGVCkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 22:40:03 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:42974 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731614AbgGVCkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 22:40:03 -0400
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Jul 2020 22:40:02 EDT
Received: from localhost (unknown [192.168.167.13])
        by lucky1.263xmail.com (Postfix) with ESMTP id 184F0B01D2;
        Wed, 22 Jul 2020 10:32:35 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P17843T139821074855680S1595385153515891_;
        Wed, 22 Jul 2020 10:32:35 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <0e840a0189b44ddac21ac488ab1df301>
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
Subject: [PATCH v1] clk: Export __clk_lookup()
Date:   Wed, 22 Jul 2020 10:32:30 +0800
Message-Id: <20200722023230.10826-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export __clk_lookup() to support user built as module.

ERROR:
drivers/clk/rockchip/clk.ko: In function
`rockchip_clk_protect_critical':
drivers/clk/rockchip/clk.c:741:
undefined reference to `__clk_lookup'

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/clk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 3f588ed06ce3..600284fbb257 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -618,6 +618,7 @@ struct clk *__clk_lookup(const char *name)
 
 	return !core ? NULL : core->hw->clk;
 }
+EXPORT_SYMBOL_GPL(__clk_lookup);
 
 static void clk_core_get_boundaries(struct clk_core *core,
 				    unsigned long *min_rate,
-- 
2.17.1



