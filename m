Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F022A4C7B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 18:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgKCRPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 12:15:50 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53632 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727530AbgKCRPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 12:15:49 -0500
Received: from zn.tnic (p200300ec2f10e0004a3cb1c0cad06673.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:e000:4a3c:b1c0:cad0:6673])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8B3FA1EC0411;
        Tue,  3 Nov 2020 18:15:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604423748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Fmf6Ny076jDFd4MQFVI4PCaeNMj60lAQwuiEcjY486Y=;
        b=QmI5wEl5ZAsH8Kk7+v/790cTQP+ohy+nSBbjHtf8Ltxifg0X/D+cTx9SnSFt8SHYT6eqG8
        il7L/D6/05N45qa1cgrtSWbMFk+KnGb5SqoFw6OcHoJFRNx07mTgT8vPN51Gjd/swzp65O
        JiDUaIzJVMxobEbnqiIAJeozCrQuTHg=
Date:   Tue, 3 Nov 2020 18:15:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Mark Mossberg <mark.mossberg@gmail.com>, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, jannh@google.com, kyin@redhat.com
Subject: Re: [PATCH v2] x86/dumpstack: Fix misleading instruction pointer
 error message
Message-ID: <20201103171537.GC4111@zn.tnic>
References: <20201002042915.403558-1-mark.mossberg@gmail.com>
 <20201103125034.GA30391@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201103125034.GA30391@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 01:50:34PM +0100, Oleg Nesterov wrote:
> Another problem is that show_opcodes() makes no sense if user_mode(regs)
> and tsk is not current.

Because if not current, we would access *some* user address space but
not the one to which regs belong to?

> Try "echo t > /proc/sysrq-trigger".

What am I looking for?

I see a bunch of:

[   37.622896] Code: Unable to access opcode bytes at RIP <user address>

and three Code: lines with opcode bytes, as expected:

[   37.148693] Code: 11 0d 00 48 89 c6 4c 89 ef e8 98 07 00 00 48 83 f8 ff 0f 84 3e 02 00 00 48 3b 05 b7 28 0d 00 48 89 c3 0f 83 b5 00 00 00 48 8b <0d> e7 10 0d 00 48 83 f8 0d 76 13 48 b8 28 75 6e 72 65 61 63 68 48

So all those other but the three cases, copy_code() failed.

> In this case copy_from_user_nmi() will either fail, or (worse) it will
> read the "random" memory from current->mm.
> 
> Perhaps we can add something like
> 
> 	if (user_mode(regs) && regs != task_pt_regs(current))
> 		return;
> 
> at the start of show_opcodes() ?

tglx made it use copy_from_user_nmi() in:

d181d2da0141 ("x86/dumpstack: Dump user space code correctly again")

I'm thinking this should not use the atomic variant if it can get called
in !atomic context too.

Thomas?

Leaving in the rest for reference.

> > --- a/arch/x86/kernel/dumpstack.c
> > +++ b/arch/x86/kernel/dumpstack.c
> > @@ -115,7 +115,8 @@ void show_opcodes(struct pt_regs *regs, const char *loglvl)
> >  	unsigned long prologue = regs->ip - PROLOGUE_SIZE;
> >  
> >  	if (copy_code(regs, opcodes, prologue, sizeof(opcodes))) {
> > -		printk("%sCode: Bad RIP value.\n", loglvl);
> > +		printk("%sCode: Unable to access opcode bytes at RIP 0x%lx.\n",
> > +		       loglvl, prologue);
> >  	} else {
> >  		printk("%sCode: %" __stringify(PROLOGUE_SIZE) "ph <%02x> %"
> >  		       __stringify(EPILOGUE_SIZE) "ph\n", loglvl, opcodes,
> > -- 
> > 2.25.1

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
