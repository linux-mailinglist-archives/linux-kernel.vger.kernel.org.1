Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7734D2F068C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 12:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbhAJLBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 06:01:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:44318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726288AbhAJLBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 06:01:06 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D82522D75;
        Sun, 10 Jan 2021 11:00:26 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kyYSM-006QCc-Sg; Sun, 10 Jan 2021 11:00:23 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        David Lechner <david@lechnology.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Huacai Chen <chenhuacai@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathias Kresin <dev@kresin.me>, Suman Anna <s-anna@ti.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip fixes for 5.11, take #1
Date:   Sun, 10 Jan 2021 11:00:01 +0000
Message-Id: <20210110110001.2328708-1-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tglx@linutronix.de, dan.carpenter@oracle.com, david@lechnology.com, linux@roeck-us.net, chenhuacai@kernel.org, john.garry@huawei.com, dev@kresin.me, s-anna@ti.com, valentin.schneider@arm.com, yuzenghui@huawei.com, zhengyongjun3@huawei.com, kernel-team@android.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Happy New Year!

This is the first set of fixes from the irqchip (and related)
department for 5.11. On the menu this time, three notable fixes: a
MIPS CPU hierarchy violation, a fix for the on-stack init of
msi_alloc_info (or lack thereof), and a fix for the RPi2/3 IPI irqchip
that broke on QEMU. The rest is a bunch of smaller cleanups and fixes.

Please pull,

	M.

The following changes since commit 2f5fbc4305d07725bfebaedb09e57271315691ef:

  irqchip/qcom-pdc: Fix phantom irq when changing between rising/falling (2020-12-12 10:46:02 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-5.11-1

for you to fetch changes up to 599b3063adf4bf041a87a69244ee36aded0d878f:

  irqchip/mips-cpu: Set IPI domain parent chip (2021-01-10 10:20:24 +0000)

----------------------------------------------------------------
irqchip fixes for 5.11, take #1

- Fix the MIPS CPU interrupt controller hierarchy
- Simplify the PRUSS Kconfig entry
- Eliminate trivial build warnings on the MIPS Loongson liointc
- Fix error path in devm_platform_get_irqs_affinity()
- Turn the BCM2836 IPI irq_eoi callback into irq_ack
- Fix initialisation of on-stack msi_alloc_info
- Cleanup spurious comma in irq-sl28cpld

----------------------------------------------------------------
Huacai Chen (1):
      irqchip/loongson-liointc: Fix build warnings

John Garry (1):
      driver core: platform: Add extra error check in devm_platform_get_irqs_affinity()

Marc Zyngier (1):
      irqchip/bcm2836: Fix IPI acknowledgement after conversion to handle_percpu_devid_irq

Mathias Kresin (1):
      irqchip/mips-cpu: Set IPI domain parent chip

Suman Anna (1):
      irqchip/pruss: Simplify the TI_PRUSS_INTC Kconfig

Zenghui Yu (1):
      genirq/msi: Initialize msi_alloc_info before calling msi_domain_prepare_irqs()

Zheng Yongjun (1):
      irqchip/irq-sl28cpld: Convert comma to semicolon

 drivers/base/platform.c                | 2 ++
 drivers/irqchip/Kconfig                | 5 +++--
 drivers/irqchip/irq-bcm2836.c          | 4 ++--
 drivers/irqchip/irq-loongson-liointc.c | 4 ++--
 drivers/irqchip/irq-mips-cpu.c         | 7 +++++++
 drivers/irqchip/irq-sl28cpld.c         | 2 +-
 kernel/irq/msi.c                       | 2 +-
 7 files changed, 18 insertions(+), 8 deletions(-)
