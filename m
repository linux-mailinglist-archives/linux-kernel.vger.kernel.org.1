Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D8327F720
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 03:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbgJABVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 21:21:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20618 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730223AbgJABVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 21:21:02 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601515260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9WQM922/ujEpth7wPBQLl+hC1rbuv4XbBYQfJtRx5bA=;
        b=aUhsy2LdMtJC7Oq30FtQT2Rm+LLnzicJLRowYs1YXfWlqhXgo4n/qIxve+jQ61+E/wq4xZ
        eNCJauBaFvZ4tLrhnt1sWQLw90Xq7r/ILvZQLe20KqMdiHj3kci7GiVtoafWaerYk+DhXr
        SzTAqHI4kctFhOITeSp5YmQYaTOCNeQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-GE782hG9O-iBYRPJsoNoRA-1; Wed, 30 Sep 2020 21:20:58 -0400
X-MC-Unique: GE782hG9O-iBYRPJsoNoRA-1
Received: by mail-qt1-f200.google.com with SMTP id g44so2520226qtb.15
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9WQM922/ujEpth7wPBQLl+hC1rbuv4XbBYQfJtRx5bA=;
        b=tsaG0wYCJ/kATKYrLYRsAe52dlp1KS/FDufIvviF99nGBc7lxHPZNYIU/XrmleZjaH
         30o8RzSvf/TVsf9I9gmO4I7e0aH2VD82KYJPde/v6of2zPANk/LUKHtYSfxYF7igHTmm
         p1j1ApRuMPKS6M3ojmJeURSwIFt/k+HYvh2w3R83ezf0NZyIZtagsJ02ZYEih7zyvFOk
         e1K8+8DRPPFqk3dpsePV3ix0/f0CVgQ3e5aUZe3urQMmOtF4HW9hJ2PrN0/B0mNeVKbj
         9Mhp2jkO5Y3xjKG0cuA25Lgx4yXL+/9DnGFs2wKRZKm/QhBeh1g/N6AGfuWneQi5RaVN
         s+eQ==
X-Gm-Message-State: AOAM5306TZL2lURLhbnJrYV373FO2/YPHG5vFJUMPbOhhEoYw1qJIA/h
        xaDd2XaJGJmcBWxDyaRnHcxMk9C9aMHj/u75bEBMQJn0oV5bfRnG6mAK13KBondyQAM3YbEBcOu
        D7mXmqhCBOOWRzKXv6u6x2DJX
X-Received: by 2002:a37:638d:: with SMTP id x135mr5683535qkb.60.1601515255043;
        Wed, 30 Sep 2020 18:20:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQTVVau8DmNXj8y7C7yUAlA6pcESylpD0lykjJ6MrvuWD95UQKtjaXOdePVsObH5yHGRovIg==
X-Received: by 2002:a37:638d:: with SMTP id x135mr5683519qkb.60.1601515254834;
        Wed, 30 Sep 2020 18:20:54 -0700 (PDT)
Received: from localhost.localdomain (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
        by smtp.gmail.com with ESMTPSA id y46sm4714478qtc.30.2020.09.30.18.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 18:20:54 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v13 04/14] KVM: Pass in kvm pointer into mark_page_dirty_in_slot()
Date:   Wed, 30 Sep 2020 21:20:34 -0400
Message-Id: <20201001012044.5151-5-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001012044.5151-1-peterx@redhat.com>
References: <20201001012044.5151-1-peterx@redhat.com>
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
index 2e8539213125..63cbf335e2e7 100644
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

