Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586252F414B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 02:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbhAMBmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 20:42:22 -0500
Received: from foss.arm.com ([217.140.110.172]:56494 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbhAMBmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 20:42:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 884F8101E;
        Tue, 12 Jan 2021 17:41:35 -0800 (PST)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.110])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9F2DB3F70D;
        Tue, 12 Jan 2021 17:41:29 -0800 (PST)
From:   Jia He <justin.he@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jia He <justin.he@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Steven Price <steven.price@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Gavin Shan <gshan@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [RFC PATCH 0/2] Avoid booting stall caused by
Date:   Wed, 13 Jan 2021 09:40:45 +0800
Message-Id: <20210113014047.14371-1-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a 10s stall in idmap_kpti_install_ng_mappings when kernel boots
on a Ampere EMAG server.

Commit f992b4dfd58b ("arm64: kpti: Add ->enable callback to remap
swapper using nG mappings") updates the nG bit runtime if kpti is
required.

But things get worse if rodata=full in map_mem(). NO_BLOCK_MAPPINGS |
NO_CONT_MAPPINGS is required when creating pagetable mapping. Hence all
ptes are fully mapped in this case. On a Ampere EMAG server with 256G
memory(pagesize=4k), it causes the 10s stall.

After moving init_cpu_features() ahead of early_fixmap_init(), we can use
cpu_have_const_cap earlier than before. Hence we can avoid this stall
by updating arm64_use_ng_mappings.

After this patch series, it reduces the kernel boot time from 14.7s to
4.1s:
Before:
[   14.757569] Freeing initrd memory: 60752K
After:
[    4.138819] Freeing initrd memory: 60752K

Set it as RFC because I want to resolve any other points which I have
misconerned.

Jia He (2):
  arm64/cpuinfo: Move init_cpu_features() ahead of early_fixmap_init()
  arm64: kpti: Update arm64_use_ng_mappings before pagetable mapping

 arch/arm64/include/asm/cpu.h |  1 +
 arch/arm64/kernel/cpuinfo.c  | 13 ++++++++++---
 arch/arm64/kernel/setup.c    | 18 +++++++++++++-----
 arch/arm64/kernel/smp.c      |  3 +--
 4 files changed, 25 insertions(+), 10 deletions(-)

-- 
2.17.1

