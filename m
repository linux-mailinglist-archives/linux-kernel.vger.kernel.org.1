Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A9B2F5600
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbhANA6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 19:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbhANAlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 19:41:13 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A51C061382
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 16:38:00 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id q7so3019394qki.16
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 16:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=7jIh1raiC9mO2UBk7zBiXhk5cwJa5TOTQds8hm2NQdk=;
        b=qtwFb998ztfYpmQr3CIF3rvF2R+lxZy565kY7B2uTRHEhFfLPVFp9P89AVqEuRAQQj
         q1OghinpAd8nAhvyY55P8ygwTwvn0obM4KGRZ6SrZTQgCNxXFc+0JAMFGilg2zC7hgpg
         LeJe6DeHhg6XC2VBCRfFA5HYq+Vr7ItQGEBsKYZov6T3UX/hjNTPxdiQXKaslX/UB672
         kqyFuZ3oN8m2xqMajhsk7M8hx6z94OnGC9ZR22b143v0UuSKTr0ohSGmpVe7/hnc/i+3
         WRt8xWjT2T1owedVP0MSymp0i6bc1nwmlE0saysjLAMJwE2uXrxpo5IMZGkwUwg1hL23
         EwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=7jIh1raiC9mO2UBk7zBiXhk5cwJa5TOTQds8hm2NQdk=;
        b=AT6/zeXoWVOR1p2VbXawiFo8A7yAUSwcRKCxt/85Rc4yknXA4lgaZ7rObq6N12h82m
         Q3h4AJb5uHC4WnNfEaVTCHfTJvlAqfmjJ17iYMlVORuqFVxUR3l/Fa/4P1JV34ljtxmt
         XZ4sJY/JPBYTTJAROLbcyfMgO4zshwaDtIEmH4rIKf1eMmWQ1eUctBk1orsnhuNo7HaV
         xZ0kMKyDuoOfC7zxva6DoU3oetAY48A3qpiXXfX59gYaksQS8MglblwI4av9ojxg8RJa
         Mt9IpXF/DyZKxONc9RR1QcIbqeLDN12eDCuPQG+DvUR5jEd5CickIErGq+ugkG22cM9Z
         RwqA==
X-Gm-Message-State: AOAM530/u9Ucv9Pq7ggIDtuWaRHBZyJ8S3331tLdsW7wEsvkMeIsdaYr
        hQzslLLp4DU5Onj7hoeUH6wr2HDqv7c=
X-Google-Smtp-Source: ABdhPJwlFbgrnSd6hVheUa0zIrYw1CBlvVSvihz8a6WeLJjzSKyzg/jGZrY+FPB6rF4lUwZ62mF/pFYvNWg=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a0c:ffa2:: with SMTP id d2mr4906288qvv.62.1610584680140;
 Wed, 13 Jan 2021 16:38:00 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 13 Jan 2021 16:37:04 -0800
In-Reply-To: <20210114003708.3798992-1-seanjc@google.com>
Message-Id: <20210114003708.3798992-11-seanjc@google.com>
Mime-Version: 1.0
References: <20210114003708.3798992-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 10/14] KVM: SVM: Explicitly check max SEV ASID during sev_hardware_setup()
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

Query max_sev_asid directly after setting it instead of bouncing through
its wrapper, svm_sev_enabled().  Using the wrapper is unnecessary
obfuscation.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 02a66008e9b9..1a143340103e 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1278,8 +1278,7 @@ void __init sev_hardware_setup(void)
 
 	/* Maximum number of encrypted guests supported simultaneously */
 	max_sev_asid = ecx;
-
-	if (!svm_sev_enabled())
+	if (!max_sev_asid)
 		goto out;
 
 	/* Minimum ASID value that should be used for SEV guest */
-- 
2.30.0.284.gd98b1dd5eaa7-goog

