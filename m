Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8AE029F4EA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgJ2T0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgJ2T0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:26:16 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20499C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:26:15 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id y8so2422338qki.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=k0rwmvWkh3wc2lbCLJgzaa11WuGN21taMrm4zUJORUQ=;
        b=NVC+Ua+zzy1sTczx96Us29xL21ARG+7hM7eY2liHVfFGBrqaXA72FLBZEk1wBBN7s5
         Jwquu2B89uWELg7MQ+5R/qw7kLeZyJoWsNXgcUrdP7aXd3f42d3xCKnmkx2+qzwHnR2j
         Tfkg0Na4YzIfgOrcUlvAP2fQ13a2g6WybuyRyZ4PUSWOPNB0zqIixVI5O3rmWHJ5plF5
         2IcrhXCm6nzj9w02Z7r33LNm0AIrqHLQv8pzLBlVKxwF0ZW1QAlXW00GyNqW4tyFJ+VC
         3n+xc6DCv/OXPQBNwB2wKgW/NOIxysTFap0GcIB5DcQ2uqo4Li8vMsy1HKWQsbtbOXob
         ZMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=k0rwmvWkh3wc2lbCLJgzaa11WuGN21taMrm4zUJORUQ=;
        b=InRc4S9B2Gfxe00TmkfiukbCbSmaDqga7qM38nq9TBCj6KxMrRY383yuWiK7gJa1hd
         5Skue+h1GMSxc7me1wXmZ8kXeNbDPtjB/DcRFLBa7Z6qHSChMm9lFxJ29bs3SGNRez1x
         mEXwYPIgX8//9cFv2076/Ohyt7SJ+uIfbTRW8dYJiRoHfTZ57Zf6eZGRqNFqkBQi6Zmr
         XVUtNK4YHBacFwYS8EHrHY50yh1V8XxiuyzhigNC+pYrsE6fvFREW0PxKy1SnbUtrNJ8
         Ft0B3e+bh7Zn9Hxw4THSObELqskI7SA4V8nOVR2RiYn+piOHmPN/MzY+upQQFPQ/a59y
         cGsw==
X-Gm-Message-State: AOAM532Mv1095cDBEaSJZO0esKgR5AS/p0m9rdageidttTu0wz2Kxog6
        DUscqaIH1P/c1YOHIfK/yOn9oT9lJgVYCVRd
X-Google-Smtp-Source: ABdhPJylIhqkabBCZpdBX+3Tvu7RqR/RhkOnUcvT5jdQ/wBFwf9mnbqA3VqFJMk9ziXNlsJRusckxQ25xsTjimTC
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:e308:: with SMTP id
 s8mr6182701qvl.10.1603999574230; Thu, 29 Oct 2020 12:26:14 -0700 (PDT)
Date:   Thu, 29 Oct 2020 20:25:24 +0100
In-Reply-To: <cover.1603999489.git.andreyknvl@google.com>
Message-Id: <d31459cf316fff73874058b8753d2385a137e956.1603999489.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603999489.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v6 03/40] arm64: mte: Reset the page tag in page->flags
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
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
 arch/arm64/kernel/mte.c  | 1 +
 arch/arm64/mm/copypage.c | 1 +
 arch/arm64/mm/mteswap.c  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 8f99c65837fd..06ba6c923ab7 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -34,6 +34,7 @@ static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
 			return;
 	}
 
+	page_kasan_tag_reset(page);
 	mte_clear_page_tags(page_address(page));
 }
 
diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
index 70a71f38b6a9..348f4627da08 100644
--- a/arch/arm64/mm/copypage.c
+++ b/arch/arm64/mm/copypage.c
@@ -22,6 +22,7 @@ void copy_highpage(struct page *to, struct page *from)
 	copy_page(kto, kfrom);
 
 	if (system_supports_mte() && test_bit(PG_mte_tagged, &from->flags)) {
+		page_kasan_tag_reset(to);
 		set_bit(PG_mte_tagged, &to->flags);
 		mte_copy_page_tags(kto, kfrom);
 	}
diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
index c52c1847079c..0e7eccbe598a 100644
--- a/arch/arm64/mm/mteswap.c
+++ b/arch/arm64/mm/mteswap.c
@@ -53,6 +53,7 @@ bool mte_restore_tags(swp_entry_t entry, struct page *page)
 	if (!tags)
 		return false;
 
+	page_kasan_tag_reset(page);
 	mte_restore_page_tags(page_address(page), tags);
 
 	return true;
-- 
2.29.1.341.ge80a0c044ae-goog

