Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A808E2B0E7A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgKLTuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgKLTuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:50:02 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E14C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:50:01 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id g7so5540743pfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NvlbRf6o4iqfxYWdblnv/aYXcxMztTx66EJ83u92hhw=;
        b=Kkl+ct1H4eqUStLU9rjqUx2uXHw6oc06Umkdhi1K9qNVDj7wtPwdTHOyXbmzOVHV6H
         /wA8wNhMMfcIheoC7oYLA80Ux3cS153zqz+AyrYrifppG3er4sBAqpGNAbim+UNsE7eA
         4PZegvZBWp5ofxzHi/Gh4rfPah3d4f5b9V83E77FMJGS8aK/e1/k1zA67X0FggtjlFq7
         eZ90DBq4jA8peJDfF226BD+ezZOPAFzxiucxc4W5i72ashgLF3pPrkNvZigmqZg7Oj0r
         Y7RxYM1Q3ALKmGxHbeCUcVQerW4RdJh0jtyAAxwXkxUHY9Kn0hfGv+5sTKb/Y98mZ+Er
         dvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=NvlbRf6o4iqfxYWdblnv/aYXcxMztTx66EJ83u92hhw=;
        b=IuLS84bPtsAcZr1D/b663vZeAit4vy15RghQVwp7b/y1N4m8J4qlkQW6js8/ntRqvR
         kS9tDUNa7wb5OIKbQeQ92KdeGRhpMc0qs/WOzE6k1EYoWrAPyxcLbDS1QcHojJMKMUUl
         /8WvpnmhbMwLsoe5CAjf8AJL+7PxRatyb/9tkZlkb4az7knQeLQ3S1CVCGIxGtAOGCD7
         8Furgoh3CC+o0WYFbQRAeG68f9dJDbpJd1rpcA5SGhdYaxPvRRxVPh61xpwKwao79BJr
         3KKpTnJhHGTzuIJYn/J71ifHOY/nKVVmC4D0Er6FHuOvJRhMRi0F6SABVQIStjCQ1WBJ
         00qg==
X-Gm-Message-State: AOAM532IbUrTSJFQ9n3F7fy100XcW5G1ZxpBbLHYiMBebVLoM2FjlHWn
        E3evdLLaAApnWNOJogWjgo8=
X-Google-Smtp-Source: ABdhPJzyBwOoOKzay2doG2pjgeOMkJF6Q3yAx34LQnu8xcSIPAN/YcFBYitFLpsjemwpUvJFCnNnyg==
X-Received: by 2002:a17:90a:7022:: with SMTP id f31mr794727pjk.213.1605210601467;
        Thu, 12 Nov 2020 11:50:01 -0800 (PST)
Received: from google.com (c-67-188-94-199.hsd1.ca.comcast.net. [67.188.94.199])
        by smtp.gmail.com with ESMTPSA id e17sm7824196pfl.216.2020.11.12.11.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:50:00 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 12 Nov 2020 11:49:57 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Stefan Agner <stefan@agner.ch>,
        ngupta@vflare.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        sjenning@linux.vnet.ibm.com, gregkh <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/zsmalloc: include sparsemem.h for MAX_PHYSMEM_BITS
Message-ID: <20201112194957.GA123036@google.com>
References: <bdfa44bf1c570b05d6c70898e2bbb0acf234ecdf.1604762181.git.stefan@agner.ch>
 <20201108064659.GD301837@kernel.org>
 <7782fb694a6b0c500e8f32ecf895b2bf@agner.ch>
 <20201110095806.GH301837@kernel.org>
 <CAK8P3a2MCdUbN0QSb+M3g5_6HjPsaQwtKxFjADMZWomdry4-Ww@mail.gmail.com>
 <20201110162155.GA4758@kernel.org>
 <20201110233620.GA3310704@google.com>
 <20201111065200.GE4758@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111065200.GE4758@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 11, 2020 at 08:52:00AM +0200, Mike Rapoport wrote:
