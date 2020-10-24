Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1DF297B28
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 09:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759658AbgJXHNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 03:13:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759546AbgJXHNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 03:13:20 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 378F72177B;
        Sat, 24 Oct 2020 07:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603523599;
        bh=/4DmeoK4zDaEb58vLcqZhVV250xMT3C6SsJcAHed+Qs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bvl1VAJm0rQGVtyO/7cZAxIVMQXDAYKVgvNrN/iDHuZJQZSUArF30IHsK3W5qwpld
         h7jDaKpDjYv4odSis80sfcgHqQiUYjtd9jNiDXUBL6EUd0UE9Pq/Ft+uoZCv+ovGic
         ZYH+UxmPw7uiqVJOSNwNLD4YU8jkVNOpiLl1sJNE=
Date:   Sat, 24 Oct 2020 16:13:15 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@kernel.org>, x86-ml <x86@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Have insn decoder functions return success/failure
Message-Id: <20201024161315.267499b854b1d08213f7c445@kernel.org>
In-Reply-To: <20201023232741.GF23324@zn.tnic>
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
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Oct 2020 01:27:41 +0200
Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Oct 23, 2020 at 07:47:04PM +0900, Masami Hiramatsu wrote:
> > Thanks! I look forward to it.
> 
> Ok, here's a first stab, it is a single big diff and totally untested
> but it should show what I mean. I've made some notes while converting,
> as I went along.

Thanks, so will you split this into several patches, since I saw some
cleanups in this patch?

> 
> Have a look at insn_decode() and its call sites: they are almost trivial
> now because caller needs simply to do:
> 
> 	if (insn_decode(insn, buffer, ...))
> 
> and not care about any helper functions.

Yeah, that's good to me because in the most cases, user needs prefix,
length or total decoded info.

BTW, it seems you returns 1 for errors, I rather like -EINVAL or -EILSEQ
for errors so that user can also write

 if (insn_decode() < 0)
   ...

I think "positive" and "zero" pair can easily mislead user to "true" and
"false" trap.


> For some of the call sites it still makes sense to do a piecemeal insn
> decoding and I've left them this way but they can be converted too, if
> one wants.

Yeah, for the kprobes, if you see the insn_init() and insn_get_length()
those can be replaced with one insn_decode(). 

> In any case, just have a look please and lemme know if that looks OKish.
> I'll do the actual splitting and testing afterwards.

Except for the return value, it looks good to me.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
