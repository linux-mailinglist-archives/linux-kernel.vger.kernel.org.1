Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D58B2B2848
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgKMWRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgKMWRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:17:20 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B38C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:17:19 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id bc27so5449802edb.18
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Ho6gRtmpYK99NRY0nqMDMTWGuBlu7BoOKXCHJVaPFrA=;
        b=MPUYatJk7xzMsJxOWFcCa6BB02oLTJrhQbX6JQ7njNHRxutqkHM7Nf/rADloq7EOOd
         1bOP73z+zEvZcc1/Rza5+PLrWfrHzsx3Kn4X1K/wF10kJV3wK/zwjavAis3RZUrC9Q86
         07FBoH1iNkLllu20EOOOye3QtXKS23Wfg8XEt7QTHyh6fAaZiu0SLHyOB/k4Gj4ntaVd
         WHsmuRr9rs2GdcUzkKJqwMc/7K31SR26FRmxo5AcmO/+eHUOYTBsQAlHePI8VC7wVVio
         IqAAfiyCa2Qvhhp5ZIHWfyp4U2bFFecERfDNQTImby6l6XCKmRDgBDrmJJVq5IdYfD6Q
         RmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ho6gRtmpYK99NRY0nqMDMTWGuBlu7BoOKXCHJVaPFrA=;
        b=Xf/dg5ybmfrfIMc5ZrqSFmPzONeXsk1L7vM5yrGq+36j8sdu3WDzwPl32plLs/ySCh
         o61hBe1z4KtaEwepSwMRyLmd9GkiRdkEV0o/2kRmDQkQCno9gRJNunOsdEaVkgEWnyfq
         vhUc45B82aCLFhufDzpOiXZOxCsBpyB7yWhVTEjxYIBR+FKxH9Srb0gUf9FxcFHHRkTr
         BznVJSSDMuCvkQrqHSWYkoU8h3/f+XAtofC1zHLEYs6Ym3tvnR3/FXC+LJU0SAZC49ez
         ROvu7AMnM9nkMHt5SLPDSTjmKKZGoWQbniEvekXp+J93K6tI2vc/7ivzwet6uzMgEnly
         Nc0Q==
X-Gm-Message-State: AOAM532yYni8XESPBZ4l5tummgcpHBVuafDt3TN2NvLXp9+tOfIQxKF6
        6vmhnRSqGgFbHMSXRmlo1Une2DqE6o9H2dNQ
X-Google-Smtp-Source: ABdhPJwwDdmdZNdEOH2L6Fb2cJeAT+sPEneLl017puSQqEBadhnH3ZkI6kBSMGHj9GT8pFPmpfdJrjnS9Zn7EaOn
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6402:141:: with SMTP id
 s1mr4617132edu.87.1605305837947; Fri, 13 Nov 2020 14:17:17 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:15:54 +0100
In-Reply-To: <cover.1605305705.git.andreyknvl@google.com>
Message-Id: <18bca1ff61bf6605289e7213153b3fd5b8f81e27.1605305705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v10 26/42] arm64: mte: Reset the page tag in page->flags
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

The hardware tag-based KASAN for compatibility with the other modes
stores the tag associated to a page in page->flags.
Due to this the kernel faults on access when it allocates a page with an
initial tag and the user changes the tags.

Reset the tag associated by the kernel to a page in all the meaningful
places to prevent kernel faults on access.

Note: An alternative to this approach could be to modify page_to_virt().
This though could end up being racy, in fact if a CPU checks the
PG_mte_tagged bit and decides that the page is not tagged but another
CPU maps the same with PROT_MTE and becomes tagged the subsequent kernel
access would fail.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
Change-Id: I8451d438bb63364de2a3e68041e3a27866921d4e
---
 arch/arm64/kernel/hibernate.c | 5 +++++
 arch/arm64/kernel/mte.c       | 9 +++++++++
 arch/arm64/mm/copypage.c      | 9 +++++++++
 arch/arm64/mm/mteswap.c       | 9 +++++++++
 4 files changed, 32 insertions(+)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 42003774d261..9c9f47e9f7f4 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -371,6 +371,11 @@ static void swsusp_mte_restore_tags(void)
 		unsigned long pfn = xa_state.xa_index;
 		struct page *page = pfn_to_online_page(pfn);
 
+		/*
+		 * It is not required to invoke page_kasan_tag_reset(page)
+		 * at this point since the tags stored in page->flags are
+		 * already restored.
+		 */
 		mte_restore_page_tags(page_address(page), tags);
 
 		mte_free_tag_storage(tags);
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 8f99c65837fd..86d554ce98b6 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -34,6 +34,15 @@ static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
 			return;
 	}
 
+	page_kasan_tag_reset(page);
+	/*
+	 * We need smp_wmb() in between setting the flags and clearing the
+	 * tags because if another thread reads page->flags and builds a
+	 * tagged address out of it, there is an actual dependency to the
+	 * memory access, but on the current thread we do not guarantee that
+	 * the new page->flags are visible before the tags were updated.
+	 */
+	smp_wmb();
 	mte_clear_page_tags(page_address(page));
 }
 
diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
index 70a71f38b6a9..b5447e53cd73 100644
--- a/arch/arm64/mm/copypage.c
+++ b/arch/arm64/mm/copypage.c
@@ -23,6 +23,15 @@ void copy_highpage(struct page *to, struct page *from)
 
 	if (system_supports_mte() && test_bit(PG_mte_tagged, &from->flags)) {
 		set_bit(PG_mte_tagged, &to->flags);
+		page_kasan_tag_reset(to);
+		/*
+		 * We need smp_wmb() in between setting the flags and clearing the
+		 * tags because if another thread reads page->flags and builds a
+		 * tagged address out of it, there is an actual dependency to the
+		 * memory access, but on the current thread we do not guarantee that
+		 * the new page->flags are visible before the tags were updated.
+		 */
+		smp_wmb();
 		mte_copy_page_tags(kto, kfrom);
 	}
 }
diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
index c52c1847079c..7c4ef56265ee 100644
--- a/arch/arm64/mm/mteswap.c
+++ b/arch/arm64/mm/mteswap.c
@@ -53,6 +53,15 @@ bool mte_restore_tags(swp_entry_t entry, struct page *page)
 	if (!tags)
 		return false;
 
+	page_kasan_tag_reset(page);
+	/*
+	 * We need smp_wmb() in between setting the flags and clearing the
+	 * tags because if another thread reads page->flags and builds a
+	 * tagged address out of it, there is an actual dependency to the
+	 * memory access, but on the current thread we do not guarantee that
+	 * the new page->flags are visible before the tags were updated.
+	 */
+	smp_wmb();
 	mte_restore_page_tags(page_address(page), tags);
 
 	return true;
-- 
2.29.2.299.gdc1121823c-goog

