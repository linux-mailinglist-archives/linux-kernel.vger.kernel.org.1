Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E91235979
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Aug 2020 19:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgHBRUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Aug 2020 13:20:39 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:39300 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgHBRUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 13:20:39 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 072HKJqe027023;
        Sun, 2 Aug 2020 19:20:19 +0200
Date:   Sun, 2 Aug 2020 19:20:19 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: powerpc: build failures in Linus' tree
Message-ID: <20200802172019.GB26677@1wt.eu>
References: <20200802204842.36bca162@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200802204842.36bca162@canb.auug.org.au>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 02, 2020 at 08:48:42PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> We are getting build failures in some PowerPC configs for Linus' tree.
> See e.g. http://kisskb.ellerman.id.au/kisskb/buildresult/14306515/
> 
> In file included from /kisskb/src/arch/powerpc/include/asm/paca.h:18,
>                  from /kisskb/src/arch/powerpc/include/asm/percpu.h:13,
>                  from /kisskb/src/include/linux/random.h:14,
>                  from /kisskb/src/include/linux/net.h:18,
>                  from /kisskb/src/net/ipv6/ip6_fib.c:20:
> /kisskb/src/arch/powerpc/include/asm/mmu.h:139:22: error: unknown type name 'next_tlbcam_idx'
>   139 | DECLARE_PER_CPU(int, next_tlbcam_idx);
> 
> I assume this is caused by commit
> 
>   1c9df907da83 ("random: fix circular include dependency on arm64 after addition of percpu.h")
> 
> But I can't see how, sorry.

So there, asm/mmu.h includes asm/percpu.h, which includes asm/paca.h, which
includes asm/mmu.h.

I suspect that we can remove asm/paca.h from asm/percpu.h as it *seems*
to be only used by the #define __my_cpu_offset but I don't know if anything
will break further, especially if this __my_cpu_offset is used anywhere
without this paca definition.

Willy
