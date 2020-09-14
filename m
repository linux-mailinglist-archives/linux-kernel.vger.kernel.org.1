Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBAC268B71
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 14:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgINMuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 08:50:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:58000 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgINMq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:46:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 586A5AC79;
        Mon, 14 Sep 2020 12:46:30 +0000 (UTC)
Date:   Mon, 14 Sep 2020 14:46:12 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/traps: fix recoverability of machine check
 handling on book3s/32
Message-ID: <20200914124612.GC29778@kitsune.suse.cz>
References: <1c804764d38fb084b420b12ca13e8c1b2dea075e.1548166189.git.christophe.leroy@c-s.fr>
 <20200911091542.GE29521@kitsune.suse.cz>
 <87pn6sqweq.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pn6sqweq.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 11:23:57PM +1000, Michael Ellerman wrote:
> Michal Suchánek <msuchanek@suse.de> writes:
> > Hello,
> >
> > does this logic apply to "Unrecoverable System Reset" as well?
> 
> Which logic do you mean?
> 
> We do call die() before checking MSR_RI in system_reset_exception():
> 
>   	/*
>   	 * No debugger or crash dump registered, print logs then
>   	 * panic.
>   	 */
>   	die("System Reset", regs, SIGABRT);
>   
>   	mdelay(2*MSEC_PER_SEC); /* Wait a little while for others to print */
>   	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
>   	nmi_panic(regs, "System Reset");
>   
>   out:
>   #ifdef CONFIG_PPC_BOOK3S_64
>   	BUG_ON(get_paca()->in_nmi == 0);
>   	if (get_paca()->in_nmi > 1)
>   		die("Unrecoverable nested System Reset", regs, SIGABRT);
>   #endif
>   	/* Must die if the interrupt is not recoverable */
>   	if (!(regs->msr & MSR_RI))
>   		die("Unrecoverable System Reset", regs, SIGABRT);
> 
> 
> So you should see the output from die("System Reset", ...) even if
> MSR[RI] was clear when you took the system reset.

Indeed, replied to the wrong patch. I was looking at daf00ae71dad
("powerpc/traps: restore recoverability of machine_check interrupts")
which has very similar commit message.

Sorry about the confusion.

Thanks

Michal

> 
> cheers
> 
> > On Tue, Jan 22, 2019 at 02:11:24PM +0000, Christophe Leroy wrote:
> >> Looks like book3s/32 doesn't set RI on machine check, so
> >> checking RI before calling die() will always be fatal
> >> allthought this is not an issue in most cases.
> >> 
> >> Fixes: b96672dd840f ("powerpc: Machine check interrupt is a non-maskable interrupt")
> >> Fixes: daf00ae71dad ("powerpc/traps: restore recoverability of machine_check interrupts")
> >> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >> Cc: stable@vger.kernel.org
> >> ---
> >>  arch/powerpc/kernel/traps.c | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> >> index 64936b60d521..c740f8bfccc9 100644
> >> --- a/arch/powerpc/kernel/traps.c
> >> +++ b/arch/powerpc/kernel/traps.c
> >> @@ -763,15 +763,15 @@ void machine_check_exception(struct pt_regs *regs)
> >>  	if (check_io_access(regs))
> >>  		goto bail;
> >>  
> >> -	/* Must die if the interrupt is not recoverable */
> >> -	if (!(regs->msr & MSR_RI))
> >> -		nmi_panic(regs, "Unrecoverable Machine check");
> >> -
> >>  	if (!nested)
> >>  		nmi_exit();
> >>  
> >>  	die("Machine check", regs, SIGBUS);
> >>  
> >> +	/* Must die if the interrupt is not recoverable */
> >> +	if (!(regs->msr & MSR_RI))
> >> +		nmi_panic(regs, "Unrecoverable Machine check");
> >> +
> >>  	return;
> >>  
> >>  bail:
> >> -- 
> >> 2.13.3
> >> 
