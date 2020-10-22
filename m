Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB1929644E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 19:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901382AbgJVR6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 13:58:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438961AbgJVR6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 13:58:47 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0172A21531
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 17:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603389526;
        bh=ywOGmxPuLS0e0wyJ5+K6QqU2bybNk5omgI2eYJyD/+A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nR8ollAQUWUkg8Rpm+sF/Koo66ZqTTaofITwrVXnohIxgfubnivJQfqeSV1+D1KOk
         /7qDjHwDX9dZwxGSEoRrWtaaAKhIhLPtCiD8TcPOPUNEXZrNSgp7P85rY7PXGmR+Id
         DlAq/zpE4e89e8DcG6tTX0OeP1D84FR24980xpGw=
Received: by mail-wr1-f54.google.com with SMTP id n18so3649121wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 10:58:45 -0700 (PDT)
X-Gm-Message-State: AOAM533yfmxT7wqVtWUxl4FTcGlrdhWJ13RAs0YnyXnLGyJkylp4um8L
        Xa3ov32lIGsRhGRf44HjOJ5b/2yy6ErMj3D1cYePxA==
X-Google-Smtp-Source: ABdhPJzrCmXNZ2VDGmeuIoGfdTMaVVraAE9SnrV9Dl0ZS9+4UPixDgQaA98Afr0UjLZYZtlRHv1bCVvIA5V+3VAaxGA=
X-Received: by 2002:adf:ff86:: with SMTP id j6mr3945145wrr.184.1603389524453;
 Thu, 22 Oct 2020 10:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201020120232.GD11583@zn.tnic> <20201020232700.5510c236d810b7f8a66779e2@kernel.org>
 <20201020143746.GG11583@zn.tnic> <20201021095013.d82637f84af564ae4363189d@kernel.org>
 <20201021092750.GA4050@zn.tnic> <20201021232613.e40c1daef4b567e0e29044a4@kernel.org>
 <20201021164558.GB4050@zn.tnic> <20201022163100.1139b28220da4eafb5e70fcc@kernel.org>
 <20201022093044.GA29222@zn.tnic> <20201022222140.f46e6db1243e05fdd049b504@kernel.org>
In-Reply-To: <20201022222140.f46e6db1243e05fdd049b504@kernel.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 22 Oct 2020 10:58:32 -0700
X-Gmail-Original-Message-ID: <CALCETrWhzzZ=EAoKZ4=k3FjffvS_3R4o5N1Rkj9FkHQdiUag6A@mail.gmail.com>
Message-ID: <CALCETrWhzzZ=EAoKZ4=k3FjffvS_3R4o5N1Rkj9FkHQdiUag6A@mail.gmail.com>
Subject: Re: [RFC] Have insn decoder functions return success/failure
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, x86-ml <x86@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 6:21 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Thu, 22 Oct 2020 11:30:44 +0200
> Borislav Petkov <bp@alien8.de> wrote:
>
> > On Thu, Oct 22, 2020 at 04:31:00PM +0900, Masami Hiramatsu wrote:
> > > No, insn_get_length() implies it decodes whole of the instruction.
> > > (yeah, we need an alias of that, something like insn_get_complete())
> >
> > That's exactly what I'm trying to point out: the whole API is not
> > entirely wrong - it just needs a better naming and documentation. Now,
> > the implication that getting the length of the insn will give you a full
> > decode is a totally internal detail which users don't need and have to
> > know.
>
> Ok, what names would you like to suggest? insn_get_complete()?
>
> > > I need insn.length too. Of course we can split it into 2 calls. But
> > > as I said, since the insn_get_length() implies it decodes all other
> > > parts, I just called it once.
> >
> > Yes, I have noticed that and wrote about it further on. The intent was
> > to show that the API needs work.
> >
> > > Hm, it is better to call insn_get_immediate() if it doesn't use length later.
> >
> > Ok, so you see the problem. This thing wants to decode the whole insn -
> > that's what the function is called. But it reads like it does something
> > else.
> >
> > > Would you mean we'd better have something like insn_get_until_immediate() ?
> > >
> > > Since the x86 instruction is CISC, we can not decode intermediate
> > > parts. The APIs follows that. If you are confused, I'm sorry about that.
> >
> > No, I'm not confused - again, I'd like for the API to be properly
> > defined and callers should not have to care which parts of the insn they
> > need to decode in order to get something else they actually need.
>
> Sorry, I can not get what you point. We already have those APIs,
>
> extern void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64);
> extern void insn_get_prefixes(struct insn *insn);
> extern void insn_get_opcode(struct insn *insn);
> extern void insn_get_modrm(struct insn *insn);
> extern void insn_get_sib(struct insn *insn);
> extern void insn_get_displacement(struct insn *insn);
> extern void insn_get_immediate(struct insn *insn);
> extern void insn_get_length(struct insn *insn);
>
> As I agreed, that we may need an alias of insn_get_length(). But it seems
> clear to me, if you need insn.immediate, you must call insn_get_immediate().

I'm guessing that the confusion here is that the kernel instruction
decoder was originally designed to be used to decode kernel
instructions, which are generally trusted to be valid, but that it's
starting to be used to decode user code and such as well.

Masami, could we perhaps have an extra API like:

extern int insn_decode_fully(struct insn *insn);

that decodes the *entire* instruction, returns success if the decoder
thinks the instruction is valid, and returns an error if the decoder
thinks it's invalid?  We would use this when decoding arbitrary bytes
when we're not really sure that there's a valid instruction there.
For user code emulation, we don't really care much about performance
-- the overhead of getting #GP in the first place is much, much higher
than the overhead of decoding more of the instruction than needed.

Ideally we would solve another little problem at the same time.  Right
now, we are quite sloppy about how we fetch the instruction bytes, and
it might be nice to fix this.  It would be nice if we could have a
special error code saying "more bytes are needed".  So
insn_decode_fully() would return 0 (or the length) on a successful
decode, -EINVAL if the bytes are not a valid instruction, and -EAGAIN
(or something more appropriate) if the bytes are a valid *prefix* of
an instruction but more bytes are needed.  Then the caller would do:

len = min(15, remaining bytes in page);
fetch len bytes;
insn_init();
ret = insn_decode_fully();
if (ret == -EAGAIN) {
  fetch remaining 15 - len bytes;
  insn_init();
  ret = insn_decode_fully();
}

It's a bit impolite to potentially cause page faults on the page after
a short instruction, but it's also not so good to fail to decode a
long instruction that happens to cross a page boundary.

--Andy
