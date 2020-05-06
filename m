Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA931C69EB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 09:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgEFHTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 03:19:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgEFHTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 03:19:32 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F374420663;
        Wed,  6 May 2020 07:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588749572;
        bh=QuJoFlHL30sC+0HfhLIHXNWYmeVyaepPc79QoY6a1Y8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IKcCKYiuihKxGIxZI0baNIcMUCMTdk9n4d8flfD54rK5BRWF+Lw+vvxbrBFFJ381R
         mB7Lu28v+mN8c10qsDg3cWzpKb8rWtdHqjFue+6MdYmJ2zg+uv5lbrU6G5Cy1Ml8CL
         JsaQ3G6BJhZiqp3UvlrHRN2RvpMMYQA/t8OM+L90=
Date:   Wed, 6 May 2020 08:19:27 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        shan.gavin@gmail.com
Subject: Re: [PATCH] arm64/mm: Remove add_huge_page_size()
Message-ID: <20200506071927.GB7021@willie-the-truck>
References: <20200506064635.20114-1-gshan@redhat.com>
 <fa3ad75d-9c4d-d6c9-1664-53b4c9770c6b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa3ad75d-9c4d-d6c9-1664-53b4c9770c6b@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 12:36:43PM +0530, Anshuman Khandual wrote:
> 
> 
> On 05/06/2020 12:16 PM, Gavin Shan wrote:
> > The function add_huge_page_size(), wrapper of hugetlb_add_hstate(),
> > avoids to register duplicated huge page states for same size. However,
> > the same logic has been included in hugetlb_add_hstate(). So it seems
> > unnecessary to keep add_huge_page_size() and this just removes it.
> 
> Makes sense.
> 
> > 
> > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > ---
> >  arch/arm64/mm/hugetlbpage.c | 18 +++++-------------
> >  1 file changed, 5 insertions(+), 13 deletions(-)
> > 
> > diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> > index bbeb6a5a6ba6..ed7530413941 100644
> > --- a/arch/arm64/mm/hugetlbpage.c
> > +++ b/arch/arm64/mm/hugetlbpage.c
> > @@ -441,22 +441,14 @@ void huge_ptep_clear_flush(struct vm_area_struct *vma,
> >  	clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
> >  }
> >  
> > -static void __init add_huge_page_size(unsigned long size)
> > -{
> > -	if (size_to_hstate(size))
> > -		return;
> > -
> > -	hugetlb_add_hstate(ilog2(size) - PAGE_SHIFT);
> > -}
> > -
> >  static int __init hugetlbpage_init(void)
> >  {
> >  #ifdef CONFIG_ARM64_4K_PAGES
> > -	add_huge_page_size(PUD_SIZE);
> > +	hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
> >  #endif
> > -	add_huge_page_size(CONT_PMD_SIZE);
> > -	add_huge_page_size(PMD_SIZE);
> > -	add_huge_page_size(CONT_PTE_SIZE);
> > +	hugetlb_add_hstate(CONT_PMD_SHIFT + PMD_SHIFT - PAGE_SHIFT);
> > +	hugetlb_add_hstate(PMD_SHIFT - PAGE_SHIFT);
> > +	hugetlb_add_hstate(CONT_PTE_SHIFT);

Something similar has already been done in linux-next.

> Should these page order values be converted into macros instead. Also
> we should probably keep (CONT_PTE_SHIFT + PAGE_SHIFT - PAGE_SHIFT) as
> is to make things more clear.

I think the real confusion stems from us not being consistent with your
*_SHIFT definitions on arm64. It's madness for CONT_PTE_SHIFT to be smaller
than PAGE_SHIFT imo, but it's just cosmetic I guess.

Will
