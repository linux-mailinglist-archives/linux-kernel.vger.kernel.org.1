Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23BDA29DEDF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403784AbgJ2A5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:57:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731609AbgJ1WRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:36 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7588B246C8;
        Wed, 28 Oct 2020 11:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603884970;
        bh=MKVtSvPsm7PqyEOfnI8yAO4yCQEnbhAOESNXVqEGrQY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=atBaBGCdhAwJWg/QcyVafBBPtr/ae+fCCJ7gGftj2cm3n0KPEcn2JTpUB8O8i+iEy
         vLz0EFdvQFKiETGQAcHpb4mDH4FUPIy0JgfwUpzXxlCB0sUDPeVKTKPHk/9Bqo5jXW
         Ds4QLnqmrJuoetzSMkaTyC0CkLyUTVJ4EFnV5sw0=
Date:   Wed, 28 Oct 2020 20:36:07 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        x86-ml <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Have insn decoder functions return success/failure
Message-Id: <20201028203607.194db3f95690674022887d7a@kernel.org>
In-Reply-To: <20201027134251.GH15580@zn.tnic>
References: <20201022093044.GA29222@zn.tnic>
        <20201022222140.f46e6db1243e05fdd049b504@kernel.org>
        <CALCETrWhzzZ=EAoKZ4=k3FjffvS_3R4o5N1Rkj9FkHQdiUag6A@mail.gmail.com>
        <20201023182850.c54ac863159fb312c411c029@kernel.org>
        <20201023093254.GC23324@zn.tnic>
        <20201023194704.f723c86e5f8dfc1133dd5930@kernel.org>
        <20201023232741.GF23324@zn.tnic>
        <CALCETrVQDVLPwTTXgsRYSjxVmzeK5ekmrEiT2rWkQKO0inRLGQ@mail.gmail.com>
        <20201024082316.GA11562@zn.tnic>
        <CALCETrW0Ub-vA8iS=0JGOpZL3P7p7Ac8Agq+6N-k4Rsv6k_1zA@mail.gmail.com>
        <20201027134251.GH15580@zn.tnic>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Oct 2020 14:42:51 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Sat, Oct 24, 2020 at 09:10:25AM -0700, Andy Lutomirski wrote:
> > I can pretty much guarantee that a real modern CPU is able to decode a
> > <15 byte instruction that is followed by unmapped or non-executable
> > pages.  I don't know specifically how the CPU implements it, but it
> > works.
> 
> Yes, so reportedly and architecturally, a CPU tries to execute every
> last byte it has fetched. If it fails decoding an instruction because it
> is incomplete, then it raises a #PF. So you're correct.
> 
> > If I have a page that ends in 0x0F followed by an unmapped page, then
> > the correct response to an attempt to decode is SIGSEGV or -EFAULT.
> > If there's a page there that contains garbage, then the correct
> > response is SIGILL or -EINVAL or similar.  These are different
> > scenarios, and I don't think the current decoder API can be used to
> > distinguish them.
> 
> See above - the insn decoder should be taught to look only at the bytes
> it is *allowed* to look, i.e., the bytes which have been fetched and not
> peek forward. And I believe it does that to some extent but I need to
> look closer.

Yeah, it always does except for the prefix decoding. Anyway, it always
check the boundary (end address) when peek the byte.

> And it should detect the cases where the insn bytes come short. But that
> needs also looking but first things first.
> 
> Bottomline: it should do exactly what a CPU does, IMO.
> 
> Again, find me on IRC to hash out details but I believe we're in an
> agreement here.
> 
> > Take a look at fixup_umip_exception().  It currently has two bugs:
> > 
> > 1. If it tries to decode a short instruction followed by something
> > like a userfaultfd page, it will incorrectly trigger the userfaultfd.
> > This is because it tries to fetch MAX_INSN_SIZE even if the
> > instruction is shorter than that.

Hmm, did it pass the correct buf_size to insn_init()?
...
        nr_copied = insn_fetch_from_user(regs, buf);
...
Ah, I got it. It copies not until the page boundary but +MAX_INSN_SIZE...

> > 
> > 2. It will fail on execute-only memory, and it will succeed on NX
> > memory.  copy_from_user() is the wrong API to use here.  We don't have
> > the right API, and we should add it.  (Hi Dave - what's the best way
> > to do this?  New get_user_pages() mode?  Try to fault it in, hold an
> > appropriate lock, walk the page tables to check permissions, and then
> > access the user address directly?)

Good point! If we can not read the page we can not decode it by software.

Thank you,

> > 
> > I don't know how much anyone really cares about this for UMIP, but
> > with SEV-ES and such, I can see this becoming more important.
> 
> I'll have a look at those when I do the patchset.
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
