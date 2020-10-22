Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752DB295FD6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506495AbgJVNVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:21:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439419AbgJVNVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:21:45 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED8BB2417D;
        Thu, 22 Oct 2020 13:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603372904;
        bh=imaYIfsDwMHkkiZz0txYafwsmOxZZcka5WzSZDZvOMc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hlaBwn96/Z/ocnQHcDHthDlc+R/uh2SQ+r8oYdrOWoXmOwTgeajdlKcOBxPZxCHu5
         p/secp8SSjZgPNwWLcFqIBTQHqHRkI3CRfZOWZGm1nLnRBeSBile47AmBzRDGersCn
         auRhckr6/qmFJfDOSgKM+K2hbkc5iy8C0zfM+kyA=
Date:   Thu, 22 Oct 2020 22:21:40 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Have insn decoder functions return success/failure
Message-Id: <20201022222140.f46e6db1243e05fdd049b504@kernel.org>
In-Reply-To: <20201022093044.GA29222@zn.tnic>
References: <20201020120232.GD11583@zn.tnic>
        <20201020232700.5510c236d810b7f8a66779e2@kernel.org>
        <20201020143746.GG11583@zn.tnic>
        <20201021095013.d82637f84af564ae4363189d@kernel.org>
        <20201021092750.GA4050@zn.tnic>
        <20201021232613.e40c1daef4b567e0e29044a4@kernel.org>
        <20201021164558.GB4050@zn.tnic>
        <20201022163100.1139b28220da4eafb5e70fcc@kernel.org>
        <20201022093044.GA29222@zn.tnic>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Oct 2020 11:30:44 +0200
Borislav Petkov <bp@alien8.de> wrote:

> On Thu, Oct 22, 2020 at 04:31:00PM +0900, Masami Hiramatsu wrote:
> > No, insn_get_length() implies it decodes whole of the instruction.
> > (yeah, we need an alias of that, something like insn_get_complete())
> 
> That's exactly what I'm trying to point out: the whole API is not
> entirely wrong - it just needs a better naming and documentation. Now,
> the implication that getting the length of the insn will give you a full
> decode is a totally internal detail which users don't need and have to
> know.

Ok, what names would you like to suggest? insn_get_complete()?

> > I need insn.length too. Of course we can split it into 2 calls. But
> > as I said, since the insn_get_length() implies it decodes all other
> > parts, I just called it once.
> 
> Yes, I have noticed that and wrote about it further on. The intent was
> to show that the API needs work.
> 
> > Hm, it is better to call insn_get_immediate() if it doesn't use length later.
> 
> Ok, so you see the problem. This thing wants to decode the whole insn -
> that's what the function is called. But it reads like it does something
> else.
> 
> > Would you mean we'd better have something like insn_get_until_immediate() ? 
> > 
> > Since the x86 instruction is CISC, we can not decode intermediate
> > parts. The APIs follows that. If you are confused, I'm sorry about that.
> 
> No, I'm not confused - again, I'd like for the API to be properly
> defined and callers should not have to care which parts of the insn they
> need to decode in order to get something else they actually need.

Sorry, I can not get what you point. We already have those APIs, 

extern void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64);
extern void insn_get_prefixes(struct insn *insn);
extern void insn_get_opcode(struct insn *insn);
extern void insn_get_modrm(struct insn *insn);
extern void insn_get_sib(struct insn *insn);
extern void insn_get_displacement(struct insn *insn);
extern void insn_get_immediate(struct insn *insn);
extern void insn_get_length(struct insn *insn);

As I agreed, that we may need an alias of insn_get_length(). But it seems
clear to me, if you need insn.immediate, you must call insn_get_immediate().

> So the main API should be: insn_decode_insn() or so and it should give
> you everything you need.
> 
> If this succeeds, you can go poke at insn.<field> and you know you have
> valid data there.

Ah, so you meant that we don't need such a different insn_get_* APIs,
but a single insn_decode() API, which will decode all fields.
(IOW, alias of insn_init() and insn_get_length(), right?)

> If there are specialized uses, you can call some of the insn_get_*
> helpers if you're not interested in decoding the full insn.

OK, agreed.

> 
> But if simply calling insn_decode_insn() would give you everything and
> that is not that expensive, we can do that - API simplicity.

I rather like simple "insn_decode()" function, no need to repeat
insn again.

int insn_decode(struct insn *insn, const void *kaddr, int buf_len, bool x86_64);

> 
> What I don't want to have is calling insn_get_length() or so and then
> inspecting the opcode bytes because that's totally non-transparent.

OK, I agreed.

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
