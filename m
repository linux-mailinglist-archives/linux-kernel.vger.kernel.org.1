Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915C32CE468
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 01:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbgLDAT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 19:19:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:35118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbgLDAT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 19:19:28 -0500
Date:   Fri, 4 Dec 2020 09:18:42 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607041127;
        bh=K73zKPDR/PIfxQGypE9LCnYmbiU58cXGrjGP4ooyVMc=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=ii92ksj1RY3nJZzbzc8+oeJRuOpsMCSkreKo/ZKm54ciztgCLJcaywHa3Uy6opI6A
         BkzhmQ8T+RRXusWprn/UWQpIkrYPjisUyf+PVhEQYAHQulFozqldyjHm7hmewm1exD
         loGhVFr/2/dskyfDAnyufsU+linFQayx0HBdbWeWw0h6w9eWzDvKjvO3T83V2sZB/R
         JocxiCzZR2P/8vyP652M9cc8Kwp7G/3kV1YICQe8WFAOyyylzbCPMo/kJeHApLTw9M
         hHfzYIsWvzFP0ecOyvGOkPWomHr9wVNeN5DqkvGXIlpHKEyzP8IkBFzBLeRExhXMq4
         omSlEBFhhNnZg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Jann Horn <jannh@google.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] x86/uprobes: Fix not using prefixes.nbytes for
 loop over prefixes.bytes
Message-Id: <20201204091842.456286ad9b09ad0cd865670b@kernel.org>
In-Reply-To: <20201203123757.GH3059@zn.tnic>
References: <160697102582.3146288.10127018634865687932.stgit@devnote2>
        <160697103739.3146288.7437620795200799020.stgit@devnote2>
        <20201203123757.GH3059@zn.tnic>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Dec 2020 13:37:57 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Thu, Dec 03, 2020 at 01:50:37PM +0900, Masami Hiramatsu wrote:
> > Since the insn.prefixes.nbytes can be bigger than the size of
> > insn.prefixes.bytes[] when a same prefix is repeated, we have to
> > check whether the insn.prefixes.bytes[i] != 0 and i < 4 instead
> > of insn.prefixes.nbytes.
> > This introduces for_each_insn_prefix() macro for this purpose.
> > 
> > Fixes: 2b1444983508 ("uprobes, mm, x86: Add the ability to install and remove uprobes breakpoints")
> > Reported-by: syzbot+9b64b619f10f19d19a7c@syzkaller.appspotmail.com
> > Debugged-by: Kees Cook <keescook@chromium.org>
> > Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: stable@vger.kernel.org
> > ---
> >  Changes in v2:
> >   - Add for_each_insn_prefix() macro and fix to check index first.
> > ---
> >  arch/x86/include/asm/insn.h |   15 +++++++++++++++
> >  arch/x86/kernel/uprobes.c   |   10 ++++++----
> >  2 files changed, 21 insertions(+), 4 deletions(-)
> 
> Warning: Kernel ABI header at 'tools/arch/x86/include/asm/insn.h' differs from latest version at 'arch/x86/include/asm/insn.h'

Oops.

> 
> > diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
> > index 5c1ae3eff9d4..e6b38ebd3a1c 100644
> > --- a/arch/x86/include/asm/insn.h
> > +++ b/arch/x86/include/asm/insn.h
> > @@ -201,6 +201,21 @@ static inline int insn_offset_immediate(struct insn *insn)
> >  	return insn_offset_displacement(insn) + insn->displacement.nbytes;
> >  }
> >  
> > +/**
> > + * for_each_insn_prefix() -- Iterate prefixes in the instruction
> > + * @insn: Pointer to struct insn.
> > + * @idx:  Index storage.
> > + * @prefix: Prefix byte.
> > + *
> > + * Iterate prefix bytes of given @insn. Each prefix byte is stored in @prefix
> > + * and the index is stored in @idx (note that this @idx is just for a cursor,
> > + * do not change it.)
> > + * Since prefixes.nbytes can be bigger than 4 if some prefixes are repeated,
> > + * we can not use it for looping over the prefixes.
> 
> Please use passive voice: no "we" or "I", etc,

OK.

> 
> > + */
> > +#define for_each_insn_prefix(insn, idx, prefix)	\
> > +	for (idx = 0; idx < 4 && (prefix = insn->prefixes.bytes[idx]) != 0; idx++)
> 
> Btw, looking at the struct insn definition, that prefixes member should
> have a comment above it that those are the legacy prefixes which can be
> <= 4. But that's minor.
> 
> In any case, I'll fix up the minor issues now but pls remember to do
> them in the future.

OK, I will add a macro with comment for it.

Thank you,

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette


-- 
Masami Hiramatsu <mhiramat@kernel.org>
