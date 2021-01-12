Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740C62F3825
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 19:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406370AbhALSM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 13:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406339AbhALSMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 13:12:52 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0C2C061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 10:11:29 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id e10so1944596pjj.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 10:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=g0L8hmPn9GuXc9nZO+Oou7JZXqfcIc+E8Ihxm6+j3DU=;
        b=UT0gYjhnNhJ+NBN73bHFodwS8foa8jvrx4VmOboLjqDbrgRqkha4K2C69MJnR6Sqf5
         H2gUwLNolfgumTqWw5nf9oo7A6B6j8Te/VpjlEhGDHrr1uDFEa3WCBf6N1nwmpfd7vNU
         IeiQQ/gUvG3/xt/JtGO5PXOyNTf36L5gA2i+hrltGwouhR2tClE5m/2AsUqq0hP0qfqP
         GDuLNIMzumJgBhT3uYKCtOgGh1fuayZNIwIf8FCXghVM/V5+YFsuTrSGtZxim2DXSzWL
         uYiFzkvXeSm7xQpvCqfwLicmmy2eLViDEfKavNF9z1tR6S3efmaZwa3CHkh/qqEyrAZ+
         hDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g0L8hmPn9GuXc9nZO+Oou7JZXqfcIc+E8Ihxm6+j3DU=;
        b=Z+9n7VcTO0CHPCr3qQkaheJ6uR9OTaSBd9/YPhitzkpAwi6NEV3B84Q7/+JWoFnZU5
         K0zq37dATbQ/2BQsZDL73+9AsxE9nE7pKcDHfv8I6/PY7G2XrQu7tk7gQqz2Log4nYN8
         M/QqIF1miJCcCffTtGDlmMZnb0k0ieg/9KCVEB7uSp9WK7TcPDf3OGiygThdjco1M7X8
         jMY8JbVKzQKC4GuX29KK8/FSPG8nm4tKp10ocOaFW/E+p0km3nqtWa2qH6F9tuygOfRt
         C9KiBnxafFg4qQKGq2bD9I5p8FDwSsvyOE2sGM/Mh5Z3TFQ/wqVAqxR6O+SPWM/etWHF
         vFBQ==
X-Gm-Message-State: AOAM530zpJXtJV5GcrKF0+oaGJlXgl0u7xTELgVMitzFozphKRfgF2Em
        jzGSZVm+8TYetqgZ00QU98aVFRK0/nND58MhkJ2SAmvgaI34BNQVsyigVVYtmNgfXyFqy455I3n
        DmGp1papMv8sqp7haswicSOjwPaJZkHCmMM+/Lb6GZX/fUtZ5iRs9XwGDoJ1qMsoza86dekzu
X-Google-Smtp-Source: ABdhPJy+BhtXRABw6D2zuNKJQwmN0hyHQI3MsRgEDguv9uWdT8S5ve5nVaC82N7Wy6MFXkyveNHCcsSyooM+
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a17:90b:ec2:: with SMTP id
 gz2mr328174pjb.143.1610475088336; Tue, 12 Jan 2021 10:11:28 -0800 (PST)
Date:   Tue, 12 Jan 2021 10:10:41 -0800
In-Reply-To: <20210112181041.356734-1-bgardon@google.com>
Message-Id: <20210112181041.356734-25-bgardon@google.com>
Mime-Version: 1.0
References: <20210112181041.356734-1-bgardon@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 24/24] kvm: x86/mmu: Allow parallel page faults for the TDP MMU
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

Make the last few changes necessary to enable the TDP MMU to handle page
faults in parallel while holding the mmu_lock in read mode.

Reviewed-by: Peter Feiner <pfeiner@google.com>

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 280d7cd6f94b..fa111ceb67d4 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3724,7 +3724,12 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 		return r;
 
 	r = RET_PF_RETRY;
-	kvm_mmu_lock(vcpu->kvm);
+
+	if (is_tdp_mmu_root(vcpu->kvm, vcpu->arch.mmu->root_hpa))
+		kvm_mmu_lock_shared(vcpu->kvm);
+	else
+		kvm_mmu_lock(vcpu->kvm);
+
 	if (mmu_notifier_retry(vcpu->kvm, mmu_seq))
 		goto out_unlock;
 	r = make_mmu_pages_available(vcpu);
@@ -3739,7 +3744,10 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 				 prefault, is_tdp);
 
 out_unlock:
-	kvm_mmu_unlock(vcpu->kvm);
+	if (is_tdp_mmu_root(vcpu->kvm, vcpu->arch.mmu->root_hpa))
+		kvm_mmu_unlock_shared(vcpu->kvm);
+	else
+		kvm_mmu_unlock(vcpu->kvm);
 	kvm_release_pfn_clean(pfn);
 	return r;
 }
-- 
2.30.0.284.gd98b1dd5eaa7-goog

