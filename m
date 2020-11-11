Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3218C2AEEB6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 11:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgKKK1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 05:27:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:48642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbgKKK1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 05:27:01 -0500
Received: from kernel.org (unknown [77.125.7.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CF2C20756;
        Wed, 11 Nov 2020 10:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605090421;
        bh=b0ZajuazmUfC3iDVX3AAJzMeBC7oZNbdiuUzj2pr3Cw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uoNjyA6cs5/wdsvtlaWgvh9dx4BvskHzPCySB2eSBKzLYdj+dChKcciEgPFRAc0pN
         u6fyzwveY9pzPS2tyq+0JyTjnmNzNgICEsLWsfwmhnljV8qXzJnwkwyvyWedy/MyFB
         tlN5gwpTalnb4jr47CynpHo6dYoqzbV5zq1oOX0I=
Date:   Wed, 11 Nov 2020 12:26:54 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Stefan Agner <stefan@agner.ch>, Minchan Kim <minchan@kernel.org>,
        ngupta@vflare.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        sjenning@linux.vnet.ibm.com, gregkh <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/zsmalloc: include sparsemem.h for MAX_PHYSMEM_BITS
Message-ID: <20201111102654.GF4758@kernel.org>
References: <bdfa44bf1c570b05d6c70898e2bbb0acf234ecdf.1604762181.git.stefan@agner.ch>
 <20201108064659.GD301837@kernel.org>
 <7782fb694a6b0c500e8f32ecf895b2bf@agner.ch>
 <20201110095806.GH301837@kernel.org>
 <CAK8P3a2MCdUbN0QSb+M3g5_6HjPsaQwtKxFjADMZWomdry4-Ww@mail.gmail.com>
 <20201110162155.GA4758@kernel.org>
 <CAK8P3a2vKOb_R3_tqO_XVCCn5Si2jFA5DRe_spB2-+gsoDhO6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2vKOb_R3_tqO_XVCCn5Si2jFA5DRe_spB2-+gsoDhO6g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 10:33:29AM +0100, Arnd Bergmann wrote:
> On Tue, Nov 10, 2020 at 5:21 PM Mike Rapoport <rppt@kernel.org> wrote:
> > On Tue, Nov 10, 2020 at 12:21:11PM +0100, Arnd Bergmann wrote:
> > >
> > > To be on the safe side, we could provoke a compile-time error
> > > when CONFIG_PHYS_ADDR_T_64BIT is set on a 32-bit
> > > architecture, but MAX_POSSIBLE_PHYSMEM_BITS is not set.
> >
> > Maybe compile time warning and a runtime error in zs_init() if 32 bit
> > machine has memory above 4G?
> 
> If the fix is as easy as adding a single line in a header, I think a
> compile-time
> error makes it easier, no need to wait for someone to boot a broken
> system before fixing it.

Not sure it would be as easy as adding a single line in a header for
MIPS with it's diversity.

How about adding a runtime detection like Minchan suggested for
!MEMORY_HOTPLUG (e.g. MIPS and ARC) and a compile time error otherwise
(i386, ppc)?

>        Arnd

-- 
Sincerely yours,
Mike.
