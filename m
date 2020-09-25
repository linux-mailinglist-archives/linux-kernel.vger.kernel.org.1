Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6017127932C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 23:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbgIYVXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 17:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgIYVXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 17:23:09 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321B3C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 14:23:09 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id t56so3215933qtt.19
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 14:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=WhSHXLCkju2/puXa6k5MbwPT2DXvEVJiaCvaA6Ap7fQ=;
        b=CNiIGHXxRoK3qhcUJCN8jKMQo+/coc4H/tTeM8I73ezc7/rLXSt/+D1m8y42+foLxG
         bE12cpwtdq6987ilEd2us3mqAkilRAMKnTLzWSEbvm19WSBGLFb5nJ7z8DXbBP2WnO3Z
         dYPI5btgNrhpBUEI3YlAc/eUHn7HOZkLzJL7CZObbjwq8GVsXR1f9eGu2O/+rqtf8ltU
         LQpgE26nOV50rTCemLAR2QbDLIKu/5liJ/WuBpPLSOANK9MCCpq/JWbwnVNHT/zgYg0r
         gZWyzc5WdJ8LaEzeX7ifqT29Ur8rHhCRJu6GvST/zbQgw/ly5eq/QnY7H/koRS54xAa5
         VgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=WhSHXLCkju2/puXa6k5MbwPT2DXvEVJiaCvaA6Ap7fQ=;
        b=WTDAw+1tnGRO94cbHCXeSI9DKydmlnl5EJ4CyKqegxvwrbF1NfF5Kbm/WyomgjUIFY
         GKR8Y+j5h4Mq+kRYQgzpQbUWzpgZrkkf+Sbd5RJwli5rKucNF6SmQPPBVIORF83SVPLz
         s0pYwoPjqx7zNPGQ/8XAF+A0LEMyKdtg5dN4CIVavoknsEzwuNk/YTlnc492ujcVJ1H2
         98NENFuHfY9tECU/TdnvY5GTCL9lcKsLp7I6TNX2MsPk8TW0vispEvWR7hqfjGvAvtbz
         YVT0RWsNLX8ziJD+A4QuD0V31jY2HUaVPldkaekTe0IFBSZXD75NF4R9dUyhZDGpl0GV
         G2rg==
X-Gm-Message-State: AOAM5319NbU0DPtX8Tm+ZutT/YlaH7xD9f54/wcUXUgxfWSQosY86tr+
        2UIi2vU1XU6Ft7DHXLYDGIXawQagbH9nIguF7N4Cby+j812P/Mh9KO+pgYxfZVLNLRQnrSabHuP
        nHxSgO3VbOOvYRZFJwS0U+rnbKIutnSrcn1Xu4VrPuyNyyUyxufDcFoFd+r7UEjHS19Ftgqip
X-Google-Smtp-Source: ABdhPJzqKnFLiB2rs8BKpZdKjFq7yB7IURYL2VHUH6zjuOMgmoioiBcLZbd/+9pDLZAoq1GVwLUjuzrdAIOr
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:ad4:5743:: with SMTP id
 q3mr681860qvx.6.1601068988189; Fri, 25 Sep 2020 14:23:08 -0700 (PDT)
Date:   Fri, 25 Sep 2020 14:22:40 -0700
Message-Id: <20200925212302.3979661-1-bgardon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH 00/22] Introduce the TDP MMU
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Cannon Matthews <cannonmatthews@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Over the years, the needs for KVM's x86 MMU have grown from running small
guests to live migrating multi-terabyte VMs with hundreds of vCPUs. Where
we previously depended on shadow paging to run all guests, we now have
two dimensional paging (TDP). This patch set introduces a new
implementation of much of the KVM MMU, optimized for running guests with
TDP. We have re-implemented many of the MMU functions to take advantage of
the relative simplicity of TDP and eliminate the need for an rmap.
Building on this simplified implementation, a future patch set will change
the synchronization model for this "TDP MMU" to enable more parallelism
than the monolithic MMU lock. A TDP MMU is currently in use at Google
and has given us the performance necessary to live migrate our 416 vCPU,
12TiB m2-ultramem-416 VMs.

This work was motivated by the need to handle page faults in parallel for
very large VMs. When VMs have hundreds of vCPUs and terabytes of memory,
KVM's MMU lock suffers extreme contention, resulting in soft-lockups and
long latency on guest page faults. This contention can be easily seen
running the KVM selftests demand_paging_test with a couple hundred vCPUs.
Over a 1 second profile of the demand_paging_test, with 416 vCPUs and 4G
per vCPU, 98% of the time was spent waiting for the MMU lock. At Google,
the TDP MMU reduced the test duration by 89% and the execution was
dominated by get_user_pages and the user fault FD ioctl instead of the
MMU lock.

