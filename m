Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4114127BB23
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 04:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbgI2Csa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 22:48:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38456 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726064AbgI2Csa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 22:48:30 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 581AE6F5C321A3400CCE;
        Tue, 29 Sep 2020 10:48:28 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 29 Sep 2020 10:48:20 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Libin <huawei.libin@huawei.com>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>
Subject: [PATCH v6 0/1] irqchip: dw-apb-ictl: support hierarchy irq domain
Date:   Tue, 29 Sep 2020 10:48:10 +0800
Message-ID: <20200929024811.2245-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v6 -- > v7
All other 5 patches are applied, this is the only one left. And it depends
on: https://www.spinics.net/lists/devicetree/msg379734.html

The modifications of this version are:
1. Remove the unneeded allOf. It's already selected based on node name.
   allOf:
     - $ref: /schemas/interrupt-controller.yaml#
2. Drop the descriptionss of the properties: reg, interrupts, #interrupt-cells.
   They are common and not new to this binding. 
3. add "additionalProperties: false"
4. remove the unused labels in "example:" 
   -    aic: interrupt-controller@3000 {
   -    vic: interrupt-controller@10130000 {
   +    interrupt-controller@3000 {
   +    interrupt-controller@10130000 {


v5 --> v6:
1. add Reviewed-by: Rob Herring <robh@kernel.org> for Patch 4.
2. Some modifications are made to Patch 5:
   1) add " |" for each "description:" property if its content exceeds one line,
      to tell the yaml keep the "newline" character.
   2) add "..." to mark the end of the yaml file.
   3) Change the name list of maintainers to the author of "snps,dw-apb-ictl.txt"
	 maintainers:
	-  - Marc Zyngier <marc.zyngier@arm.com>
	+  - Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
   4) add "maxItems: 1" for property "reg".
   5) for property "interrupts":
	 interrupts:
	-    minItems: 1
	-    maxItems: 65
	+    maxItems: 1
   6) move below descriptions under the top level property "description:"
	description: |
	  Synopsys DesignWare provides interrupt controller IP for APB known as
	  dw_apb_ictl. The IP is used as secondary interrupt controller in some SoCs
	  with APB bus, e.g. Marvell Armada 1500. It can also be used as primary
	  interrupt controller in some SoCs, e.g. Hisilicon SD5203.

	+  The interrupt sources map to the corresponding bits in the interrupt
	+  registers, i.e.
	+  - 0 maps to bit 0 of low interrupts,
	+  - 1 maps to bit 1 of low interrupts,
	+  - 32 maps to bit 0 of high interrupts,
	+  - 33 maps to bit 1 of high interrupts,
	+  - (optional) fast interrupts start at 64.
	+

   For more details of 2-6), please refer https://lkml.org/lkml/2020/9/24/13

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

Zhen Lei (1):
  dt-bindings: dw-apb-ictl: convert to json-schema

 .../interrupt-controller/snps,dw-apb-ictl.txt      | 43 --------------
 .../interrupt-controller/snps,dw-apb-ictl.yaml     | 68 ++++++++++++++++++++++
 2 files changed, 68 insertions(+), 43 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.yaml

-- 
1.8.3


