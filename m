Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF8626FE59
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 15:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgIRNXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 09:23:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13308 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726129AbgIRNXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:23:12 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8FD234D8814BFEC69583;
        Fri, 18 Sep 2020 21:23:08 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 21:22:58 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jianguo Chen <chenjianguo3@huawei.com>
Subject: [PATCH v3 0/9] clocksource: sp804: add support for Hisilicon sp804 timer
Date:   Fri, 18 Sep 2020 21:22:28 +0800
Message-ID: <20200918132237.3552-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 --> v3:
1. Move the marcos of Hisilicon 64-bit timer, such as HISI_TIMER_LOAD, from
   "drivers/clocksource/timer-sp.h" into "drivers/clocksource/timer-sp804.c",
   involved Patch7-8.
2. Because the DT binding of ARM SP-804 has been converted to json-schema recently,
   so rewrote Patch9, it based on below patch
   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/patch/?id=a85a4aa32ab9568751b7aff8bd33e1b44b1cd3a1
3. Other patches have no chnage.


v1 --> v2:
1. Split the Patch 3 of v1 into three patches: Patch 3-5
2. Change compatible "hisi,sp804" to "hisilicon,sp804" in Patch 7.
3. Add dt-binding description of "hisilicon,sp804", Patch 9

Other patches are not changed.


v1:
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

Zhen Lei (8):
  clocksource: sp804: remove unused sp804_timer_disable() and
    timer-sp804.h
  clocksource: sp804: delete the leading "__" of some functions
  clocksource: sp804: remove a mismatched comment
  clocksource: sp804: prepare for support non-standard register offset
  clocksource: sp804: support non-standard register offset
  clocksource: sp804: add support for Hisilicon sp804 timer
  clocksource: sp804: enable Hisilicon sp804 timer 64bit mode
  dt-bindings: sp804: add support for Hisilicon sp804 timer

 .../devicetree/bindings/timer/arm,sp804.yaml       |   7 +-
 drivers/clocksource/timer-sp.h                     |  32 ++++
 drivers/clocksource/timer-sp804.c                  | 210 ++++++++++++++-------
 include/clocksource/timer-sp804.h                  |  29 ---
 4 files changed, 185 insertions(+), 93 deletions(-)
 delete mode 100644 include/clocksource/timer-sp804.h

-- 
1.8.3


