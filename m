Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5471A29510E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503136AbgJUQqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:46:11 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35594 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409368AbgJUQqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:46:10 -0400
Received: from zn.tnic (p200300ec2f0c9a004cef083969089481.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9a00:4cef:839:6908:9481])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7B80D1EC0409;
        Wed, 21 Oct 2020 18:46:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603298769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=daOTF2/FSKZKCBtKD62ijH+Yjgjxv3mEX/vZTvoWX0s=;
        b=UFV4ApC4M5DwlQjJrh5ootvVUOcayBfyUXieUfOQvDLT9RI5cfpYFt2+90OVwE011DgNRh
        hoaja7LzLASRTRk6Ehd27ycRiw3BxrxgarK+PeF9uKuFOB4HiTJH5iPcohCIG+uzNcd1CS
        DvLxsSMTsfkIFAeanfzEoafFz5mrn1Y=
Date:   Wed, 21 Oct 2020 18:45:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     x86-ml <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Have insn decoder functions return success/failure
Message-ID: <20201021164558.GB4050@zn.tnic>
References: <20201020120232.GD11583@zn.tnic>
 <20201020232700.5510c236d810b7f8a66779e2@kernel.org>
 <20201020143746.GG11583@zn.tnic>
 <20201021095013.d82637f84af564ae4363189d@kernel.org>
 <20201021092750.GA4050@zn.tnic>
 <20201021232613.e40c1daef4b567e0e29044a4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201021232613.e40c1daef4b567e0e29044a4@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 11:26:13PM +0900, Masami Hiramatsu wrote:
> Hmm, I meant someone might think it can be used for filtering the
> instruction something like,
> 
> insn_init(insn, buf, buflen, 1);
> ret = insn_get_length(insn);
> if (!ret) {
> 	/* OK, this is safe */
> 	patch_text(buf, trampoline);
> }
> 
> No, we need another validator for such usage.

Well, I think calling insn_get_length() should give you only the
*length* of the insn and nothing else - I mean that is what the function
is called. And I believe current use is wrong.

Examples:

arch/x86/kernel/kprobes/core.c:
                insn_get_length(&insn);

                /*
                 * Another debugging subsystem might insert this breakpoint.
                 * In that case, we can't recover it.
                 */
                if (insn.opcode.bytes[0] == INT3_INSN_OPCODE)

So this has called get_length but it is far from clear that after that
call, the opcode bytes in insn.opcode.bytes are there.

What that should do instead IMO is this:

	insn_get_opcode(&insn);

and *then* the return value can tell you whether the opcode bytes were
parsed properly or not. See what I mean?

That's even documented that way:

/**
 * insn_get_opcode - collect opcode(s)
 * @insn:       &struct insn containing instruction
 *
 * Populates @insn->opcode, updates @insn->next_byte to point past the
 * opcode byte(s), and set @insn->attr (except for groups).


Similarly here:

static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)

	...

        insn_get_length(&ctxt->insn);

        ret = ctxt->insn.immediate.got ? ES_OK : ES_DECODE_FAILED;

that thing wants to decode the insn but it is looking whether it parsed
an *immediate*?!

I'm not saying this is necessarily wrong - just the naming nomenclature
and the API should be properly defined when you call a function of the
insn decoder, what you are guaranteed to get and what a caller can
assume after that. And then the proper functions be called.

In the kprobes/core.c example above, it does a little further:

	ddr += insn.length;	

which, IMO, it should be either preceeded by a call to insn_get_length()
- yes, this time we want the insn length or, the code should call a
decoding function which gives you *both* length* and opcode bytes.
insn_decode_insn() or whatever. And *that* should be documented in that
function's kernel-doc section. And so on...

Does that make more sense?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
