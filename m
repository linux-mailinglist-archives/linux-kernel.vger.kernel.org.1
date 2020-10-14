Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251D928E660
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 20:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389685AbgJNS22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 14:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388824AbgJNS10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 14:27:26 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2276C0613D8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 11:27:15 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id y45so83148qve.15
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 11:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=VK4nUWuE6Urr4OKvNaeKhHJ/uqy3tmhC2rICDI8pQEM=;
        b=OAJeWAMCiUkqNclZIZf9eCtx/a5JmLB6dQP0x/vHoRZN6eRjepQJ5IfxrSSSNjYTYA
         Jd09oJC3odnZ1Wh+n+RhpcXhBpCP4xxAUic4bJ1G+4tdDUhnuSeoZ8NyFzBuLqLQS/Ab
         cVy7VO5/g+ilZj/s3i6HHMo5C5oVQ/84hldrGUDWYSUAL5hXcY7OeV8EAx6gw2UWROTP
         B9xz91Sl+QVxN4LD+FNBkILXAqN//pmeoXnuAnDnTXpHttILErUf2QFND92a8N4EnMjS
         1crQLtNcD5SWGdSYYSe9sP7W0i7AY5DMRQbiln5R8bEa4B4UfXBXQl+xM2389bVsuAM+
         Gk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VK4nUWuE6Urr4OKvNaeKhHJ/uqy3tmhC2rICDI8pQEM=;
        b=BM62efxCKzqxj3qD1vMiCOBJV0YCNFmloEJoi/wAwvpN+S3ztVKDgVyLgnvjSScy0q
         qUtffHdzEeTHlmk3XJtlZuM/sgZHiKyeBOFcjZ1NMP9BCpHrT5oAYVySLd7Ql+spZ8WE
         qDvXYkabVO5h3ROYx8573RvHdMzh3iPgyOjNi5IxDQapM/GO7TTPw4hHtrRsW8mgVze/
         xQFsNjoWXc9AMpatIL2zukGF9thr8cjmm8K2sb0xYXuV9FT56cekdmLVRXnL643BONlj
         QamweU9DZLwZ5J/3imiISMEdV17Ws2ZU8pezatcYEshn8UY9DTQix9iKJcPsSWwt0ruB
         +m1Q==
X-Gm-Message-State: AOAM5306R2to8Ek8QLBVH+7WXBxs+tLH1QFZaHNqEZIftnsuw7RFiT/f
        UArcx9YEsVTBWFjhWmNpe48beYotSDGOkuTthjaoGfcafPq6J0DVw/6bIoOyjO9qFOLFQ2HcHQL
        GLQnU5AYX5u2sUn1YeRy9AtW/4FbwKgMonm5C166RxJZCcADVaje8GcgV7Gmt6zfg+Sx5kF2+
X-Google-Smtp-Source: ABdhPJyDBH3cxsFvKx/KaPbcmYDwJ74J5KkBtAYRqy4tXdQWuOmgGQKly65dlFs0LkNo/wLpP2LAlGH+A4SU
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:ad4:5192:: with SMTP id
 b18mr641006qvp.14.1602700034772; Wed, 14 Oct 2020 11:27:14 -0700 (PDT)
Date:   Wed, 14 Oct 2020 11:26:46 -0700
In-Reply-To: <20201014182700.2888246-1-bgardon@google.com>
Message-Id: <20201014182700.2888246-7-bgardon@google.com>
Mime-Version: 1.0
References: <20201014182700.2888246-1-bgardon@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v2 06/20] KVM: Cache as_id in kvm_memory_slot
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
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Xu <peterx@redhat.com>

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
index 05e3c2fb3ef78..c6f45687ba89c 100644
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
index 68edd25dcb11f..2e85392131252 100644
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
2.28.0.1011.ga647a8990f-goog

