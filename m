Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3332623A3EF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 14:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgHCMSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 08:18:03 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:39343 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbgHCMSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:18:00 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 073CHdmK015921;
        Mon, 3 Aug 2020 14:17:39 +0200
Date:   Mon, 3 Aug 2020 14:17:39 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: powerpc: build failures in Linus' tree
Message-ID: <20200803121739.GA15918@1wt.eu>
References: <20200802204842.36bca162@canb.auug.org.au>
 <20200802172019.GB26677@1wt.eu>
 <20200803034547.GA15501@1wt.eu>
 <87v9i0yo47.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9i0yo47.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 09:18:00PM +1000, Michael Ellerman wrote:
> If we just move the include of asm/paca.h below asm-generic/percpu.h
> then it avoids the bad circular dependency and we still have paca.h
> included from percpu.h as before.
> 
> eg:
> 
> diff --git a/arch/powerpc/include/asm/percpu.h b/arch/powerpc/include/asm/percpu.h
> index dce863a7635c..8e5b7d0b851c 100644
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
> @@ -19,4 +17,6 @@
>  
>  #include <asm-generic/percpu.h>
>  
> +#include <asm/paca.h>
> +
>  #endif /* _ASM_POWERPC_PERCPU_H_ */
> 
> 
> So I think I'm inclined to merge that as a minimal fix that's easy to
> backport.

This totally makes sense indeed!
Willy
