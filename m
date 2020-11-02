Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7DD2A2F11
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgKBQEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgKBQEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:04:38 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804F5C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:04:36 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id p7so2010993wma.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=k0rwmvWkh3wc2lbCLJgzaa11WuGN21taMrm4zUJORUQ=;
        b=bIDVeRsji4tBcSziaWmd3p8Yom+Rz5Zbrz5Yqz14PpIs5s5KmlgJzz8X15ZWTZdsFQ
         5Q2lmUEKPMg9u+bmW/E0w/GBlrnJeD7xVNx0WbfKgCOVvhoQkBH/kTXwhz5FdPJfKygJ
         uzjY6CjqFdyqwfpUMj2T4QGYES4YY3Nyl786lmwKjtkymBWJHQjZ0syRB8Q8UXpImsUs
         run3bc/c/+IHUk5HNoX4yEGFwIgbwB5gotPzKnfbO+zYpPJkQzFrhfv9fiYCm2Cz4iI9
         mJIQ8LogebzOMVH/8OvnfLoA5Sum2PoDekgIcZU01aJcNQ0fVBfqVsNxGIJZ/JCZTbFg
         Pa+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=k0rwmvWkh3wc2lbCLJgzaa11WuGN21taMrm4zUJORUQ=;
        b=awXkDHaLDVxYM8rFx4R8amau3CIyjEReoEmd24FDyfoVP3SSzFa0m11/3B/YCXFEXt
         okkz5xiIOD1deE7qtzWhxxoSirgUOWNgJThHgH4XqSe8YGl0JGhy8d4RbwJI+NJ7qEa0
         ZXtI+pG3W6Gid24v+u1qAYHCmTXRk2fNtK+Pn7eGN09hjDkda70TOLbF8jouJ5BNhEpz
         PBcmX5FR9/4C6ISpCkMpYN8PQWuPYerpOxyzO/nJPbjCHH09bkkA0kzv6bsx0VznLHj4
         UjCqPbdMtViPtwf9lAv/0HGTvDAAry/QzNnxn5qb9JW8qSrTg7IJqeJ+sUFsh3SZsraz
         1YJQ==
X-Gm-Message-State: AOAM531wI1xiocG/qwXiXQxs1J4udrKoyHXAKv0n7K4JqHOSODw4oJJa
        V1lC0i0swyExsy2Q2cNlZARyY6v0o8SE4uLc
X-Google-Smtp-Source: ABdhPJyZIJTcwnQm65tgUQlzGPuO+nIq44DxEt+DE7AwfFdTHqXm3mrrutL6CaLDLnbfZYj420Vs2HWNKZogn9w+
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:414b:: with SMTP id
 h11mr17902427wmm.157.1604333074095; Mon, 02 Nov 2020 08:04:34 -0800 (PST)
Date:   Mon,  2 Nov 2020 17:03:43 +0100
In-Reply-To: <cover.1604333009.git.andreyknvl@google.com>
Message-Id: <88290ed7a2bafc5e1eb4872ec0eebac5060d0b64.1604333009.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604333009.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v7 03/41] arm64: mte: Reset the page tag in page->flags
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

