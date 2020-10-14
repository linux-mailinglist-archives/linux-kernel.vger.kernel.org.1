Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9058128E658
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 20:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbgJNS2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 14:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389175AbgJNS1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 14:27:46 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5BBC0613E3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 11:27:39 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id y77so354049qkb.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 11:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=89LrHzVsLlwPBCGn84hGo/p+FJBhRaw2texxmtA4jtA=;
        b=G0CBA16RiGAumu6zAemSqyOdhCK2t0J6mY2WbIOvQp14LFcD7co9CLm/gSj3d7ou9G
         XtE2cAaxSEe5Ua17Si2vIdYX7lVuMAei6cqwgXO6puYzYxn3e81DiB8pen/ANenriYWS
         MQ8HAiCMx2x+8+Ge7jbI98vKWUhOXzsfhAORKXZP76rjJ+BQNRXGXa4/exCXtxqUCxI+
         MBcrDurIBPgrBVhTz3yzlEWtcNu1/fqxh+9osjW3AmiiPEO+J8wWZM7eZtPR65BaBhyB
         0FOqWx9w2DrlrYhNfql9GH7DSU2FjrjKgWSmGLnPNMSAQPk6s+ePGXMmClf3tubOYaTl
         kndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=89LrHzVsLlwPBCGn84hGo/p+FJBhRaw2texxmtA4jtA=;
        b=AX1MCX/GcXNXThXx6wNM61qtbxeUz+eKuoHO5/42a+F5dkrEQvLaIYUk60URtOg2HD
         TqKQ92muydIvwXoQ1hCN5w3RF6PV2ttMXOWJEYEpM3jNRUzhcGp2qwDCyFGLzH9JQ7AD
         ivol71yGKUM3GAVYsh2b6W3Bx3TWFWBeuUIJnsLtOsdDtIubPfzo9l+7HC4+MWIF7Lic
         CdyJARwmk48+XkOt1M3Y/sOc+8FWT7EJmtlSOt5793DtISmlq56eTVb9Wxi7MbAzj0qS
         xdi3i6sYUldbN9IJWfXhW4V0kVGuyhHuGPC+fydwf1ked95Uo/skr1mMTE4E8W7IXpaU
         F8JA==
X-Gm-Message-State: AOAM532AoBmQmT8dOlCBxKRsl9Z9o8g/i4ESpcI+umqrwLC8uiVzcNPe
        068RCKETQ2YB49pqVgor+19kk+IIBBQmEKdV8C6N2iLsRTpBLpMLqfEY9LOcj8YMEiR7ZcMy0cN
        WsY8sgVwgm5dJ0C5E4o0AZBubogYcCNTmWNJKT79DPfOJrRu/EN+lb/S4Rk9n7PkyKPmM0fna
X-Google-Smtp-Source: ABdhPJwawAS2Dd68rKKMGCq+qgkWISOp7hkWeeEYdOms1yoISAraLw8ftyqMJBLQy+cDH0TqvBG2hrHKkY7D
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a05:6214:2ed:: with SMTP id
 h13mr593520qvu.26.1602700058739; Wed, 14 Oct 2020 11:27:38 -0700 (PDT)
Date:   Wed, 14 Oct 2020 11:26:59 -0700
In-Reply-To: <20201014182700.2888246-1-bgardon@google.com>
Message-Id: <20201014182700.2888246-20-bgardon@google.com>
Mime-Version: 1.0
References: <20201014182700.2888246-1-bgardon@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v2 19/20] kvm: x86/mmu: Don't clear write flooding count for
 direct roots
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

Direct roots don't have a write flooding count because the guest can't
affect that paging structure. Thus there's no need to clear the write
flooding count on a fast CR3 switch for direct roots.

Tested by running kvm-unit-tests and KVM selftests on an Intel Haswell
machine. This series introduced no new failures.

This series can be viewed in Gerrit at:
	https://linux-review.googlesource.com/c/virt/kvm/kvm/+/2538

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 2e8bf8d19c35a..3935c10278736 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4266,7 +4266,13 @@ static void __kvm_mmu_new_pgd(struct kvm_vcpu *vcpu, gpa_t new_pgd,
 	 */
 	vcpu_clear_mmio_info(vcpu, MMIO_GVA_ANY);
 
-	__clear_sp_write_flooding_count(to_shadow_page(vcpu->arch.mmu->root_hpa));
+	/*
+	 * If this is a direct root page, it doesn't have a write flooding
+	 * count. Otherwise, clear the write flooding count.
+	 */
+	if (!new_role.direct)
+		__clear_sp_write_flooding_count(
+				to_shadow_page(vcpu->arch.mmu->root_hpa));
 }
 
 void kvm_mmu_new_pgd(struct kvm_vcpu *vcpu, gpa_t new_pgd, bool skip_tlb_flush,
-- 
2.28.0.1011.ga647a8990f-goog

