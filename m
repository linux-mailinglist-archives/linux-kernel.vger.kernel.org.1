Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4102CAD10
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbgLAUL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:11:27 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8175 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbgLAUL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:11:27 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CltWG2qksz15PTY;
        Wed,  2 Dec 2020 04:10:18 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.186.123) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Wed, 2 Dec 2020 04:10:37 +0800
From:   Yanan Wang <wangyanan55@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        "Julien Thierry" <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Gavin Shan <gshan@redhat.com>,
        Quentin Perret <qperret@google.com>
CC:     <wanghaibin.wang@huawei.com>, <yezengruan@huawei.com>,
        <zhukeqian1@huawei.com>, <yuzenghui@huawei.com>,
        <jiangkunkun@huawei.com>, <wangjingyi11@huawei.com>,
        <lushenming@huawei.com>, Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH v2 0/3] Fix several bugs in KVM stage 2 translation
Date:   Wed, 2 Dec 2020 04:10:31 +0800
Message-ID: <20201201201034.116760-1-wangyanan55@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.186.123]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When installing a new pte entry or updating an old valid entry in stage 2
translation, we use get_page()/put_page() to record page_count of the page-table
pages. PATCH 1/3 aims to fix incorrect use of get_page()/put_page() in stage 2,
which might make page-table pages unable to be freed when unmapping a range.

When dirty logging of a guest with hugepages is finished, we should merge tables
back into a block entry if adjustment of huge mapping is found necessary.
In addition to installing the block entry, we should not only free the non-huge
page-table pages but also invalidate all the TLB entries of non-huge mappings for
the block. PATCH 2/3 adds enough TLBI when merging tables into a block entry.

The rewrite of page-table code and fault handling add two different handlers
for "just relaxing permissions" and "map by stage2 page-table walk", that's
good improvement. Yet, in function user_mem_abort(), conditions where we choose
the above two fault handlers are not strictly distinguished. This will causes
guest errors such as infinite-loop (soft lockup will occur in result), because of
calling the inappropriate fault handler. So, a solution that can strictly
distinguish conditions is introduced in PATCH 3/3.

Changes from v1:
 * In PATCH 1/3, introduce a more concise fix.
 * In PATCH 2/3, using full S2 TLB invalidation when merging tables into
   a block entry.

Yanan Wang (3):
  KVM: arm64: Fix possible memory leak in kvm stage2
  KVM: arm64: Fix handling of merging tables into a block entry
  KVM: arm64: Add usage of stage 2 fault lookup level in
    user_mem_abort()

 arch/arm64/include/asm/esr.h         |  1 +
 arch/arm64/include/asm/kvm_emulate.h |  5 +++++
 arch/arm64/kvm/hyp/pgtable.c         | 11 ++++++++++-
 arch/arm64/kvm/mmu.c                 | 11 +++++++++--
 4 files changed, 25 insertions(+), 3 deletions(-)


-- 
2.19.1

