Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A452AE2DB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732846AbgKJWMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732438AbgKJWMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:12:16 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE35BC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:12:14 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id m17so64162qvg.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=d8tQjB/ZefUWtBLBKefANqT3i+lXlksl44G7nQ4ChAg=;
        b=q4QGAbbqFTvG6svSX1Y0b5DmMlf+NnGY0eiXeETEiNsT5IhVUxrzZAWozr85jU/KJq
         Hw3qUNVXht63Cl41GMwM4nSEWQMgQIQKPZKH+pp7BlVDHA96GIfThT03HMXtZLqQ3aF1
         +MLrQS4e0kX0JqCO4hu39P1wLKBuhSzRmmjtvRei8lAyxDUlaNXXlSf37xwv4ffbzJL/
         3tKcthjfCuVOwupQZvFHoFApZNVPK8ph6PdYhGn/hu9VaXKWHL81G+0/7Rhcl0iYOlpi
         sVNuMjpbnNwR2c2H3OZVgTqeZqu+3wgsO5ID4aqoaRZAOztUipZebXL4aQL405F+j7Og
         PuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=d8tQjB/ZefUWtBLBKefANqT3i+lXlksl44G7nQ4ChAg=;
        b=EtMkqggnLWxvmSpXuKIstsBG/mB3U8Sgr/+v7TzHgrBhBkUQb2q8XHYCSjge3EEBhV
         cvNydE3KWJB4j7I79rxbUwz1VcuoFAK4rNiRKJ0gSlwkIxME1s1kE/rhb2xtfB+jCAU9
         v5McDCSPTyOLgCphCyjJ1Z2dcPDr0dVwr4jgg/VvhlXjBWu8EM7pSSKaDAfVY+9nhlq3
         dW+WpdCcASrffCZLaBaWLPi0VbbYgQyqHUVar8LkJ7krMLTIiyxESOTmNBJ14wumm9/Z
         CvMOChB5X3p+tS/cEBzVm2R2Z9WCTTW8opgB52npKm2y82PIfnNRR22dEifrh93tDXFP
         YJBQ==
X-Gm-Message-State: AOAM531sW2GK59o82omp8n5GSGtKPF4SOJNxrUe9lbHRqdLsjD2Q7zay
        UIagZ3X/PJU4RdgHBzEeXROn1ea7Bwwvnh+q
X-Google-Smtp-Source: ABdhPJzqUKiPBTpkp/5b4P8WdJ74FMvyA0HFkNkdi7ue58Cvjh4Qv1e8HBk18wTn5vXmofT8hPC6q7lrIrvVjhHc
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:f951:: with SMTP id
 i17mr7499877qvo.22.1605046333870; Tue, 10 Nov 2020 14:12:13 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:10:25 +0100
In-Reply-To: <cover.1605046192.git.andreyknvl@google.com>
Message-Id: <4a7819f8942922451e8075d7003f7df357919dfc.1605046192.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v9 28/44] arm64: mte: Reset the page tag in page->flags
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
 arch/arm64/mm/copypage.c      | 1 +
 arch/arm64/mm/mteswap.c       | 9 +++++++++
 4 files changed, 24 insertions(+)

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
index 8f99c65837fd..600b26d65b41 100644
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
+	 * the new new page->flags are visible before the tags were updated.
+	 */
+	smp_wmb();
 	mte_clear_page_tags(page_address(page));
 }
 
diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
index 70a71f38b6a9..f0efa4847e2f 100644
--- a/arch/arm64/mm/copypage.c
+++ b/arch/arm64/mm/copypage.c
@@ -23,6 +23,7 @@ void copy_highpage(struct page *to, struct page *from)
 
 	if (system_supports_mte() && test_bit(PG_mte_tagged, &from->flags)) {
 		set_bit(PG_mte_tagged, &to->flags);
+		page_kasan_tag_reset(to);
 		mte_copy_page_tags(kto, kfrom);
 	}
 }
diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
index c52c1847079c..9cc59696489c 100644
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
+	 * the new new page->flags are visible before the tags were updated.
+	 */
+	smp_wmb();
 	mte_restore_page_tags(page_address(page), tags);
 
 	return true;
-- 
2.29.2.222.g5d2a92d10f8-goog

