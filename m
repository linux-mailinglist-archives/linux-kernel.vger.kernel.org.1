Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F0D2AB3CA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgKIJmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:42:49 -0500
Received: from foss.arm.com ([217.140.110.172]:36208 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbgKIJms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:42:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C0661042;
        Mon,  9 Nov 2020 01:42:48 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 93EC03F718;
        Mon,  9 Nov 2020 01:42:46 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Subject: [PATCH 0/5] genirq: Get rid of handle_percpu_devid_fasteoi_ipi()
Date:   Mon,  9 Nov 2020 09:41:16 +0000
Message-Id: <20201109094121.29975-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

While hacking on the GIC flow handlers, I grew increasingly suspicious of 
handle_percpu_devid_fasteoi_ipi() and thus did a bit of digging. AFAICT it isn't
actually needed and handle_percpu_devid_irq() would suffice. Argumentation is in
patch 1.

Tested on my Juno (GICv2) and eMAG (GICv3).

Whichever way this goes I owe Marc some pastries, given I either
- Missed something and created some noise
- Turned my brain off back when reviewing this flow handler
so maybe just start with pinging me what you want...

Valentin Schneider (5):
  irqchip/gic, gic-v3: Make SGIs use handle_percpu_devid_irq()
  irqchip/armada-370-xp: Make IPIs use handle_percpu_devid_irq()
  irqchip/bcm2836: Make IPIs use handle_percpu_devid_irq()
  irqchip/hip04: Make IPIs use handle_percpu_devid_irq()
  Revert "genirq: Add fasteoi IPI flow"

 drivers/irqchip/irq-armada-370-xp.c |  2 +-
 drivers/irqchip/irq-bcm2836.c       |  2 +-
 drivers/irqchip/irq-gic-v3.c        |  6 ------
 drivers/irqchip/irq-gic.c           |  8 +-------
 drivers/irqchip/irq-hip04.c         |  6 +-----
 include/linux/irq.h                 |  1 -
 kernel/irq/chip.c                   | 27 ---------------------------
 7 files changed, 4 insertions(+), 48 deletions(-)

--
2.27.0

