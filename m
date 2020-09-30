Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA92F27F474
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 23:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbgI3Vyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 17:54:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60688 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728721AbgI3Vyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 17:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601502875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AJr6sZtaF32qOZfij42mZzwqbz/lcN7EM7H0y7gk4Xo=;
        b=OYgG1Mo+QEqCQXY8A86uCEFrIFNxJv9DoePhtaXc0Qn03RrvjATlQoQcTGTn768gRpz4XY
        m9iiGH88KdB5iGf8Q0JdXZG+DyGWx1cSBokkJq9qdamXG0azemKqsuNPdUrt8FBo0IGUIu
        SVzoi/AFfDg2G2AvMdGalTflwfC+0QY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-UJNykJ3DOvKj4DgBZNOgRQ-1; Wed, 30 Sep 2020 17:54:31 -0400
X-MC-Unique: UJNykJ3DOvKj4DgBZNOgRQ-1
Received: by mail-qv1-f70.google.com with SMTP id t7so1859581qvz.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 14:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AJr6sZtaF32qOZfij42mZzwqbz/lcN7EM7H0y7gk4Xo=;
        b=uF52KzDw10d7wqokVSMxlegshY7Jxjp3J9XKQo+rYVNlR5a6mH6vOiVmYg55mK0HKA
         NqRxHWNCuexF3wKc2/XyFZo9RJFtSjDG+egeYZvDau1WQOQjfCn1teAvhvGl10ZZVXl/
         h3D76ovEpqcbZclj3T2imLYAhQJhsmc1dWk3hzsqdobXQJUO0R/1s4V7FcLTThr8tIjO
         7jwnI02Sh799iUDNhn3AMlSsxYxzaY2VFXVKtc3Z6rDG3+vMmP0bv9oQsDCB8ogdhouc
         OeRbHNNouHQ6+O/djHlvtpzHxVQx5KSFv4za0zKIpTnWoWAk42ftOjUzAHcat6zqoeMs
         Al5w==
X-Gm-Message-State: AOAM5313hqLSwLEI3yh4AX3mhyOrOgSmfhNAqvCWKloAYt+FIIN9Ab3A
        cASWPy2ZMsL4QIkCf1eaTAAszwds6iJlSUlFZoB2Jb9FxHqZBICOUbTCvDbMx4mueUx+bgghFat
        UQ4nI6atcrdoryvaaFjcrM2Yy
X-Received: by 2002:ac8:75d4:: with SMTP id z20mr4402598qtq.370.1601502870522;
        Wed, 30 Sep 2020 14:54:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyr25D7L5l+McNtqfhiHi2P5wJro6ohn7YWEsHWKQCwDVHrs9Dp9zS6GaHLJclzU15mvM51fw==
X-Received: by 2002:ac8:75d4:: with SMTP id z20mr4402584qtq.370.1601502870304;
        Wed, 30 Sep 2020 14:54:30 -0700 (PDT)
Received: from xz-x1.redhat.com (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
        by smtp.gmail.com with ESMTPSA id p20sm4194211qtk.21.2020.09.30.14.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 14:54:29 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrew Jones <drjones@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com
Subject: [PATCH v12 03/13] KVM: Pass in kvm pointer into mark_page_dirty_in_slot()
Date:   Wed, 30 Sep 2020 17:54:28 -0400
Message-Id: <20200930215428.47901-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930214948.47225-1-peterx@redhat.com>
References: <20200930214948.47225-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The context will be needed to implement the kvm dirty ring.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 virt/kvm/kvm_main.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 64228366bf9d..fd0fff7d767b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -143,7 +143,9 @@ static void hardware_disable_all(void);
 
 static void kvm_io_bus_destroy(struct kvm_io_bus *bus);
 
-static void mark_page_dirty_in_slot(struct kvm_memory_slot *memslot, gfn_t gfn);
+static void mark_page_dirty_in_slot(struct kvm *kvm,
+				    struct kvm_memory_slot *memslot,
+				    gfn_t gfn);
 
 __visible bool kvm_rebooting;
 EXPORT_SYMBOL_GPL(kvm_rebooting);
@@ -2198,7 +2200,8 @@ int kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map)
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_map);
 
