Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C552296BF7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461337AbgJWJUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:20:16 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37068 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S461285AbgJWJUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:20:16 -0400
Received: from zn.tnic (p200300ec2f0f8300d0366120c91f316b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:8300:d036:6120:c91f:316b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1E66C1EC02E6;
        Fri, 23 Oct 2020 11:20:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603444815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jmHZA6622Bz8emcs7v99h2jc7kfJ5txqqzfV0Qa6XYQ=;
        b=jKd3X7maoBDxh3EHnAcYIb+q+t+zKmw+Fd+dCN7y5thsZZ69q0itVJy1DX6PbN2nmVBj/x
        bt9J+cT+OT33Z8NtvsHezenga9wsasR2OXAOBecwbIc5xEd9HDq0X9WOTjQb1u2RHCk7b1
        tigKNL5fDgTXeqSnfCWcChC2WXlO9/Y=
Date:   Fri, 23 Oct 2020 11:20:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, x86-ml <x86@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Have insn decoder functions return success/failure
Message-ID: <20201023092010.GB23324@zn.tnic>
References: <20201020232700.5510c236d810b7f8a66779e2@kernel.org>
 <20201020143746.GG11583@zn.tnic>
 <20201021095013.d82637f84af564ae4363189d@kernel.org>
 <20201021092750.GA4050@zn.tnic>
 <20201021232613.e40c1daef4b567e0e29044a4@kernel.org>
 <20201021164558.GB4050@zn.tnic>
 <20201022163100.1139b28220da4eafb5e70fcc@kernel.org>
 <20201022093044.GA29222@zn.tnic>
 <20201022222140.f46e6db1243e05fdd049b504@kernel.org>
 <CALCETrWhzzZ=EAoKZ4=k3FjffvS_3R4o5N1Rkj9FkHQdiUag6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrWhzzZ=EAoKZ4=k3FjffvS_3R4o5N1Rkj9FkHQdiUag6A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 10:58:32AM -0700, Andy Lutomirski wrote:
> I'm guessing that the confusion here is that the kernel instruction
> decoder was originally designed to be used to decode kernel
> instructions, which are generally trusted to be valid, but that it's
> starting to be used to decode user code and such as well.
>
> Masami, could we perhaps have an extra API like:
>
> extern int insn_decode_fully(struct insn *insn);

insn_decode(). Simple. :)

> that decodes the *entire* instruction, returns success if the decoder
> thinks the instruction is valid, and returns an error if the decoder
> thinks it's invalid?

Yap, exactly.

> We would use this when decoding arbitrary bytes
> when we're not really sure that there's a valid instruction there.
> For user code emulation, we don't really care much about performance
> -- the overhead of getting #GP in the first place is much, much higher
> than the overhead of decoding more of the instruction than needed.

Ack.

> Ideally we would solve another little problem at the same time.  Right
> now, we are quite sloppy about how we fetch the instruction bytes, and
> it might be nice to fix this.  It would be nice if we could have a
> special error code saying "more bytes are needed".  So
> insn_decode_fully() would return 0 (or the length) on a successful
> decode, -EINVAL if the bytes are not a valid instruction, and -EAGAIN
> (or something more appropriate) if the bytes are a valid *prefix* of
> an instruction but more bytes are needed.  Then the caller would do:

Yah, lemme see if that can be done easily.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