> Hi,
> 
> On Tue, Nov 10, 2020 at 03:36:20PM -0800, Minchan Kim wrote:
> > On Tue, Nov 10, 2020 at 06:21:55PM +0200, Mike Rapoport wrote:
> > > On Tue, Nov 10, 2020 at 12:21:11PM +0100, Arnd Bergmann wrote:
> > > > On Tue, Nov 10, 2020 at 10:58 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > > > > >
> > > > > > > asm/sparsemem.h is not available on some architectures.
> > > > > > > It's better to use linux/mmzone.h instead.
> > > > 
> > > > Ah, I missed that, too.
> > > > 
> > > > > > Hm, linux/mmzone.h only includes asm/sparsemem.h when CONFIG_SPARSEMEM
> > > > > > is enabled. However, on ARM at least I can have configurations without
> > > > > > CONFIG_SPARSEMEM and physical address extension on (e.g.
> > > > > > multi_v7_defconfig + CONFIG_LPAE + CONFIG_ZSMALLOC).
> > > > > >
> > > > > > While sparsemem seems to be a good idea with LPAE it really seems not
> > > > > > required (see also https://lore.kernel.org/patchwork/patch/567589/).
> > > > > >
> > > > > > There seem to be also other architectures which define MAX_PHYSMEM_BITS
> > > > > > only when SPARSEMEM is enabled, e.g.
> > > > > > arch/riscv/include/asm/sparsemem.h...
> > > > > >
> > > > > > Not sure how to get out of this.. Maybe make ZSMALLOC dependent on
> > > > > > SPARSEMEM? It feels a bit silly restricting ZSMALLOC selection only due
> > > > > > to a compile time define...
> > > > >
> > > > > I think we can define MAX_POSSIBLE_PHYSMEM_BITS in one of
> > > > > arch/arm/inclide/asm/pgtable-{2,3}level-*.h headers to values supported
> > > > > by !LPAE and LPAE.
> > > > 
> > > > Good idea. I wonder what other architectures need the same though.
> > > > Here are some I found:
> > > > 
> > > > $ git grep -l PHYS_ADDR_T_64BIT arch | grep Kconfig
> > > > arch/arc/Kconfig
> > > > arch/arm/mm/Kconfig
> > > > arch/mips/Kconfig
> > > > arch/powerpc/platforms/Kconfig.cputype
> > > > arch/x86/Kconfig
> > > > 
> > > > arch/arc has a CONFIG_ARC_HAS_PAE40 option
> > > > arch/riscv has 34-bit addressing in rv32 mode
> > > > arch/mips has up to 40 bits with mips32r3 XPA, but I don't know what
> > > >     supports that
> > > > 
> > > > arch/powerpc has this:
> > > > config PHYS_64BIT
> > > >         bool 'Large physical address support' if E500 || PPC_86xx
> > > >         depends on (44x || E500 || PPC_86xx) && !PPC_83xx && !PPC_82xx
> > > > 
> > > > Apparently all three (4xx, e500v2, mpc86xx/e600) do 36-bit physical
> > > > addressing, but each one has a different page table format.
> > > > 
> > > > Microblaze has physical address extensions, but neither those nor
> > > > 64-bit mode have so far made it into the kernel.
> > > > 
> > > > To be on the safe side, we could provoke a compile-time error
> > > > when CONFIG_PHYS_ADDR_T_64BIT is set on a 32-bit
> > > > architecture, but MAX_POSSIBLE_PHYSMEM_BITS is not set.
> > > 
> > > Maybe compile time warning and a runtime error in zs_init() if 32 bit
> > > machine has memory above 4G?
> > 
> > I guess max_pfn will represent maximum pfn configued in the system
> > and will not be changed in the runtime. If it's true, how about this?
> > (didn't test at all but just for RFC)
> 
> Largely, max_pfn is the maximal pfn at boot time but I don't think it
> can be used on systems with memory hotplug. Unless I'm missing
> something, with memory hotplug we must have compile-time maximum.
> 

Make sense. I am looking forward to seeing Arnd's patches at this
moment.

Thanks!

Thanks for the help!
