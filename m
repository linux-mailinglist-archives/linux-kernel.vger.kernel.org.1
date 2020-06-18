Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB371FECB0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 09:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgFRHo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 03:44:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727930AbgFRHo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 03:44:27 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97A442166E;
        Thu, 18 Jun 2020 07:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592466266;
        bh=LpxGETJrqE7ptBTScyTDcyHebnrA5FbmxlQMV/3rWPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hZoIdqxSbVDRXxRT8A4We5T4VQWpR3PAcfmToMUljypXIpacktpjV+CmnQQB5SQ31
         zR8T61Em8Pusugz2FWs5OxzwVTrDHGA4mT3SiUiX02Ut+3iz4UTzxxeFkNQMbtIr26
         UzYVdOCJx2i+M2nMRN6Wju/q4yzY4FS0kxVVlrHM=
Date:   Thu, 18 Jun 2020 08:44:21 +0100
From:   Will Deacon <will@kernel.org>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Roman Gushchin <guro@fb.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "nsaenzjulienne@suse.de" <nsaenzjulienne@suse.de>,
        "steve.capper@arm.com" <steve.capper@arm.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2] arm64: mm: reserve hugetlb CMA after numa_init
Message-ID: <20200618074421.GA5109@willie-the-truck>
References: <20200616221924.74780-1-song.bao.hua@hisilicon.com>
 <20200617101824.GB3368@willie-the-truck>
 <B926444035E5E2439431908E3842AFD2502AA9@DGGEMI525-MBS.china.huawei.com>
 <20200617182026.GA19784@carbon.dhcp.thefacebook.com>
 <B926444035E5E2439431908E3842AFD2503532@DGGEMI525-MBS.china.huawei.com>
 <20200618071934.GA4864@willie-the-truck>
 <B926444035E5E2439431908E3842AFD2507431@DGGEMI525-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B926444035E5E2439431908E3842AFD2507431@DGGEMI525-MBS.china.huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 07:43:43AM +0000, Song Bao Hua (Barry Song) wrote:
> 
> 
> > -----Original Message-----
> > From: Will Deacon [mailto:will@kernel.org]
> > Sent: Thursday, June 18, 2020 7:20 PM
> > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> > Cc: Roman Gushchin <guro@fb.com>; catalin.marinas@arm.com;
> > nsaenzjulienne@suse.de; steve.capper@arm.com; rppt@linux.ibm.com;
> > akpm@linux-foundation.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>; Matthias
> > Brugger <matthias.bgg@gmail.com>
> > Subject: Re: [PATCH v2] arm64: mm: reserve hugetlb CMA after numa_init
> > 
> > On Wed, Jun 17, 2020 at 09:43:51PM +0000, Song Bao Hua (Barry Song)
> > wrote:
> > > > From: Roman Gushchin [mailto:guro@fb.com]
> > > > On Wed, Jun 17, 2020 at 11:38:03AM +0000, Song Bao Hua (Barry Song)
> > > > > > From: Will Deacon [mailto:will@kernel.org]
> > > > > > On Wed, Jun 17, 2020 at 10:19:24AM +1200, Barry Song wrote:
> > > > > > > hugetlb_cma_reserve() is called at the wrong place. numa_init has not
> > > > > > > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > > > > > > index e631e6425165..41914b483d54 100644
> > > > > > > --- a/arch/arm64/mm/init.c
> > > > > > > +++ b/arch/arm64/mm/init.c
> > > > > > > @@ -404,11 +404,6 @@ void __init arm64_memblock_init(void)
> > > > > > >  	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
> > > > > > >
> > > > > > >  	dma_contiguous_reserve(arm64_dma32_phys_limit);
> > > > > > > -
> > > > > > > -#ifdef CONFIG_ARM64_4K_PAGES
> > > > > > > -	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> > > > > > > -#endif
> > > > > >
> > > > > > Why is this dependent on CONFIG_ARM64_4K_PAGES? We
> > unconditionally
> > > > > > select ARCH_HAS_GIGANTIC_PAGE so this seems unnecessary.
> > > > >
> > > > > Roman, would you like to answer this question? Have you found any
> > > > problem if system
> > > > > doesn't set 4K_PAGES?
> > > >
> > > > No, I was just following the code in arch/arm64/mm/hugetlbpage.c where
> > all
> > > > related to PUD-sized pages is guarded by CONFIG_ARM64_4K_PAGES.
> > > > Actually I did all my testing on x86-64, I don't even have any arm
> > hardware.
> > > >
> > > > I'm totally fine with removing this #ifdef if it's not needed.
> > >
> > > At this moment, I would suggest we should keep this "ifdef". Otherwise,
> > hugetlb_cma_reserve() won't be really useful.
> > >
> > > For example, while setting PAGE size to 64KB. I got this error in
> > hugetlb_cma_reserve():
> > > hugetlb_cma: cma area should be at least 4194304 MiB
> > > This is absolutely unreasonable.
> > 
> > Maybe one for RaspberryPi 5, huh? ;)
> > 
> > But ok, I'll take your patch as-is and add a comment about NUMA.
> 
> Have you seen the v3 with comment? I've already sent.

Thanks, just saw that (I'm going through morning email atm :)

Will
