Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37357246318
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 11:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgHQJUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 05:20:35 -0400
Received: from foss.arm.com ([217.140.110.172]:51626 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728139AbgHQJUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:20:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C522E31B;
        Mon, 17 Aug 2020 02:20:30 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.65.199])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 88B433F6CF;
        Mon, 17 Aug 2020 02:20:27 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64/mm: Enable THP migration
Date:   Mon, 17 Aug 2020 14:49:42 +0530
Message-Id: <1597655984-15428-1-git-send-email-anshuman.khandual@arm.com>
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

This series is based on v5.9-rc1.

Changes in V1:

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

