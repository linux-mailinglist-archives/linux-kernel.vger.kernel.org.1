Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D09295BD2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 11:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509952AbgJVJa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 05:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508746AbgJVJa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 05:30:57 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66BDC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 02:30:56 -0700 (PDT)
Received: from zn.tnic (p200300ec2f123f00b577de4e643a255a.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:3f00:b577:de4e:643a:255a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3F8851EC04CB;
        Thu, 22 Oct 2020 11:30:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603359055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=aWS+duHM0ToR6CCOpBfRlV+qjymx1mLPjhOOSWuyyaQ=;
        b=j+i4YyR0WHxOGCths9b/jZB86XjM56mbcpA0fj0EV3wWotLJXdIVsgqhDxjBsQOA//xozT
        4LrsL8n1BrMnn/am50YGjuyaZa+7nslS5XSb6R5fFdihjGIPGkJmSHR8SX+2fVffnCkS+D
        JQU4qfc7/v88LcIOhuFiOg0Cy/VhoDc=
Date:   Thu, 22 Oct 2020 11:30:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     x86-ml <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Have insn decoder functions return success/failure
Message-ID: <20201022093044.GA29222@zn.tnic>
References: <20201020120232.GD11583@zn.tnic>
 <20201020232700.5510c236d810b7f8a66779e2@kernel.org>
 <20201020143746.GG11583@zn.tnic>
 <20201021095013.d82637f84af564ae4363189d@kernel.org>
 <20201021092750.GA4050@zn.tnic>
 <20201021232613.e40c1daef4b567e0e29044a4@kernel.org>
 <20201021164558.GB4050@zn.tnic>
 <20201022163100.1139b28220da4eafb5e70fcc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201022163100.1139b28220da4eafb5e70fcc@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 04:31:00PM +0900, Masami Hiramatsu wrote:
> No, insn_get_length() implies it decodes whole of the instruction.
> (yeah, we need an alias of that, something like insn_get_complete())

That's exactly what I'm trying to point out: the whole API is not
entirely wrong - it just needs a better naming and documentation. Now,
the implication that getting the length of the insn will give you a full
decode is a totally internal detail which users don't need and have to
know.

> I need insn.length too. Of course we can split it into 2 calls. But
> as I said, since the insn_get_length() implies it decodes all other
> parts, I just called it once.

Yes, I have noticed that and wrote about it further on. The intent was
to show that the API needs work.

> Hm, it is better to call insn_get_immediate() if it doesn't use length later.

Ok, so you see the problem. This thing wants to decode the whole insn -
that's what the function is called. But it reads like it does something
else.

> Would you mean we'd better have something like insn_get_until_immediate() ? 
> 
> Since the x86 instruction is CISC, we can not decode intermediate
> parts. The APIs follows that. If you are confused, I'm sorry about that.

No, I'm not confused - again, I'd like for the API to be properly
defined and callers should not have to care which parts of the insn they
need to decode in order to get something else they actually need.

So the main API should be: insn_decode_insn() or so and it should give
you everything you need.

If this succeeds, you can go poke at insn.<field> and you know you have
valid data there.

If there are specialized uses, you can call some of the insn_get_*
helpers if you're not interested in decoding the full insn.

But if simply calling insn_decode_insn() would give you everything and
that is not that expensive, we can do that - API simplicity.

What I don't want to have is calling insn_get_length() or so and then
inspecting the opcode bytes because that's totally non-transparent.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
