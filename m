Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE4430366D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732753AbhAZGVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:21:52 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:59496 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728826AbhAYN2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:28:06 -0500
X-Greylist: delayed 543 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Jan 2021 08:28:05 EST
Received: from ircbox.informatik.uni-erlangen.de (ircbox.informatik.uni-erlangen.de [IPv6:2001:638:a000:4130:131:188:30:49])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id CA581240B98;
        Mon, 25 Jan 2021 14:17:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cip.cs.fau.de;
        s=dkim2019; t=1611580682;
        bh=kWhg0Wm0Q8NhNaaazbaZnC4s7mUOQuDxgF07Mriyms0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZtIRYaFgmyX7NdAaTcbJyto6J1FwSH/UIsK/FVxPYEM0kjUqnjtB3t1ri9tyPSDoT
         4738EmaMOroh4SAmsIFW+cqkYQV5aa4GU5dPtT+G4Q/PU4jBI7EI2w++rZXSj5mQvQ
         MtysbeGg/3VSMl+T1u30pisblIxkx1W+591qzfJy2/BSIdfs/6IANZlmibxTu9DiF6
         SXShXIzvS031FkHZfuTvgj18DUNGmX1OxIx1YNK3UnoWsCI2qwStC5XYRbnrRl8V3o
         WHBSdQ3bhu2lBZ1DZF3LCiIxXIzxWJQXOPdtiD3glXHK8Ecjiq8mnHqJeiC1b/3Rry
         +qZ5/bf/M3JYw==
Received: by ircbox.informatik.uni-erlangen.de (Postfix, from userid 28847)
        id B9356401063; Mon, 25 Jan 2021 14:17:20 +0100 (CET)
Date:   Mon, 25 Jan 2021 14:17:20 +0100
From:   Lorena Kretzschmar <qy15sije@cip.cs.fau.de>
To:     x86@kernel.org, Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Stefan Saecherl <stefan.saecherl@fau.de>,
        linux-kernel@i4.cs.fau.de, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kgdb: Allow removal of early BPs
Message-ID: <20210125131720.GA31985@stud.informatik.uni-erlangen.de>
References: <20201214141314.5717-1-stefan.saecherl@fau.de>
 <20201218164421.qy5ov2lyhrfi3kr6@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218164421.qy5ov2lyhrfi3kr6@holly.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wanted to ask about the status of the patch. Let us know if there are any
other steps we can undertake.

Kind regards
Lorena

