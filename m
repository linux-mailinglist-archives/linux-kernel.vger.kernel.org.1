Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B1929EC0F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgJ2Mmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgJ2Mml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:42:41 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB39C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 05:42:40 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ce900b5f28346c4b9bcfc.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:e900:b5f2:8346:c4b9:bcfc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 488391EC0212;
        Thu, 29 Oct 2020 13:42:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603975359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WZ+iHRQt699/ETjft2eWWSM+UHf4hfIDwpuqC4cM/cI=;
        b=Vg2eq9l1OE25n1CIerCIojmtd++tplrGvh9kPsDcdR92bVGLH1fbh3tPmFpOwmRTGSIoms
        hEO4NDjsrA+3CT+3AMD4KRKHW5MrWfqfGrY7KCSAAV7dhNv6x3eLtFhZkv3oZ3tp8M0zrK
        /7FK0W+oxnmn6FI1eD/yzqtVRj6eDsg=
Date:   Thu, 29 Oct 2020 13:42:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     x86-ml <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Have insn decoder functions return success/failure
Message-ID: <20201029124231.GB31903@zn.tnic>
References: <20201021232613.e40c1daef4b567e0e29044a4@kernel.org>
 <20201021164558.GB4050@zn.tnic>
 <20201022163100.1139b28220da4eafb5e70fcc@kernel.org>
 <20201022093044.GA29222@zn.tnic>
 <20201022222140.f46e6db1243e05fdd049b504@kernel.org>
 <CALCETrWhzzZ=EAoKZ4=k3FjffvS_3R4o5N1Rkj9FkHQdiUag6A@mail.gmail.com>
 <20201023182850.c54ac863159fb312c411c029@kernel.org>
 <20201023093254.GC23324@zn.tnic>
 <20201023194704.f723c86e5f8dfc1133dd5930@kernel.org>
 <20201023232741.GF23324@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201023232741.GF23324@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Sat, Oct 24, 2020 at 01:27:41AM +0200, Borislav Petkov wrote:
> @@ -230,14 +231,20 @@ void insn_get_prefixes(struct insn *insn)
>   * If necessary, first collects any preceding (prefix) bytes.
>   * Sets @insn->opcode.value = opcode1.  No effect if @insn->opcode.got
>   * is already 1.
> + *
> + * Returns:
> + * 0:  on success
> + * !0: on error
>   */
> -void insn_get_opcode(struct insn *insn)
> +int insn_get_opcode(struct insn *insn)
>  {
>  	struct insn_field *opcode = &insn->opcode;
>  	insn_byte_t op;
>  	int pfx_id;
> +
>  	if (opcode->got)
> -		return;
> +		return 0;
> +
>  	if (!insn->prefixes.got)
>  		insn_get_prefixes(insn);
>  
> @@ -254,9 +261,13 @@ void insn_get_opcode(struct insn *insn)
>  		insn->attr = inat_get_avx_attribute(op, m, p);
>  		if ((inat_must_evex(insn->attr) && !insn_is_evex(insn)) ||
>  		    (!inat_accept_vex(insn->attr) &&
> -		     !inat_is_group(insn->attr)))
> -			insn->attr = 0;	/* This instruction is bad */
> -		goto end;	/* VEX has only 1 byte for opcode */
> +		     !inat_is_group(insn->attr))) {
> +			/* This instruction is bad */
> +			insn->attr = 0;
> +			return 1;
> +		}
> +		/* VEX has only 1 byte for opcode */
> +		goto end;

so I'm playing more with this and am hitting the following after I made
this change to insn_get_opcode() to actually return an error because,
well, it is an error when the opcode bytes are pointing to an invalid
insn.

However, the current situation is that even though the comment says that
the instruction is bad:

                if ((inat_must_evex(insn->attr) && !insn_is_evex(insn)) ||
                    (!inat_accept_vex(insn->attr) &&
                     !inat_is_group(insn->attr)))
                        insn->attr = 0; /* This instruction is bad */
                goto end;       /* VEX has only 1 byte for opcode */

it would goto to end and set opcode->got = 1, i.e., denote success.

Do you have a particular reason for why it does that?

Because, for example, when it encounters an invalid VEX insn which is
bad, running insn_sanity says this:

Error: Found an access violation:
Instruction = {
        .prefixes = {
                .value = 0, bytes[] = {0, 0, 0, 0},
                .got = 1, .nbytes = 0},
        .rex_prefix = {
                .value = 0, bytes[] = {0, 0, 0, 0},
                .got = 1, .nbytes = 0},
        .vex_prefix = {
                .value = 7138501, bytes[] = {c5, ec, 6c, 0},
                .got = 1, .nbytes = 2},
        .opcode = {
                .value = 149, bytes[] = {95, 0, 0, 0},
                .got = 0, .nbytes = 1},
        .modrm = {
                .value = 0, bytes[] = {0, 0, 0, 0},
                .got = 0, .nbytes = 0},
        .sib = {
                .value = 0, bytes[] = {0, 0, 0, 0},
                .got = 0, .nbytes = 0},
        .displacement = {
                .value = 0, bytes[] = {0, 0, 0, 0},
                .got = 0, .nbytes = 0},
        .immediate1 = {
                .value = 0, bytes[] = {0, 0, 0, 0},
                .got = 0, .nbytes = 0},
        .immediate2 = {
                .value = 0, bytes[] = {0, 0, 0, 0},
                .got = 0, .nbytes = 0},
        .attr = 0, .opnd_bytes = 4, .addr_bytes = 8,
        .length = 0, .x86_64 = 1, .kaddr = 0x7ffe7cc46460}
You can reproduce this with below command(s);
 $ echo  c5 ec 95 b2 02 bd 4b c8 a8 36 b2 c5 c0 df 13 | arch/x86/tools/insn_sanity -i -
Or 
 $ arch/x86/tools/insn_sanity -s 0x87ac2160,109

I do

arch/x86/tools/insn_sanity -s 0x87ac2160 -v -y

After having added debug output, it says:

inat_get_avx_attribute: vex_m: 0x1, vex_p: 0x0
inat_get_avx_attribute: looking up opcode 0x95
insn_get_opcode: insn is bad, must_evex: 0, !accept_vex: 1, !is_group: 1
get_opcode
get_modrm
get_sib
get_displacement
get_immediate failed
insn_decode: here
main: ret: -22
Error: Found an access violation:

so long story short, 0xc5 0xec 0x95 is an invalid VEX insn because
there's no VEX insn with opcode 0x95.

So it really is a bad insn.

So after my changes, insn_decode() becomes stricter but that would need
adjusting the sanity checker. And before I do that, let me run it by you
in case I'm missing some other aspect...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
