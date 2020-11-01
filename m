Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57DF2A1DCC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 13:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgKAMWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 07:22:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:48954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbgKAMWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 07:22:36 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3257B20795;
        Sun,  1 Nov 2020 12:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604233355;
        bh=FMgN1LC7jmA8cluEWBqSmen4WayfoXA4+4zxJC2Mopo=;
        h=From:To:Cc:Subject:Date:From;
        b=D60KdlkvZjZ1ZCMwQqErMjMTKyB9fNK8nz+D6XquWQuiB2prma9fLHoCUFyGcCDWy
         AcdMZsDPpjoCr5pdNddgJ8LXZXbZyJlk1trBYCEuOcSUBjlmujEwPv2Evr5qPttCdm
         Lhz7sNqXweIBX96TO2FDssvYnPQTRWHIV113dBkI=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kZCNV-006Pn8-40; Sun, 01 Nov 2020 12:22:33 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Daniel Palmer <daniel@thingy.jp>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greentime Hu <greentime.hu@sifive.com>,
        Pavel Machek <pavel@ucw.cz>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: [GIT PULL] irqchip updates for 5.10, take #1
Date:   Sun,  1 Nov 2020 12:22:23 +0000
Message-Id: <20201101122223.255806-1-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tglx@linutronix.de, anup@brainfault.org, atish.patra@wdc.com, daniel@thingy.jp, fabrice.gasnier@st.com, geert+renesas@glider.be, greentime.hu@sifive.com, pavel@ucw.cz, peter.ujfalusi@ti.com, robh@kernel.org, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's a smallish set of fixes for 5.10. Some fixes after the
IPI-as-IRQ (I expect a couple more next week), two significant bug
fixes for the SiFive PLIC, and a TI update to handle their "unmapped
events". The rest is the usual set of cleanups and tidying up.

Please pull,

	M.

The following changes since commit 63ea38a402213d8c9c16e58ee4901ff51bc8fe3c:

  Merge branch 'irq/mstar' into irq/irqchip-next (2020-10-10 12:46:54 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-5.10-1

for you to fetch changes up to d95bdca75b3fb41bf185efe164e05aed820081a5:

  irqchip/ti-sci-inta: Add support for unmapped event handling (2020-11-01 12:00:50 +0000)

----------------------------------------------------------------
irqchip fixes for Linux 5.10, take #1

- A couple of fixes after the IPI as IRQ patches (Kconfig, bcm2836)
- Two SiFive PLIC fixes (irq_set_affinity, hierarchy handling)
- "unmapped events" handling for the ti-sci-inta controller
- Tidying up for the irq-mst driver (static functions, Kconfig)
- Small cleanup in the Renesas irqpin driver
- STM32 exti can now handle LP timer events

----------------------------------------------------------------
Fabrice Gasnier (1):
      irqchip/stm32-exti: Add all LP timer exti direct events support

Geert Uytterhoeven (2):
      irqchip/mst: MST_IRQ should depend on ARCH_MEDIATEK or ARCH_MSTARV7
      irqchip/renesas-intc-irqpin: Merge irlm_bit and needs_irlm

Greentime Hu (2):
      irqchip/sifive-plic: Fix broken irq_set_affinity() callback
      irqchip/sifive-plic: Fix chip_data access within a hierarchy

Marc Zyngier (4):
      genirq: Let GENERIC_IRQ_IPI select IRQ_DOMAIN_HIERARCHY
      irqchip/mst: Make mst_intc_of_init static
      irqchip/mips: Drop selection of IRQ_DOMAIN_HIERARCHY
      irqchip/bcm2836: Fix missing __init annotation

Peter Ujfalusi (2):
      dt-bindings: irqchip: ti, sci-inta: Update for unmapped event handling
      irqchip/ti-sci-inta: Add support for unmapped event handling

 .../bindings/interrupt-controller/ti,sci-inta.yaml | 10 +++
 drivers/irqchip/Kconfig                            |  3 +-
 drivers/irqchip/irq-bcm2836.c                      |  2 +-
 drivers/irqchip/irq-mst-intc.c                     |  4 +-
 drivers/irqchip/irq-renesas-intc-irqpin.c          |  8 +--
 drivers/irqchip/irq-sifive-plic.c                  | 10 +--
 drivers/irqchip/irq-stm32-exti.c                   |  4 ++
 drivers/irqchip/irq-ti-sci-inta.c                  | 83 +++++++++++++++++++++-
 kernel/irq/Kconfig                                 |  1 +
 9 files changed, 107 insertions(+), 18 deletions(-)
