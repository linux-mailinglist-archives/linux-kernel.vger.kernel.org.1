Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC8D2EFC60
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 01:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbhAIAtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 19:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbhAIAtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 19:49:11 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A60C06179E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 16:47:55 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a206so17358418ybg.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 16:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=292fZgTlFSUh9sat6hWygwmIzdDrAIVyQe5fuEoV9fw=;
        b=hR96DdZVhDK+6qksQXwJIuiZ/+XOj3ixyaTOVgExtrmCRA9k9BiJ8s3YgNFLU3xKuU
         fWsRiWw1w1gvEMoYm/4WwT2wYvA/XzG2nxmCkgdQN5lEU2o7K8hCtDpjCtGO+NTumXRP
         uplxJLr4QbseEMJyzcTJM6Q79qZ9JbZZ4t3fZakIvTFj+eHpG3u+xWYc795ob+Fklal2
         v1ZYK++qgNSSeAcaV1RbXR+IIrS7iZfwAe9eYOQ39xfL4eyYQxA0lnKKwIlQ1poZJRtD
         CXIharTpYAkcZdwr3+0lweYIN+Vul/f/q7ZrGWHMQPR5tLgWCzd/9snJlJ8sjvSsBIAk
         YwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=292fZgTlFSUh9sat6hWygwmIzdDrAIVyQe5fuEoV9fw=;
        b=RFn/WzFAF9SL/lXjL4DZa0LS9oGQkQrAEr/HErjXklZg26eMgBHbryy54uEtCA3ADk
         t4p0IeaTJkN9fouMH0CGQ/2NYr5DqYykhf1ghGBNd/Nbra62dt29ABJjV8yqeWqhNmlU
         kA+NpEqiRnBc8pRDmWwI521WcFxjVXmPymSqe8YnczVhjl0aXcu+mRMzY9C1Kq9NRYA+
         dRm+6AZBajA4x5vOgAC0yYXgX0mTe4ovV6LYTFH49MlUqOcy7XLT8/KWcmKnQRUvvfd+
         1xhF6LCKg6st/NoMqB5BEiD+nmE/DhGLHhyQ5oUuGTKWR7L/IQMi5Bzo7nb78p2cOCAA
         LC2Q==
X-Gm-Message-State: AOAM531+Edx3fREDGUPyMS8DCQUp9V77y4zveo7426Yi+OoD0o2iQ/6H
        b3+aCKj3Gi2rvd2EA1Y+G3+MM7YdA+0=
X-Google-Smtp-Source: ABdhPJw3HsMyJQjGxgzaMAsKqmp4qMnS3gGyTkKUApJqynd6ijFrp0GM3mYvd7UgiHpqBBeZTNZSLHGABVk=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a25:5:: with SMTP id 5mr9415276yba.478.1610153275053;
 Fri, 08 Jan 2021 16:47:55 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  8 Jan 2021 16:47:09 -0800
In-Reply-To: <20210109004714.1341275-1-seanjc@google.com>
Message-Id: <20210109004714.1341275-9-seanjc@google.com>
Mime-Version: 1.0
References: <20210109004714.1341275-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 08/13] KVM: SVM: Unconditionally invoke sev_hardware_teardown()
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

Remove the redundant svm_sev_enabled() check when calling
sev_hardware_teardown(), the teardown helper itself does the check.
Removing the check from svm.c will eventually allow dropping
svm_sev_enabled() entirely.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index f89f702b2a58..bb7b99743bea 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -887,8 +887,7 @@ static void svm_hardware_teardown(void)
 {
 	int cpu;
 
-	if (svm_sev_enabled())
-		sev_hardware_teardown();
+	sev_hardware_teardown();
 
 	for_each_possible_cpu(cpu)
 		svm_cpu_uninit(cpu);
-- 
2.30.0.284.gd98b1dd5eaa7-goog

