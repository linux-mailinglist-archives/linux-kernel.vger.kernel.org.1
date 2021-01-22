Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671EB300ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 22:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbhAVVVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 16:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729710AbhAVU0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:26:00 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B0DC061221
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:22:17 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id i82so6543784yba.18
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=35f31jPrbe/qFsWIcvakk7ysCD9lwX+ABE7eqvtZ0wc=;
        b=EWHkszKWjWp3VUR8JHd2bWBdtPZxXe/SOOX7kxabAidsStvU1/xEwp9KDG5vFAgPFl
         Wt/ht2xY/BXbfaQ/rk85jEnnJNBK6EQ8gsF0eIaODn9xfAyO1pHM9tnAASXTqdJjhJDA
         ftehr1/dLRiddhGjvjT5EVEVpvqiVx3up7Cmg8Xjp5wt7cBH8t52JMX/ZR9wGYqCRGSL
         BfIK/0eMfzDgik5WmClDfni1br/Kmtn5C5Ayuhu2PQi2ptNvwCC9wqZdABnXcsGeb2eQ
         OdHsTMcGr1rgoNK2SigZ2LblU3cTKUfnmPaHnwSXBwF4Fn4BuNxUB23XsVhunQIMkXnv
         WcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=35f31jPrbe/qFsWIcvakk7ysCD9lwX+ABE7eqvtZ0wc=;
        b=CwpbmItKTH8LS4jthktTBNYR52r4rh9hC1zFoYJHDlc1TbpsnbT9VetHVWiA+Yg+Nu
         12iC7ySYeXkhpwrJemlt807VCQ5jiEr/jGyxZADiG6i7EBCTYZpm6C79OWZ1t5xdV5t5
         eW9uD/ypmd+9RE5+J2QXbmB0OkQotUo8PR7iUSBOku2YyOwiXejru3XdKE0rIh0qRT8R
         S6ZG2zGvXeF9s38cHTBr0XLDALksz6ecFskpNPklcvPt2sB3ddNaiRsAo81GCInqQkPX
         3VWaItZoltEmxB/Hlna3xPJbrvnaAumsoQhpabq8TzRjBuEBj0TumKycI3m3y9CGzkil
         YzGA==
X-Gm-Message-State: AOAM5324NK3gMmwkGg6dAtFtRiz+P/uz3d0q5UM7aINEP0C/iJlvXv0m
        nUdZBZAiJxGm9h0Sz2nYr8G2Plf+OsI=
X-Google-Smtp-Source: ABdhPJyvI0r5XWvCIMMizQISLztTQ6kWCu2dC6ZjFbTiwMUFQCYT/DIFQ9DjhRKNzNOAl16xqAKhwgIhgFY=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a25:df4b:: with SMTP id w72mr9151292ybg.174.1611346936569;
 Fri, 22 Jan 2021 12:22:16 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 22 Jan 2021 12:21:41 -0800
In-Reply-To: <20210122202144.2756381-1-seanjc@google.com>
Message-Id: <20210122202144.2756381-11-seanjc@google.com>
Mime-Version: 1.0
References: <20210122202144.2756381-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v3 10/13] KVM: SVM: Move SEV VMCB tracking allocation to sev.c
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
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the allocation of the SEV VMCB array to sev.c to help pave the way
toward encapsulating SEV enabling wholly within sev.c.

No functional change intended.

Reviewed by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 12 ++++++++++++
 arch/x86/kvm/svm/svm.c | 16 ++++++++--------
 arch/x86/kvm/svm/svm.h |  1 +
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 0c69de022614..55a47a34a0ef 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1331,6 +1331,18 @@ void sev_hardware_teardown(void)
 	sev_flush_asids();
 }
 
+int sev_cpu_init(struct svm_cpu_data *sd)
+{
+	if (!svm_sev_enabled())
+		return 0;
+
+	sd->sev_vmcbs = kcalloc(max_sev_asid + 1, sizeof(void *), GFP_KERNEL);
+	if (!sd->sev_vmcbs)
+		return -ENOMEM;
+
+	return 0;
+}
+
 /*
  * Pages used by hardware to hold guest encrypted state must be flushed before
  * returning them to the system.
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 751785b156ab..89b95fb87a0c 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -552,22 +552,22 @@ static void svm_cpu_uninit(int cpu)
 static int svm_cpu_init(int cpu)
 {
 	struct svm_cpu_data *sd;
+	int ret;
 
 	sd = kzalloc(sizeof(struct svm_cpu_data), GFP_KERNEL);
 	if (!sd)
 		return -ENOMEM;
 	sd->cpu = cpu;
 	sd->save_area = alloc_page(GFP_KERNEL);
-	if (!sd->save_area)
+	if (!sd->save_area) {
+		ret = -ENOMEM;
 		goto free_cpu_data;
+	}
 	clear_page(page_address(sd->save_area));
 
-	if (svm_sev_enabled()) {
-		sd->sev_vmcbs = kcalloc(max_sev_asid + 1, sizeof(void *),
-					GFP_KERNEL);
-		if (!sd->sev_vmcbs)
-			goto free_save_area;
-	}
+	ret = sev_cpu_init(sd);
+	if (ret)
+		goto free_save_area;
 
 	per_cpu(svm_data, cpu) = sd;
 
@@ -577,7 +577,7 @@ static int svm_cpu_init(int cpu)
 	__free_page(sd->save_area);
 free_cpu_data:
 	kfree(sd);
-	return -ENOMEM;
+	return ret;
 
 }
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 8e169835f52a..4eb4bab0ca3e 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -583,6 +583,7 @@ int svm_unregister_enc_region(struct kvm *kvm,
 void pre_sev_run(struct vcpu_svm *svm, int cpu);
 void __init sev_hardware_setup(void);
 void sev_hardware_teardown(void);
+int sev_cpu_init(struct svm_cpu_data *sd);
 void sev_free_vcpu(struct kvm_vcpu *vcpu);
 int sev_handle_vmgexit(struct vcpu_svm *svm);
 int sev_es_string_io(struct vcpu_svm *svm, int size, unsigned int port, int in);
-- 
2.30.0.280.ga3ce27912f-goog

