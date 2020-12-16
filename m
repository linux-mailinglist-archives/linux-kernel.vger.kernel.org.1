Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F082DC051
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 13:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgLPM3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 07:29:36 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9616 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgLPM3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 07:29:36 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CwvYD03Mjz15cqV;
        Wed, 16 Dec 2020 20:28:16 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 16 Dec 2020 20:28:47 +0800
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
        Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH v2 0/3] RFC: Solve several problems in stage 2 translation
Date:   Wed, 16 Dec 2020 20:28:41 +0800
Message-ID: <20201216122844.25092-1-wangyanan55@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.128]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is the second version, thanks for reading.

PATCH1/3:
Procedures of hyp stage 1 mapping and guest stage 2 mapping are different, but
they are tied closely by function kvm_set_valid_leaf_pte(). So separate them by
rewriting kvm_set_valid_leaf_pte().

PATCH2/3:
To avoid unnecessary update and small loops, add prejudgement in the translation
fault handler: Skip updating the PTE with break-before-make if we are trying to
recreate the exact same mapping or only change the access permissions. Actually,
change of permissions will be handled through the relax_perms path next time if
necessary.

(1) If there are some vCPUs accessing the same GPA at the same time and the leaf
PTE is not set yet, then they will all cause translation faults and the first vCPU
holding mmu_lock will set valid leaf PTE, and the others will later update the old
PTE with a new one if they are different.

(2) When changing a leaf entry or a table entry with break-before-make, if there
are some vCPUs accessing the same GPA just catch the moment when the target PTE
is set invalid in a BBM procedure coincidentally, they will all cause translation
faults and will later update the old PTE with a new one if they are different.

The worst case can be like this: vCPU A causes a translation fault with RW prot and
sets the leaf PTE with RW permissions, and then the next vCPU B with RO prot updates
the PTE back to RO permissions with break-before-make. And the BBM-invalid moment
may trigger more unnecessary translation faults, then some useless small loops might
occur which could lead to vCPU stuck.

PATCH3/3:
We now mark the page dirty and set the bitmap before calling fault handlers in
user_mem_abort(), and we might end up having spurious dirty pages if update of
permissions or mapping has failed. So, mark the page dirty only if the fault is
handled successfully.

Let the guest directly enter again but not return to userspace if we were trying
to recreate the same mapping or only change access permissions with BBM, which is
not permitted in the mapping path.

Changes from v1:
- Make part of the diff as an independent patch (PATCH1/3),
  and add Will's Signed-off-by.
- Use *return -EPERM* way when changing permissions only in the mapping path.
- Add a new patch (PATCH3/3).

Yanan Wang (3):
  KVM: arm64: Decouple partial code of hyp stage 1 mapping and guest
    stage 2 mapping
  KVM: arm64: Add prejudgement for relaxing permissions only case in
    stage2 translation fault handler
  KVM: arm64: Mark the page dirty only if the fault is handled
    successfully

 arch/arm64/kvm/hyp/pgtable.c | 78 ++++++++++++++++++++----------------
 arch/arm64/kvm/mmu.c         | 18 +++++++--
 2 files changed, 58 insertions(+), 38 deletions(-)

-- 
2.19.1

