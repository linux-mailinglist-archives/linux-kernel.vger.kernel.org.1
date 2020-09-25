Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800B7279339
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 23:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgIYVXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 17:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728967AbgIYVXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 17:23:23 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7A3C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 14:23:23 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id n19so276449pjt.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 14:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=hVmmolr7lApGk7er3lyz+NeUKAxqmQR1uXEi12OS9QI=;
        b=uRtx0Sr98de4gAfMY1ZHAxFljk+3TBqrF4dPujcOUMsyV5fvW1CpsCnPvnSk4Vs+2i
         ZIVNnjex9pUL+yK2imwPPO4huqwVjgM8aoxMQwsFtsJEy9fgN9n7CkyoOIeKjvvywy+X
         EIVWmdyevSw4H6HREAcQ15Lslpl96aSeEoNszzmvueLQQn4Knbs7hlmXnRsSIfrCUE7X
         MT8uAB+eDiYP0NilKmyz4QL2kbEm0sbZSyHIG6uAzPpXvcZcWORNbzFap6tjeGdZSpiV
         1eLi0rhwnrXhacfCK/zMlMJoJ9XRG+/E3Ch4YUnDGPXHUQ3STFZNKmhlIoK2AddOrYa1
         CpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hVmmolr7lApGk7er3lyz+NeUKAxqmQR1uXEi12OS9QI=;
        b=mW3h3D+SbmHEYb3Bd3UVeEjrkk+ha+DusM+DHOduzBAy999W08HkPWYGolLIy/gE8C
         uHtHGyHslDh5Svel1fk7sTOiQ3N9L2yOiOsxgrX7T2uBdi5jo+jm/mZRQbnkd/nbVw1m
         W4e4+sUgtkXriJDnwbcHjDJXx2Sb+fYJOhfgpb2/MAHcQmHRG1+uxJXlFcZ/nM4nSZKC
         q6EjUsv2KHC9ve1ZdION0U/ldRGiXgV36KPBuaoQnwguh+reobtmLwbe1OTyFjmD5GBH
         Tv6Zskf1xXPKKcuktHYdGYYR5pEQYLEphbc2fwNJM+Yh+x/KfZwZWe4HDu4vI917jgtt
         I4SQ==
X-Gm-Message-State: AOAM530dDHyOvTsHnjj5vyRaDwX9mOLl5kHRnI+O/LFow0fkG51DKbzS
        A36cDjslkOgDHbwysK7FfwIMPB4d1QSQyMrN4JwFXfJnewzt032lTlu76V45XnOmt4o06l8a3xl
        f8pcdOGDCKc1w5tZs5UuFYENsPPdwt8ATb4tNW+PISkGAErTMmiqFTk73RSyS19trw6WrFSOg
X-Google-Smtp-Source: ABdhPJykTZAToU4jQbARt+8vitv5ixVAqw6g+lXeuJjrE9Gr7hVSbzWTzxvSUmnaY+OwpaF11zb8bh9nYq2n
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a17:902:5995:b029:d2:6140:79d6 with SMTP
 id p21-20020a1709025995b02900d2614079d6mr1286927pli.11.1601069002622; Fri, 25
 Sep 2020 14:23:22 -0700 (PDT)
Date:   Fri, 25 Sep 2020 14:22:48 -0700
In-Reply-To: <20200925212302.3979661-1-bgardon@google.com>
Message-Id: <20200925212302.3979661-9-bgardon@google.com>
Mime-Version: 1.0
References: <20200925212302.3979661-1-bgardon@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH 08/22] kvm: mmu: Separate making non-leaf sptes from link_shadow_page
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

The TDP MMU page fault handler will need to be able to create non-leaf
SPTEs to build up the paging structures. Rather than re-implementing the
function, factor the SPTE creation out of link_shadow_page.

Tested by running kvm-unit-tests and KVM selftests on an Intel Haswell
machine. This series introduced no new failures.

This series can be viewed in Gerrit at:
	https://linux-review.googlesource.com/c/virt/kvm/kvm/+/2538

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 7a17cca19b0c1..6344e7863a0f5 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2555,21 +2555,30 @@ static void shadow_walk_next(struct kvm_shadow_walk_iterator *iterator)
 	__shadow_walk_next(iterator, *iterator->sptep);
 }
 
-static void link_shadow_page(struct kvm_vcpu *vcpu, u64 *sptep,
-			     struct kvm_mmu_page *sp)
+static u64 make_nonleaf_spte(u64 *child_pt, bool ad_disabled)
 {
 	u64 spte;
 
-	BUILD_BUG_ON(VMX_EPT_WRITABLE_MASK != PT_WRITABLE_MASK);
-
-	spte = __pa(sp->spt) | shadow_present_mask | PT_WRITABLE_MASK |
+	spte = __pa(child_pt) | shadow_present_mask | PT_WRITABLE_MASK |
 	       shadow_user_mask | shadow_x_mask | shadow_me_mask;
 
-	if (sp_ad_disabled(sp))
+	if (ad_disabled)
 		spte |= SPTE_AD_DISABLED_MASK;
 	else
 		spte |= shadow_accessed_mask;
 
+	return spte;
+}
+
+static void link_shadow_page(struct kvm_vcpu *vcpu, u64 *sptep,
+			     struct kvm_mmu_page *sp)
+{
+	u64 spte;
+
+	BUILD_BUG_ON(VMX_EPT_WRITABLE_MASK != PT_WRITABLE_MASK);
+
+	spte = make_nonleaf_spte(sp->spt, sp_ad_disabled(sp));
+
 	mmu_spte_set(sptep, spte);
 
 	mmu_page_add_parent_pte(vcpu, sp, sptep);
-- 
2.28.0.709.gb0816b6eb0-goog

