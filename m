Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4382C1821
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 23:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbgKWWFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 17:05:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:40872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729715AbgKWWFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 17:05:04 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 740072065E;
        Mon, 23 Nov 2020 22:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606169103;
        bh=8QnfruGejTRH7nfsdvCBeNb2gG3IvvOWgour8c1dXr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=deUS5+Vx3/ztra+NR51IRW3qxLRl5qvD5WjmIkfuSVBWe9GGetwCg9ahlhhkXiK7S
         VfcP0iwXuWE1It6EuQnVIOu4Atuv7HEopSvXMho1AknqlXXt+Q2Hv8bJgHpB5BwVAQ
         HLhCsJpAGMErHaGQGzWXlJun8YIYHmsjPWJi5j7c=
Date:   Mon, 23 Nov 2020 22:04:57 +0000
From:   Will Deacon <will@kernel.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/6] mm: proc: Invalidate TLB after clearing soft-dirty
 page state
Message-ID: <20201123220457.GB12069@willie-the-truck>
References: <20201120143557.6715-1-will@kernel.org>
 <20201120143557.6715-5-will@kernel.org>
 <20201120202253.GB1303870@google.com>
 <20201121024922.GA1363491@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121024922.GA1363491@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 07:49:22PM -0700, Yu Zhao wrote:
> On Fri, Nov 20, 2020 at 01:22:53PM -0700, Yu Zhao wrote:
> > On Fri, Nov 20, 2020 at 02:35:55PM +0000, Will Deacon wrote:
> > > Since commit 0758cd830494 ("asm-generic/tlb: avoid potential double flush"),
> > > TLB invalidation is elided in tlb_finish_mmu() if no entries were batched
> > > via the tlb_remove_*() functions. Consequently, the page-table modifications
> > > performed by clear_refs_write() in response to a write to
> > > /proc/<pid>/clear_refs do not perform TLB invalidation. Although this is
> > > fine when simply aging the ptes, in the case of clearing the "soft-dirty"
> > > state we can end up with entries where pte_write() is false, yet a
> > > writable mapping remains in the TLB.
> > 
> > I don't think we need a TLB flush in this context, same reason as we
> > don't have one in copy_present_pte() which uses ptep_set_wrprotect()
> > to write-protect a src PTE.

Hmm. Afaict, copy_present_pte() is only called on the fork() path when
VM_WIPEONFORK is set. I think that's a bit different to the fault case,
and even then, there is a fullmm flush after the copy.

> > ptep_modify_prot_start/commit() and ptep_set_wrprotect() guarantee
> > either the dirty bit is set (when a PTE is still writable) or a PF
> > happens (when a PTE has become r/o) when h/w page table walker races
> > with kernel that modifies a PTE using the two APIs.
> 
> After we remove the writable bit, if we end up with a clean PTE, any
> subsequent write will trigger a page fault. We can't have a stale
> writable tlb entry. The architecture-specific APIs guarantee this.
> 
> If we end up with a dirty PTE, then yes, there will be a stale
> writable tlb entry. But this won't be a problem because when we
> write-protect a page (not PTE), we always check both pte_dirty()
> and pte_write(), i.e., write_protect_page() and page_mkclean_one().
> When they see this dirty PTE, they will flush. And generally, only
> callers of pte_mkclean() should flush tlb; otherwise we end up one
> extra if callers of pte_mkclean() and pte_wrprotect() both flush.

I just find this sort of analysis incredibly fragile: we're justifying the
lack of TLB invalidation on a case-by-case basis rather than some general
rules that mean it is not required by construction. Even if all current
users don't need it, what means that will still be true in six months time?
It's not like this stuff is easy to trigger in practice if we get it wrong.

Will
