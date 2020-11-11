Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE9B2AF25C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgKKNkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:40:39 -0500
Received: from elvis.franken.de ([193.175.24.41]:53797 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727277AbgKKNkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:40:36 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1kcqMT-0000ID-00; Wed, 11 Nov 2020 14:40:33 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 14235C4DDD; Wed, 11 Nov 2020 14:39:46 +0100 (CET)
Date:   Wed, 11 Nov 2020 14:39:46 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Mike Rapoport <rppt@kernel.org>, Stefan Agner <stefan@agner.ch>,
        Minchan Kim <minchan@kernel.org>, ngupta@vflare.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        sjenning@linux.vnet.ibm.com, gregkh <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/zsmalloc: include sparsemem.h for MAX_PHYSMEM_BITS
Message-ID: <20201111133945.GA12288@alpha.franken.de>
References: <bdfa44bf1c570b05d6c70898e2bbb0acf234ecdf.1604762181.git.stefan@agner.ch>
 <20201108064659.GD301837@kernel.org>
 <7782fb694a6b0c500e8f32ecf895b2bf@agner.ch>
 <20201110095806.GH301837@kernel.org>
 <CAK8P3a2MCdUbN0QSb+M3g5_6HjPsaQwtKxFjADMZWomdry4-Ww@mail.gmail.com>
 <20201110162155.GA4758@kernel.org>
 <CAK8P3a2vKOb_R3_tqO_XVCCn5Si2jFA5DRe_spB2-+gsoDhO6g@mail.gmail.com>
 <20201111102654.GF4758@kernel.org>
 <CAK8P3a0sfYWkHvNauEN8BwPCi2cMX-TVBTXUtnLJZpAzS7YNMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0sfYWkHvNauEN8BwPCi2cMX-TVBTXUtnLJZpAzS7YNMg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 11:57:02AM +0100, Arnd Bergmann wrote:
> On Wed, Nov 11, 2020 at 11:26 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Wed, Nov 11, 2020 at 10:33:29AM +0100, Arnd Bergmann wrote:
> > > On Tue, Nov 10, 2020 at 5:21 PM Mike Rapoport <rppt@kernel.org> wrote:
> > > > On Tue, Nov 10, 2020 at 12:21:11PM +0100, Arnd Bergmann wrote:
> > > > >
> > > > > To be on the safe side, we could provoke a compile-time error
> > > > > when CONFIG_PHYS_ADDR_T_64BIT is set on a 32-bit
> > > > > architecture, but MAX_POSSIBLE_PHYSMEM_BITS is not set.
> > > >
> > > > Maybe compile time warning and a runtime error in zs_init() if 32 bit
> > > > machine has memory above 4G?
> > >
> > > If the fix is as easy as adding a single line in a header, I think a
> > > compile-time
> > > error makes it easier, no need to wait for someone to boot a broken
> > > system before fixing it.
> >
> > Not sure it would be as easy as adding a single line in a header for
> > MIPS with it's diversity.
> 
> I looked up the architecture, and found:
> 
> - The pre-MIPS32r1 cores only support 32-bit addressing
> - octeon selects PHYS_ADDR_T_64BIT but no longer
>   supports 32-bit kernels
> - Alchemy and netlogic (XLR, XLP) have 36-bit addressing
> - CONFIG_XPA implies 40-bit addressing

MIPS32r5 might have up to 60-bit addressing according to the MIPS32 PRA
docuemnt (MD00090). But there is probably no chip, which implements it
so for now 40-bit addressing is correct.

> 
> We should run it by the MIPS maintainers, but I think this patch
> is sufficient:

Do you want me to run it through mips tree or do you need an
Acked-By from me ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