-static void __kvm_unmap_gfn(struct kvm_memory_slot *memslot,
+static void __kvm_unmap_gfn(struct kvm *kvm,
+			struct kvm_memory_slot *memslot,
 			struct kvm_host_map *map,
 			struct gfn_to_pfn_cache *cache,
 			bool dirty, bool atomic)
@@ -2223,7 +2226,7 @@ static void __kvm_unmap_gfn(struct kvm_memory_slot *memslot,
 #endif
 
 	if (dirty)
-		mark_page_dirty_in_slot(memslot, map->gfn);
+		mark_page_dirty_in_slot(kvm, memslot, map->gfn);
 
 	if (cache)
 		cache->dirty |= dirty;
@@ -2237,7 +2240,7 @@ static void __kvm_unmap_gfn(struct kvm_memory_slot *memslot,
 int kvm_unmap_gfn(struct kvm_vcpu *vcpu, struct kvm_host_map *map, 
 		  struct gfn_to_pfn_cache *cache, bool dirty, bool atomic)
 {
-	__kvm_unmap_gfn(gfn_to_memslot(vcpu->kvm, map->gfn), map,
+	__kvm_unmap_gfn(vcpu->kvm, gfn_to_memslot(vcpu->kvm, map->gfn), map,
 			cache, dirty, atomic);
 	return 0;
 }
@@ -2245,8 +2248,8 @@ EXPORT_SYMBOL_GPL(kvm_unmap_gfn);
 
 void kvm_vcpu_unmap(struct kvm_vcpu *vcpu, struct kvm_host_map *map, bool dirty)
 {
-	__kvm_unmap_gfn(kvm_vcpu_gfn_to_memslot(vcpu, map->gfn), map, NULL,
-			dirty, false);
+	__kvm_unmap_gfn(vcpu->kvm, kvm_vcpu_gfn_to_memslot(vcpu, map->gfn),
+			map, NULL, dirty, false);
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_unmap);
 
@@ -2420,7 +2423,8 @@ int kvm_vcpu_read_guest_atomic(struct kvm_vcpu *vcpu, gpa_t gpa,
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_read_guest_atomic);
 
-static int __kvm_write_guest_page(struct kvm_memory_slot *memslot, gfn_t gfn,
+static int __kvm_write_guest_page(struct kvm *kvm,
+				  struct kvm_memory_slot *memslot, gfn_t gfn,
 			          const void *data, int offset, int len)
 {
 	int r;
@@ -2432,7 +2436,7 @@ static int __kvm_write_guest_page(struct kvm_memory_slot *memslot, gfn_t gfn,
 	r = __copy_to_user((void __user *)addr + offset, data, len);
 	if (r)
 		return -EFAULT;
-	mark_page_dirty_in_slot(memslot, gfn);
+	mark_page_dirty_in_slot(kvm, memslot, gfn);
 	return 0;
 }
 
@@ -2441,7 +2445,7 @@ int kvm_write_guest_page(struct kvm *kvm, gfn_t gfn,
 {
 	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
 
-	return __kvm_write_guest_page(slot, gfn, data, offset, len);
+	return __kvm_write_guest_page(kvm, slot, gfn, data, offset, len);
 }
 EXPORT_SYMBOL_GPL(kvm_write_guest_page);
 
@@ -2450,7 +2454,7 @@ int kvm_vcpu_write_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn,
 {
 	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 
-	return __kvm_write_guest_page(slot, gfn, data, offset, len);
+	return __kvm_write_guest_page(vcpu->kvm, slot, gfn, data, offset, len);
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_write_guest_page);
 
@@ -2569,7 +2573,7 @@ int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 	r = __copy_to_user((void __user *)ghc->hva + offset, data, len);
 	if (r)
 		return -EFAULT;
-	mark_page_dirty_in_slot(ghc->memslot, gpa >> PAGE_SHIFT);
+	mark_page_dirty_in_slot(kvm, ghc->memslot, gpa >> PAGE_SHIFT);
 
 	return 0;
 }
@@ -2645,7 +2649,8 @@ int kvm_clear_guest(struct kvm *kvm, gpa_t gpa, unsigned long len)
 }
 EXPORT_SYMBOL_GPL(kvm_clear_guest);
 
-static void mark_page_dirty_in_slot(struct kvm_memory_slot *memslot,
+static void mark_page_dirty_in_slot(struct kvm *kvm,
+				    struct kvm_memory_slot *memslot,
 				    gfn_t gfn)
 {
 	if (memslot && memslot->dirty_bitmap) {
@@ -2660,7 +2665,7 @@ void mark_page_dirty(struct kvm *kvm, gfn_t gfn)
 	struct kvm_memory_slot *memslot;
 
 	memslot = gfn_to_memslot(kvm, gfn);
-	mark_page_dirty_in_slot(memslot, gfn);
+	mark_page_dirty_in_slot(kvm, memslot, gfn);
 }
 EXPORT_SYMBOL_GPL(mark_page_dirty);
 
@@ -2669,7 +2674,7 @@ void kvm_vcpu_mark_page_dirty(struct kvm_vcpu *vcpu, gfn_t gfn)
 	struct kvm_memory_slot *memslot;
 
 	memslot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
-	mark_page_dirty_in_slot(memslot, gfn);
+	mark_page_dirty_in_slot(vcpu->kvm, memslot, gfn);
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_mark_page_dirty);
 
-- 
2.26.2

