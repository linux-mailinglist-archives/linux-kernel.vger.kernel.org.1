Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B138285F47
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 14:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgJGMfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 08:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgJGMfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 08:35:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380F6C061755;
        Wed,  7 Oct 2020 05:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A8S5rW2sEaEJHpHml4mFPuJ2r5+DIxjOYtXnAeTe5d4=; b=cZcO41+5mqkO+dDkoy9Q3MuYw/
        vGjFobbV9rfsNmO8Vf9dzYmHg7toIxcvMAB4Xmsh0WCB3wKn+l6lwEawXUTLzi+gj7kBaBcruiwez
        gfcd4yrJ+Zce7OFzUkztjbQlz2/SQ7ISgG0vyzrDNbFnetzpeP3Qphof2P4Yh8Ik4R5tN0LCXpfNK
        IGD3h+jN4WY69QfQVtgCxs/FTAzGldoXol6IxO1sM66G/Hth5XDyV6EmJlmhI3xfEJxr2S91FEcsP
        9siebPZixepPSmbYEzyVH5amKjjV4nAaXypAfliKQbp5Y1z3vJFeg2ovOVMMEii5iR6uBgWnRj2Zr
        Z0/2uF5Q==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQ8fY-0003dz-Db; Wed, 07 Oct 2020 12:35:44 +0000
Date:   Wed, 7 Oct 2020 13:35:44 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Khalid Aziz <khalid.aziz@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] mm/mprotect: Call arch_validate_prot under mmap_lock
 and with length
Message-ID: <20201007123544.GA11433@infradead.org>
References: <20201007073932.865218-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007073932.865218-1-jannh@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 09:39:31AM +0200, Jann Horn wrote:
> diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
> index 078608ec2e92..b1fabb97d138 100644
> --- a/arch/powerpc/kernel/syscalls.c
> +++ b/arch/powerpc/kernel/syscalls.c
> @@ -43,7 +43,7 @@ static inline long do_mmap2(unsigned long addr, size_t len,
>  {
>  	long ret = -EINVAL;
>  
> -	if (!arch_validate_prot(prot, addr))
> +	if (!arch_validate_prot(prot, addr, len))

This call isn't under mmap lock.  I also find it rather weird as the
generic code only calls arch_validate_prot from mprotect, only powerpc
also calls it from mmap.

This seems to go back to commit ef3d3246a0d0
("powerpc/mm: Add Strong Access Ordering support")
