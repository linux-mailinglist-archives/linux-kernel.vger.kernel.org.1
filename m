Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE452AF3A9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgKKOdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:33:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:45128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgKKOdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:33:36 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 861A12072C
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 14:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605105215;
        bh=AkOWFzfC1WgzaY2rFJ9zyFuiAVBoXe4F9k4Ch1ZFBqU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=szrJLErLDiorupxe7+k/h9LozX58+K2IvsJEbKUYg0MiNfEbZLlEXaBr39MTluaZ7
         MMy8BwbyEnrlVJNyfEIMfPJ4bu4oD7HFdSnGwsl6XZinaVHiqcDIaAD3XJcyVlsYHw
         f4KRSP5ZllRHKFH0zHQg5WtUtPsVGlN8XpvM00QM=
Received: by mail-oi1-f170.google.com with SMTP id d9so2380724oib.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:33:35 -0800 (PST)
X-Gm-Message-State: AOAM531rG7RlZL6aICoZQRGLV5tPp4YZYWah9YFL2qOnZem8JVREWqkA
        0zmNaelwwR1qmxUOFuBfrgXMgzq5hR+IBaRXt60=
X-Google-Smtp-Source: ABdhPJzfPFXYMfgYom8Z01dt1mZWHegsRu8ouV5ojtX4ZiiWuBxueBkWOFz6e4WpfAk5MWycLSoKboE9QMP6vpva1Ps=
X-Received: by 2002:aca:180a:: with SMTP id h10mr2193827oih.4.1605105214752;
 Wed, 11 Nov 2020 06:33:34 -0800 (PST)
MIME-Version: 1.0
References: <bdfa44bf1c570b05d6c70898e2bbb0acf234ecdf.1604762181.git.stefan@agner.ch>
 <20201108064659.GD301837@kernel.org> <7782fb694a6b0c500e8f32ecf895b2bf@agner.ch>
 <20201110095806.GH301837@kernel.org> <CAK8P3a2MCdUbN0QSb+M3g5_6HjPsaQwtKxFjADMZWomdry4-Ww@mail.gmail.com>
 <20201110162155.GA4758@kernel.org> <CAK8P3a2vKOb_R3_tqO_XVCCn5Si2jFA5DRe_spB2-+gsoDhO6g@mail.gmail.com>
 <20201111102654.GF4758@kernel.org> <CAK8P3a0sfYWkHvNauEN8BwPCi2cMX-TVBTXUtnLJZpAzS7YNMg@mail.gmail.com>
 <20201111133945.GA12288@alpha.franken.de>
In-Reply-To: <20201111133945.GA12288@alpha.franken.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 11 Nov 2020 15:33:18 +0100
X-Gmail-Original-Message-ID: <CAK8P3a34gW-Cj0sOGiwXHewJjgimpxPqt4mEN2Lh=MiSA_tAaw@mail.gmail.com>
Message-ID: <CAK8P3a34gW-Cj0sOGiwXHewJjgimpxPqt4mEN2Lh=MiSA_tAaw@mail.gmail.com>
Subject: Re: [PATCH] mm/zsmalloc: include sparsemem.h for MAX_PHYSMEM_BITS
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Mike Rapoport <rppt@kernel.org>, Stefan Agner <stefan@agner.ch>,
        Minchan Kim <minchan@kernel.org>, ngupta@vflare.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        sjenning@linux.vnet.ibm.com, gregkh <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 2:39 PM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
> On Wed, Nov 11, 2020 at 11:57:02AM +0100, Arnd Bergmann wrote:
> > On Wed, Nov 11, 2020 at 11:26 AM Mike Rapoport <rppt@kernel.org> wrote:
> > >
> > > On Wed, Nov 11, 2020 at 10:33:29AM +0100, Arnd Bergmann wrote:
> > > > On Tue, Nov 10, 2020 at 5:21 PM Mike Rapoport <rppt@kernel.org> wrote:
> > > > > On Tue, Nov 10, 2020 at 12:21:11PM +0100, Arnd Bergmann wrote:
> > > > > >
> > > > > > To be on the safe side, we could provoke a compile-time error
> > > > > > when CONFIG_PHYS_ADDR_T_64BIT is set on a 32-bit
> > > > > > architecture, but MAX_POSSIBLE_PHYSMEM_BITS is not set.
> > > > >
> > > > > Maybe compile time warning and a runtime error in zs_init() if 32 bit
> > > > > machine has memory above 4G?
> > > >
> > > > If the fix is as easy as adding a single line in a header, I think a
> > > > compile-time
> > > > error makes it easier, no need to wait for someone to boot a broken
> > > > system before fixing it.
> > >
> > > Not sure it would be as easy as adding a single line in a header for
> > > MIPS with it's diversity.
> >
> > I looked up the architecture, and found:
> >
> > - The pre-MIPS32r1 cores only support 32-bit addressing
> > - octeon selects PHYS_ADDR_T_64BIT but no longer
> >   supports 32-bit kernels
> > - Alchemy and netlogic (XLR, XLP) have 36-bit addressing
> > - CONFIG_XPA implies 40-bit addressing
>
> MIPS32r5 might have up to 60-bit addressing according to the MIPS32 PRA
> docuemnt (MD00090). But there is probably no chip, which implements it
> so for now 40-bit addressing is correct.
>
> >
> > We should run it by the MIPS maintainers, but I think this patch
> > is sufficient:
>
> Do you want me to run it through mips tree or do you need an
> Acked-By from me ?

I'll follow up with a proper submission for MIPS and the other
architectures, please apply that one.

       Arnd
