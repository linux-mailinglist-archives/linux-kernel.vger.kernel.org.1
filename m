Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642B82F184E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387984AbhAKO2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:28:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:40168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731825AbhAKO2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:28:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 737C122473;
        Mon, 11 Jan 2021 14:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610375244;
        bh=NeQZAI3Se6XnjBLgTKT5kwYcHmcn0zV0JGG0txZc5HA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JER9akiF6aHhzPy1WYWZfp7WhPw4SxmNlvZhH5vN2GhTQ7jRed4db3ImU5rXEjSAi
         mrtqazmvZoUKQYJ9rFF16yAtoJmcdcjKv94VpMeTNUBixIL/eKT9Q2eYQfNGyCLdWa
         ThQIRnU9rwrPz5kP9b9pMaJQbvY6mLvtMr7e9jw2w3oqNZ5G//M+zuGWwJ66JMBZds
         AlIYa//Thf6u+BxkDvys78gi06c3TfomSX5ht7+7Bxzulx9+ZcNGgVGXPb+XP/b7Mk
         pbB5QdbwqOkAiACEYea5ccWGwDTAu79n8qKVvSdGAWb7rC4ZTAm+3HZSr1gvm7iTpH
         47AQpo6KJEprA==
Date:   Mon, 11 Jan 2021 14:27:19 +0000
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
Subject: Re: [PATCH v2 1/3] mm: Cleanup faultaround and finish_fault()
 codepaths
Message-ID: <20210111142718.GC7642@willie-the-truck>
References: <20210108171517.5290-1-will@kernel.org>
 <20210108171517.5290-2-will@kernel.org>
 <20210111142620.ylv3ccrsubef62mi@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111142620.ylv3ccrsubef62mi@box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 05:26:20PM +0300, Kirill A. Shutemov wrote:
> On Fri, Jan 08, 2021 at 05:15:15PM +0000, Will Deacon wrote:
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index ecdf8a8cd6ae..801dd99f733c 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -542,8 +542,8 @@ struct vm_fault {
> >  					 * is not NULL, otherwise pmd.
> >  					 */
> >  	pgtable_t prealloc_pte;		/* Pre-allocated pte page table.
> > -					 * vm_ops->map_pages() calls
> > -					 * alloc_set_pte() from atomic context.
> > +					 * vm_ops->map_pages() sets up a page
> > +					 * table from from atomic context.
> >  					 * do_fault_around() pre-allocates
> >  					 * page table to avoid allocation from
> >  					 * atomic context.
> 
> The typo Matthew has pointed out:
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index d3d4e307fa09..358fc8616d8b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -535,7 +535,7 @@ struct vm_fault {
>  					 */
>  	pgtable_t prealloc_pte;		/* Pre-allocated pte page table.
>  					 * vm_ops->map_pages() sets up a page
> -					 * table from from atomic context.
> +					 * table from atomic context.
>  					 * do_fault_around() pre-allocates
>  					 * page table to avoid allocation from
>  					 * atomic context.

Cheers, fixed locally and will include for v3!

Will
