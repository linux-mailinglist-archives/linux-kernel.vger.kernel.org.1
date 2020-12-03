Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47EE2CD5A4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 13:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388982AbgLCMio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 07:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgLCMio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 07:38:44 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A31C061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 04:38:04 -0800 (PST)
Received: from zn.tnic (p200300ec2f0dc5005cbee08096bf44b9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:c500:5cbe:e080:96bf:44b9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 938381EC01A2;
        Thu,  3 Dec 2020 13:38:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606999082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=V2cz35lINT9Zeuy3nKGMlMztk2TKZ0PdsRQLOuQYazM=;
        b=TQjge2UtyKvyX4W7wPZD4VoqMFkOqiHezzVpHp6fu8gG7V9ib0M5TpC4fdJ+23tkE1osbR
        LsB41r55lCzFSqa8x4blfp17UXvdpksmuqkMW3P5C8YEgrgYu6cJjG7nEdLjRIgAqDs45P
        nI3EYjbAH7WWjYk4w5RPpA8yVFczVT8=
Date:   Thu, 3 Dec 2020 13:37:57 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Jann Horn <jannh@google.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] x86/uprobes: Fix not using prefixes.nbytes for
 loop over prefixes.bytes
Message-ID: <20201203123757.GH3059@zn.tnic>
References: <160697102582.3146288.10127018634865687932.stgit@devnote2>
 <160697103739.3146288.7437620795200799020.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <160697103739.3146288.7437620795200799020.stgit@devnote2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 01:50:37PM +0900, Masami Hiramatsu wrote:
> Since the insn.prefixes.nbytes can be bigger than the size of
> insn.prefixes.bytes[] when a same prefix is repeated, we have to
> check whether the insn.prefixes.bytes[i] != 0 and i < 4 instead
> of insn.prefixes.nbytes.
> This introduces for_each_insn_prefix() macro for this purpose.
> 
> Fixes: 2b1444983508 ("uprobes, mm, x86: Add the ability to install and remove uprobes breakpoints")
> Reported-by: syzbot+9b64b619f10f19d19a7c@syzkaller.appspotmail.com
> Debugged-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  Changes in v2:
>   - Add for_each_insn_prefix() macro and fix to check index first.
> ---
>  arch/x86/include/asm/insn.h |   15 +++++++++++++++
>  arch/x86/kernel/uprobes.c   |   10 ++++++----
>  2 files changed, 21 insertions(+), 4 deletions(-)

Warning: Kernel ABI header at 'tools/arch/x86/include/asm/insn.h' differs from latest version at 'arch/x86/include/asm/insn.h'

> diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
> index 5c1ae3eff9d4..e6b38ebd3a1c 100644
> --- a/arch/x86/include/asm/insn.h
> +++ b/arch/x86/include/asm/insn.h
> @@ -201,6 +201,21 @@ static inline int insn_offset_immediate(struct insn *insn)
>  	return insn_offset_displacement(insn) + insn->displacement.nbytes;
>  }
>  
> +/**
> + * for_each_insn_prefix() -- Iterate prefixes in the instruction
> + * @insn: Pointer to struct insn.
> + * @idx:  Index storage.
> + * @prefix: Prefix byte.
> + *
> + * Iterate prefix bytes of given @insn. Each prefix byte is stored in @prefix
> + * and the index is stored in @idx (note that this @idx is just for a cursor,
> + * do not change it.)
> + * Since prefixes.nbytes can be bigger than 4 if some prefixes are repeated,
> + * we can not use it for looping over the prefixes.

Please use passive voice: no "we" or "I", etc,

> + */
> +#define for_each_insn_prefix(insn, idx, prefix)	\
> +	for (idx = 0; idx < 4 && (prefix = insn->prefixes.bytes[idx]) != 0; idx++)

Btw, looking at the struct insn definition, that prefixes member should
have a comment above it that those are the legacy prefixes which can be
<= 4. But that's minor.

In any case, I'll fix up the minor issues now but pls remember to do
them in the future.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
