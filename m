Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F010E2C4CB7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 02:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732179AbgKZBhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 20:37:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:43070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731670AbgKZBhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 20:37:14 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69810206F7;
        Thu, 26 Nov 2020 01:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606354633;
        bh=1bzCsK3pUzVc5uoXaRp/Kcz+Q0YOjQKCfDGGKmnLL1g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aCIpiywZTW6wg1TYBBSt9KJ+2f8AdcUtAyXcE/81j+oHCHd9Urtu4iGEtlkxfqjfs
         YjG9fBx87mxHLq15a2uPu1LZWAD16zvSeXEGZcjUTmoJcZRoaYaS0lf83+iT+C6KZJ
         heUPIlV+PbVmVx8q0olklVsNTbO/5QHNMwdYLnzw=
Date:   Thu, 26 Nov 2020 10:37:09 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@amacapital.net>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v0 03/19] x86/insn: Add an insn_decode() API
Message-Id: <20201126103709.23d581fe2320f14a272a7dc5@kernel.org>
In-Reply-To: <20201125192553.GD9996@zn.tnic>
References: <20201124101952.7909-1-bp@alien8.de>
        <20201124101952.7909-4-bp@alien8.de>
        <20201126015333.fb0fb2b548013073ce72f19f@kernel.org>
        <20201125192553.GD9996@zn.tnic>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Nov 2020 20:25:53 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Thu, Nov 26, 2020 at 01:53:33AM +0900, Masami Hiramatsu wrote:
> > (only from the viewpoint of VEX coding, a bit stricter, but not perfect.)
> 
> Yeah, I wanted to document the fact that it has changed behavior in the
> commit message - we'll make it perfect later. :-)

It is just a note :) and no need to update the document.

BTW, the instruction validation depends on who needs it, because to
check the all invalid ops, we need more information in the x86-opcode-map.txt
and it will bloat up the table size and consumes more time to analysis.
(Moreover, it depends on the processor generation -- older processor will
not support VEX prefix, those are invalid)
If we can expect that the target instruction is kernel text which compiler
outputs, we may not need such instruction validation.
> 
> > > @@ -98,8 +101,12 @@ static void insn_get_emulate_prefix(struct insn *insn)
> > >   * Populates the @insn->prefixes bitmap, and updates @insn->next_byte
> > >   * to point to the (first) opcode.  No effect if @insn->prefixes.got
> > >   * is already set.
> > > + *
> > > + * * Returns:
> > > + * 0:  on success
> > > + * !0: on error
> > >   */
> > 
> > So this is different from...
> > 
> > [..]
> > > +
> > > +/**
> > > + * insn_decode() - Decode an x86 instruction
> > > + * @insn:	&struct insn to be initialized
> > > + * @kaddr:	address (in kernel memory) of instruction (or copy thereof)
> > > + * @buf_len:	length of the insn buffer at @kaddr
> > > + * @m:		insn mode, see enum insn_mode
> > > + *
> > > + * Returns:
> > > + * 0: if decoding succeeded
> > > + * < 0: otherwise.
> > 
> > this return value.
> > 
> > Even for the insn_get_*(), I would like to see them returning -EINVAL
> > as same as insn_decode(). Same API group has different return value is
> > confusing.
> 
> Right, my goal in the end here is to make *all* users of the decoder
> call insn_decode() and nothing else. And there you can have different
> return values so checking negative/positive is the proper way to go.
> 
> Those other helpers, though, should then become internal and for those I
> think it is easier to use them when they return a boolean yes/no value,
> meaning, they do one thing and one thing only:
> 
> For example, it is more readable to do:
> 
> 	if (insn_...)
> 
> vs
> 
> 	int ret;
> 
> 	...
> 
> 	ret = insn_,...()
> 	if (ret)
> 		...
> 
> which is 4 more lines of error handling and return variable, leading to
> more code.

OK, then could you use -1 instead of 1? It may allow us to expand it
to return error code in the future.

> 
> But if you want to be able to use those other helpers outside of the
> decoder - for whatever reason - then sure, the function signatures
> should be the same.

I think insn_get_prefixes() can be used independently, because x86
perfix bytes is very complex. (I found kprobes is using its insn_attribute
directly, but that is not good. I'll fix it)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
