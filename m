Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C6B286E9F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 08:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgJHGWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 02:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgJHGWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 02:22:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BEDC061755;
        Wed,  7 Oct 2020 23:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yUoIc9I8zBFW1l1RUkMTpa9dMjCgFjwiUO5I2agyv3s=; b=hdRv5sr7QtXVOGXnAnhUe3FNGb
        SRotAyEmN3rCMEJEhz3DikQcIqwCTG7CrAXiGiJWRUiku6BDUa42w6DZZiCTkfkbxFoXIe7hgn76r
        +C3TZkRE3oivb3DH5SBC/7jmkOXuTxXsYCUrSeefXQOupAXXmHcOAHPsplH9Um35Qqw3L/7lh0c2R
        i2QFfuqlGN1tfs6y+SyuJJCpyrrrN502ektDR3lor/9mvl6TtW94LyJ01rK7Nbdg2H7PMHKQIP93E
        NeJhUT3dXGmvhbe8Yp0AXOEET4abmXiWKvn13m9skKm3U05B8wtsNCsN+hd1Ih2h7T+f9vwrEqpAW
        cwLC1J/Q==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQPJ6-00070T-71; Thu, 08 Oct 2020 06:21:40 +0000
Date:   Thu, 8 Oct 2020 07:21:40 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        sparclinux@vger.kernel.org,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] mm/mprotect: Call arch_validate_prot under mmap_lock
 and with length
Message-ID: <20201008062140.GA24315@infradead.org>
References: <20201007073932.865218-1-jannh@google.com>
 <20201007123544.GA11433@infradead.org>
 <CAG48ez3kjTeVtQcjQerYYRs7sX5qq3O7SU-FEaYLNXisFmAeOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3kjTeVtQcjQerYYRs7sX5qq3O7SU-FEaYLNXisFmAeOg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 04:42:55PM +0200, Jann Horn wrote:
> > > @@ -43,7 +43,7 @@ static inline long do_mmap2(unsigned long addr, size_t len,
> > >  {
> > >       long ret = -EINVAL;
> > >
> > > -     if (!arch_validate_prot(prot, addr))
> > > +     if (!arch_validate_prot(prot, addr, len))
> >
> > This call isn't under mmap lock.  I also find it rather weird as the
> > generic code only calls arch_validate_prot from mprotect, only powerpc
> > also calls it from mmap.
> >
> > This seems to go back to commit ef3d3246a0d0
> > ("powerpc/mm: Add Strong Access Ordering support")
> 
> I'm _guessing_ the idea in the generic case might be that mmap()
> doesn't check unknown bits in the protection flags, and therefore
> maybe people wanted to avoid adding new error cases that could be
> caused by random high bits being set? So while the mprotect() case
> checks the flags and refuses unknown values, the mmap() code just lets
> the architecture figure out which bits are actually valid to set (via
> arch_calc_vm_prot_bits()) and silently ignores the rest?
> 
> And powerpc apparently decided that they do want to error out on bogus
> prot values passed to their version of mmap(), and in exchange, assume
> in arch_calc_vm_prot_bits() that the protection bits are valid?

The problem really is that now programs behave different on powerpc
compared to all other architectures.

> powerpc's arch_validate_prot() doesn't actually need the mmap lock, so
> I think this is fine-ish for now (as in, while the code is a bit
> unclean, I don't think I'm making it worse, and I don't think it's
> actually buggy). In theory, we could move the arch_validate_prot()
> call over into the mmap guts, where we're holding the lock, and gate
> it on the architecture or on some feature CONFIG that powerpc can
> activate in its Kconfig. But I'm not sure whether that'd be helping or
> making things worse, so when I sent this patch, I deliberately left
> the powerpc stuff as-is.

For now I'd just duplicate the trivial logic from arch_validate_prot
in the powerpc version of do_mmap2 and add a comment that this check
causes a gratious incompatibility to all other architectures.  And then
hope that the powerpc maintainers fix it up :)
