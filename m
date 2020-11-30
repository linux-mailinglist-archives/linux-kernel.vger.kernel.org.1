Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474C22C8360
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbgK3Ljt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgK3Ljs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:39:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E97C0617A7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 03:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=9rpmj7e+Hv4t7twTnPnStJvZhGql4xrwM1pM4f4qTOM=; b=v/A3yNF6sUJE5HpF7raY5uFFNv
        LPvE3P4LP5V9kkgmI+/QIcDyPpVT7Vh3gc5QRFwNaiWzqzaL5X2gi+khpdds4OqWrrWqvRTzZW77A
        9rp3kp5SMnx2isXm7N/cf4A8FxPDVR3hPnZB8ZCGbB1pycC/C7iOsoNNJV2fsS705RBHS+VpqDBrl
        KovUEqHFj7y3yqT2EqGgpZrx+UocBkhosH13AEmesyHKZF+zploGxfnqYmYPEVGCBMZg+qCdB3Zu4
        DKJZbFge63xNTPMMHmJ2sXWU1S4rGAwU1jgBF40LEiENRmdGXH8BlGqHK5kRGxaPlpQLRYLKJlGPa
        fli9mZ/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjhVa-0007Qe-SJ; Mon, 30 Nov 2020 11:38:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EA9FE3059DD;
        Mon, 30 Nov 2020 12:38:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D90AE2B84F9C5; Mon, 30 Nov 2020 12:38:17 +0100 (CET)
Message-ID: <20201130113602.959570640@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 30 Nov 2020 12:27:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, willy@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de, peterz@infradead.org
Subject: [RFC][PATCH 3/9] sh/mm: Make pmd_t similar to pte_t
References: <20201130112705.900705277@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like 64bit pte_t, have a low/high split in pmd_t.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/sh/include/asm/pgtable-3level.h |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/arch/sh/include/asm/pgtable-3level.h
+++ b/arch/sh/include/asm/pgtable-3level.h
@@ -28,9 +28,15 @@
 #define pmd_ERROR(e) \
 	printk("%s:%d: bad pmd %016llx.\n", __FILE__, __LINE__, pmd_val(e))
 
-typedef struct { unsigned long long pmd; } pmd_t;
+typedef struct {
+	struct {
+		unsigned long pmd_low;
+		unsigned long pmd_high;
+	};
+	unsigned long long pmd;
+} pmd_t;
 #define pmd_val(x)	((x).pmd)
-#define __pmd(x)	((pmd_t) { (x) } )
+#define __pmd(x)	((pmd_t) { .pmd = (x) } )
 
 static inline unsigned long pud_page_vaddr(pud_t pud)
 {


