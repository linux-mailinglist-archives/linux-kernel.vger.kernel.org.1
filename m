Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547FC28C32B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731409AbgJLUqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388136AbgJLUpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:45:10 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0798C0613D7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:45:01 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id t17so9829950wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=RnzGNcZZeUOChTXWjqk4hUmc/KbEjOJj4ndSgqlzHDU=;
        b=iIDEyl7CBUrNGW7ual3xgjcUs4niAzLn4GGPidCLY23D/yhRmuEQkQaxz6hYqsrpm6
         g+b/DaN5rI+nTMbn4p3G1NzsM5kuVcXKkYlLWlXlegEJM4VEzNqHKsThYAY7+M2bZFKX
         N6ztusCeBw4FjsvHamUtbM9x7dK9rxgd0027y1VoTK+VByrtXN3+fz+P7nDt5En0hnVF
         OUYgPYwhnoQmCzPQkOIGbxoZ2wzo+DiNTsAccje6bUPP1Zh8YM8Z4VZNM+3yHZwd2BRD
         9m4qoMZsfueoa/x0a4t/UTcddiOYBCSI+lmclcNMlWAN2/cX7WuPjh0QZn/tLOBtcOHn
         E9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RnzGNcZZeUOChTXWjqk4hUmc/KbEjOJj4ndSgqlzHDU=;
        b=AMYzQBhH9sEzlUtTE912TW3EoqBQtX3IMRaYdafg8X0K+BUtPaYUm6GXsnjUp2P5uD
         4gwdB07bzMlE/OyDRgF3k6G8CsNHGbhjIoXPEULvf2ZIpRqIEW6udVmeox1dAvcvAKFm
         gLZhbpMUsbX+gRdvhOm1IBkMztyWx2iq1qGM6uo/seWCYTyX50j6alkxVwIHHI0RftyW
         M5gm0wUJvnApe419EFXZTIitAW+su3zPrd8lRnXZnAYQ9jP0DZva+RVq+jzQ5seWGzqP
         LBsMXyr2Ik3VCnQwzICYDHr1i47lk4A3hrJQvwPH0qw7OXUG2tIB5mJcUYNO14FbQsA9
         XAoA==
X-Gm-Message-State: AOAM5329MdHrBOsIerdu0cdc4Y7XosUEPE/G4RPk3lWLXjnkbPbG36Sd
        UM1qjhZ6n5srxIU2fxWm+GBWEVEx8B19/xNj
X-Google-Smtp-Source: ABdhPJz44Dw3TNwbR+bJ7fpKPS7f55nY86TbGRyMyDSx5tgtBGEbIku3dj/PUSFW6ZaBlgHOBzLZF7MyxG1XMnNG
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a7b:c14f:: with SMTP id
 z15mr13021569wmi.73.1602535500490; Mon, 12 Oct 2020 13:45:00 -0700 (PDT)
Date:   Mon, 12 Oct 2020 22:44:09 +0200
In-Reply-To: <cover.1602535397.git.andreyknvl@google.com>
Message-Id: <41244709e289a2467f6e5d639acf6a41a535d168.1602535397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1602535397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 03/40] arm64: mte: Reset the page tag in page->flags
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
2.28.0.1011.ga647a8990f-goog

