Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EAA2C15EC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731459AbgKWUJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731324AbgKWUJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:09:29 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69ABFC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:09:29 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id e15so103452wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=utlsD1mw0rorOhWh+9V4hpftFWJXg/4VW/2wSqx9Lr0=;
        b=QghR/2kE9NUz+UPTow/wMUK0um+zciJOn8LYNh3m83vv2prNKjgOeCPk4o4OzDFfUk
         CDPF0kEnLqcTUfY37m+bkl3Ny3288a3tiAdC2F7W06efThDosRzBdZz+pDjVem5ZuSlR
         rNn1C6/CJZMBawDF1MijFLVam73dmNA76LXTZ2mIU3OnYtNLgumIatnfm8RqCCelv0Oa
         XizxZDb2eZZ3kifWxGXqU0uSdCzIrxzopGomlNemoCq5eGHS1cZOSiKyVc1sa5QO4Unr
         DUUK1pBv305/WqN+WZlppX+12kYK14wV05lTeq98GH2CAdlGedCLvLc8zUgflk+DNM3I
         jKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=utlsD1mw0rorOhWh+9V4hpftFWJXg/4VW/2wSqx9Lr0=;
        b=c0ZMWk3zaMKOBUp1x/rYsOIMpXWKX03L5c1Hlz5WKr2Qw5msevJ56mEnocHlenYKtX
         J4HTyP9y4ld3ac65F0xgjlB+G2K9a+s44r/DGEcyyc+SwwOuOX/0T2Wwk0Z32vRiffKM
         60uD8ybmuvHwajFVbV622AzibGmnJwqck59zd44nwTxijNiVwrqmc5CqbF9oMfNl35i/
         gG39VVFJ2qgLLpsp/95Y2V5Ik/YVkYrKo7GyiXM7w36vwVwMb2KZQ+GcKRIunBGwWqGM
         RBREdyN8wpN8zZseWLnjGXEnc7oblbrYSORK29d7B92DE3pZlNhQanWdCAa/0F0D/fF8
         8z3g==
X-Gm-Message-State: AOAM5315IgVOAn0Ima3Sm1LzHXehtFRATsKHKkaffO1N2NsZuTYaIeq7
        kzPrPsInfYXojloV0qhmXNp9Bcyzks26NtJU
X-Google-Smtp-Source: ABdhPJzgONaFTZU/h3JPqsgZz6R2sgr3ZA9iJYvpwZvYvUFgReYxzWPEWMFsJd+B8VTgu3nwC5HgaPBLZj2SDWUW
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a7b:c84a:: with SMTP id
 c10mr612311wml.44.1606162168044; Mon, 23 Nov 2020 12:09:28 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:07:50 +0100
In-Reply-To: <cover.1606161801.git.andreyknvl@google.com>
Message-Id: <9073d4e973747a6f78d5bdd7ebe17f290d087096.1606161801.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606161801.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v11 26/42] arm64: mte: Reset the page tag in page->flags
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
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
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
2.29.2.454.gaff20da3a2-goog

