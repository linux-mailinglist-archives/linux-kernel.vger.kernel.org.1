Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812A6296BF2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461316AbgJWJSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:18:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36696 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S461193AbgJWJSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:18:07 -0400
Received: from zn.tnic (p200300ec2f0f8300d0366120c91f316b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:8300:d036:6120:c91f:316b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9C79B1EC02E6;
        Fri, 23 Oct 2020 11:18:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603444686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Jw1L079D5mZUECcUPb21cpUxm4To5cz1ZXkX42RBlu8=;
        b=HaFAHkrxxDCxtPgnpp0eeUI2o7BFRAhy0hQOvdmCqJjVLR5mYDvyVqJyvwSf/KiLAMityq
        E6P6wkCnURQcTf8Fs06KBtIlBlBW3wo6rC2733MKNPEwFXJ9Vb8aCWtJ2pFhVvZ/jd/b25
        gLmuyBH8afNUb5Jy8P5fHDvsOta/tj8=
Date:   Fri, 23 Oct 2020 11:17:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     x86-ml <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Have insn decoder functions return success/failure
Message-ID: <20201023091755.GA23324@zn.tnic>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201022222140.f46e6db1243e05fdd049b504@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 10:21:40PM +0900, Masami Hiramatsu wrote:
> extern void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64);
> extern void insn_get_prefixes(struct insn *insn);
> extern void insn_get_opcode(struct insn *insn);
> extern void insn_get_modrm(struct insn *insn);
> extern void insn_get_sib(struct insn *insn);
> extern void insn_get_displacement(struct insn *insn);
> extern void insn_get_immediate(struct insn *insn);
> extern void insn_get_length(struct insn *insn);

...

> Ah, so you meant that we don't need such a different insn_get_* APIs,
> but a single insn_decode() API, which will decode all fields.
> (IOW, alias of insn_init() and insn_get_length(), right?)

Yes, so there should be a balance between what one wants to decode:

length, opcodes, etc

vs

when one needs only a certain *single* aspect: sib, length,
displacement, etc.

So if you need a couple of things, you can simply call the insn_decode()
function - I'm reading forward and I like your naming :) - and when
that returns success, you can be sure that struct insn contains all the
fields needed.

Otherwise...

> > If there are specialized uses, you can call some of the insn_get_*
> > helpers if you're not interested in decoding the full insn.
> 
> OK, agreed.

... yes, exactly!

> > But if simply calling insn_decode_insn() would give you everything and
> > that is not that expensive, we can do that - API simplicity.
> 
> I rather like simple "insn_decode()" function, no need to repeat
> insn again.
> 
> int insn_decode(struct insn *insn, const void *kaddr, int buf_len, bool x86_64);

Yap, good.

Ok, seems we agree, lemme poke at this one more time, convert some users
and we can see how it looks like and talk then.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
