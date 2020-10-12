Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463D828C322
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbgJLUqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388367AbgJLUpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:45:41 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C15CC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:45:41 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id m126so8383116qkd.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=bjQ7HGNrl6lZ+I2pFRgMH/Dm6JOdeFQivr4o3Lh72GE=;
        b=dLvBzdDsHU3nkH1DZiyfjyiagb8r0YdxC1NozDS/5TzzBA8m/WOSFooZk8qb+x6s6P
         bEdqTk8kH6jHnObfPBWOyws8rLD/aIeEvix5if7mE9NCW/081/UCqq0riFzXMVZvi8wQ
         pcCPYLnw326ICNK3kTQ71Jj07Mz8ZCxtt97kFgqTyuz4Zq8QAOVa6lUN/F+o+JXfnM0G
         f6KP0vBwsMjchXkQPaeoVwBQyjo/odiPM2oFCpgyIH25bpQ8fTHTLwHaxif+nVLWGyYv
         x89u8C9X4YKuKYuaxcftYBesXQhdCMI2GszRmgLBO3HVqWrphkVi00XT1GCJ6+mPyTns
         BiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bjQ7HGNrl6lZ+I2pFRgMH/Dm6JOdeFQivr4o3Lh72GE=;
        b=TruoP631H9c39w3AH56CkpgI1BraINwSRC30xVx+/4IQtwy2zddGGZsAXrhfMRNc+B
         epUqYbufVK7gMIEEgJg5Lh3riFnPpo01exco1NVn0S2zXz/lyNI3j5XgoeyjC2SaEsgc
         +/nOohhguyOUkeX7BcGY61ikVyYDZemeNB9y2QvExjor6KJdctsz2Qms9EXuSbeTrjR8
         fGzKq1Fgoz1BfHqVobqm6WYYSSZZzbrUPfKXXUuzogzuxUsx+Qceducm9/OPWcDirnmh
         alCgEVW1Fc1uH++g9nZ2x1P9pqhcMMVFBCPq1xSaQOcCDo2JufSQ3ukblR9jacxVHL8I
         RZDA==
X-Gm-Message-State: AOAM532woqkBvLFkW2AXfq7PCRDN0AuO2Q1i/DAqaX5wuuOeBAl15z9t
        7bcKydCt4e0Vmf5GmeLR5DgV1n/unsiaZuJ/
X-Google-Smtp-Source: ABdhPJyp+dP5hrLWYj/H3YNzdkWB4H84ynFi1wV9A4frEFWuBPkIDB+KcM2Bmask3Q8ancqgp0KSD5Gx1EWFRCgt
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:ee86:: with SMTP id
 u6mr27307337qvr.56.1602535540392; Mon, 12 Oct 2020 13:45:40 -0700 (PDT)
Date:   Mon, 12 Oct 2020 22:44:26 +0200
In-Reply-To: <cover.1602535397.git.andreyknvl@google.com>
Message-Id: <46a553603c4c16e8ec2311bbec2294ac4938a0db.1602535397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1602535397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 20/40] kasan: don't duplicate config dependencies
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

Both KASAN_GENERIC and KASAN_SW_TAGS have common dependencies, move
those to KASAN.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
---
Change-Id: I77e475802e8f1750b9154fe4a6e6da4456054fcd
---
 lib/Kconfig.kasan | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index e1d55331b618..f73d5979575a 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -24,6 +24,8 @@ menuconfig KASAN
 		   (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)
 	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
 	depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
+	select CONSTRUCTORS
+	select STACKDEPOT
 	help
 	  Enables KASAN (KernelAddressSANitizer) - runtime memory debugger,
 	  designed to find out-of-bounds accesses and use-after-free bugs.
@@ -46,10 +48,7 @@ choice
 config KASAN_GENERIC
 	bool "Generic mode"
 	depends on HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC
-	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
 	select SLUB_DEBUG if SLUB
-	select CONSTRUCTORS
-	select STACKDEPOT
 	help
 	  Enables generic KASAN mode.
 
@@ -70,10 +69,7 @@ config KASAN_GENERIC
 config KASAN_SW_TAGS
 	bool "Software tag-based mode"
 	depends on HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS
-	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
 	select SLUB_DEBUG if SLUB
-	select CONSTRUCTORS
-	select STACKDEPOT
 	help
 	  Enables software tag-based KASAN mode.
 
-- 
2.28.0.1011.ga647a8990f-goog

