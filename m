Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154C42F3822
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 19:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406332AbhALSMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 13:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406311AbhALSMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 13:12:49 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E200C061385
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 10:11:09 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id u14so1956321plx.23
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 10:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=HlxHQG6STtx0QDM9VJz9RspfS5viveHc/2QI5Fjkqgw=;
        b=d4mGH/OB1ceSgbJO5NKkqNsIB4zZmkowAlLR9wa74B703TN95w9BrVrCdbPNO4Yryr
         WvnNjjMDNKXC0/eGEcJnHWiRgcT3W99lFEMPOcInPWFcON0SSEI82n9OJtJjJItq+RUs
         +I0M7NHcozxn4iSlhgT42nbqxfQE0rnSH27MW8S/vn992usCRq9VK2V+sSvvCnw3FO8K
         GN+4CyhivXqt8Q0zHVEnKB5PekVmUcG20I7pKZwNZo6c9OfBp1N6a1DebJsr7arkg7d9
         siXIUVI5NIWysNkgLEjOJBHAK3zQ85W38Fvg/XCdZsD/Gmw/H0l0nSVKIpvxaxbCnTzx
         mKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HlxHQG6STtx0QDM9VJz9RspfS5viveHc/2QI5Fjkqgw=;
        b=h7B/KlbTLys0fyAu1RXLIv5nL0vA6+PkHaHlzsLd2+KcOs0eGHCAkZliCVV1a8NREt
         2JZ55/aaRDCJbGuyIYZ7nlCLk2wCzlGSNBSuhkGhUIZN4lGaOoSpIc4bh8XgTZfkSl97
         0lrqLlF9uBh0lyG+fq0FMqeff0qLEPF5CCQbWpVXSFeCtX55q5EFzqSkv7e8pYhpn3gG
         o2JsWuq7mZWQS8B21apmH40EZaCt1gVzj4gwgcOn10KV41z0UPJpFPwLLNzmajcuKPHQ
         yamR4fQahGmuRp7VybeiJH48rk9NU/VwIJMonYWBTM2tSb1UMPtutnq5XSvEFRjIFSk2
         w+YA==
X-Gm-Message-State: AOAM531HqV6kZsCn3csuDL6ZXEPrG3KugmUg6Tn56eOKj2jxEgDYe5LY
        AJwKcO86JViQzOi4x3cvRuPYUBDIHVxQYAt7aeLQG+1Ve8n2Isw3EGhTUkoMkR6MZ6tpqbfIBb2
        0xejgUq0hfcZuW9KLnCw+2t2MyTt+EyEnr66cATaX2tFWYmDxuFal3iuClGBOuOt6+8LoW5ju
X-Google-Smtp-Source: ABdhPJzg28iu7t/1wOfSzZBQdSgjd/0s49dwgkvIcEHYSTQhnxllRD1Mf3g4mwnNhaeW7LkyIluVzEezkLjm
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a17:902:34f:b029:dc:3032:e47d with SMTP id
 73-20020a170902034fb02900dc3032e47dmr181607pld.15.1610475068774; Tue, 12 Jan
 2021 10:11:08 -0800 (PST)
Date:   Tue, 12 Jan 2021 10:10:30 -0800
In-Reply-To: <20210112181041.356734-1-bgardon@google.com>
Message-Id: <20210112181041.356734-14-bgardon@google.com>
Mime-Version: 1.0
References: <20210112181041.356734-1-bgardon@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 13/24] kvm: x86/mmu: Only free tdp_mmu pages after a grace period
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
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

By waiting until an RCU grace period has elapsed to free TDP MMU PT memory,
the system can ensure that no kernel threads access the memory after it
has been freed.

Reviewed-by: Peter Feiner <pfeiner@google.com>

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/mmu_internal.h |  3 +++
 arch/x86/kvm/mmu/tdp_mmu.c      | 31 +++++++++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index bfc6389edc28..7f599cc64178 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -57,6 +57,9 @@ struct kvm_mmu_page {
 	atomic_t write_flooding_count;
 
 	bool tdp_mmu_page;
+
+	/* Used for freeing the page asyncronously if it is a TDP MMU page. */
+	struct rcu_head rcu_head;
 };
 
 extern struct kmem_cache *mmu_page_header_cache;
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 662907d374b3..dc5b4bf34ca2 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -42,6 +42,12 @@ void kvm_mmu_uninit_tdp_mmu(struct kvm *kvm)
 		return;
 
 	WARN_ON(!list_empty(&kvm->arch.tdp_mmu_roots));
+
+	/*
+	 * Ensure that all the outstanding RCU callbacks to free shadow pages
+	 * can run before the VM is torn down.
+	 */
+	rcu_barrier();
 }
 
 static void tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root)
@@ -196,6 +202,28 @@ hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu)
 	return __pa(root->spt);
 }
 
+static void tdp_mmu_free_sp(struct kvm_mmu_page *sp)
+{
+	free_page((unsigned long)sp->spt);
+	kmem_cache_free(mmu_page_header_cache, sp);
+}
+
+/*
+ * This is called through call_rcu in order to free TDP page table memory
+ * safely with respect to other kernel threads that may be operating on
+ * the memory.
+ * By only accessing TDP MMU page table memory in an RCU read critical
+ * section, and freeing it after a grace period, lockless access to that
+ * memory won't use it after it is freed.
+ */
+static void tdp_mmu_free_sp_rcu_callback(struct rcu_head *head)
+{
+	struct kvm_mmu_page *sp = container_of(head, struct kvm_mmu_page,
+					       rcu_head);
+
+	tdp_mmu_free_sp(sp);
+}
+
 static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
 				u64 old_spte, u64 new_spte, int level);
 
@@ -273,8 +301,7 @@ static void handle_disconnected_tdp_mmu_page(struct kvm *kvm, u64 *pt)
 	kvm_flush_remote_tlbs_with_address(kvm, gfn,
 					   KVM_PAGES_PER_HPAGE(level));
 
-	free_page((unsigned long)pt);
-	kmem_cache_free(mmu_page_header_cache, sp);
+	call_rcu(&sp->rcu_head, tdp_mmu_free_sp_rcu_callback);
 }
 
 /**
-- 
2.30.0.284.gd98b1dd5eaa7-goog

