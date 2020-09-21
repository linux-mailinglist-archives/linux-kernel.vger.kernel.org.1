Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9793A272353
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 14:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgIUMF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 08:05:59 -0400
Received: from foss.arm.com ([217.140.110.172]:42014 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbgIUMF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 08:05:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DFA8D6E;
        Mon, 21 Sep 2020 05:05:58 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.75.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7510D3F73B;
        Mon, 21 Sep 2020 05:05:54 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/3] arm64/mm/hotplug: Improve memory offline event notifier
Date:   Mon, 21 Sep 2020 17:35:05 +0530
Message-Id: <1600689908-28213-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series brings three different changes to the only memory event notifier on
arm64 platform. These changes improve it's robustness while also enhancing debug
capabilities during potential memory offlining error conditions.

This applies on 5.9-rc6

Changes in V3:

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
Cc: Will Deacon <will@kernel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (3):
  arm64/mm/hotplug: Register boot memory hot remove notifier earlier
  arm64/mm/hotplug: Enable MEM_OFFLINE event handling
  arm64/mm/hotplug: Ensure early memory sections are all online

 arch/arm64/mm/mmu.c | 110 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 103 insertions(+), 7 deletions(-)

-- 
2.20.1

