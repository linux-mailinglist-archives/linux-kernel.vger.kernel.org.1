Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D286A2EFC54
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 01:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbhAIAsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 19:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbhAIAsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 19:48:18 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9A7C0613C1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 16:47:38 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w8so17175687ybj.14
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 16:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=vDh4eKmFYAmn/pACCaUYHAK8byzvJFHct+dqDkZvWfA=;
        b=Ab+7KA0qdYGMnAlMWUILK6GjCUGeaAGIXD1IgpqBsA+n84nWw3Hu9UJnAsDhcSgg/E
         vJOCJ/HYzKN3TK4VsDF1VD7KLG8mLeDQRhDcT/kpC2PCxVmj2Z7uaDzGYH5nX5ZdUMZf
         XpVCD90r9FJ+UE30VWduFe/RfljbpsZsnAfgsv7S0aiICdA3UzSwRxKpPUpuj9e+5Y9V
         6prkzbU2veqaKHV6H7tNxm/EMvVW2ciZFiXMxv65XkiRkO7M3shcIHwtk6Buxg1s6qzM
         ZCQLN2K5UHdNrLG4UL2Ouikn2MEiZVvNbSExcgR501mWeMJRWw3BtRLva4c5x2SnJLr1
         wn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=vDh4eKmFYAmn/pACCaUYHAK8byzvJFHct+dqDkZvWfA=;
        b=Eimzuclj3zNg/VAr9vjsW2hu9e3pVssuUSsHzpeGGhgMD+CU8N2dhGcQIr1x9Qbu/d
         pQFcRW0WHFBiSy57e/Jm3fEG2ZQAC8ALvjDVmJk1YWPFFr2JqZdznpuH994yrw1GPXm+
         Wj04m1076U4MnspsYYoMgk32+fYazUSuLD5fQve/2QhnfbPEB0cdA9RSp7+JBooHhcbg
         9XY4lhvbJQ8QHcFCxu9PCh2yozdycMwWAIwb5kyRlDDowFhiLJ0F9icoxHWrvfUQbboT
         1M1GOuBPA3pw4UuAlXbCe0BocIwaphYmx/GJl529R9Bcb1mdt/b0b0DIDT8bkQBSG1Om
         M4aQ==
X-Gm-Message-State: AOAM5321fa5OCHAkuBGq6hABmqHCrYX/3h3yP6nPfyMcHVGDInPeyTQd
        FfL7HjOhtzuNMNtIjVYo7HA9mf3tfYE=
X-Google-Smtp-Source: ABdhPJzFpFPedRE22hMJwVQdeGOf/7DAB6URy8FyAahzhV7B7CbCorTQlmBb0br5xFhkKkBa7AoYbUOolUU=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a05:6902:6d4:: with SMTP id
 m20mr9411689ybt.434.1610153257450; Fri, 08 Jan 2021 16:47:37 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  8 Jan 2021 16:47:02 -0800
In-Reply-To: <20210109004714.1341275-1-seanjc@google.com>
Message-Id: <20210109004714.1341275-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210109004714.1341275-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 01/13] KVM: SVM: Free sev_asid_bitmap during init if SEV setup fails
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free sev_asid_bitmap if the reclaim bitmap allocation fails, othwerise
it will be leaked as sev_hardware_teardown() frees the bitmaps if and
only if SEV is fully enabled (which obviously isn't the case if SEV
setup fails).

Fixes: 33af3a7ef9e6 ("KVM: SVM: Reduce WBINVD/DF_FLUSH invocations")
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c8ffdbc81709..0eeb6e1b803d 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1274,8 +1274,10 @@ void __init sev_hardware_setup(void)
 		goto out;
 
 	sev_reclaim_asid_bitmap = bitmap_zalloc(max_sev_asid, GFP_KERNEL);
-	if (!sev_reclaim_asid_bitmap)
+	if (!sev_reclaim_asid_bitmap) {
+		bitmap_free(sev_asid_bitmap);
 		goto out;
+	}
 
 	pr_info("SEV supported: %u ASIDs\n", max_sev_asid - min_sev_asid + 1);
 	sev_supported = true;
-- 
2.30.0.284.gd98b1dd5eaa7-goog

