Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA37300DAF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 21:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbhAVU2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 15:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbhAVU0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:26:00 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873CDC06121E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:22:12 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id r1so6524384ybd.23
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Lssm9vnV0iLXDZRtVS+ip+CuQrLpbDOdWlfsE39gna0=;
        b=P5spKE249v9MJhHuwociWOenZQfCsvhYhlHK6Xc4Tq87LjXje/dHDcQ2y3Hxai/Zn1
         hDYMAOVwFRGtA55Sao1EVVnPzIYgxLrzaniitFQEJQwsgVCQkQOGduueEx6iMXTgihdm
         KNSR+lg2IjuKhTAguQrjSFNxzOmM55UfUWTdLmeRHQZVelE5uye1KSkdXezvWQNIbUOM
         uBL7B7vs0SsVtvKVoqoVN21kUtHsBGiMLqDXjkEAVCpWWAM8sPa5itMJ88zpMfAGRAD6
         /uFjEO3+U5czMQSXjnSWSmSYbUXaoHZMCKpUgYRAxxvQR+ehsC0NQBdNtFjdYiQkQfoZ
         gChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Lssm9vnV0iLXDZRtVS+ip+CuQrLpbDOdWlfsE39gna0=;
        b=fmKXQzzCmkS0LnXg7VN+JcZKHDEvmsfwI4dsT2D+oG3NQ7dg3eiEaSMWQGtb+LFxia
         JUJZAF/tQnLvVNtu6pnxISQOUTwu2eJqlnMo23N2qlIoigwiXHun2qoK/agKVYHczsTe
         wuVmgr5b2lLr/HvtAAn3U79btfrO8vuTbwTqvKWzjXHctuFcb2Q2Jcp3pfYYj8b2ksDB
         pVafS5YzmCiNuCybWRARaspv7JcEmUZEsfrZoaN1JjkY09lVYPaMOLhV5map4C+yqK/Z
         XjF6b4sOpuLmdilif8eInNGv5jzt8ceaA/XIFcdTLMDfr2m+Spf7aoTpc0I9V9bFZkeO
         /ksw==
X-Gm-Message-State: AOAM533L8m4WSFn1jnj9Pl1FzZR31w9C80UZ8znrfYRUsmZeydWGe0Q9
        xv3QZMnMrT7xeeDTfUx/PSy6diFYgAc=
X-Google-Smtp-Source: ABdhPJz6EFMndS+4oeFU5UpWrQTe6vvvKj25yyvz9//zruAK3FHxzyZdF+qTGPahqUOCYf24KiAEghirxPc=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a25:8409:: with SMTP id u9mr9067127ybk.67.1611346931772;
 Fri, 22 Jan 2021 12:22:11 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 22 Jan 2021 12:21:39 -0800
In-Reply-To: <20210122202144.2756381-1-seanjc@google.com>
Message-Id: <20210122202144.2756381-9-seanjc@google.com>
Mime-Version: 1.0
References: <20210122202144.2756381-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v3 08/13] KVM: SVM: Unconditionally invoke sev_hardware_teardown()
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

Remove the redundant svm_sev_enabled() check when calling
sev_hardware_teardown(), the teardown helper itself does the check.
Removing the check from svm.c will eventually allow dropping
svm_sev_enabled() entirely.

No functional change intended.

Reviewed by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d223db3a77b0..751785b156ab 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -886,8 +886,7 @@ static void svm_hardware_teardown(void)
 {
 	int cpu;
 
-	if (svm_sev_enabled())
-		sev_hardware_teardown();
+	sev_hardware_teardown();
 
 	for_each_possible_cpu(cpu)
 		svm_cpu_uninit(cpu);
-- 
2.30.0.280.ga3ce27912f-goog

