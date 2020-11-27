Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F7B2C67A6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 15:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbgK0OPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 09:15:49 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:44457 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730452AbgK0OPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 09:15:48 -0500
X-UUID: 8978fd3abd0e426fabbd4ebd9e976a26-20201127
X-UUID: 8978fd3abd0e426fabbd4ebd9e976a26-20201127
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <hanks.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 259538449; Fri, 27 Nov 2020 22:15:41 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 27 Nov 2020 22:15:32 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 27 Nov 2020 22:15:32 +0800
From:   Hanks Chen <hanks.chen@mediatek.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        CC Hwang <cc.hwang@mediatek.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        Hanks Chen <hanks.chen@mediatek.com>
Subject: Support 1 of N SPI interrupt for interrupt distribution
Date:   Fri, 27 Nov 2020 22:15:28 +0800
Message-ID: <1606486531-25719-1-git-send-email-hanks.chen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*** BLURB HERE ***
The GICv3 supports 1 of N selection of SPI interrupts.
When the GICD_IROUTERn.Interrupt_Routing_Mode == 1, the GIC selects
the appropriate core for a SPI.

Actually, dispatch the interrupt by hardware Interrupt Control Unit
is more efficient than irqbalance of software logic
and no need to implement software contoller to decide the targeted CPU
on various platform.

In order to reduce interrupt latency, all interrupts are targeted to
each online CPU defaultly by 1 of N selection of SPI interrupts.
That is, SPI interrupts might be serviced simultaneously on different CPUs.

[default policy]
AS-IS (target to boot CPU)
       CPU0       CPU1       CPU2       CPU3
 29:     92          0          0          0     GICv3 141 Level   ttyS0

TO-BE (enable ARM_IRQ_TARGET_ALL)
       CPU0       CPU1       CPU2       CPU3
 29:     23         23         24         22     GICv3 141 Level   ttyS0


Hanks Chen (3):
  irqchip/gic: enable irq target all
  arm: disable irq on cpu shutdown flow
  arm64: disable irq on cpu shutdown flow

 arch/arm/kernel/smp.c              |  10 ++-
 arch/arm64/kernel/smp.c            |   9 ++-
 drivers/irqchip/Kconfig            |  12 ++++
 drivers/irqchip/irq-gic-v3.c       | 107 +++++++++++++++++++++--------
 include/linux/irqchip/arm-gic-v3.h |   1 +
 kernel/irq/cpuhotplug.c            |  22 ++++++
 kernel/irq/manage.c                |   7 ++
 7 files changed, 138 insertions(+), 30 deletions(-)

-- 
2.18.0

