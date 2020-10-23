Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23661296C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461484AbgJWJ2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:28:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S461366AbgJWJ2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:28:54 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 522802225F;
        Fri, 23 Oct 2020 09:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603445333;
        bh=yqIXDcdSAKSqtoFlL1UJ+mUqY+ne1RvOd2G7OXO+hGE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Cag2/wVFgOvpDeITUYgRJwrmTmLriAosxqPhV/ysCQItDFHJ3w7bMdgxlvrixR5Sf
         MsKUYRbD1X4nuTJYKF4Z9DYEqVArENgAaBYvdC+3V1jEQnoJnTlRxPpyNUFchUqVB0
         KRMVyVTq3Cz2gxJe5s72NU01slHeROFOVMNWdc8Y=
Date:   Fri, 23 Oct 2020 18:28:50 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, x86-ml <x86@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Have insn decoder functions return success/failure
Message-Id: <20201023182850.c54ac863159fb312c411c029@kernel.org>
In-Reply-To: <CALCETrWhzzZ=EAoKZ4=k3FjffvS_3R4o5N1Rkj9FkHQdiUag6A@mail.gmail.com>
References: <20201020120232.GD11583@zn.tnic>
        <20201020232700.5510c236d810b7f8a66779e2@kernel.org>
        <20201020143746.GG11583@zn.tnic>
        <20201021095013.d82637f84af564ae4363189d@kernel.org>
        <20201021092750.GA4050@zn.tnic>
        <20201021232613.e40c1daef4b567e0e29044a4@kernel.org>
        <20201021164558.GB4050@zn.tnic>
        <20201022163100.1139b28220da4eafb5e70fcc@kernel.org>
        <20201022093044.GA29222@zn.tnic>
        <20201022222140.f46e6db1243e05fdd049b504@kernel.org>
        <CALCETrWhzzZ=EAoKZ4=k3FjffvS_3R4o5N1Rkj9FkHQdiUag6A@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Oct 2020 10:58:32 -0700
Andy Lutomirski <luto@kernel.org> wrote:

> On Thu, Oct 22, 2020 at 6:21 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Thu, 22 Oct 2020 11:30:44 +0200
> > Borislav Petkov <bp@alien8.de> wrote:
> >
> > > On Thu, Oct 22, 2020 at 04:31:00PM +0900, Masami Hiramatsu wrote:
> > > > No, insn_get_length() implies it decodes whole of the instruction.
> > > > (yeah, we need an alias of that, something like insn_get_complete())
> > >
> > > That's exactly what I'm trying to point out: the whole API is not
> > > entirely wrong - it just needs a better naming and documentation. Now,
> > > the implication that getting the length of the insn will give you a full
> > > decode is a totally internal detail which users don't need and have to
> > > know.
> >
> > Ok, what names would you like to suggest? insn_get_complete()?
> >
> > > > I need insn.length too. Of course we can split it into 2 calls. But
> > > > as I said, since the insn_get_length() implies it decodes all other
> > > > parts, I just called it once.
> > >
> > > Yes, I have noticed that and wrote about it further on. The intent was
> > > to show that the API needs work.
> > >
> > > > Hm, it is better to call insn_get_immediate() if it doesn't use length later.
> > >
> > > Ok, so you see the problem. This thing wants to decode the whole insn -
> > > that's what the function is called. But it reads like it does something
> > > else.
> > >
> > > > Would you mean we'd better have something like insn_get_until_immediate() ?
> > > >
> > > > Since the x86 instruction is CISC, we can not decode intermediate
> > > > parts. The APIs follows that. If you are confused, I'm sorry about that.
> > >
> > > No, I'm not confused - again, I'd like for the API to be properly
> > > defined and callers should not have to care which parts of the insn they
> > > need to decode in order to get something else they actually need.
> >
> > Sorry, I can not get what you point. We already have those APIs,
> >
> > extern void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64);
> > extern void insn_get_prefixes(struct insn *insn);
> > extern void insn_get_opcode(struct insn *insn);
> > extern void insn_get_modrm(struct insn *insn);
> > extern void insn_get_sib(struct insn *insn);
> > extern void insn_get_displacement(struct insn *insn);
> > extern void insn_get_immediate(struct insn *insn);
> > extern void insn_get_length(struct insn *insn);
> >
> > As I agreed, that we may need an alias of insn_get_length(). But it seems
> > clear to me, if you need insn.immediate, you must call insn_get_immediate().
> 
> I'm guessing that the confusion here is that the kernel instruction
> decoder was originally designed to be used to decode kernel
> instructions, which are generally trusted to be valid, but that it's
> starting to be used to decode user code and such as well.

Hmm, right...

> 
> Masami, could we perhaps have an extra API like:
> 
> extern int insn_decode_fully(struct insn *insn);
> 
> that decodes the *entire* instruction, returns success if the decoder
> thinks the instruction is valid, and returns an error if the decoder
> thinks it's invalid?  We would use this when decoding arbitrary bytes
> when we're not really sure that there's a valid instruction there.
> For user code emulation, we don't really care much about performance
> -- the overhead of getting #GP in the first place is much, much higher
> than the overhead of decoding more of the instruction than needed.

OK, would you think we also better to integrate it with insn_init()?

> Ideally we would solve another little problem at the same time.  Right
> now, we are quite sloppy about how we fetch the instruction bytes, and
> it might be nice to fix this.  It would be nice if we could have a
> special error code saying "more bytes are needed".  So
> insn_decode_fully() would return 0 (or the length) on a successful
> decode, -EINVAL if the bytes are not a valid instruction, and -EAGAIN
> (or something more appropriate)

Maybe -ERANGE?

> if the bytes are a valid *prefix* of
> an instruction but more bytes are needed.  Then the caller would do:
> 
> len = min(15, remaining bytes in page);
> fetch len bytes;
> insn_init();
> ret = insn_decode_fully();
> if (ret == -EAGAIN) {
>   fetch remaining 15 - len bytes;
>   insn_init();
>   ret = insn_decode_fully();
> }
> 
> It's a bit impolite to potentially cause page faults on the page after
> a short instruction, but it's also not so good to fail to decode a
> long instruction that happens to cross a page boundary.

OK.

Borislav, would you handle it? I think you already started.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
