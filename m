Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893C82FF11B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 17:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388192AbhAUQxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 11:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388190AbhAUQxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 11:53:02 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8825BC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 08:52:22 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id m6so1841115pfm.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 08:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9W5ZfzceZEprkNwKnWxd/HA2+wZNESBmIZ6OZLN9IFs=;
        b=ckzOtzlwn3A88sAj8WM5TYRP6OOOxFgTO7qXVqyF5No7YgF71gnW4IRy+/9lLfhNYg
         9K7SXhQluGFJMxjs8t9MkpR6njztLa5rVZC+52x+tNjtbJ6/q0X857JvUXaspEjVCANq
         yyidiLqA4khKahGyELHlKazQGtd1FFFaoetdhUj25fEZip1ISo5yCAK27rT07nYouTuV
         uhTa04KC2wmEZbfYXpdkplIUovLimLQ95u0Tedre+h9YOyYsDTd7iS7A8oA65+YCd3lY
         aEjiPMRaThFSpCtzm/gMe0amvZlQN11HDg2eE1hmVz1XW5qMuqPbsES6T6/hoAExC6F4
         PYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9W5ZfzceZEprkNwKnWxd/HA2+wZNESBmIZ6OZLN9IFs=;
        b=Gsfk2yWIKDxcvW/NLFgdiwACLRVO9+wsMdJbf4KN8qYcsbJ2wdaUcWfwAn8t03KNlh
         TpgmzcqWkLG+L5j9vmH71KVV0w+bYQ5s5+ClVZ7vpk3aR20WAAfy525wTCb7qBIkym74
         pRtscvCJ6tVjQQ0WKaa2B/AR1widsxNu/JtoByytjk2IwBzKKZNsENooBXDCYIjN34Wf
         Cop6Yua4FAcQPsP2DJ9UrrqLOWpVNzhNMbk1YVyBA75r46QjKyJkqyM8zzKBZ3xF21F0
         5UQMystCs04I3YQedrXOrZxUsDY5zHwWz2xoLdkApD0v9UsIZdvKzmvoX7wa3aHJow9u
         r3bA==
X-Gm-Message-State: AOAM532m69IbvPII75DOr8oTHARWraQ9FRVi62FSiERkWj/nPx98gTFR
        +1imAqhDctiMq9u7EK4hHcm+h5RyKHOUAZxI
X-Google-Smtp-Source: ABdhPJxNpyN17S4hDGlHxKA4qYwirkO64sVLE7fKwFZ/xhJi6EzTiP6oB/d9hAYSWmT7OmCXsJCkdA==
X-Received: by 2002:a62:32c5:0:b029:1b6:7586:f718 with SMTP id y188-20020a6232c50000b02901b67586f718mr266295pfy.74.1611247941684;
        Thu, 21 Jan 2021 08:52:21 -0800 (PST)
Received: from localhost.localdomain ([2405:201:5c0b:3035:cd47:c5b3:4276:dc05])
        by smtp.gmail.com with ESMTPSA id m27sm5924291pgn.62.2021.01.21.08.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 08:52:21 -0800 (PST)
From:   Prathu Baronia <prathubaronia2011@gmail.com>
X-Google-Original-From: Prathu Baronia <prathu.baronia@oneplus.com>
To:     linux-kernel@vger.kernel.org
Cc:     chintan.pandya@oneplus.com,
        Prathu Baronia <prathu.baronia@oneplus.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "glider@google.com" <glider@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/1] mm: Optimizing hugepage zeroing in arm64
Date:   Thu, 21 Jan 2021 22:21:51 +0530
Message-Id: <20210121165153.17828-2-prathu.baronia@oneplus.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210121165153.17828-1-prathu.baronia@oneplus.com>
References: <20210121165153.17828-1-prathu.baronia@oneplus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In !HIGHMEM cases, specially in 64-bit architectures, we don't need temp
mapping of pages. Hence, k(map|unmap)_atomic() acts as nothing more than
multiple barrier() calls, for example for a 2MB hugepage in
clear_huge_page() these are called 512 times i.e. to map and unmap each
subpage that means in total 2048 barrier calls. This called for
optimization. Simply getting VADDR from page does the job for us.
We profiled clear_huge_page() using ftrace and observed an improvement
of 62%.

Setup:-
Below data has been collected on Qualcomm's SM7250 SoC THP enabled (kernel
v4.19.113) with only CPU-0(Cortex-A55) and CPU-7(Cortex-A76) switched on
and set to max frequency, also DDR set to perf governor.

FTRACE Data:-

Base data:-
Number of iterations: 48
Mean of allocation time: 349.5 us
std deviation: 74.5 us

v1 data:-
Number of iterations: 48
Mean of allocation time: 131 us
std deviation: 32.7 us

The following simple userspace experiment to allocate
100MB(BUF_SZ) of pages and writing to it gave us a good insight,
we observed an improvement of 42% in allocation and writing timings.
-------------------------------------------------------------
Test code snippet
-------------------------------------------------------------
      clock_start();
      buf = malloc(BUF_SZ); /* Allocate 100 MB of memory */

        for(i=0; i < BUF_SZ_PAGES; i++)
        {
                *((int *)(buf + (i*PAGE_SIZE))) = 1;
        }
      clock_end();
-------------------------------------------------------------

Malloc test timings for 100MB anon allocation:-

Base data:-
Number of iterations: 100
Mean of allocation time: 31831 us
std deviation: 4286 us

v1 data:-
Number of iterations: 100
Mean of allocation time: 18193 us
std deviation: 4915 us

Reported-by: Chintan Pandya <chintan.pandya@oneplus.com>
Signed-off-by: Prathu Baronia <prathu.baronia@oneplus.com>
---
 arch/arm64/include/asm/page.h | 3 +++
 arch/arm64/mm/copypage.c      | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 012cffc574e8..8f9d005a11bb 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -35,6 +35,9 @@ void copy_highpage(struct page *to, struct page *from);
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
+#define clear_user_highpage clear_user_highpage
+void clear_user_highpage(struct page *page, unsigned long vaddr);
+
 typedef struct page *pgtable_t;
 
 extern int pfn_valid(unsigned long);
diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
index b5447e53cd73..7f5943c6fc12 100644
--- a/arch/arm64/mm/copypage.c
+++ b/arch/arm64/mm/copypage.c
@@ -44,3 +44,11 @@ void copy_user_highpage(struct page *to, struct page *from,
 	flush_dcache_page(to);
 }
 EXPORT_SYMBOL_GPL(copy_user_highpage);
+
+inline void clear_user_highpage(struct page *page, unsigned long vaddr)
+{
+	void *addr = page_address(page);
+
+	clear_user_page(addr, vaddr, page);
+}
+EXPORT_SYMBOL_GPL(clear_user_highpage);
-- 
2.17.1

