Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07222297B34
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 09:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759840AbgJXHVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 03:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759767AbgJXHVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 03:21:08 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E17DC2177B;
        Sat, 24 Oct 2020 07:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603524068;
        bh=cIZwiJaaEyi2GGX/jsGX9WoEK4jndq/S7aU9PT3nqyw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zAyVQkJlxWKemdYBsyfCapCZRAgZUD34uD8FU1D0iRIf/YzkpXTMCs5/5dOwn/r7n
         EZvgT1aHC+eR/M5ZzSGS54Uv2X7dfltiF1+Xx+YCxd5v/HqDaDrJbPHwo4p4hf5tY9
         O1D0XloGuwZKomdq9dF60OG3+fR45pWbBICS5JOA=
Date:   Sat, 24 Oct 2020 16:21:03 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        x86-ml <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Have insn decoder functions return success/failure
Message-Id: <20201024162103.a479e06af9bbc6c83ffea1a7@kernel.org>
In-Reply-To: <CALCETrVQDVLPwTTXgsRYSjxVmzeK5ekmrEiT2rWkQKO0inRLGQ@mail.gmail.com>
References: <20201021092750.GA4050@zn.tnic>
        <20201021232613.e40c1daef4b567e0e29044a4@kernel.org>
        <20201021164558.GB4050@zn.tnic>
        <20201022163100.1139b28220da4eafb5e70fcc@kernel.org>
        <20201022093044.GA29222@zn.tnic>
        <20201022222140.f46e6db1243e05fdd049b504@kernel.org>
        <CALCETrWhzzZ=EAoKZ4=k3FjffvS_3R4o5N1Rkj9FkHQdiUag6A@mail.gmail.com>
        <20201023182850.c54ac863159fb312c411c029@kernel.org>
        <20201023093254.GC23324@zn.tnic>
        <20201023194704.f723c86e5f8dfc1133dd5930@kernel.org>
        <20201023232741.GF23324@zn.tnic>
        <CALCETrVQDVLPwTTXgsRYSjxVmzeK5ekmrEiT2rWkQKO0inRLGQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Oct 2020 17:12:49 -0700
Andy Lutomirski <luto@kernel.org> wrote:

> On Fri, Oct 23, 2020 at 4:27 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Fri, Oct 23, 2020 at 07:47:04PM +0900, Masami Hiramatsu wrote:
> > > Thanks! I look forward to it.
> >
> > Ok, here's a first stab, it is a single big diff and totally untested
> > but it should show what I mean. I've made some notes while converting,
> > as I went along.
> >
> > Have a look at insn_decode() and its call sites: they are almost trivial
> > now because caller needs simply to do:
> >
> >         if (insn_decode(insn, buffer, ...))
> >
> > and not care about any helper functions.
> >
> > For some of the call sites it still makes sense to do a piecemeal insn
> > decoding and I've left them this way but they can be converted too, if
> > one wants.
> >
> > In any case, just have a look please and lemme know if that looks OKish.
> > I'll do the actual splitting and testing afterwards.
> >
> > And what Andy wants can't be done with the decoder because it already
> > gets a fixed size buffer and length - it doesn't do the fetching. The
> > caller does.
> >
> > What you wanna do:
> >
> > > len = min(15, remaining bytes in page);
> > > fetch len bytes;
> > > insn_init();
> > > ret = insn_decode_fully();
> >
> > <--- you can't always know here whether the insn is valid if you don't
> > have all the bytes. But you can always fetch *all* bytes and then give
> > it to the decoder for checking.
> >
> > Also, this doesn't make any sense: try insn decode on a subset of bytes
> > and then if it fails, try it on the whole set of bytes. Why even try the
> > subset - it will almost always fail.
> 
> I disagree.  A real CPU does exactly what I'm describing.  If I stick
> 0xcc at the end of a page and a make the next page not-present, I get
> #BP, not #PF.  But if I stick 0x0F at the end of a page and mark the
> next page not-present, I get #PF.  If we're trying to decode an
> instruction in user memory, we can kludge it by trying to fetch 15
> bytes and handling -EFAULT by fetching fewer bytes, but that's gross
> and doesn't really have the right semantics.  What we actually want is
> to fetch up to the page boundary and try to decode it.  If it's a
> valid instruction or if it's definitely invalid, we're done.
> Otherwise we fetch across the page boundary.
> 
> Eventually we should wrap this whole mess up in an insn_decode_user()
> helper that does the right thing.  And we can then make that helper
> extra fancy by getting PKRU and EPT-hacker-execute-only right, whereas
> we currently get these cases wrong.

+1. To handle the user-space (untrusted) instruction, we need to
take more care about page boundary and presense. Also less side-effect
is perferrable.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
