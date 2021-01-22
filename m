Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8DA300DA8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 21:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbhAVU0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 15:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731095AbhAVUXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:23:42 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CCBC061793
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:21:57 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id d38so6588320ybe.15
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=xatFlG/AVNIen+GoMQ+mcSrw0d7B4eZmn9C7BW5uyPU=;
        b=SQ/uRc4jsfp9desMKe1Aaa7z1d+QGQ9FhqDbhi/Ajh67V8PvDuzO+WSsZHt560WaFL
         9/1onZhyGtM8Kxiwu0nlNhje3KvtVNiZK4+YcXcD+GCWtMQen/YchibvRfY+7gj548NZ
         x+YeIlePLGtS3nz4n+GqWH+Qjj+vbgHOUEHlnMto3Dz69RXITPeXavd3La+S0AoxPOHt
         KpkcP0VMXwj+k2TP4X5qoYT6trImenTYHi/eIF1pqpOlIjaoCAk7hxpJ33IKi86VDshb
         d7y+f0jWQFvveA5Nok1xG+z6u6+ekNMcabEH70j+bh3GyZ3mr1Bz9bZv6DSX8q5zHBhf
         8eLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=xatFlG/AVNIen+GoMQ+mcSrw0d7B4eZmn9C7BW5uyPU=;
        b=sRz9/qni8EOicWEro65uKee7vuTId1TpR74nRYl/7+ZsbaOAM+VQMrW9oMd+j4I0lC
         fjfDGuad1DGsqyfMpwa2H61xAWrW1DIxxZg2ANIxZRWW/pElBhWVayEpHh17w0jjI3Ib
         ll0lKtZtpk/R7/fVJJZY8aY1o1n7RMWQ6fzxZJmJ2s3S8SlGAjkKIXxP0AYi8A9KS1MK
         w1jWXOYZKc6xMW99VOmmfS+KeadBn265iQuLmrNK7jJZKOEQ+NsVwwaBiKr3L2WKlP/c
         iEADz703B3Ud66yAEGNykwd3O12VEkuaHVz/XGkmmyqluX9Zl5HzH4l/FozOKvV/M4PH
         t6oQ==
X-Gm-Message-State: AOAM5329O+t5nKfYZi0kVfOx8KgV9AFVHxK2QKwi5g75JQ/nzwlm8AYJ
        4ys9g5AIpyCjvJYHt3+pFTygpu+gjbI=
X-Google-Smtp-Source: ABdhPJyT/LYjjG/hMK4LAz62sl2SsF08PEFexksGLVNXU5L71t95rEn/K0wa7RveYaxkd9u9l7cvlBe9HHA=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a25:9a04:: with SMTP id x4mr8975579ybn.184.1611346916488;
 Fri, 22 Jan 2021 12:21:56 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 22 Jan 2021 12:21:33 -0800
In-Reply-To: <20210122202144.2756381-1-seanjc@google.com>
Message-Id: <20210122202144.2756381-3-seanjc@google.com>
Mime-Version: 1.0
References: <20210122202144.2756381-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v3 02/13] KVM: SVM: Free sev_asid_bitmap during init if SEV
 setup fails
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

Free sev_asid_bitmap if the reclaim bitmap allocation fails, othwerise
KVM will unnecessarily keep the bitmap when SEV is not fully enabled.

Freeing the page is also necessary to avoid introducing a bug when a
future patch eliminates svm_sev_enabled() in favor of using the global
'sev' flag directly.  While sev_hardware_enabled() checks max_sev_asid,
which is true even if KVM setup fails, 'sev' will be true if and only
if KVM setup fully succeeds.

Fixes: 33af3a7ef9e6 ("KVM: SVM: Reduce WBINVD/DF_FLUSH invocations")
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c8ffdbc81709..ec742dabbd5b 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1274,8 +1274,11 @@ void __init sev_hardware_setup(void)
 		goto out;
 
 	sev_reclaim_asid_bitmap = bitmap_zalloc(max_sev_asid, GFP_KERNEL);
-	if (!sev_reclaim_asid_bitmap)
+	if (!sev_reclaim_asid_bitmap) {
+		bitmap_free(sev_asid_bitmap);
+		sev_asid_bitmap = NULL;
 		goto out;
+	}
 
 	pr_info("SEV supported: %u ASIDs\n", max_sev_asid - min_sev_asid + 1);
 	sev_supported = true;
-- 
2.30.0.280.ga3ce27912f-goog

