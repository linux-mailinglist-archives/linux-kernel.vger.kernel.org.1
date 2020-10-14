Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68DB428E64B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 20:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388978AbgJNS11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 14:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388649AbgJNS1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 14:27:25 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDF7C0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 11:27:19 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id g10so61125plq.16
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 11:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=wY4tgs0pi6sIzg93cSmFgz86D4AP0S31kjVXLjyJIw0=;
        b=olYHCR2NXYq0J8YqJvQH0WOXdRPl6mlbpCuZbG+u1S889Dhkvlt86OKpSfQgYmh2cT
         A/kYeakkwnl6TjH8W09rHezZUNYOmMWz7JWDDKFYlz5IwExB8KpTujnNuJ8ynHtTQfiL
         ll+J0xJ99N5OwHP+UD8jy+ZGLJwkcXGXqO0XXs8rU5oV+qq01h8KtRw1oJBv+dWjZuUm
         ehKZO5InCluPB/TR3OOiLhlTcvIR7//sU51JMOKST+yeE6XmyRsEs61Bka6xHYMvRzeG
         ubiz77vDCqUNqq+AsHptb7ncaHRovE1zd70HTcX5mmgIoftgIcPF4JJKCZQhKB3p+1KF
         H4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wY4tgs0pi6sIzg93cSmFgz86D4AP0S31kjVXLjyJIw0=;
        b=K/uqprHw27E1MeUpJ4ZVQ3GNH8bRc877ylREEM4vlRNJ9MuDXP9bvqnZsx1F8pWdho
         6M9LbJgIwdKrK6J0p0ji0n7xnsZQIdSj3xJIVFAjy5jAJ3iTCXbfGGDxToNTqjkkoJnG
         3Neh5vppzeds2Wu+ND1VUPjNaY39ssPJk+JKv7rbK/iqtJy5GTutdWVR7krSPeVtX2m6
         Vg3d6B44FF+NMwEZYHIt56SvoaDJVAYOgumElCuuYjOYrdWm8DWVVvwAm5zNLThs9nVw
         HT3+RROTGHYxnys0RObn7nOm4i6Lcz8f3xIB9DpiKkjDKOHUAiiZGCed+7cDICf2u4Ui
         f0OA==
X-Gm-Message-State: AOAM5310jvL++6Zhk8I76ZLwRrion+sBVeAkGPqSC6tlPEzEFrVHEfxB
        eRSWpJTZCz3nJM7Ii6dP8ZT5XKi5usin17xY3NminqnmJwE0ANn54beiCqfpCpMPa+Hix9Hkr9Q
        LFCNytW27rqxvEL5upGNRK20hOVvrNqJFA+FKbbtU0R0rWruMLvVXRucUYUYnETmXnxYpIxHi
X-Google-Smtp-Source: ABdhPJwXOeBFjFNi1VtMFt6WRQ9LuOV/lmvwx45bGJF9r02uD5Cnpqm88v1FGDw0Elkeg1BKVbkyCtLJ7TY1
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a17:902:ec02:b029:d1:fc2b:fe95 with SMTP
 id l2-20020a170902ec02b02900d1fc2bfe95mr241980pld.79.1602700038329; Wed, 14
 Oct 2020 11:27:18 -0700 (PDT)
Date:   Wed, 14 Oct 2020 11:26:48 -0700
In-Reply-To: <20201014182700.2888246-1-bgardon@google.com>
Message-Id: <20201014182700.2888246-9-bgardon@google.com>
Mime-Version: 1.0
References: <20201014182700.2888246-1-bgardon@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v2 08/20] kvm: x86/mmu: Separate making non-leaf sptes from link_shadow_page
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
index 337ab6823e312..05024b8ae5a4d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2468,21 +2468,30 @@ static void shadow_walk_next(struct kvm_shadow_walk_iterator *iterator)
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
2.28.0.1011.ga647a8990f-goog

