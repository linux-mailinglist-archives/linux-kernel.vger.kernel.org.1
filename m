Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382AD23A336
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 13:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgHCLSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 07:18:05 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56887 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgHCLSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 07:18:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BKwNW1yJpz9sPC;
        Mon,  3 Aug 2020 21:18:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1596453483;
        bh=dYeVUhR07ZAkkPPkL+OF20bNAosgm3CVfzbhC05UNb4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=OokSIORh8TKNPBzo76jdcL0Q/6Qi63Z+vfPp+Whn+fHRlBtlTKi7r/CvmDbrNHgE5
         Z5lXZr3PnAdNkM2hb+LVvfFdXcqMlYCYuOlN2hnBPzYvs0syZ7pdCUNoodERrMAjbj
         qSmAjcDDP4tKPVAa6LCHY8mgOFCOQUCtwJhMqctMVrU3j6Tn/YStFOI12LPAJSsJyU
         JaZeQl+mwVYcCri4cW0I7avpreRchGPUMbQ0k4k3ydOejMkwMs/IleJ3nKfErNFZxF
         ZI7jRBbeVtAnKPJPm0kwSA7ER7frSNkK7IX2jslIm/orBz4DfYepK/1vlFTnm6+XB1
         LXywizjDRUq1w==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Willy Tarreau <w@1wt.eu>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: powerpc: build failures in Linus' tree
In-Reply-To: <20200803034547.GA15501@1wt.eu>
References: <20200802204842.36bca162@canb.auug.org.au> <20200802172019.GB26677@1wt.eu> <20200803034547.GA15501@1wt.eu>
Date:   Mon, 03 Aug 2020 21:18:00 +1000
Message-ID: <87v9i0yo47.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <w@1wt.eu> writes:
> On Sun, Aug 02, 2020 at 07:20:19PM +0200, Willy Tarreau wrote:
>> On Sun, Aug 02, 2020 at 08:48:42PM +1000, Stephen Rothwell wrote:
>> > Hi all,
>> > 
>> > We are getting build failures in some PowerPC configs for Linus' tree.
>> > See e.g. http://kisskb.ellerman.id.au/kisskb/buildresult/14306515/
>> > 
>> > In file included from /kisskb/src/arch/powerpc/include/asm/paca.h:18,
>> >                  from /kisskb/src/arch/powerpc/include/asm/percpu.h:13,
>> >                  from /kisskb/src/include/linux/random.h:14,
>> >                  from /kisskb/src/include/linux/net.h:18,
>> >                  from /kisskb/src/net/ipv6/ip6_fib.c:20:
>> > /kisskb/src/arch/powerpc/include/asm/mmu.h:139:22: error: unknown type name 'next_tlbcam_idx'
>> >   139 | DECLARE_PER_CPU(int, next_tlbcam_idx);
>> > 
>> > I assume this is caused by commit
>> > 
>> >   1c9df907da83 ("random: fix circular include dependency on arm64 after addition of percpu.h")
>> > 
>> > But I can't see how, sorry.
>> 
>> So there, asm/mmu.h includes asm/percpu.h, which includes asm/paca.h, which
>> includes asm/mmu.h.
>> 
>> I suspect that we can remove asm/paca.h from asm/percpu.h as it *seems*
>> to be only used by the #define __my_cpu_offset but I don't know if anything
>> will break further, especially if this __my_cpu_offset is used anywhere
>> without this paca definition.
>
> I tried this and it fixed 5.8 for me with your config above. I'm appending
> a patch that does just this. I didn't test other configs as I don't know
> which ones to test though. If it fixes the problem for you, maybe it can
> be picked by the PPC maintainers.
>
> Willy
> From bcd64a7d0f3445c9a75d3b4dc4837d2ce61660c9 Mon Sep 17 00:00:00 2001
> From: Willy Tarreau <w@1wt.eu>
> Date: Mon, 3 Aug 2020 05:27:57 +0200
> Subject: powerpc: fix circular dependency in percpu.h
>
> After random.h started to include percpu.h (commit f227e3e), several
> archs broke in circular dependencies around percpu.h.
>
> In https://lore.kernel.org/lkml/20200802204842.36bca162@canb.auug.org.au/
> Stephen Rothwell reported breakage for powerpc with CONFIG_PPC_FSL_BOOK3E.
>
> It turns out that asm/percpu.h includes asm/paca.h, which itself
> includes mmu.h, which includes percpu.h when CONFIG_PPC_FSL_BOOK3E=y.
>
> Percpu seems to include asm/paca.h only for local_paca which is used in
> the __my_cpu_offset macro. Removing this include solves the issue for
> this config.
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: f227e3e ("random32: update the net random state on interrupt and activity")
> Link: https://lore.kernel.org/lkml/20200802204842.36bca162@canb.auug.org.au/
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> ---
>  arch/powerpc/include/asm/percpu.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/percpu.h b/arch/powerpc/include/asm/percpu.h
> index dce863a..cd3f6e5 100644
> --- a/arch/powerpc/include/asm/percpu.h
> +++ b/arch/powerpc/include/asm/percpu.h
> @@ -10,8 +10,6 @@
>  
>  #ifdef CONFIG_SMP
>  
> -#include <asm/paca.h>
> -
>  #define __my_cpu_offset local_paca->data_offset
>  
>  #endif /* CONFIG_SMP */

If we just move the include of asm/paca.h below asm-generic/percpu.h
then it avoids the bad circular dependency and we still have paca.h
included from percpu.h as before.

eg:

diff --git a/arch/powerpc/include/asm/percpu.h b/arch/powerpc/include/asm/percpu.h
index dce863a7635c..8e5b7d0b851c 100644
--- a/arch/powerpc/include/asm/percpu.h
+++ b/arch/powerpc/include/asm/percpu.h
@@ -10,8 +10,6 @@
 
 #ifdef CONFIG_SMP
 
-#include <asm/paca.h>
-
 #define __my_cpu_offset local_paca->data_offset
 
 #endif /* CONFIG_SMP */
@@ -19,4 +17,6 @@
 
 #include <asm-generic/percpu.h>
 
+#include <asm/paca.h>
+
 #endif /* _ASM_POWERPC_PERCPU_H_ */


So I think I'm inclined to merge that as a minimal fix that's easy to
backport.

cheers
