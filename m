Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6DFE2F1869
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732700AbhAKOi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:38:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:41792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbhAKOi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:38:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D905E2255F;
        Mon, 11 Jan 2021 14:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610375868;
        bh=GWRS5isknuBePcoSAEiQ0Gy97LT1eGijAvL9gElMOKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r504WNhhXsmdMwwackGhLo169jGkVCjkosfE9M0sCA0ZYCTMnJILVvIQbIESp1eWw
         pheYCRuPCnBSGC9dYMVYt2RxAS//hrSZxls78sajMqIhrA9rrRHL3ffErTIWhP6Yky
         XXtQSUy9D2V9NpydrbhpZKLbdjtcM4p5z3I+pu7Rv5zcz9S/XPms9+7i816uP1mXLN
         N0jRUfMInp84kiybxt1UYP5xetN7fRLythVa4Y82fhV7RK/EKZDMGrHjW4ceV6WSwj
         t5v2MOCcLEImMD6QAljKq5yOWkit6zp55i4vwV/iV3WoYiQeXRzyFy0Mvdlu+c5R0v
         LgfQfu9skWxPA==
Date:   Mon, 11 Jan 2021 14:37:42 +0000
From:   Will Deacon <will@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>, kernel-team@android.com
Subject: Re: [PATCH v2 2/3] mm: Allow architectures to request 'old' entries
 when prefaulting
Message-ID: <20210111143742.GD7642@willie-the-truck>
References: <20210108171517.5290-1-will@kernel.org>
 <20210108171517.5290-3-will@kernel.org>
 <20210111142533.oulduqd76mkpdkst@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111142533.oulduqd76mkpdkst@box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 05:25:33PM +0300, Kirill A. Shutemov wrote:
> On Fri, Jan 08, 2021 at 05:15:16PM +0000, Will Deacon wrote:
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index c1f2dc89b8a7..0fb9d1714797 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -3051,14 +3051,18 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
> >  		if (!pte_none(*vmf->pte))
> >  			goto unlock;
> >  
> > +		/* We're about to handle the fault */
> > +		if (vmf->address == address) {
> > +			vmf->flags &= ~FAULT_FLAG_PREFAULT;
> > +			ret = VM_FAULT_NOPAGE;
> > +		} else {
> > +			vmf->flags |= FAULT_FLAG_PREFAULT;
> > +		}
> > +
> 
> Do we need to restore the oririnal status of the bit once we are done?

I can certainly add that, although it doesn't look like we do that for
vmf->pte, so it's hard to tell what the rules are here. It certainly feels
odd to restore some fields but not others, as it looks like vmf->address
will be out-of-whack with vmf->pte when filemap_map_pages() returns. Am I
missing something?

Will
