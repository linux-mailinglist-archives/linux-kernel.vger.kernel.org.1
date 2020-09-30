Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3571527F46A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 23:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbgI3VuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 17:50:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40919 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731052AbgI3VuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 17:50:00 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601502599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nSk3L+lLkvPp2zEMzy7lJYZ9nOSi7WB6jupEA1yhNZY=;
        b=G2C7Zm0XUXX4HWb0VlWx7nd6O1XWRQLXwsCVE0p0dq03wO9lvt5p8MgaYv+Yo8tp2rHpx5
        nbf+oDjvBKZFq+Mryn7oR2Imd+oixQ9LWMJdzg0ehu7PNydsp2NAsLGVGHtItxOIZqC6cz
        sevIw9+4gh7flF55LX0lKhgfjFWFNLo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-cfJU0MmPPISdk7jDYHp1Qw-1; Wed, 30 Sep 2020 17:49:53 -0400
X-MC-Unique: cfJU0MmPPISdk7jDYHp1Qw-1
Received: by mail-qt1-f200.google.com with SMTP id f5so2195404qtk.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 14:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nSk3L+lLkvPp2zEMzy7lJYZ9nOSi7WB6jupEA1yhNZY=;
        b=tEuxYIRTL+0gDzGudB1d7qlfTmgchj1RK1YZjQKegw0hcLYIKLlH6+9ls/G5MHNhLV
         n7eR7PV/rPToYuRCFzkeVNzqgcuYjZC51PaDImV7VZ2uywqNHr8vlL25GaJfCR63/VCt
         VbUp67/94huZLC+hnqWUb88YLPorRK5jXzQ/71MOMT9fMf/Iu23+59KFyFq/+Xn3GGPJ
         ZIg6/HCG9oAB+37bAV9JUoZWkAgRwT1uoODrsPOPjmjUa64gboDT1+sovDU9uaYdEQU3
         0aTXCwSTjNHqKBi/mcF+3yqRX54xHdLzLKdj7cUrqrEEV1SH448phNceKJ4YI+tyIgbe
         sBsA==
X-Gm-Message-State: AOAM5331T/ijSDSgz7MgLNUSt4dE7bCdJmoYCp21g6b9d8SYjNLDXlds
        E0p3br5oXHrxPXe5vmVV27dd6+iporlTFztCLgqjn9XpoKvG/GnunqJj2FFjMwTXslH6y+Jg7mP
        JZ1J8K+BQF1jTOUqzanzDzStK
X-Received: by 2002:a05:620a:159b:: with SMTP id d27mr4736273qkk.28.1601502592577;
        Wed, 30 Sep 2020 14:49:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6fbIGQaF1ah2COu5uu8NtppdFGpVXdoA4I6mTDTmKqVzv97JX+7YzZ+hePeH4V5AzWCYw9g==
X-Received: by 2002:a05:620a:159b:: with SMTP id d27mr4736253qkk.28.1601502592365;
        Wed, 30 Sep 2020 14:49:52 -0700 (PDT)
Received: from xz-x1.redhat.com (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
        by smtp.gmail.com with ESMTPSA id j88sm3786165qte.96.2020.09.30.14.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 14:49:51 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
        Andrew Jones <drjones@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v12 01/13] KVM: Cache as_id in kvm_memory_slot
Date:   Wed, 30 Sep 2020 17:49:36 -0400
Message-Id: <20200930214948.47225-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930214948.47225-1-peterx@redhat.com>
References: <20200930214948.47225-1-peterx@redhat.com>
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
index cf88233b819a..64228366bf9d 100644
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

