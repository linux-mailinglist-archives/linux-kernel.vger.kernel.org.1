Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE11A300ECC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 22:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbhAVVVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 16:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729778AbhAVU0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:26:06 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CDFC0611C1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:22:24 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id u14so6593802ybu.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ehdULWTO7EegFXRAR9N52T5SfWTOsL20pH6ob+5mEtA=;
        b=ncns3vkljJeRg+++B9bI09LSTPIN7Q50r6Q7c3MG3mj6tTLQaNCbLE7wM8xKTNclNM
         Xb7K5tzwyTXa4bffG5EKhNkSaXz30tPX9tCoPNbuQ/hMkGdSr7CfpXYWs+efUuAj8cfh
         fqpXgp5EaS838qONnFeoLOuKl6380AywdBxmcehdaKJkRWwU3iRgBx0O3QwZPFFGP3no
         j0Ws4IvPqfGHisE28k+OQm6EgqgwuOp1shbTTLVEVzv7c9UGmdqyzY8s9SL+fidtXZyj
         PFM6jOmCk5X32S6qiHLRJP5DqpHQY5Fil30Nvx3NUdObX4SZL+37j5IqYdVW2VLqTVWF
         y1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ehdULWTO7EegFXRAR9N52T5SfWTOsL20pH6ob+5mEtA=;
        b=GLuDwH0uznBZ9T4OuXWVLgP6T/VMfdS9Hf3h6d2zR+VJYfn7FyTVRBORJW/mG/u1BA
         v9xcBkcRGDjgZwOXlvdrFnrA3Tq2F6GO7R/qElEtNTEOoe+hXGgVQoKfgGFWCnv5sVfy
         yDOX1LmN/JGEBclVhkeJUjizL1wqW2bGReN/Zbahg8kNzgb5ybKikREPL8zmWJZL4+6p
         8stZZ5pFtmIfWfpusSeOpVkJ7YTJ5ToOpTEPPvYpXUszCA9Wppey7K0m5DBva7HMX/nW
         WH1pNQduwSCAGns6TPsv7AR75xK/pw7w/EnaL1eOhmLBJUJTXvGYWHiyyR4jGg2yH5ys
         yJgQ==
X-Gm-Message-State: AOAM530kOk0907lyladqtl2EflcVRI9W9AzwzfYunk8qdz88k5bdyVgV
        lCtS9KrZiGSDFCLrxz+a0pILvzjcQAc=
X-Google-Smtp-Source: ABdhPJzLhnyCrRs/Bk9YHCsNQ28pCnNpi0SPWgybuUOEstJduRVYRC0Mk+Qb4Qf5/pmV72gNAwVxTE51u/Y=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a25:db87:: with SMTP id g129mr3270161ybf.518.1611346943739;
 Fri, 22 Jan 2021 12:22:23 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 22 Jan 2021 12:21:44 -0800
In-Reply-To: <20210122202144.2756381-1-seanjc@google.com>
Message-Id: <20210122202144.2756381-14-seanjc@google.com>
Mime-Version: 1.0
References: <20210122202144.2756381-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v3 13/13] KVM: SVM: Skip SEV cache flush if no ASIDs have been used
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

Skip SEV's expensive WBINVD and DF_FLUSH if there are no SEV ASIDs
waiting to be reclaimed, e.g. if SEV was never used.  This "fixes" an
issue where the DF_FLUSH fails during hardware teardown if the original
SEV_INIT failed.  Ideally, SEV wouldn't be marked as enabled in KVM if
SEV_INIT fails, but that's a problem for another day.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 73da2af1e25d..0a4715e60b88 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -56,9 +56,14 @@ struct enc_region {
 	unsigned long size;
 };
 
-static int sev_flush_asids(void)
+static int sev_flush_asids(int min_asid, int max_asid)
 {
-	int ret, error = 0;
+	int ret, pos, error = 0;
+
+	/* Check if there are any ASIDs to reclaim before performing a flush */
+	pos = find_next_bit(sev_reclaim_asid_bitmap, max_sev_asid, min_asid);
+	if (pos >= max_asid)
+		return -EBUSY;
 
 	/*
 	 * DEACTIVATE will clear the WBINVD indicator causing DF_FLUSH to fail,
@@ -80,14 +85,7 @@ static int sev_flush_asids(void)
 /* Must be called with the sev_bitmap_lock held */
 static bool __sev_recycle_asids(int min_asid, int max_asid)
 {
-	int pos;
-
-	/* Check if there are any ASIDs to reclaim before performing a flush */
-	pos = find_next_bit(sev_reclaim_asid_bitmap, max_sev_asid, min_asid);
-	if (pos >= max_asid)
-		return false;
-
-	if (sev_flush_asids())
+	if (sev_flush_asids(min_asid, max_asid))
 		return false;
 
 	/* The flush process will flush all reclaimable SEV and SEV-ES ASIDs */
@@ -1324,10 +1322,11 @@ void sev_hardware_teardown(void)
 	if (!sev_enabled)
 		return;
 
+	/* No need to take sev_bitmap_lock, all VMs have been destroyed. */
+	sev_flush_asids(0, max_sev_asid);
+
 	bitmap_free(sev_asid_bitmap);
 	bitmap_free(sev_reclaim_asid_bitmap);
-
-	sev_flush_asids();
 }
 
 int sev_cpu_init(struct svm_cpu_data *sd)
-- 
2.30.0.280.ga3ce27912f-goog

