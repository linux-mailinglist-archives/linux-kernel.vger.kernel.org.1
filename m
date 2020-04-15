Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89AD01A972D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 10:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894898AbgDOInx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 04:43:53 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:44583 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894890AbgDOInn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1586940224; x=1618476224;
  h=from:to:cc:subject:date:message-id;
  bh=EMYtFdH844Gy8q0zDObO0i3soKGeCT1N6ZnKHQH7qjI=;
  b=YpVMeTaNDlyWXaEGzRXJHbA5fd09GUaZXNZeXWeUn1jvHe4aEmt4A6gn
   0ewqO9G+QaLh3Dbu1n65G8oE9lCmYDY/ZMeDr5W9pM9N3XtinosAhBhlJ
   /OxY4T0oOJMKRS2Kc09heUsbfa2fXgMrlTrxYNAIo8eiqIIUjioNfaber
   I=;
IronPort-SDR: sh/mYkNm0w7U8qD8vmxXEf50rvhX5vgl8boba5UFNT+Gie7eTRc2Nu1whcyXfttLtiJVNkb6Bf
 2HJbI0RIxMHQ==
X-IronPort-AV: E=Sophos;i="5.72,386,1580774400"; 
   d="scan'208";a="37157160"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-98acfc19.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 15 Apr 2020 08:43:42 +0000
Received: from u8ac3f2494b6e5c.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1d-98acfc19.us-east-1.amazon.com (Postfix) with ESMTPS id F023DA218E;
        Wed, 15 Apr 2020 08:43:37 +0000 (UTC)
Received: from u8ac3f2494b6e5c.ant.amazon.com (localhost [127.0.0.1])
        by u8ac3f2494b6e5c.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id 03F8hZjA007973
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 15 Apr 2020 10:43:35 +0200
Received: (from giangyi@localhost)
        by u8ac3f2494b6e5c.ant.amazon.com (8.15.2/8.15.2/Submit) id 03F8hYvM007966;
        Wed, 15 Apr 2020 10:43:34 +0200
From:   Jiang Yi <giangyi@amazon.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Jiang Yi <giangyi@amazon.com>, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: arm/arm64: release kvm->mmu_lock in loop to prevent starvation
Date:   Wed, 15 Apr 2020 10:42:29 +0200
Message-Id: <20200415084229.29992-1-giangyi@amazon.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do cond_resched_lock() in stage2_flush_memslot() like what is done in
unmap_stage2_range() and other places holding mmu_lock while processing
a possibly large range of memory.

Signed-off-by: Jiang Yi <giangyi@amazon.com>
---
 virt/kvm/arm/mmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index e3b9ee268823..7315af2c52f8 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -417,16 +417,19 @@ static void stage2_flush_memslot(struct kvm *kvm,
 	phys_addr_t next;
 	pgd_t *pgd;
 
 	pgd = kvm->arch.pgd + stage2_pgd_index(kvm, addr);
 	do {
 		next = stage2_pgd_addr_end(kvm, addr, end);
 		if (!stage2_pgd_none(kvm, *pgd))
 			stage2_flush_puds(kvm, pgd, addr, next);
+
+		if (next != end)
+			cond_resched_lock(&kvm->mmu_lock);
 	} while (pgd++, addr = next, addr != end);
 }
 
 /**
  * stage2_flush_vm - Invalidate cache for pages mapped in stage 2
  * @kvm: The struct kvm pointer
  *
  * Go through the stage 2 page tables and invalidate any cache lines
-- 
2.17.1

