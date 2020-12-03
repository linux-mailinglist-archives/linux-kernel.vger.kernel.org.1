Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A3A2CE044
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 22:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgLCVAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 16:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgLCVAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 16:00:23 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A462C061A52
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 12:59:43 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id b4so1867481plk.17
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 12:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=S5ra3fFtwyrR4DBSDAkXB7bmFSTJjJvoJm1aScqSvD8=;
        b=CMgmPGQ3LRAJ91emyWbIDeeu4Npdy86zsS9HBSAc8ghZ8AyFtq8IPAKujurb3BXMl6
         qydVnY5AUbZc+vdzxNbWWmIYmU4B56Pn368RqYqcA/O84Rn1fAmI+r5iI/4QxefdR5L4
         iQPuaefyDoLSUm69oF0b5m4cjGZdtvwKugIsWO4AGpChjbjG3aZNa/TpTARfvmP7XDMv
         kYG4ybDJe0sJEk612YLAPX11BceZM8h3ap3K0/bEhhEFT2n2BI4/ChT6ITK0bUC3ZAtT
         gej5444rFOdUyWbg53TWG8bvVleKc4MyYctWo1+IF5Y2QdMGnyziGqHn4tNa6P/rBz3k
         R3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=S5ra3fFtwyrR4DBSDAkXB7bmFSTJjJvoJm1aScqSvD8=;
        b=PF8IjP4dQFh5e0Xze6S8oKRjvwIYCVnslw6WIuqAjZqAYA9wkytHzbuFnj5vD8q7gn
         X2bX16GRFC1y4tP27wKSo32gHbv4l9QyennbDxyuH1lY5Ao8hXt4v60YHuxV3TGzRmUr
         dUDsLeAzrECWBlEUta7qmGQh/DsjUSuEAR8vNTEqNEsUQ1fa/x5ACB8HdDi5SWIsV6ES
         KgAMV+ZQzaLgNyqItFLbXg4XB9kooEXjsjEQfO0YqVAECLM4+Jap6FBIzs72Jhk0ThkD
         +z5r0ftqLjGFcnoKmFkWCrEiFwUCSxzw6onGlKqqQiAcF2BJUT0WH8MjIVQ1xofhh+vy
         HRvA==
X-Gm-Message-State: AOAM530GmhfIg7514Fe4gvhhmarXa5ztLcxGcFlQXEDQbZ448K/CfMsT
        U0vIRqBBbibs4pDhmk90nRR5LH6xciSO5A==
X-Google-Smtp-Source: ABdhPJzp6sEpJwizJg9kJ4t6HFh8/cL5/4seSshW8xQdAExolaPsro05znE1zqmIooU9dIASPm7CyJikDZMC8w==
Sender: "jacobhxu via sendmgr" <jacobhxu@mhmmm.sea.corp.google.com>
X-Received: from mhmmm.sea.corp.google.com ([2620:15c:100:202:f693:9fff:feef:a9a1])
 (user=jacobhxu job=sendmgr) by 2002:a62:1a16:0:b029:197:eabc:9b74 with SMTP
 id a22-20020a621a160000b0290197eabc9b74mr683802pfa.62.1607029182775; Thu, 03
 Dec 2020 12:59:42 -0800 (PST)
Date:   Thu,  3 Dec 2020 12:59:39 -0800
Message-Id: <20201203205939.1783969-1-jacobhxu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH] kvm: svm: de-allocate svm_cpu_data for all cpus in svm_cpu_uninit()
From:   Jacob Xu <jacobhxu@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        Oliver Upton <oupton@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jacob Xu <jacobhxu@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpu arg for svm_cpu_uninit() was previously ignored resulting in the
per cpu structure svm_cpu_data not being de-allocated for all cpus.

Signed-off-by: Jacob Xu <jacobhxu@google.com>
---
 arch/x86/kvm/svm/svm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 79b3a564f1c9..da7eb4aaf44f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -530,12 +530,12 @@ static int svm_hardware_enable(void)
 
 static void svm_cpu_uninit(int cpu)
 {
-	struct svm_cpu_data *sd = per_cpu(svm_data, raw_smp_processor_id());
+	struct svm_cpu_data *sd = per_cpu(svm_data, cpu);
 
 	if (!sd)
 		return;
 
-	per_cpu(svm_data, raw_smp_processor_id()) = NULL;
+	per_cpu(svm_data, cpu) = NULL;
 	kfree(sd->sev_vmcbs);
 	__free_page(sd->save_area);
 	kfree(sd);
-- 
2.29.2.576.ga3fc446d84-goog