On Fri 2020-12-18 16:44:21, Daniel Thompson wrote:
> Hi Stefan
> 
> On Mon, Dec 14, 2020 at 03:13:12PM +0100, Stefan Saecherl wrote:
> > The problem is that breakpoints that are set early (e.g. via kgdbwait)
> > cannot be deleted after boot completed (to be precise after mark_rodata_ro
> > ran).
> > 
> > When setting a breakpoint early there are executable pages that are
> > writable so the copy_to_kernel_nofault call in kgdb_arch_set_breakpoint
> > succeeds and the breakpoint is saved as type BP_BREAKPOINT.
> > 
> > Later in the boot write access to these pages is restricted. So when
> > removing the breakpoint the copy_to_kernel_nofault call in
> > kgdb_arch_remove_breakpoint is destined to fail and the breakpoint removal
> > fails. So after copy_to_kernel_nofault failed try to text_poke_kgdb which
> > can work around nonwriteability.
> > 
> > One thing to consider when doing this is that code can go away during boot
> > (e.g. .init.text). Previously kgdb_arch_remove_breakpoint handled this case
> > gracefully by just having copy_to_kernel_nofault fail but if one then calls
> > text_poke_kgdb the system dies due to the BUG_ON we moved out of
> > __text_poke.  To avoid this __text_poke now returns an error in case of a
> > nonpresent code page and the error is handled at call site.
> > 
> > Checkpatch complains about two uses of BUG_ON but the new code should not
> > trigger BUG_ON in cases where the old didn't.
> > 
> > Co-developed-by: Lorena Kretzschmar <qy15sije@cip.cs.fau.de>
> > Signed-off-by: Lorena Kretzschmar <qy15sije@cip.cs.fau.de>
> > Signed-off-by: Stefan Saecherl <stefan.saecherl@fau.de>
> 
> I took this to be a gap in the kgdbtest suite so I added a couple of
> tests that cover this area. Before this patch they failed now they
> pass (at least they do for ARCH=x86).
> 
> I don't see any new failures either, so:
> 
> Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> 
> Daniel.
> 
> 
> 
> > ---
> >  arch/x86/kernel/alternative.c | 16 +++++++----
> >  arch/x86/kernel/kgdb.c        | 54 ++++++++++++++++++++++++-----------
> >  2 files changed, 48 insertions(+), 22 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> > index 2400ad62f330..0f145d837885 100644
> > --- a/arch/x86/kernel/alternative.c
> > +++ b/arch/x86/kernel/alternative.c
> > @@ -878,11 +878,9 @@ static void *__text_poke(void *addr, const void *opcode, size_t len)
> >  		if (cross_page_boundary)
> >  			pages[1] = virt_to_page(addr + PAGE_SIZE);
> >  	}
> > -	/*
> > -	 * If something went wrong, crash and burn since recovery paths are not
> > -	 * implemented.
> > -	 */
> > -	BUG_ON(!pages[0] || (cross_page_boundary && !pages[1]));
> > +
> > +	if (!pages[0] || (cross_page_boundary && !pages[1]))
> > +		return ERR_PTR(-EFAULT);
> >  
> >  	/*
> >  	 * Map the page without the global bit, as TLB flushing is done with
> > @@ -976,7 +974,13 @@ void *text_poke(void *addr, const void *opcode, size_t len)
> >  {
> >  	lockdep_assert_held(&text_mutex);
> >  
> > -	return __text_poke(addr, opcode, len);
> > +	addr = __text_poke(addr, opcode, len);
> > +	/*
> > +	 * If something went wrong, crash and burn since recovery paths are not
> > +	 * implemented.
> > +	 */
> > +	BUG_ON(IS_ERR(addr));
> > +	return addr;
> >  }
> >  
> >  /**
> > diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
> > index ff7878df96b4..e98c9c43db7c 100644
> > --- a/arch/x86/kernel/kgdb.c
> > +++ b/arch/x86/kernel/kgdb.c
> > @@ -731,6 +731,7 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long ip)
> >  int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
> >  {
> >  	int err;
> > +	void *addr;
> >  
> >  	bpt->type = BP_BREAKPOINT;
> >  	err = copy_from_kernel_nofault(bpt->saved_instr, (char *)bpt->bpt_addr,
> > @@ -747,8 +748,14 @@ int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
> >  	 */
> >  	if (mutex_is_locked(&text_mutex))
> >  		return -EBUSY;
> > -	text_poke_kgdb((void *)bpt->bpt_addr, arch_kgdb_ops.gdb_bpt_instr,
> > -		       BREAK_INSTR_SIZE);
> > +
> > +	addr = text_poke_kgdb((void *)bpt->bpt_addr, arch_kgdb_ops.gdb_bpt_instr,
> > +				BREAK_INSTR_SIZE);
> > +	/* This should never trigger because the above call to copy_from_kernel_nofault
> > +	 * already succeeded.
> > +	 */
> > +	BUG_ON(IS_ERR(addr));
> > +
> >  	bpt->type = BP_POKE_BREAKPOINT;
> >  
> >  	return 0;
> > @@ -756,21 +763,36 @@ int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
> >  
> >  int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
> >  {
> > -	if (bpt->type != BP_POKE_BREAKPOINT)
> > -		goto knl_write;
> > -	/*
> > -	 * It is safe to call text_poke_kgdb() because normal kernel execution
> > -	 * is stopped on all cores, so long as the text_mutex is not locked.
> > -	 */
> > -	if (mutex_is_locked(&text_mutex))
> > -		goto knl_write;
> > -	text_poke_kgdb((void *)bpt->bpt_addr, bpt->saved_instr,
> > -		       BREAK_INSTR_SIZE);
> > -	return 0;
> > +	void *addr;
> > +	int err;
> >  
> > -knl_write:
> > -	return copy_to_kernel_nofault((char *)bpt->bpt_addr,
> > -				  (char *)bpt->saved_instr, BREAK_INSTR_SIZE);
> > +	if (bpt->type == BP_POKE_BREAKPOINT) {
> > +		if (mutex_is_locked(&text_mutex)) {
> > +			err = copy_to_kernel_nofault((char *)bpt->bpt_addr,
> > +							(char *)bpt->saved_instr,
> > +							BREAK_INSTR_SIZE);
> > +		} else {
> > +			/*
> > +			 * It is safe to call text_poke_kgdb() because normal kernel execution
> > +			 * is stopped on all cores, so long as the text_mutex is not locked.
> > +			 */
> > +			addr = text_poke_kgdb((void *)bpt->bpt_addr,
> > +							bpt->saved_instr,
> > +							BREAK_INSTR_SIZE);
> > +			err = PTR_ERR_OR_ZERO(addr);
> > +		}
> > +	} else {
> > +		err = copy_to_kernel_nofault((char *)bpt->bpt_addr,
> > +						(char *)bpt->saved_instr,
> > +						BREAK_INSTR_SIZE);
> > +		if (err == -EFAULT && !mutex_is_locked(&text_mutex)) {
> > +			addr = text_poke_kgdb((void *)bpt->bpt_addr,
> > +						bpt->saved_instr,
> > +						BREAK_INSTR_SIZE);
> > +			err = PTR_ERR_OR_ZERO(addr);
> > +		}
> > +	}
> > +	return err;
> >  }
> >  
> >  const struct kgdb_arch arch_kgdb_ops = {
> > -- 
> > 2.20.1
