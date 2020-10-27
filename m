Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B297729ADAC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 14:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752487AbgJ0NnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 09:43:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46778 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440605AbgJ0NnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 09:43:01 -0400
Received: from zn.tnic (p200300ec2f0dae007668a82e4598cc3d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:ae00:7668:a82e:4598:cc3d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 885F91EC025D;
        Tue, 27 Oct 2020 14:42:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603806179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tqFC3GW9GkxjNNMprD8r1M10nniS0/Cp9WdJD5N4EDY=;
        b=PXUHaw5jNl7q1CCWQd+CjHy7hJWZs1AqzEqwf27XdUwzPzilBUGFRd8Qf3WjAV+O3WOgOF
        c0JEHb245Epy7IaY1WaavMy2HTqSOtZae9jslT8VSwKms+Ba4zQxFXqGt53Ihkbdr+dtVN
        z8+hIPQW+PiUWUZTTV9W+hbqlx5tjVM=
Date:   Tue, 27 Oct 2020 14:42:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        x86-ml <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Have insn decoder functions return success/failure
Message-ID: <20201027134251.GH15580@zn.tnic>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrW0Ub-vA8iS=0JGOpZL3P7p7Ac8Agq+6N-k4Rsv6k_1zA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 24, 2020 at 09:10:25AM -0700, Andy Lutomirski wrote:
> I can pretty much guarantee that a real modern CPU is able to decode a
> <15 byte instruction that is followed by unmapped or non-executable
> pages.  I don't know specifically how the CPU implements it, but it
> works.

Yes, so reportedly and architecturally, a CPU tries to execute every
last byte it has fetched. If it fails decoding an instruction because it
is incomplete, then it raises a #PF. So you're correct.

> If I have a page that ends in 0x0F followed by an unmapped page, then
> the correct response to an attempt to decode is SIGSEGV or -EFAULT.
> If there's a page there that contains garbage, then the correct
> response is SIGILL or -EINVAL or similar.  These are different
> scenarios, and I don't think the current decoder API can be used to
> distinguish them.

See above - the insn decoder should be taught to look only at the bytes
it is *allowed* to look, i.e., the bytes which have been fetched and not
peek forward. And I believe it does that to some extent but I need to
look closer.

And it should detect the cases where the insn bytes come short. But that
needs also looking but first things first.

Bottomline: it should do exactly what a CPU does, IMO.

Again, find me on IRC to hash out details but I believe we're in an
agreement here.

> Take a look at fixup_umip_exception().  It currently has two bugs:
> 
> 1. If it tries to decode a short instruction followed by something
> like a userfaultfd page, it will incorrectly trigger the userfaultfd.
> This is because it tries to fetch MAX_INSN_SIZE even if the
> instruction is shorter than that.
> 
> 2. It will fail on execute-only memory, and it will succeed on NX
> memory.  copy_from_user() is the wrong API to use here.  We don't have
> the right API, and we should add it.  (Hi Dave - what's the best way
> to do this?  New get_user_pages() mode?  Try to fault it in, hold an
> appropriate lock, walk the page tables to check permissions, and then
> access the user address directly?)
> 
> I don't know how much anyone really cares about this for UMIP, but
> with SEV-ES and such, I can see this becoming more important.

I'll have a look at those when I do the patchset.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
