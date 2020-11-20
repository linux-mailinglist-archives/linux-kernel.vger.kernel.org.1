Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5593C2BB0BD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbgKTQlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:41:17 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:55675 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729311AbgKTQlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:41:15 -0500
X-Originating-IP: 86.194.86.39
Received: from localhost (lfbn-lyo-1-1010-39.w86-194.abo.wanadoo.fr [86.194.86.39])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id F3A121BF209;
        Fri, 20 Nov 2020 16:41:12 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        <Steen.Hegelund@microchip.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v4 0/6] Extend irqchip ocelot driver to support other SoCs
Date:   Fri, 20 Nov 2020 17:41:02 +0100
Message-Id: <20201120164108.2096359-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Ocelot SoC belongs to a larger family of SoCs which use the same
interrupt controller with a few variation.

This series of patches add support for Luton, Serval and Jaguar2, they
are all MIPS based.

The first patches of the series also updates the binding documentation
with the new compatible strings.

Gregory

Changelog:
v3 -> v4
 - Fix example in binding adding #address-cells property.

 - Split the intial "irqchip: ocelot: Add support for Luton platforms"
   patch with a new patch "irqchip: ocelot: prepare to support more
   SoC"

 - Move from u32 to u8 the type used inside the "struct chip_props"

 - Keep the function ocelot_irq_unmask as is and use generic function
   irq_gc_mask_disable_reg and irq_gc_unmask_enable_reg for Luton.

 - Removed the irq_set_irqchip_state callback, actually this function
   was never called on this platform and seemed in the end useless.

 - Add acked-by from Alexandre on the last 2 patches.

v2 -> v3
 - Fix new-line-at-end-of-file error in the yaml file

v1 -> v2:
 - Convert the binding to yaml
 - Squashed the patches adding new binding in a single one

Gregory CLEMENT (6):
  dt-bindings: interrupt-controller: convert icpu intr bindings to
    json-schema
  dt-bindings: interrupt-controller: Add binding for few Microsemi
    interrupt controllers
  irqchip: ocelot: prepare to support more SoC
  irqchip: ocelot: Add support for Luton platforms
  irqchip: ocelot: Add support for Serval platforms
  irqchip: ocelot: Add support for Jaguar2 platforms

 .../mscc,ocelot-icpu-intr.txt                 |  21 ---
 .../mscc,ocelot-icpu-intr.yaml                |  64 ++++++++
 drivers/irqchip/irq-mscc-ocelot.c             | 146 +++++++++++++++---
 3 files changed, 187 insertions(+), 44 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml

-- 
2.29.2

