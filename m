Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032612A7140
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732811AbgKDXUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732782AbgKDXUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:20:15 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEDBC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:20:15 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id q15so45249wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=k0rwmvWkh3wc2lbCLJgzaa11WuGN21taMrm4zUJORUQ=;
        b=uWjOaiCp/aQ7tdjvxD3necJ9LlCN2dKAwKwizWGVIexVk50McV5ni5cQWGWku5ZCFK
         PKvJmCjMn+bQqYqk+j0XNar7WlUsjTEnoXIzxMF5JurlYjxWSpDdiCoPQBrInZe8TepD
         Leze21ogS5ZK1uctnGaKZEmhAXr44QJ8D4VwFFBrFBnij6FuL5XUR3100Wi8JTT00hTd
         wr4UClytKAaMQDTNT9WDH3Lz9D+2x2nhJHxJR5F72qz+WLYLlFdlzLOBgJsYDpREFTjZ
         nZjiqj+jk+NdXsQC57jljwC3G66hiELMb32lHeUy62pZctwzbq9bPvmKHtxO5hbJ15xX
         lH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=k0rwmvWkh3wc2lbCLJgzaa11WuGN21taMrm4zUJORUQ=;
        b=b8nhaIxKdoLH96W5TIoUZaj2/wmRpXMYJWMI/fFPwm8c2xNNVTXcDDJiObFJn5qss+
         PcX9O2ovbH8L7FUZBNOa7Qtj8iJuBF0mPz+iipjwqfV5yPSGW+SqMogxaFnW1ym9KnFN
         atCHGOJSUWuL8+9jONBcLfu873Fc3hXlk/YSw6VEykUvxa8cJnzbD6+rTPoacfjYCG0L
         x9duDef5+/H3WPwY1+aoypILvtf02jhKpzrs5ekijCdpaMhB5jXvxZGHn822MGTGV2U4
         6VvmCKkQ4NfNGqB96UesrqrnL8MF7Z1i7Lfy6PkwIIi0H1EWPsoqHnA0IwYcRahf6GUb
         BNWw==
X-Gm-Message-State: AOAM531ctxCuwfBp0zAl07yLtutuf2AGvEnKo6cQ/eHWqUpGU/u6N7hJ
        MQi1nJQHLCD8aZvOs5755lI9zL5ULNWRp1Bc
X-Google-Smtp-Source: ABdhPJz0zucCZ65+O5+GurNj337OxWPm/l0D5EwqlzuEn6V6sXz3ts50YYxAk/os0lAiyx4hSptYSHMMX4k918L0
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:4d05:: with SMTP id
 o5mr87270wmh.94.1604532013713; Wed, 04 Nov 2020 15:20:13 -0800 (PST)
Date:   Thu,  5 Nov 2020 00:18:43 +0100
In-Reply-To: <cover.1604531793.git.andreyknvl@google.com>
Message-Id: <fc9e96c022a147120b67056525362abb43b2a0ce.1604531793.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604531793.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v8 28/43] arm64: mte: Reset the page tag in page->flags
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

