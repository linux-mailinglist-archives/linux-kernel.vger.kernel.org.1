Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C172AB02A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 05:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbgKIE3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 23:29:13 -0500
Received: from foss.arm.com ([217.140.110.172]:33898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728038AbgKIE3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 23:29:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB81D101E;
        Sun,  8 Nov 2020 20:29:12 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.78.250])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8208A3F6CF;
        Sun,  8 Nov 2020 20:29:09 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     gshan@redhat.com, Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V5 0/3] arm64/mm/hotplug: Improve memory offline event notifier
Date:   Mon,  9 Nov 2020 09:58:54 +0530
Message-Id: <1604896137-16644-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series brings three different changes to the only memory event notifier on
arm64 platform. These changes improve it's robustness while also enhancing debug
capabilities during potential memory offlining error conditions.

This applies on 5.10-rc3

Changes in V5:

- Added some more documentation in [PATCH 2/3]
- Used for_each_mem_range() as for_each_memblock() has been dropped
- validate_bootmem_online() just prints non-compliant early sections
- validate_bootmem_online() does not prevent notifier registration
- Folded two pr_err() statements into just a single one per Gavin

Changes in V4: (https://lore.kernel.org/linux-arm-kernel/1601387687-6077-1-git-send-email-anshuman.khandual@arm.com/

- Dropped additional return in prevent_bootmem_remove_init() per Gavin
- Rearranged memory section loop in prevent_bootmem_remove_notifier() per Gavin
- Call out boot memory ranges for attempted offline or offline events

Changes in V3: (https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=352717)

- Split the single patch into three patch series per Catalin
- Trigger changed from setup_arch() to early_initcall() per Catalin
- Renamed back memory_hotremove_notifier() as prevent_bootmem_remove_init()
- validate_bootmem_online() is now called from prevent_bootmem_remove_init() per Catalin
- Skip registering the notifier if validate_bootmem_online() returns negative

Changes in V2: (https://patchwork.kernel.org/patch/11732161/)

- Dropped all generic changes wrt MEM_CANCEL_OFFLINE reasons enumeration
- Dropped all related (processing MEM_CANCEL_OFFLINE reasons) changes on arm64
- Added validate_boot_mem_online_state() that gets called with early_initcall()
- Added CONFIG_MEMORY_HOTREMOVE check before registering memory notifier
- Moved notifier registration i.e memory_hotremove_notifier into setup_arch()

Changes in V1: (https://patchwork.kernel.org/project/linux-mm/list/?series=271237)

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Gavin Shan <gshan@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (3):
  arm64/mm/hotplug: Register boot memory hot remove notifier earlier
  arm64/mm/hotplug: Enable MEM_OFFLINE event handling
  arm64/mm/hotplug: Ensure early memory sections are all online

 arch/arm64/mm/mmu.c | 95 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 91 insertions(+), 4 deletions(-)

-- 
2.20.1

