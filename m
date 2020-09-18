Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7207D26FB56
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgIRLWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:22:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33906 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725900AbgIRLWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:22:54 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1F4EFB19B69D7C9B0CE8;
        Fri, 18 Sep 2020 19:22:52 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 19:22:45 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Alexey Brodkin" <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-snps-arc <linux-snps-arc@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Haoyu Lv <lvhaoyu@huawei.com>, Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v5 0/6] irqchip: dw-apb-ictl: support hierarchy irq domain
Date:   Fri, 18 Sep 2020 19:21:56 +0800
Message-ID: <20200918112202.3418-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4 --> v5:
1. Add WARN_ON(1) in set_handle_irq() if !GENERIC_IRQ_MULTI_HANDLER
2. Convert "snps,dw-apb-ictl.txt" to "snps,dw-apb-ictl.yaml"
3. Fix the errors detected by "snps,dw-apb-ictl.yaml" on arch/arc

v3 --> v4:
1. remove "gc->chip_types[0].chip.irq_eoi = irq_gc_noop;", the "chip.irq_eoi" hook
   is not needed by handle_level_irq(). Thanks for Marc Zyngier's review.
2. Add a new patch: define an empty function set_handle_irq() if !GENERIC_IRQ_MULTI_HANDLER
   to avoid compilation error on arch/arc system.

v2 --> v3:
1. change (1 << hwirq) to BIT(hwirq).
2. change __exception_irq_entry to __irq_entry, so we can "#include <linux/interrupt.h>"
   instead of "#include <asm/exception.h>". Ohterwise, an compilation error will be
   reported on arch/csky.
   drivers/irqchip/irq-dw-apb-ictl.c:20:10: fatal error: asm/exception.h: No such file or directory
3. use "if (!parent || (np == parent))" to determine whether it is primary interrupt controller.
4. make the primary interrupt controller case also use function handle_level_irq(), I used 
   handle_fasteoi_irq() as flow_handler before.
5. Other minor changes are not detailed.

v1 --> v2:
According to Marc Zyngier's suggestion, discard adding an independent SD5203-VIC
driver, but make the dw-apb-ictl irqchip driver to support hierarchy irq domain.
It was originally available only for secondary interrupt controller, now it can
also be used as primary interrupt controller. The related dt-bindings is updated
appropriately.

Add "Suggested-by: Marc Zyngier <maz@kernel.org>".
Add "Tested-by: Haoyu Lv <lvhaoyu@huawei.com>".


v1:
The interrupt controller of SD5203 SoC is VIC(vector interrupt controller), it's
based on Synopsys DesignWare APB interrupt controller (dw_apb_ictl) IP, but it
can not directly use dw_apb_ictl driver. The main reason is that VIC is used as
primary interrupt controller and dw_apb_ictl driver worked for secondary
interrupt controller. So add a new driver: "hisilicon,sd5203-vic".

Zhen Lei (6):
  genirq: define an empty function set_handle_irq() if
    !GENERIC_IRQ_MULTI_HANDLER
  irqchip: dw-apb-ictl: prepare for support hierarchy irq domain
  irqchip: dw-apb-ictl: support hierarchy irq domain
  dt-bindings: dw-apb-ictl: support hierarchy irq domain
  dt-bindings: dw-apb-ictl: convert to json-schema
  ARC: [dts] fix the errors detected by dtbs_check

 .../interrupt-controller/snps,dw-apb-ictl.txt      | 31 --------
 .../interrupt-controller/snps,dw-apb-ictl.yaml     | 75 +++++++++++++++++++
 arch/arc/boot/dts/axc001.dtsi                      |  2 +-
 arch/arc/boot/dts/axc003.dtsi                      |  2 +-
 arch/arc/boot/dts/axc003_idu.dtsi                  |  2 +-
 arch/arc/boot/dts/vdk_axc003.dtsi                  |  2 +-
 arch/arc/boot/dts/vdk_axc003_idu.dtsi              |  2 +-
 drivers/irqchip/Kconfig                            |  2 +-
 drivers/irqchip/irq-dw-apb-ictl.c                  | 83 ++++++++++++++++++----
 include/linux/irq.h                                |  6 ++
 10 files changed, 158 insertions(+), 49 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.yaml

-- 
1.8.3


