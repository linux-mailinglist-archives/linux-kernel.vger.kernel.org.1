Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72EE2F3849
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 19:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406641AbhALSOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 13:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404683AbhALSMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 13:12:09 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C344CC0617B0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 10:10:56 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id x17so3228963ybs.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 10:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6HOAnRul988JJcHPRX8SIpofrQYmL4UmifPvTiFwC5E=;
        b=LmD+Ye0gR0HZbJIPEvD4VMC4cKzk725zV2/I/TjwpnVJLuYfqqLkO0eIEa2hZOetTC
         ZjhPYAo3MAhSjXnYSpfZljfHlU/c9zjss8vB7Vc8RSEnJmeceI4VXTEoaArE+NVbSO58
         LUF7knuZiZ3BTP7c4FYkC9dbj1lDMNOgURs0nNOH2RTWSa6dNSNKsjlznWFVUbWVe8ZS
         Lb1Zx1dstLkNo2eOYo4LCQ5SxK02ud96DUmzsCP6V7FzdI7TdiBzzbDx+GRqg3bHMFry
         hSO0cGIoQLqOoNsUiDsAQjcQonWePyD/XXEyUSLb5StZU+RSVwUpaoajF6NUy0J5EFpa
         GxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6HOAnRul988JJcHPRX8SIpofrQYmL4UmifPvTiFwC5E=;
        b=Mn7f/DQAGyF06YYL2Oj13B8ZyCIAppgkzffmP/MFXNrKbVZxIMhedbf8IE479Rgt2P
         /wSOqjQHbzmseLzVSUEgfl5pLbN3C7kKlMn/eI4f/i92qE6YTZ2hPMxpVOusgyyjN0ZI
         2KK9HQFxS+tl5345QmPQLW0ssV0xbjeKHnOA7oRHvII6Zndzmi+s8YebB4OSJFc/W06W
         0cCSzK45uB9cjjUfOy+Gx++zPH4725gAFfxaCqe+VLk4kvpLp4awW7s/aCjiy7xtCrG+
         rN1/qPKp+HTufGQm1n7RROJTFNBW9i2hi+US+sRLkQhIX3/LLH0e6UcreWu8iJrnN+VL
         8NIg==
X-Gm-Message-State: AOAM530hCHc/LrEUn23Ex9G9jK97XWEW4Y3cZKUv/pjNn+lR1d3Zdkz0
        z/0vyZu4rb80vvFhuF7gnBpS3ikJsxaMNx2oP1z8L4GhA0GX0zPvPvAL27nyzHYkBU7Qo4MHY50
        4OBpls94Y1A0C1pqCnX4+BWptO/0ba8wbE8WyCmipMP2IZEvSgT4/+pagFoBAbyqTq+YxVuNZ
X-Google-Smtp-Source: ABdhPJyu8CadpvpA1fsQat/u/JMloS9CaK7kdDmHf9MbN/B1p2uMNEhZ0ffseqJyFcQP6mrEVPryUpTHf8XJ
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a25:5f41:: with SMTP id
 h1mr975579ybm.159.1610475055930; Tue, 12 Jan 2021 10:10:55 -0800 (PST)
Date:   Tue, 12 Jan 2021 10:10:23 -0800
In-Reply-To: <20210112181041.356734-1-bgardon@google.com>
Message-Id: <20210112181041.356734-7-bgardon@google.com>
Mime-Version: 1.0
References: <20210112181041.356734-1-bgardon@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 06/24] kvm: x86/mmu: Skip no-op changes in TDP MMU functions
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

Skip setting SPTEs if no change is expected.

Reviewed-by: Peter Feiner <pfeiner@google.com>

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 1987da0da66e..2650fa9fe066 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -882,6 +882,9 @@ static bool wrprot_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
 		    !is_last_spte(iter.old_spte, iter.level))
 			continue;
 
+		if (!(iter.old_spte & PT_WRITABLE_MASK))
+			continue;
+
 		new_spte = iter.old_spte & ~PT_WRITABLE_MASK;
 
 		tdp_mmu_set_spte_no_dirty_log(kvm, &iter, new_spte);
@@ -1079,6 +1082,9 @@ static bool set_dirty_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
 		if (!is_shadow_present_pte(iter.old_spte))
 			continue;
 
+		if (iter.old_spte & shadow_dirty_mask)
+			continue;
+
 		new_spte = iter.old_spte | shadow_dirty_mask;
 
 		tdp_mmu_set_spte(kvm, &iter, new_spte);
-- 
2.30.0.284.gd98b1dd5eaa7-goog

