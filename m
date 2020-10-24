Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1B62979DC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 02:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756028AbgJXANE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 20:13:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756013AbgJXAND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 20:13:03 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7139223EA
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 00:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603498383;
        bh=3Sic+5wFvAIsX7gow5/0D1Jg1LI5KglLa6qXaFqF0lg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qH2E+FWRuLgzSgq7rzIVEJ2u4jerkFDQcS/zeQrmqK5RtegUNG/1kzgYPAbgtoWa+
         huT18KsuZ3X3HxX/X5k1/4Ya/kF3hr15RF2+WxL+aGwmd9AERmF+3AaIZteYphA/9j
         QSOK6xN8HAkWIPryFQj1On+kk+zFG2nM7bEgA0cY=
Received: by mail-wm1-f54.google.com with SMTP id d3so4325621wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 17:13:02 -0700 (PDT)
X-Gm-Message-State: AOAM530pdkC2aQ8pcjLXG0zzgwHyzWpubyJHIIUNYChM81wNDtoNWtaL
        CoqzhhXaYAciFbunSeSBflUPxHO/chD7+d1w8Hi4MA==
X-Google-Smtp-Source: ABdhPJxIH/U5FUZelCs0pudEFPG0vdWmPQ1EJjuTOnGovHNyzn1hDGdiRvxzEI6czvOlBM059FrS9cyRYdgEKwiK9XY=
X-Received: by 2002:a7b:c858:: with SMTP id c24mr4596888wml.176.1603498381377;
 Fri, 23 Oct 2020 17:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201021092750.GA4050@zn.tnic> <20201021232613.e40c1daef4b567e0e29044a4@kernel.org>
 <20201021164558.GB4050@zn.tnic> <20201022163100.1139b28220da4eafb5e70fcc@kernel.org>
 <20201022093044.GA29222@zn.tnic> <20201022222140.f46e6db1243e05fdd049b504@kernel.org>
 <CALCETrWhzzZ=EAoKZ4=k3FjffvS_3R4o5N1Rkj9FkHQdiUag6A@mail.gmail.com>
 <20201023182850.c54ac863159fb312c411c029@kernel.org> <20201023093254.GC23324@zn.tnic>
 <20201023194704.f723c86e5f8dfc1133dd5930@kernel.org> <20201023232741.GF23324@zn.tnic>
In-Reply-To: <20201023232741.GF23324@zn.tnic>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 23 Oct 2020 17:12:49 -0700
X-Gmail-Original-Message-ID: <CALCETrVQDVLPwTTXgsRYSjxVmzeK5ekmrEiT2rWkQKO0inRLGQ@mail.gmail.com>
Message-ID: <CALCETrVQDVLPwTTXgsRYSjxVmzeK5ekmrEiT2rWkQKO0inRLGQ@mail.gmail.com>
Subject: Re: [RFC] Have insn decoder functions return success/failure
To:     Borislav Petkov <bp@alien8.de>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86-ml <x86@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 4:27 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Oct 23, 2020 at 07:47:04PM +0900, Masami Hiramatsu wrote:
> > Thanks! I look forward to it.
>
> Ok, here's a first stab, it is a single big diff and totally untested
> but it should show what I mean. I've made some notes while converting,
> as I went along.
>
> Have a look at insn_decode() and its call sites: they are almost trivial
> now because caller needs simply to do:
>
>         if (insn_decode(insn, buffer, ...))
>
> and not care about any helper functions.
>
> For some of the call sites it still makes sense to do a piecemeal insn
> decoding and I've left them this way but they can be converted too, if
> one wants.
>
> In any case, just have a look please and lemme know if that looks OKish.
> I'll do the actual splitting and testing afterwards.
>
> And what Andy wants can't be done with the decoder because it already
> gets a fixed size buffer and length - it doesn't do the fetching. The
> caller does.
>
> What you wanna do:
>
> > len = min(15, remaining bytes in page);
> > fetch len bytes;
> > insn_init();
> > ret = insn_decode_fully();
>
> <--- you can't always know here whether the insn is valid if you don't
> have all the bytes. But you can always fetch *all* bytes and then give
> it to the decoder for checking.
>
> Also, this doesn't make any sense: try insn decode on a subset of bytes
> and then if it fails, try it on the whole set of bytes. Why even try the
> subset - it will almost always fail.

I disagree.  A real CPU does exactly what I'm describing.  If I stick
0xcc at the end of a page and a make the next page not-present, I get
#BP, not #PF.  But if I stick 0x0F at the end of a page and mark the
next page not-present, I get #PF.  If we're trying to decode an
instruction in user memory, we can kludge it by trying to fetch 15
bytes and handling -EFAULT by fetching fewer bytes, but that's gross
and doesn't really have the right semantics.  What we actually want is
to fetch up to the page boundary and try to decode it.  If it's a
valid instruction or if it's definitely invalid, we're done.
Otherwise we fetch across the page boundary.

Eventually we should wrap this whole mess up in an insn_decode_user()
helper that does the right thing.  And we can then make that helper
extra fancy by getting PKRU and EPT-hacker-execute-only right, whereas
we currently get these cases wrong.

Does this make sense?
