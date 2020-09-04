Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F7125D292
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 09:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbgIDHoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 03:44:17 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:54374 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgIDHoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 03:44:16 -0400
Received: from localhost (unknown [192.168.167.223])
        by lucky1.263xmail.com (Postfix) with ESMTP id CCA0FCC317;
        Fri,  4 Sep 2020 15:44:09 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P15471T140656136742656S1599205448140075_;
        Fri, 04 Sep 2020 15:44:09 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <476be6e72284b797704417aaac901372>
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
Subject: [PATCH v3 0/6] clk: rockchip: Support module build
Date:   Fri,  4 Sep 2020 15:43:59 +0800
Message-Id: <20200904074405.24439-1-zhangqing@rock-chips.com>
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
 drivers/clk/rockchip/clk-rk3399.c       |  55 ++++++++++++
 drivers/clk/rockchip/clk.c              | 113 +++++++++++++-----------
 drivers/clk/rockchip/softrst.c          |   7 +-
 8 files changed, 231 insertions(+), 84 deletions(-)
 create mode 100644 drivers/clk/rockchip/Kconfig


base-commit: b36c969764ab12faebb74711c942fa3e6eaf1e96
-- 
2.17.1



