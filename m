Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED59295939
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 09:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508558AbgJVHbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 03:31:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437532AbgJVHbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 03:31:06 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40F8E20848;
        Thu, 22 Oct 2020 07:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603351865;
        bh=7I+PcjTKEQcGGYCICKHT2LTWj9pWa7Y/4OLDorb9ZbU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BRnVw0rtBqN4j0r3C7UfFHA7le9H0oE5px9aGx5xdpfJ0eMqDzErD5w53h3IqPh2i
         /1Rpkpz0GqlkemygICFGE8JgxKdpr0uCCsbkbat/RqKEA5HwnfIA7TZnlY2hbFXpit
         joigz02cSH62FxuNBgAKJnz5mxunkyNdJcUhmR+4=
Date:   Thu, 22 Oct 2020 16:31:00 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Have insn decoder functions return success/failure
Message-Id: <20201022163100.1139b28220da4eafb5e70fcc@kernel.org>
In-Reply-To: <20201021164558.GB4050@zn.tnic>
References: <20201020120232.GD11583@zn.tnic>
        <20201020232700.5510c236d810b7f8a66779e2@kernel.org>
        <20201020143746.GG11583@zn.tnic>
        <20201021095013.d82637f84af564ae4363189d@kernel.org>
        <20201021092750.GA4050@zn.tnic>
        <20201021232613.e40c1daef4b567e0e29044a4@kernel.org>
        <20201021164558.GB4050@zn.tnic>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Oct 2020 18:45:58 +0200
Borislav Petkov <bp@alien8.de> wrote:

> On Wed, Oct 21, 2020 at 11:26:13PM +0900, Masami Hiramatsu wrote:
> > Hmm, I meant someone might think it can be used for filtering the
> > instruction something like,
> > 
> > insn_init(insn, buf, buflen, 1);
> > ret = insn_get_length(insn);
> > if (!ret) {
> > 	/* OK, this is safe */
> > 	patch_text(buf, trampoline);
> > }
> > 
> > No, we need another validator for such usage.
> 
> Well, I think calling insn_get_length() should give you only the
> *length* of the insn and nothing else - I mean that is what the function
> is called. And I believe current use is wrong.
> 
> Examples:
> 
> arch/x86/kernel/kprobes/core.c:
>                 insn_get_length(&insn);
> 
>                 /*
>                  * Another debugging subsystem might insert this breakpoint.
>                  * In that case, we can't recover it.
>                  */
>                 if (insn.opcode.bytes[0] == INT3_INSN_OPCODE)
> 
> So this has called get_length but it is far from clear that after that
> call, the opcode bytes in insn.opcode.bytes are there.

No, insn_get_length() implies it decodes whole of the instruction.
(yeah, we need an alias of that, something like insn_get_complete())

> 
> What that should do instead IMO is this:
> 
> 	insn_get_opcode(&insn);
> 

No, you've cut the last lines of that loop.

                /*
                 * Another debugging subsystem might insert this breakpoint.
                 * In that case, we can't recover it.
                 */
                if (insn.opcode.bytes[0] == INT3_INSN_OPCODE)
                        return 0;
                addr += insn.length;
        }

I need insn.length too. Of course we can split it into 2 calls. But
as I said, since the insn_get_length() implies it decodes all other
parts, I just called it once.

> and *then* the return value can tell you whether the opcode bytes were
> parsed properly or not. See what I mean?

I agreed to check the return value of insn_get_length() at that point
only for checking whether the instruction parsing was failed or not.

> 
> That's even documented that way:
> 
> /**
>  * insn_get_opcode - collect opcode(s)
>  * @insn:       &struct insn containing instruction
>  *
>  * Populates @insn->opcode, updates @insn->next_byte to point past the
>  * opcode byte(s), and set @insn->attr (except for groups).
> 
> 
> Similarly here:
> 
> static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
> 
> 	...
> 
>         insn_get_length(&ctxt->insn);
> 
>         ret = ctxt->insn.immediate.got ? ES_OK : ES_DECODE_FAILED;
> 
> that thing wants to decode the insn but it is looking whether it parsed
> an *immediate*?!

Hm, it is better to call insn_get_immediate() if it doesn't use length later.

> 
> I'm not saying this is necessarily wrong - just the naming nomenclature
> and the API should be properly defined when you call a function of the
> insn decoder, what you are guaranteed to get and what a caller can
> assume after that. And then the proper functions be called.

Would you mean we'd better have something like insn_get_until_immediate() ? 

Since the x86 instruction is CISC, we can not decode intermediate
parts. The APIs follows that. If you are confused, I'm sorry about that.

> 
> In the kprobes/core.c example above, it does a little further:
> 
> 	ddr += insn.length;	
> 
> which, IMO, it should be either preceeded by a call to insn_get_length()
> - yes, this time we want the insn length or, the code should call a
> decoding function which gives you *both* length* and opcode bytes.
> insn_decode_insn() or whatever. And *that* should be documented in that
> function's kernel-doc section. And so on...

Actually, there is a historical reason too. INT3 check was added afterwards.
At first, I just calculated the instruction length in the loop...

Thank you,

> 
> Does that make more sense?
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
