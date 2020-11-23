Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028E62C163B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733177AbgKWUMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbgKWUJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:09:03 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C20CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:09:03 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id l12so6981636edw.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=fDQy1wc4ePFUib94ltbYtVazi0RsE8I+c8xac0+Q+Wo=;
        b=rJ0wPyDSmdZPXeUKe9MhjGKLsaMM8OIwtm/Sg53kDkBndhHuAHu0Ef8DkEUGSuihlD
         uOaC3rDAfcukQGcvItdwVDUKC2Zc2OHOwV6pXC+2IfBzeLsspGPjDa+dOEOFIFS7GvNJ
         Uu1kVEQ7ZjpY2uA0La7T80tuogNGb0lBz6HwH0aZGz1DhOLM9FFRPHVqn5Ku1MoN45Gw
         CDlthTd9ZADLhifyzJNdeDLNDAOMClT6gMUXGzchMXHinne8n1kLv1j4ckjAGW6+ly6o
         8H8jjDLCOV3J4/iwccRhoUSgJsDQPum/xiJyTRtSgOI0yR9tTVObuR8NM78WH8zMVkui
         OPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fDQy1wc4ePFUib94ltbYtVazi0RsE8I+c8xac0+Q+Wo=;
        b=dgWpzqrdh1IKA19+IvEogYh7AynnwCOvRvaJahHk515Q5PwJmsJZgTXDgYOC37pG54
         cyDrXQYOb99l99Qm5cpkqsQeFTJq+Ly/YZshU+yA1CHkPUmubW+wV7MB2XBO3sjBDwN0
         H9iTtJ4NaQba8aaEpldgqCl1p//+v8MwXPxkB8w+WtoyjQgox2UytcLRXLxW0Lr2MU3c
         NFcPBX2mA52iYbeB/EZ2r9JW0JzcAuE+1qbEXo/X4fmDBd6qg+JnbRRv7qu2WQhO+0gB
         X63LkQxSsUF9iKKhnnhweSjWNQ1QfrW857lZ3YPuEUT/4PP38oXXtWy18u5XMtNatxoR
         V7GQ==
X-Gm-Message-State: AOAM530vL52PKg6NRKCdIHkKE8NJ+u/BE/0jBYXlfhO1MMvQdJT1sAJm
        WC9qDiMNLS/WeJUZQ/JMqc3UKvseUEJxnAt9
X-Google-Smtp-Source: ABdhPJwUEGMqgP1Mwk9YauS/ahrxnBn0vv0AM7jn5w6OhhPxh7R9yPQSQDF/sQwWUPd6WhwpZ7+0rfqyIUpe209i
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:aa7:d703:: with SMTP id
 t3mr791202edq.375.1606162141605; Mon, 23 Nov 2020 12:09:01 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:07:42 +0100
In-Reply-To: <cover.1606161801.git.andreyknvl@google.com>
Message-Id: <370466fba590a4596b55ffd38adfd990f8886db4.1606161801.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606161801.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v11 18/42] kasan: rename addr_has_shadow to addr_has_metadata
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

This is a preparatory commit for the upcoming addition of a new hardware
tag-based (MTE-based) KASAN mode.

Hardware tag-based KASAN won't be using shadow memory, but will reuse
this function. Rename "shadow" to implementation-neutral "metadata".

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
---
Change-Id: I03706fe34b38da7860c39aa0968e00001a7d1873
---
 mm/kasan/kasan.h          | 2 +-
 mm/kasan/report.c         | 6 +++---
 mm/kasan/report_generic.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 488ca1ff5979..c79d30c6fcdb 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -147,7 +147,7 @@ static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
 		<< KASAN_SHADOW_SCALE_SHIFT);
 }
 
-static inline bool addr_has_shadow(const void *addr)
+static inline bool addr_has_metadata(const void *addr)
 {
 	return (addr >= kasan_shadow_to_mem((void *)KASAN_SHADOW_START));
 }
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index af9138ea54ad..2990ca34abaf 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -361,7 +361,7 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
 	untagged_addr = reset_tag(tagged_addr);
 
 	info.access_addr = tagged_addr;
-	if (addr_has_shadow(untagged_addr))
+	if (addr_has_metadata(untagged_addr))
 		info.first_bad_addr = find_first_bad_addr(tagged_addr, size);
 	else
 		info.first_bad_addr = untagged_addr;
@@ -372,11 +372,11 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
 	start_report(&flags);
 
 	print_error_description(&info);
-	if (addr_has_shadow(untagged_addr))
+	if (addr_has_metadata(untagged_addr))
 		print_tags(get_tag(tagged_addr), info.first_bad_addr);
 	pr_err("\n");
 
-	if (addr_has_shadow(untagged_addr)) {
+	if (addr_has_metadata(untagged_addr)) {
 		print_address_description(untagged_addr, get_tag(tagged_addr));
 		pr_err("\n");
 		print_shadow_for_address(info.first_bad_addr);
diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
index b543a1ed6078..16ed550850e9 100644
--- a/mm/kasan/report_generic.c
+++ b/mm/kasan/report_generic.c
@@ -118,7 +118,7 @@ const char *get_bug_type(struct kasan_access_info *info)
 	if (info->access_addr + info->access_size < info->access_addr)
 		return "out-of-bounds";
 
-	if (addr_has_shadow(info->access_addr))
+	if (addr_has_metadata(info->access_addr))
 		return get_shadow_bug_type(info);
 	return get_wild_bug_type(info);
 }
-- 
2.29.2.454.gaff20da3a2-goog

