Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFD72DD0D3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 12:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgLQLvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 06:51:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:45202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727454AbgLQLvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 06:51:05 -0500
Date:   Thu, 17 Dec 2020 11:50:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608205824;
        bh=aGXtJfxx4UR9SrC/wSxGQsXmg4iOOc+hR4oNQdvQOR4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=kV0aKnYhez1VawH2KBXMwDLuHbhrwpHgA2yO/X8pmIIutmw6Nc747a8b8vsQSH/WB
         S4iVCQQAHegTMxi1ZkdZR6UH5IO4wjc6yNc3vG08Fohnv01/Hu0gt2son3U4CRcMw7
         BXRwJzyz0Czw2TWt6uwHqiDStGCXh/cisyJYZ9LALDNYrXAi7zyrCOaZ5Xl9Pp0jVm
         RFZlSn27FtWtHTcw3L1eQyWE5DrGs6mNwmPLF4RazYtjzp0VJQ9QfBbdhvW4vZYhtP
         oBIZbk/4zWMficQYbz3uTjMlJuohr5DOVN4sSEUQimBBKxuZjutedUL6FIpdA+DjOk
         NO6EIOz3lo/lA==
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mohamed Alzayat <alzayat@mpi-sws.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/6] tlb: Fix (soft-)dirty bit management clean up API
Message-ID: <20201217115018.GA17544@willie-the-truck>
References: <20201210121110.10094-1-will@kernel.org>
 <20201210122607.GO2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210122607.GO2414@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 01:26:07PM +0100, Peter Zijlstra wrote:
> On Thu, Dec 10, 2020 at 12:11:04PM +0000, Will Deacon wrote:
> > Will Deacon (6):
> >   mm: proc: Invalidate TLB after clearing soft-dirty page state
> >   tlb: mmu_gather: Remove unused start/end arguments from
> >     tlb_finish_mmu()
> >   tlb: mmu_gather: Introduce tlb_gather_mmu_fullmm()
> >   tlb: mmu_gather: Remove start/end arguments from tlb_gather_mmu()
> >   tlb: arch: Remove empty __tlb_remove_tlb_entry() stubs
> >   x86/ldt: Use tlb_gather_mmu_fullmm() when freeing LDT page-tables
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Cheers. I don't think this series is urgent, so I'll post it again in
the New Year.

Will
