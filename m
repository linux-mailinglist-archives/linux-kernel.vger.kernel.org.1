Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C09E2C85CB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgK3Np3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:45:29 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40698 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgK3Np2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:45:28 -0500
Received: from zn.tnic (p200300ec2f0c0400b0063e9f0046aa3d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:400:b006:3e9f:46:aa3d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1F9891EC04A9;
        Mon, 30 Nov 2020 14:44:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606743887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=enMUDweG7jQb0semvEMxAkl78zQ8YKxuI5qRFWoLr/Y=;
        b=M9yS26lNcZtTToWA06fe1dksqSx0S4o09Hj+4I37mTaol2zb2O+x+0QJl4Ym7Y5v/hy9Qq
        GVIRe0FJWJ1OfO1Ousi+NNSuwXvUbIv2tVmBz0VIkyJ7Cmr+8dX9tw/F7TGHfTM4QjyWYA
        +RcLRhBsPB5h5hhJHyWWR//JFhcsFSE=
Date:   Mon, 30 Nov 2020 14:44:42 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andy Lutomirski <luto@amacapital.net>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v0 00/19] x86/insn: Add an insn_decode() API
Message-ID: <20201130134442.GB6019@zn.tnic>
References: <20201124101952.7909-1-bp@alien8.de>
 <20201124174647.GI4009@zn.tnic>
 <CALCETrXXuUmM6LPj36h2KLw5zuKUPnmrACcOq2-8XfXzWXQt7Q@mail.gmail.com>
 <20201129175005.7e07a9f799e888ffd5f4ed67@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201129175005.7e07a9f799e888ffd5f4ed67@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 29, 2020 at 05:50:05PM +0900, Masami Hiramatsu wrote:
> Good point. I think we can return, e.g. -EFAULT if we failed in
> get_next(). Then, we can read out next page, for example.

Why -EFAULT?

Running this

        size = 1;
        ret = insn_decode(&insn, b, size, INSN_MODE_64)

i.e., buffer size is 1:

./arch/x86/tools/insn_sanity: Success: decoded and checked 10000 random instructions with 0 errors (seed:0x9994a137)
insn buffer:
0x48 0xcf 0x48 0x83 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 
supplied buf size: 15, ret 0
supplied buf size: 2, ret 0
supplied buf size: 3, ret 0
supplied buf size: 4, ret 0
insn_decode: entry
insn_decode: will get_length
insn_get_immediate: getting immediate
insn_get_displacement: getting displacement
insn_get_sib: getting sib
insn_get_modrm: entry
insn_get_opcode: entry
insn_get_prefixes: entry, prefixes->got: 0
insn_get_prefixes: 1
insn_get_prefixes: REX
insn_get_prefixes: VEX
insn_get_prefixes: validate_next: 0
insn_get_prefixes: insn->next_byte: 0x7ffec297c3e1, insn->end_kaddr: 0x7ffec297c3e1
insn_get_prefixes: errored out
supplied buf size: 1, ret -22

is caught in validate_next() where ->next_byte == ->end_kaddr.

I'm thinking we should return EOF here, to denote that we're reached the
end and then propagate that error up the callchain.

We don't have "define EOF" in the kernel but we can designate one for
the insn decoder, perhaps

#define EOF      -1

as stdio.h does:

/* The value returned by fgetc and similar functions to indicate the
   end of the file.  */
#define EOF (-1)

Hmm, but then the callers would need to know EOF too so maybe EIO or
something.

In any case, it should be a value which callers should be able to use to
get told that input buffer is truncated...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
