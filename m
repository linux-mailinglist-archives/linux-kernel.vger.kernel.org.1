Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406D52D5A80
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 13:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbgLJM1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 07:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbgLJM1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 07:27:01 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0B1C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 04:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yQicWsh++4Tuha+ofqyMiQufgJXnp2xipJggzw4rkQs=; b=E2p87UGsQDfr2WMPXBfG1ER89y
        ypK/8ac4Qjt1nlcKHJSEs8GF9FJndq4A5POlFe4hNqEzva4lceJrQcFD9Md8FOTX/zzciTmNINifx
        2yziWIVqtaKWj27pf476o1xypJAEsqPL2FAtPSTuDPAdAkJMfIskyNntsgaSfUsCy5e5x3myUkNMZ
        1xuDVtHbaGSMsa8n/I4U2Nsjx/1A1OBdo9UikrIRNDIcJPl7eqg/TJkhNS/5ZVvLrTsNYoOc3Yywl
        UveapwDUgRsxL34oeMrmg0t/5MrxWad7A9hFGMIHqK/tfPafD1I+a8Xk/vMiv2+kMrBDimHN3Ekx8
        qKbYkj6w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knL1M-00088V-JZ; Thu, 10 Dec 2020 12:26:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4D4613011F0;
        Thu, 10 Dec 2020 13:26:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 29BE120234B76; Thu, 10 Dec 2020 13:26:07 +0100 (CET)
Date:   Thu, 10 Dec 2020 13:26:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mohamed Alzayat <alzayat@mpi-sws.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/6] tlb: Fix (soft-)dirty bit management clean up API
Message-ID: <20201210122607.GO2414@hirez.programming.kicks-ass.net>
References: <20201210121110.10094-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210121110.10094-1-will@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 12:11:04PM +0000, Will Deacon wrote:
> Will Deacon (6):
>   mm: proc: Invalidate TLB after clearing soft-dirty page state
>   tlb: mmu_gather: Remove unused start/end arguments from
>     tlb_finish_mmu()
>   tlb: mmu_gather: Introduce tlb_gather_mmu_fullmm()
>   tlb: mmu_gather: Remove start/end arguments from tlb_gather_mmu()
>   tlb: arch: Remove empty __tlb_remove_tlb_entry() stubs
>   x86/ldt: Use tlb_gather_mmu_fullmm() when freeing LDT page-tables

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
