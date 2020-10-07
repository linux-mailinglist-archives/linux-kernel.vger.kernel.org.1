Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C530286988
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 22:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgJGUy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 16:54:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36144 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728503AbgJGUxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 16:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602104032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6xHjUrHigWna5Zg5F0+gVJTiR0rRWsZLLLTG4Bqd1lY=;
        b=gi195+tgr14IM2eGj1eeJyi69hfadqlgmbvP+mTO5UAjx5PPu5R9+kNID6oRLsLoZrcrhf
        7zgaXwGEuwfOiBD1FJSwy57KUtPotJjNjIi+N6/kaPJ9xpjEKR136NnE7Py+fegYv3BSWt
        fAzAKYxoayh/uDkbgGEyw2/4TWq7/SY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-yvlFhFShNKiLMNvV9jNGWg-1; Wed, 07 Oct 2020 16:53:47 -0400
X-MC-Unique: yvlFhFShNKiLMNvV9jNGWg-1
Received: by mail-qv1-f70.google.com with SMTP id s8so2170130qvv.18
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 13:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6xHjUrHigWna5Zg5F0+gVJTiR0rRWsZLLLTG4Bqd1lY=;
        b=n1sATdFEdOH2NZrcqVXvOdwJpB/H3VTCCBGf2RcQg0BMYhLFoWYY6hHbtebSa11m/z
         YsTE1NToFDeO+aW2jGVBBCUXKhwzZhbsc02IfWftaZCZcRsHZBDODXiaEdpKV4uaNFAe
         jK/meILOcInpUOI+je6BLvuAnm8+ZskpUg8cIAzXQXkEPBp87fLkRRrxsLlM+/UfYhn3
         WWJ2oacw8OXb8QhufMNZKpuJYNQVwgqcp/amXACVypv7DmYL/hZIzNs/rEK8/EaqLcRc
         l+BrBCakN52u/jJ3r9+eFmMCwWEN7k+OkJXZTKuRm58BH2zXnr22TBdZ/3aSmPrVf84E
         pDcw==
X-Gm-Message-State: AOAM5324eMez1qCUZMYRRO0CKRxCAtcO/QrnDQxzh7X69fnFSBKf9slq
        03z3LLqwLjWilCInix3mAlPSYNw8RhpGFfQJtDLfNcZ2SUM75YVibYcwSbuYlbbbY7fs/lbJ/KO
        snDhY90RI6ixJFfhTJ7vybPtu
X-Received: by 2002:a05:6214:1021:: with SMTP id k1mr4917686qvr.62.1602104027095;
        Wed, 07 Oct 2020 13:53:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhNW2wS4ALCYIj39Y72wimsXW7vLV8Lzw2/w1VJ9gCyoPqXzDfIAWFbKr0zCK2lL3ThX9NOQ==
X-Received: by 2002:a05:6214:1021:: with SMTP id k1mr4917670qvr.62.1602104026853;
        Wed, 07 Oct 2020 13:53:46 -0700 (PDT)
Received: from xz-x1.redhat.com (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca. [174.95.215.133])
        by smtp.gmail.com with ESMTPSA id j24sm2390695qkg.107.2020.10.07.13.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 13:53:46 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andrew Jones <drjones@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v14 02/14] KVM: Cache as_id in kvm_memory_slot
Date:   Wed,  7 Oct 2020 16:53:30 -0400
Message-Id: <20201007205342.295402-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201007205342.295402-1-peterx@redhat.com>
References: <20201007205342.295402-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cache the address space ID just like the slot ID.  It will be used in
order to fill in the dirty ring entries.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/kvm_host.h | 1 +
 virt/kvm/kvm_main.c      | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 05e3c2fb3ef7..c6f45687ba89 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -346,6 +346,7 @@ struct kvm_memory_slot {
 	unsigned long userspace_addr;
 	u32 flags;
 	short id;
+	u16 as_id;
 };
 
 static inline unsigned long kvm_dirty_bitmap_bytes(struct kvm_memory_slot *memslot)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 68edd25dcb11..2e8539213125 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1247,6 +1247,11 @@ static int kvm_delete_memslot(struct kvm *kvm,
 
 	memset(&new, 0, sizeof(new));
 	new.id = old->id;
+	/*
+	 * This is only for debugging purpose; it should never be referenced
+	 * for a removed memslot.
+	 */
+	new.as_id = as_id;
 
 	r = kvm_set_memslot(kvm, mem, old, &new, as_id, KVM_MR_DELETE);
 	if (r)
@@ -1313,6 +1318,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	if (!mem->memory_size)
 		return kvm_delete_memslot(kvm, mem, &old, as_id);
 
+	new.as_id = as_id;
 	new.id = id;
 	new.base_gfn = mem->guest_phys_addr >> PAGE_SHIFT;
 	new.npages = mem->memory_size >> PAGE_SHIFT;
-- 
2.26.2

