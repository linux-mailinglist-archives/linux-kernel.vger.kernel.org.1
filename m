Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9AA262683
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 06:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgIIExq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 00:53:46 -0400
Received: from foss.arm.com ([217.140.110.172]:37756 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgIIExp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 00:53:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F38531B;
        Tue,  8 Sep 2020 21:53:44 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.71.250])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 599613F68F;
        Tue,  8 Sep 2020 21:53:40 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Cc:     will@kernel.org, catalin.marinas@arm.com,
        akpm@linux-foundation.org, rcampbell@nvidia.com, ziy@nvidia.com,
        Jonathan.Cameron@Huawei.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/2] arm64/mm: Enable THP migration
Date:   Wed,  9 Sep 2020 10:23:01 +0530
Message-Id: <1599627183-14453-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables THP migration on arm64 via ARCH_ENABLE_THP_MIGRATION.
But first this modifies all existing THP helpers like pmd_present() and
pmd_trans_huge() etc per expected generic memory semantics as concluded
from a previous discussion here.

https://lkml.org/lkml/2018/10/9/220

This series is based on v5.9-rc4.

Changes in V2:

- Renamed clr_pmd_bit() as clear_pmd_bit() per Catalin
- Updated in-code documentation per Catalin and Ralph
- Updated commit message in the first patch per Catalin
- Updated commit message in the second patch per Catalin
- Added tags from Catalin

Changes in V1: (https://patchwork.kernel.org/project/linux-mm/list/?series=333627)

- Used new PMD_PRESENT_INVALID (bit 59) to represent invalidated PMD state per Catalin

Changes in RFC V2: (https://patchwork.kernel.org/project/linux-mm/list/?series=302965)

- Used PMD_TABLE_BIT to represent splitting PMD state per Catalin

Changes in RFC V1: (https://patchwork.kernel.org/project/linux-mm/list/?series=138797)

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (2):
  arm64/mm: Change THP helpers to comply with generic MM semantics
  arm64/mm: Enable THP migration

 arch/arm64/Kconfig                    |  4 +++
 arch/arm64/include/asm/pgtable-prot.h |  7 +++++
 arch/arm64/include/asm/pgtable.h      | 39 ++++++++++++++++++++++++---
 3 files changed, 47 insertions(+), 3 deletions(-)

-- 
2.20.1

