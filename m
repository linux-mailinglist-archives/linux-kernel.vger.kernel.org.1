Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A1728D88E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 04:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgJNCgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 22:36:10 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:45994 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbgJNCgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 22:36:04 -0400
Received: from localhost (unknown [192.168.167.69])
        by lucky1.263xmail.com (Postfix) with ESMTP id A55F3CCC83;
        Wed, 14 Oct 2020 10:28:15 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P18907T140199837284096S1602642493459899_;
        Wed, 14 Oct 2020 10:28:14 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <707f4ec6577f986d3b7610d3d3212a19>
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
Subject: [PATCH v4 0/5] clk: rockchip: Support for some new features
Date:   Wed, 14 Oct 2020 10:28:07 +0800
Message-Id: <20201014022812.6733-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Support for some new features
2. fix up some error

Chang in V4:
[PATCH v3 1/5] : Update the commit message.
[PATCH v3 2/5] : Update the commit message.

Chang in V3:
[PATCH v2 3/6] : It's been merged
So rebased and resubmit.

Chang in V2:
[PATCH v2 5/6] : fix up the Register error, and add delay.

Elaine Zhang (5):
  clk: rockchip: Add supprot to limit input rate for fractional divider
  clk: rockchip: fix up the frac clk get rate error
  clk: rockchip: add a clock-type for muxes based in the pmugrf
  clk: rockchip: add pll up and down when change pll freq
  clk: rockchip: support pll setting by auto

 drivers/clk/rockchip/clk-pll.c    | 236 ++++++++++++++++++++++++++++--
 drivers/clk/rockchip/clk-px30.c   |  29 ++--
 drivers/clk/rockchip/clk-rk3036.c |  13 +-
 drivers/clk/rockchip/clk-rk3128.c |  15 +-
 drivers/clk/rockchip/clk-rk3188.c |  24 +--
 drivers/clk/rockchip/clk-rk3228.c |  18 ++-
 drivers/clk/rockchip/clk-rk3288.c |  19 ++-
 drivers/clk/rockchip/clk-rk3308.c |  46 +++---
 drivers/clk/rockchip/clk-rk3328.c |  17 ++-
 drivers/clk/rockchip/clk-rk3368.c |  17 ++-
 drivers/clk/rockchip/clk-rk3399.c |  32 ++--
 drivers/clk/rockchip/clk-rv1108.c |  14 +-
 drivers/clk/rockchip/clk.c        |  39 ++++-
 drivers/clk/rockchip/clk.h        |  27 +++-
 include/linux/clk-provider.h      |   2 +
 15 files changed, 422 insertions(+), 126 deletions(-)

-- 
2.17.1



