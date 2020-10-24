Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEC1297D4A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 18:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762026AbgJXQKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 12:10:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759927AbgJXQKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 12:10:40 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5824D22263
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 16:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603555839;
        bh=bgEHfao6dQroCy9kcKlMUvFVd5wuRa2QsetjcRrbJE4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CKhqNTi6xFTWHK8bJ58kYV/DazkT4SNZcostpXoRi6rPqHu19r1ZLHinjUvbp9H3D
         Bc5FfqaTfhJQ1H468vqSXdHf1NRvfWIjNFN5tFDXIfTVnMhi3e/hpN4xRKB+Pkc9MS
         6sZOwESYtsowzwJ0YW85cajlGB7xWDIh5FyJhbeY=
Received: by mail-wr1-f43.google.com with SMTP id g12so6336940wrp.10
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 09:10:39 -0700 (PDT)
X-Gm-Message-State: AOAM533wfOu0Zm+0fpVHE2xB9RcWdX5TlkWYuj+raxJJ+MkwuCNHqEW5
        LbybBjOYEHwPZ3AqUv4oh7v+1aE4cLk30QXJAwjIcA==
X-Google-Smtp-Source: ABdhPJyEE0shHhJUbwMAl6bBfHKLOfLqdfDhDYRQ8tJVJZxLOeikwQDgKjq4cLPull06g9QML3xg+DgKarCDo+ux6xc=
X-Received: by 2002:adf:df03:: with SMTP id y3mr8230248wrl.70.1603555837794;
 Sat, 24 Oct 2020 09:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201021164558.GB4050@zn.tnic> <20201022163100.1139b28220da4eafb5e70fcc@kernel.org>
 <20201022093044.GA29222@zn.tnic> <20201022222140.f46e6db1243e05fdd049b504@kernel.org>
 <CALCETrWhzzZ=EAoKZ4=k3FjffvS_3R4o5N1Rkj9FkHQdiUag6A@mail.gmail.com>
 <20201023182850.c54ac863159fb312c411c029@kernel.org> <20201023093254.GC23324@zn.tnic>
 <20201023194704.f723c86e5f8dfc1133dd5930@kernel.org> <20201023232741.GF23324@zn.tnic>
 <CALCETrVQDVLPwTTXgsRYSjxVmzeK5ekmrEiT2rWkQKO0inRLGQ@mail.gmail.com> <20201024082316.GA11562@zn.tnic>
In-Reply-To: <20201024082316.GA11562@zn.tnic>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 24 Oct 2020 09:10:25 -0700
X-Gmail-Original-Message-ID: <CALCETrW0Ub-vA8iS=0JGOpZL3P7p7Ac8Agq+6N-k4Rsv6k_1zA@mail.gmail.com>
Message-ID: <CALCETrW0Ub-vA8iS=0JGOpZL3P7p7Ac8Agq+6N-k4Rsv6k_1zA@mail.gmail.com>
Subject: Re: [RFC] Have insn decoder functions return success/failure
To:     Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        x86-ml <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 24, 2020 at 1:23 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Oct 23, 2020 at 05:12:49PM -0700, Andy Lutomirski wrote:
> > I disagree.  A real CPU does exactly what I'm describing.  If I stick
>
> A real modern CPU fetches up to 32 bytes insn window which it tries
> to decode etc. I don't know, though, what it does when that fetch
> encounters a fault - I will have to ask people. I'm not sure it would
> even try to feed a shorter stream of bytes to the decoder but lemme
> ask...
>

I can pretty much guarantee that a real modern CPU is able to decode a
<15 byte instruction that is followed by unmapped or non-executable
pages.  I don't know specifically how the CPU implements it, but it
works.

> > 0xcc at the end of a page and a make the next page not-present, I get
> > #BP, not #PF.  But if I stick 0x0F at the end of a page and mark the
> > next page not-present, I get #PF.  If we're trying to decode an
> > instruction in user memory, we can kludge it by trying to fetch 15
> > bytes and handling -EFAULT by fetching fewer bytes, but that's gross
> > and doesn't really have the right semantics.  What we actually want is
> > to fetch up to the page boundary and try to decode it.  If it's a
> > valid instruction or if it's definitely invalid, we're done.
> > Otherwise we fetch across the page boundary.
>
> We can do that but why would you put all that logic in the insn decoder?
> Is that use case sooo important?

It's not sooo important, but I think it would be nice to at least try
to be fully correct.

>
> I mean, it would work that way anyway *even* *now* - the insn decoder
> will tell you that the insn it decoded wasn't valid and you, as a
> caller, know that you didn't fetch the whole 15 bytes so that means
> that you still need to fetch some more. You've got all the relevant
> information.

How so?

If I have a page that ends in 0x0F followed by an unmapped page, then
the correct response to an attempt to decode is SIGSEGV or -EFAULT.
If there's a page there that contains garbage, then the correct
response is SIGILL or -EINVAL or similar.  These are different
scenarios, and I don't think the current decoder API can be used to
distinguish them.

>
> > Eventually we should wrap this whole mess up in an insn_decode_user()
> > helper that does the right thing.
>
> Oh sure, you can do that easily. Just put the logic which determines
> that it copied a shorter buffer and that it attempts to decode the
> shorter buffer first in it. Yah, that can work.
>
> > And we can then make that helper
> > extra fancy by getting PKRU and EPT-hacker-execute-only right, whereas
> > we currently get these cases wrong.
> >
> > Does this make sense?
>
> Sure, but you could point me to those cases so that I can get a better
> idea what they do exactly.

Take a look at fixup_umip_exception().  It currently has two bugs:

1. If it tries to decode a short instruction followed by something
like a userfaultfd page, it will incorrectly trigger the userfaultfd.
This is because it tries to fetch MAX_INSN_SIZE even if the
instruction is shorter than that.

2. It will fail on execute-only memory, and it will succeed on NX
memory.  copy_from_user() is the wrong API to use here.  We don't have
the right API, and we should add it.  (Hi Dave - what's the best way
to do this?  New get_user_pages() mode?  Try to fault it in, hold an
appropriate lock, walk the page tables to check permissions, and then
access the user address directly?)

I don't know how much anyone really cares about this for UMIP, but
with SEV-ES and such, I can see this becoming more important.
