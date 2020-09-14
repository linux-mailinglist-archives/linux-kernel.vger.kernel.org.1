Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2158268291
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 04:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgINCXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 22:23:20 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:41140 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgINCWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 22:22:38 -0400
Received: from localhost (unknown [192.168.167.172])
        by lucky1.263xmail.com (Postfix) with ESMTP id 63256C2C0D;
        Mon, 14 Sep 2020 10:22:29 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P4753T140065155360512S1600050147471714_;
        Mon, 14 Sep 2020 10:22:28 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <a695b2afa79fefe3d9f3f4ce7255892b>
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
Subject: [PATCH v4 0/6] clk: rockchip: Support module build
Date:   Mon, 14 Sep 2020 10:22:19 +0800
Message-Id: <20200914022225.23613-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export some APIs for module drivers.
Fix the clock config to support module build.
Fix the clk driver init, add module author, description
and license to support building RK3399 SoC clock driver as module.

Change in V2:
[PATCH v2 1/6]: remove "clk",and check "hw" isn't an error value.
[PATCH v2 6/6]: store a function pointer in the match data.

Change in V3:
[PATCH v3 1/6]: fix up the compiler warning.
drivers/clk/rockchip/clk.c: In function 'rockchip_clk_register_branch':
>> drivers/clk/rockchip/clk.c:52:6: warning: variable 'ret' set but not
>> used [-Wunused-but-set-variable]
      52 |  int ret;
         |      ^~~

Change in V4:
[PATCH v4 2/6]: Use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL.
[PATCH v4 3/6]: Use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL.
[PATCH v4 4/6]: Use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL.
[PATCH v4 5/6]: Mark CONFIG_CLK_xxx to "bool".
[PATCH v4 6/6]: add .suppress_bind_attrs = true

Elaine Zhang (6):
  clk: rockchip: Use clk_hw_register_composite instead of
    clk_register_composite calls
  clk: rockchip: Export rockchip_clk_register_ddrclk()
  clk: rockchip: Export rockchip_register_softrst()
  clk: rockchip: Export some clock common APIs for module drivers
  clk: rockchip: fix the clk config to support module build
  clk: rockchip: rk3399: Support module build

 drivers/clk/Kconfig                     |   1 +
 drivers/clk/rockchip/Kconfig            |  78 ++++++++++++++++
 drivers/clk/rockchip/Makefile           |  42 ++++-----
 drivers/clk/rockchip/clk-ddr.c          |   1 +
 drivers/clk/rockchip/clk-half-divider.c |  18 ++--
 drivers/clk/rockchip/clk-rk3399.c       |  56 ++++++++++++
 drivers/clk/rockchip/clk.c              | 113 +++++++++++++-----------
 drivers/clk/rockchip/softrst.c          |   7 +-
 8 files changed, 232 insertions(+), 84 deletions(-)
 create mode 100644 drivers/clk/rockchip/Kconfig


base-commit: b36c969764ab12faebb74711c942fa3e6eaf1e96
-- 
2.17.1



