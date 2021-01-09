Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BA82EFC70
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 01:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbhAIAtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 19:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbhAIAtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 19:49:39 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFFDC0617A7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 16:48:06 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id l126so17420679ybl.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 16:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=kFsJmkb8M3ufAjXEZxfMS0MYb/t7DHhSQPFJmc4E3xo=;
        b=rwWV2rTcTh3ZbcOtWceFowsWqu8ZhEM+Zob5/myHWaq1UWg3OPjKSnndZK5sSABA8z
         /+p+ODXqLrx0qeslKe3E79H6kObTc1J6uBvTvEX8EPn8HW8nO/ywvYe3moIsuwj5otyY
         VraQ0gmOF6Ok0nKjiG0XDTDUOY39Vv8XxjJciWbj7oBpUyk5B7uD8221neIUcvwew7CE
         XvOwLpZ47hFnLaatlJhiBslX7xRVVP7FJbQVcGXYNqcLTs5iGuyg0jEzqF8pIXdvw7gL
         sKfm7inYaWjEALlOsq9qOOsnOpf9QMzVeMPUdedlw2HRaIzOB8Hk3etokpBeVi/SQclf
         2qrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=kFsJmkb8M3ufAjXEZxfMS0MYb/t7DHhSQPFJmc4E3xo=;
        b=ZjRlnhPxJry7tml+Dr/A5mQNX1CJqUcJpbNwBdbHZUY8+J5hE0S2tNSr3PSjLGGML2
         e8FMUsm7eXLmjIn4JqE2DVmS5egmN2LXHDMwtyPBPudfv9lASHPqZsFXCSG4xIKg8/FU
         BGpdKcjTBDkJ5hK1S0KHAQjQa+8gEKFq1B9fXZ0TDXYZxs9/+s25k5dYGKkCPq+9P6ED
         nBw4VraBhSYk2FyfcvoF3dexS2iPwa4PzDMuBSpvslFht0ws7ey4SFeNgb0W+0fBmhEV
         dGzFQruabL120zjJFO9px9gAtyM4h6PnytJAhTdcLfILiTy+AYMW7A78g8tvtF/+yfYp
         flgg==
X-Gm-Message-State: AOAM530868MXpdvCPgo840yV+Ag7FtVT2TTGpcVdv3Wchvev7aQje01V
        oMa0GBKmiKZrR6kuzYB1WiMM6vHjfqE=
X-Google-Smtp-Source: ABdhPJy4XZ0rEH8KPPWmFdqnCvmHl68ytC6NY7FVMOSj9YpCUewZM24l9cH9T/l9Ot7RR2FnXxxPo9aOwHI=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a25:1386:: with SMTP id 128mr9070481ybt.374.1610153285308;
 Fri, 08 Jan 2021 16:48:05 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  8 Jan 2021 16:47:13 -0800
In-Reply-To: <20210109004714.1341275-1-seanjc@google.com>
Message-Id: <20210109004714.1341275-13-seanjc@google.com>
Mime-Version: 1.0
References: <20210109004714.1341275-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 12/13] KVM: SVM: Remove an unnecessary prototype declaration
 of sev_flush_asids()
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

Remove the forward declaration of sev_flush_asids(), which is only a few
lines above the function itself.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 1b9174a49b65..b4a9c12cf8ce 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -36,7 +36,6 @@ static bool sev_es_enabled = IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
 module_param_named(sev_es, sev_es_enabled, bool, 0444);
 
 static u8 sev_enc_bit;
-static int sev_flush_asids(void);
 static DECLARE_RWSEM(sev_deactivate_lock);
 static DEFINE_MUTEX(sev_bitmap_lock);
 unsigned int max_sev_asid;
-- 
2.30.0.284.gd98b1dd5eaa7-goog

