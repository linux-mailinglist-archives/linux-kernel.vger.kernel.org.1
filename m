Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A8C2C8406
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 13:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgK3MUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 07:20:06 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9073 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgK3MUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 07:20:06 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cl45T3JkGzLxpr;
        Mon, 30 Nov 2020 20:18:37 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.186.123) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Mon, 30 Nov 2020 20:19:00 +0800
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
Subject: [RFC PATCH 0/3] Fix several bugs in KVM stage 2 translation
Date:   Mon, 30 Nov 2020 20:18:44 +0800
Message-ID: <20201130121847.91808-1-wangyanan55@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.186.123]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several problems about KVM stage 2 translation were found when testing based
on the mainline code. The following is description of the problems and the
corresponding patchs.

When installing a new pte entry or updating an old valid entry in stage 2
translation, we use get_page()/put_page() to record page_count of the page-table
pages. PATCH 1/3 aims to fix incorrect use of get_page()/put_page() in stage 2,
which might make page-table pages unable to be freed when unmapping a range.

When dirty logging of a guest with hugepages is finished, we should merge tables
back into a block entry if adjustment of huge mapping is found necessary.
In addition to installing the block entry, mapping of the lower-levels for the
block should also be unmapped to avoid multiple TLB entries.
PATCH 2/3 adds unmap operation when merge tables into a block entry.

The rewrite of page-table code and fault handling add two different handlers
for "just relaxing permissions" and "map by stage2 page-table walk", that's
great improvement. Yet, in function user_mem_abort(), conditions where we choose
the above two fault handlers are not strictly distinguished. This will causes
guest errors such as infinite-loop (soft lockup will occur in result), because of
calling the inappropriate fault handler. So, a solution that can strictly
distinguish conditions is introduced in PATCH 3/3.

Yanan Wang (3):
  KVM: arm64: Fix possible memory leak in kvm stage2
  KVM: arm64: Fix handling of merging tables into a block entry
  KVM: arm64: Add usage of stage 2 fault lookup level in
    user_mem_abort()

 arch/arm64/include/asm/esr.h         |  1 +
 arch/arm64/include/asm/kvm_emulate.h |  5 +++++
 arch/arm64/kvm/hyp/pgtable.c         | 22 +++++++++++++++++-----
 arch/arm64/kvm/mmu.c                 | 11 +++++++++--
 4 files changed, 32 insertions(+), 7 deletions(-)

-- 
2.19.1