This series is the first of two. In this series we add a basic
implementation of the TDP MMU. In the next series we will improve the
performance of the TDP MMU and allow it to execute MMU operations
in parallel.

The overall purpose of the KVM MMU is to program paging structures
(CR3/EPT/NPT) to encode the mapping of guest addresses to host physical
addresses (HPA), and to provide utilities for other KVM features, for
example dirty logging. The definition of the L1 guest physical address
(GPA) to HPA mapping comes in two parts: KVM's memslots map GPA to HVA,
and the kernel MM/x86 host page tables map HVA -> HPA. Without TDP, the
MMU must program the x86 page tables to encode the full translation of
guest virtual addresses (GVA) to HPA. This requires "shadowing" the
guest's page tables to create a composite x86 paging structure. This
solution is complicated, requires separate paging structures for each
guest CR3, and requires emulating guest page table changes. The TDP case
is much simpler. In this case, KVM lets the guest control CR3 and programs
the EPT/NPT paging structures with the GPA -> HPA mapping. The guest has
no way to change this mapping and only one version of the paging structure
is needed per L1 paging mode. In this case the paging mode is some
combination of the number of levels in the paging structure, the address
space (normal execution or system management mode, on x86), and other
attributes. Most VMs only ever use 1 paging mode and so only ever need one
TDP structure.

This series implements a "TDP MMU" through alternative implementations of
MMU functions for running L1 guests with TDP. The TDP MMU falls back to
the existing shadow paging implementation when TDP is not available, and
interoperates with the existing shadow paging implementation for nesting.
The use of the TDP MMU can be controlled by a module parameter which is
snapshot on VM creation and follows the life of the VM. This snapshot
is used in many functions to decide whether or not to use TDP MMU handlers
for a given operation.

This series can also be viewed in Gerrit here:
https://linux-review.googlesource.com/c/virt/kvm/kvm/+/2538
(Thanks to Dmitry Vyukov <dvyukov@google.com> for setting up the
Gerrit instance)

Ben Gardon (22):
  kvm: mmu: Separate making SPTEs from set_spte
  kvm: mmu: Introduce tdp_iter
  kvm: mmu: Init / Uninit the TDP MMU
  kvm: mmu: Allocate and free TDP MMU roots
  kvm: mmu: Add functions to handle changed TDP SPTEs
  kvm: mmu: Make address space ID a property of memslots
  kvm: mmu: Support zapping SPTEs in the TDP MMU
  kvm: mmu: Separate making non-leaf sptes from link_shadow_page
  kvm: mmu: Remove disallowed_hugepage_adjust shadow_walk_iterator arg
  kvm: mmu: Add TDP MMU PF handler
  kvm: mmu: Factor out allocating a new tdp_mmu_page
  kvm: mmu: Allocate struct kvm_mmu_pages for all pages in TDP MMU
  kvm: mmu: Support invalidate range MMU notifier for TDP MMU
  kvm: mmu: Add access tracking for tdp_mmu
  kvm: mmu: Support changed pte notifier in tdp MMU
  kvm: mmu: Add dirty logging handler for changed sptes
  kvm: mmu: Support dirty logging for the TDP MMU
  kvm: mmu: Support disabling dirty logging for the tdp MMU
  kvm: mmu: Support write protection for nesting in tdp MMU
  kvm: mmu: NX largepage recovery for TDP MMU
  kvm: mmu: Support MMIO in the TDP MMU
  kvm: mmu: Don't clear write flooding count for direct roots

 arch/x86/include/asm/kvm_host.h |   17 +
 arch/x86/kvm/Makefile           |    3 +-
 arch/x86/kvm/mmu/mmu.c          |  437 ++++++----
 arch/x86/kvm/mmu/mmu_internal.h |   98 +++
 arch/x86/kvm/mmu/paging_tmpl.h  |    3 +-
 arch/x86/kvm/mmu/tdp_iter.c     |  198 +++++
 arch/x86/kvm/mmu/tdp_iter.h     |   55 ++
 arch/x86/kvm/mmu/tdp_mmu.c      | 1315 +++++++++++++++++++++++++++++++
 arch/x86/kvm/mmu/tdp_mmu.h      |   52 ++
 include/linux/kvm_host.h        |    2 +
 virt/kvm/kvm_main.c             |    7 +-
 11 files changed, 2022 insertions(+), 165 deletions(-)
 create mode 100644 arch/x86/kvm/mmu/tdp_iter.c
 create mode 100644 arch/x86/kvm/mmu/tdp_iter.h
 create mode 100644 arch/x86/kvm/mmu/tdp_mmu.c
 create mode 100644 arch/x86/kvm/mmu/tdp_mmu.h

-- 
2.28.0.709.gb0816b6eb0-goog

