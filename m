Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FC22C8ACA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbgK3RW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:22:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:40292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728162AbgK3RW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:22:29 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FCB32076E;
        Mon, 30 Nov 2020 17:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606756908;
        bh=QNg0HIqrl2SacuY5OJOkhMYSmUV1XLVccyq57deq/Ac=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ht/C38nCF6UF6Gc3zw2DUABciLcDajHefjDTRDbpmOs6yE6RV1DzqI6H/075J+gO1
         rwWwFryGL6Xsn7HbZ/fRm8AOOrDh8w6a55wy7uUbVy9pxE/ED+Uayb1bP6M+FDLqhR
         m1zAGaJYFgFStT5kXgDNtB8ffwf/MqFSftaC9kjI=
Date:   Tue, 1 Dec 2020 02:21:45 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@amacapital.net>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v0 00/19] x86/insn: Add an insn_decode() API
Message-Id: <20201201022145.48201fe165a28cb0e1f042ae@kernel.org>
In-Reply-To: <20201130134442.GB6019@zn.tnic>
References: <20201124101952.7909-1-bp@alien8.de>
        <20201124174647.GI4009@zn.tnic>
        <CALCETrXXuUmM6LPj36h2KLw5zuKUPnmrACcOq2-8XfXzWXQt7Q@mail.gmail.com>
        <20201129175005.7e07a9f799e888ffd5f4ed67@kernel.org>
        <20201130134442.GB6019@zn.tnic>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020 14:44:42 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Sun, Nov 29, 2020 at 05:50:05PM +0900, Masami Hiramatsu wrote:
> > Good point. I think we can return, e.g. -EFAULT if we failed in
> > get_next(). Then, we can read out next page, for example.
> 
> Why -EFAULT?

Because it overruns the buffer. Maybe -E2BIG/ENODATA or any other
error (except for -EINVAL) is OK :)
 
> Running this
> 
>         size = 1;
>         ret = insn_decode(&insn, b, size, INSN_MODE_64)
> 
> i.e., buffer size is 1:
> 
> ./arch/x86/tools/insn_sanity: Success: decoded and checked 10000 random instructions with 0 errors (seed:0x9994a137)
> insn buffer:
> 0x48 0xcf 0x48 0x83 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 
> supplied buf size: 15, ret 0
> supplied buf size: 2, ret 0
> supplied buf size: 3, ret 0
> supplied buf size: 4, ret 0
> insn_decode: entry
> insn_decode: will get_length
> insn_get_immediate: getting immediate
> insn_get_displacement: getting displacement
> insn_get_sib: getting sib
> insn_get_modrm: entry
> insn_get_opcode: entry
> insn_get_prefixes: entry, prefixes->got: 0
> insn_get_prefixes: 1
> insn_get_prefixes: REX
> insn_get_prefixes: VEX
> insn_get_prefixes: validate_next: 0
> insn_get_prefixes: insn->next_byte: 0x7ffec297c3e1, insn->end_kaddr: 0x7ffec297c3e1
> insn_get_prefixes: errored out
> supplied buf size: 1, ret -22
> 
> is caught in validate_next() where ->next_byte == ->end_kaddr.
> 
> I'm thinking we should return EOF here, to denote that we're reached the
> end and then propagate that error up the callchain.

EOF means the end of file and it is not an error. Here, since the
decoder fails to decode the data, so it should return an error code.

> 
> We don't have "define EOF" in the kernel but we can designate one for
> the insn decoder, perhaps
> 
> #define EOF      -1
> 
> as stdio.h does:
> 
> /* The value returned by fgetc and similar functions to indicate the
>    end of the file.  */
> #define EOF (-1)

It is because libc fgetc() returns -1 in any error case...

> 
> Hmm, but then the callers would need to know EOF too so maybe EIO or
> something.
> 
> In any case, it should be a value which callers should be able to use to
> get told that input buffer is truncated...

Yes!

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
