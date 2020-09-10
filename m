Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75BE263B61
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 05:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbgIJDZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 23:25:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11334 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729719AbgIJDXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 23:23:02 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8CF1A40AD90FAFAC2985;
        Thu, 10 Sep 2020 11:22:59 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 10 Sep 2020 11:22:50 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jianguo Chen <chenjianguo3@huawei.com>
Subject: [PATCH 0/6] clocksource: sp804: add support for Hisilicon sp804 timer
Date:   Thu, 10 Sep 2020 11:14:13 +0800
Message-ID: <20200910031419.2790-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM SP804 supports a maximum of 32-bit counter, but Hisilicon extends
it to 64-bit. That means, the registers: TimerXload, TimerXValue and
TimerXBGLoad are 64bits, all other registers are the same as those in the
SP804. The driver code can be completely reused except that the register
offset is different

The register offset differences between ARM-SP804 and HISI-SP804 are as follows:

	ARM-SP804			HISI-SP804
TIMER_LOAD      0x00		HISI_TIMER_LOAD         0x00
				HISI_TIMER_LOAD_H       0x04
TIMER_VALUE     0x04		HISI_TIMER_VALUE        0x08
				HISI_TIMER_VALUE_H      0x0c
TIMER_CTRL      0x08		HISI_TIMER_CTRL         0x10
TIMER_INTCLR    0x0c		HISI_TIMER_INTCLR       0x14
TIMER_RIS       0x10		HISI_TIMER_RIS          0x18
TIMER_MIS       0x14		HISI_TIMER_MIS          0x1c
TIMER_BGLOAD    0x18		HISI_TIMER_BGLOAD       0x20
				HISI_TIMER_BGLOAD_H     0x24
TIMER_2_BASE    0x20		HISI_TIMER_2_BASE       0x40
----------------

In order to make the timer-sp804 driver support both ARM-SP804 and HISI-SP804.
Create a new structure "sp804_clkevt" to record the calculated registers
address in advance, avoid judging and calculating the register address every
place that is used.

For example:
	struct sp804_timer arm_sp804_timer = {
		.ctrl	= TIMER_CTRL,
	};

	struct sp804_timer hisi_sp804_timer = {
		.ctrl	= HISI_TIMER_CTRL,
	};

	struct sp804_clkevt clkevt;

In the initialization phase:
	if (hisi_sp804)
		clkevt.ctrl = base + hisi_sp804_timer.ctrl;
	else if (arm_sp804)
		clkevt.ctrl = base + arm_sp804_timer.ctrl;

After initialization:
-	writel(0, base + TIMER_CTRL);
+	writel(0, clkevt.ctrl);
----------------

Additional information:
These patch series are the V2 of https://lore.kernel.org/patchwork/cover/681876/
And many of the main ideas in https://lore.kernel.org/patchwork/patch/681875/ have been considered.
Thanks for Daniel Lezcano's review comments.


Kefeng Wang (1):
  clocksource: sp804: cleanup clk_get_sys()

Zhen Lei (5):
  clocksource: sp804: remove unused sp804_timer_disable() and
    timer-sp804.h
  clocksource: sp804: prepare for support non-standard register offset
  clocksource: sp804: support non-standard register offset
  clocksource: sp804: add support for Hisilicon sp804 timer
  clocksource: sp804: enable Hisilicon sp804 timer 64bit mode

 drivers/clocksource/timer-sp.h    |  47 ++++++++
 drivers/clocksource/timer-sp804.c | 194 ++++++++++++++++++++----------
 include/clocksource/timer-sp804.h |  29 -----
 3 files changed, 178 insertions(+), 92 deletions(-)
 delete mode 100644 include/clocksource/timer-sp804.h

-- 
2.26.0.106.g9fadedd


