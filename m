Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E37F301BDE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 13:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbhAXMbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 07:31:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:52212 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbhAXMbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 07:31:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 426B3ACC6;
        Sun, 24 Jan 2021 12:30:56 +0000 (UTC)
Date:   Sun, 24 Jan 2021 13:30:49 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v5.11-rc5
Message-ID: <20210124123049.GE2493@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the pile of urgent irq{,chip} fixes for v5.11.

Thx.

---

The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v5.11_rc5

for you to fetch changes up to ce09ccc50208c04a1b03abfd530b5d6314258fd0:

  genirq: Export irq_check_status_bit() (2021-01-13 15:48:05 +0100)

----------------------------------------------------------------
 - Fix a kernel panic in mips-cpu due to invalid irq domain hierarchy.

 - Fix to not lose IPIs on bcm2836.

 - Fix for a bogus marking of ITS devices as shared due to unitialized
   stack variable.

 - Clear a phantom interrupt on qcom-pdc to unblock suspend.

 - Small cleanups, warning and build fixes.

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

Thomas Gleixner (2):
      Merge tag 'irqchip-fixes-5.11-1' of git://git.kernel.org/.../maz/arm-platforms into irq/urgent
      genirq: Export irq_check_status_bit()

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
 kernel/irq/manage.c                    | 1 +
 kernel/irq/msi.c                       | 2 +-
 8 files changed, 19 insertions(+), 8 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
