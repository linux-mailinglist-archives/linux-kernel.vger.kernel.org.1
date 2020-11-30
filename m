Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1C32C8359
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgK3LjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgK3LjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:39:08 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA93FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 03:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=/uoQQYbsRyNoJjZQKQhQxCD1OTCWXbPOIVU6csr5cic=; b=CGwc8xq0mLRcSMz/aOXXnK7TYg
        A2heKgcQG+T24YsWMXOGDcvBAeE8VacWZsbVXt0acpnu+OXthiOUr+O0fD0F6fsQZVHAThCi7QRaQ
        nzKGoTgxmD8/H0VuMiVBKYqOUjmyJcVoKNR7LTQeHJBeVv777uU9AHZs3OJ5E+DgIc7+ALuq6gUp1
        wA68Golu7aKnkZP8goRA0SS2/t5N0DYpd/+M5Nmlt95Z5SofsIDIHAjZvld+eVDVsBC3JChqSkT2b
        GuRbLWBeMbyLUVWCXi336BxcKffs4F8logOqgGNRLmen/I35IgdiKaJ3767if4YeDAcad1+tG8g5A
        8qk6Jgxg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjhVc-0006CX-TD; Mon, 30 Nov 2020 11:38:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 38C87307890;
        Mon, 30 Nov 2020 12:38:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E9F922B84F9C9; Mon, 30 Nov 2020 12:38:17 +0100 (CET)
Message-ID: <20201130113603.205586001@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 30 Nov 2020 12:27:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, willy@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de, peterz@infradead.org
Subject: [RFC][PATCH 7/9] x86/mm/pae: Dont (ab)use atomic64
References: <20201130112705.900705277@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PAE implies CX8, write readable code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/pgtable-3level.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -2,8 +2,6 @@
 #ifndef _ASM_X86_PGTABLE_3LEVEL_H
 #define _ASM_X86_PGTABLE_3LEVEL_H
 
-#include <asm/atomic64_32.h>
-
 /*
  * Intel Physical Address Extension (PAE) Mode - three-level page
  * tables on PPro+ CPUs.
@@ -96,11 +94,13 @@ static inline void pud_clear(pud_t *pudp
 #ifdef CONFIG_SMP
 static inline pte_t native_ptep_get_and_clear(pte_t *ptep)
 {
-	pte_t res;
+	pte_t old;
 
-	res.pte = (pteval_t)arch_atomic64_xchg((atomic64_t *)ptep, 0);
+	do {
+		old = *ptep;
+	} while (cmpxchg64(&ptep->pte, old.pte, 0ULL) != old.pte);
 
-	return res;
+	return old;
 }
 #else
 #define native_ptep_get_and_clear(xp) native_local_ptep_get_and_clear(xp)


