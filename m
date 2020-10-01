Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1BA427F740
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 03:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbgJABWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 21:22:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47315 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730381AbgJABW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 21:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601515347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4NS8iwyIXOJFzj6So0GL06bw2MEksIZDFHtJ24IXHgI=;
        b=iCXYdl6I0yv/M5TBAO9SsQgr7xNdpIE2prKtJBhrV/MVuDtc33Fqslnms+KBobHv9/I3YD
        udkyLWRf1LJbTiW5NTko/8QxRSMFuBZG9b7TXsnO01DIs98Jw2FG1Q9CiLTrTRTA79rjOZ
        SqVGuUlIiKKCX5Tel/fAIXCx4RMW5XM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-O00tEUgtP3GfdVgf5A6Hig-1; Wed, 30 Sep 2020 21:22:26 -0400
X-MC-Unique: O00tEUgtP3GfdVgf5A6Hig-1
Received: by mail-qv1-f69.google.com with SMTP id de12so2106498qvb.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4NS8iwyIXOJFzj6So0GL06bw2MEksIZDFHtJ24IXHgI=;
        b=FVoVfLr5qVj94Gqmzcnq+TAHDbBtdOhRFv1662gILfT6Rufe/1rLBMfOdt7ojUjssS
         X6zXC/WrnQFemh4FOrE8esDUwSbD5aH6DE80ehmsw3lIZMrnTUEuKQ98Dna+vmaHE+6z
         C90hhjl+S+61NBT7r8cVWpkA2amsh0JXy74X84cmwNYXetJ/twKxInq/eoaGDR+Q6Pft
         RKXr3iABhPl9sF4kSJfhm/dCZOi18Wm9fhh1w/Q13VZpJ9FVts4Lw79S8NC3IADAEycA
         uuZ3r+uOz1fluKrekgbubbeRJLXQF7q5YNuK6cUNzbWp5/WHt8hSVvk68/jyCO4n3z2c
         TrkQ==
X-Gm-Message-State: AOAM5328qvtPRU+8mkoPzvVGwKLDn13Murdqig7sI7MK6sRatLxb+Wmt
        dg9jWFaT2cDYN02ESRDdj+m+++3rfnD+SNA9OKlwjBawpDYoEjYcXvsJP0fJlBUaUXPEDne0Mbo
        un/aIxTYynZgdmTc3xUd4jzo3
X-Received: by 2002:ac8:3597:: with SMTP id k23mr5228837qtb.238.1601515345869;
        Wed, 30 Sep 2020 18:22:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyK0vI3hhEae8W9Ii/Lnr+JfjwoNOUfHNwZB20LddBkUSYtgsBRf344+Dc+l5mQw7ah2wfA4Q==
X-Received: by 2002:ac8:3597:: with SMTP id k23mr5228800qtb.238.1601515345606;
        Wed, 30 Sep 2020 18:22:25 -0700 (PDT)
Received: from localhost.localdomain (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
        by smtp.gmail.com with ESMTPSA id f64sm4067834qkj.124.2020.09.30.18.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 18:22:24 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
        Andrew Jones <drjones@redhat.com>
Subject: [PATCH v13 07/14] KVM: Don't allocate dirty bitmap if dirty ring is enabled
Date:   Wed, 30 Sep 2020 21:22:26 -0400
Message-Id: <20201001012226.5868-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001012044.5151-1-peterx@redhat.com>
References: <20201001012044.5151-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because kvm dirty rings and kvm dirty log is used in an exclusive way,
Let's avoid creating the dirty_bitmap when kvm dirty ring is enabled.
At the meantime, since the dirty_bitmap will be conditionally created
now, we can't use it as a sign of "whether this memory slot enabled
dirty tracking".  Change users like that to check against the kvm
memory slot flags.

Note that there still can be chances where the kvm memory slot got its
dirty_bitmap allocated, _if_ the memory slots are created before
enabling of the dirty rings and at the same time with the dirty
tracking capability enabled, they'll still with the dirty_bitmap.
However it should not hurt much (e.g., the bitmaps will always be
freed if they are there), and the real users normally won't trigger
this because dirty bit tracking flag should in most cases only be
applied to kvm slots only before migration starts, that should be far
latter than kvm initializes (VM starts).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c   | 2 +-
 include/linux/kvm_host.h | 5 +++++
 virt/kvm/kvm_main.c      | 4 ++--
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 84471417930d..3725583f4f56 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1240,7 +1240,7 @@ gfn_to_memslot_dirty_bitmap(struct kvm_vcpu *vcpu, gfn_t gfn,
 	slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 	if (!slot || slot->flags & KVM_MEMSLOT_INVALID)
 		return NULL;
-	if (no_dirty_log && slot->dirty_bitmap)
+	if (no_dirty_log && kvm_slot_dirty_track_enabled(slot))
 		return NULL;
 
 	return slot;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 0656de40bff7..43cde6e80a1a 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -351,6 +351,11 @@ struct kvm_memory_slot {
 	u16 as_id;
 };
 
+static inline bool kvm_slot_dirty_track_enabled(struct kvm_memory_slot *slot)
+{
+	return slot->flags & KVM_MEM_LOG_DIRTY_PAGES;
+}
+
 static inline unsigned long kvm_dirty_bitmap_bytes(struct kvm_memory_slot *memslot)
 {
 	return ALIGN(memslot->npages, BITS_PER_LONG) / 8;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f32f9fc60d0e..a0c19f398719 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1369,7 +1369,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	/* Allocate/free page dirty bitmap as needed */
 	if (!(new.flags & KVM_MEM_LOG_DIRTY_PAGES))
 		new.dirty_bitmap = NULL;
-	else if (!new.dirty_bitmap) {
+	else if (!new.dirty_bitmap && !kvm->dirty_ring_size) {
 		r = kvm_alloc_dirty_bitmap(&new);
 		if (r)
 			return r;
@@ -2668,7 +2668,7 @@ static void mark_page_dirty_in_slot(struct kvm *kvm,
 				    struct kvm_memory_slot *memslot,
 				    gfn_t gfn)
 {
-	if (memslot && memslot->dirty_bitmap) {
+	if (memslot && kvm_slot_dirty_track_enabled(memslot)) {
 		unsigned long rel_gfn = gfn - memslot->base_gfn;
 		u32 slot = (memslot->as_id << 16) | memslot->id;
 
-- 
2.26.2

