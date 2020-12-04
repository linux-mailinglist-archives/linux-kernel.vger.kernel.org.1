Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D82C2CF058
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 16:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbgLDPGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 10:06:03 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34638 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbgLDPGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 10:06:02 -0500
Received: from zn.tnic (p200300ec2f12b100a8acd31b3e2f4e6b.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:b100:a8ac:d31b:3e2f:4e6b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 76F1F1EC0380;
        Fri,  4 Dec 2020 16:05:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607094321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8vwBFDJPYoB3/M/m0V1lRoy6WWaJ5t8cn3KMXOOqFvI=;
        b=rJvQvvvPF68xiUsi3O+q8ks5y7OQFPhlPIYGperspDWn19yt8r8pzzKjDcMPb6FseERN1n
        bo3HItdEhgffVRjFmfbCSP/fm8X+s7uH/tqljLxfaLagCF5542ga0+Ral6ryczM6KmyItj
        NbuS9yWa9PaEk63fJHb8tKeIc3u8Xxk=
Date:   Fri, 4 Dec 2020 16:05:22 +0100
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
Subject: Re: [PATCH v3 1/3] x86/uprobes: Fix not using prefixes.nbytes for
 loop over prefixes.bytes
Message-ID: <20201204150522.GG31534@zn.tnic>
References: <160707930875.3296595.12884856538916078988.stgit@devnote2>
 <160707931985.3296595.4852247459424743502.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <160707931985.3296595.4852247459424743502.stgit@devnote2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 07:55:20PM +0900, Masami Hiramatsu wrote:
> +/**
> + * for_each_insn_prefix() -- Iterate prefixes in the instruction
> + * @insn: Pointer to struct insn.
> + * @idx:  Index storage.
> + * @prefix: Prefix byte.
> + *
> + * Iterate prefix bytes of given @insn. Each prefix byte is stored in @prefix
> + * and the index is stored in @idx (note that this @idx is just for a cursor,
> + * do not change it.)
> + * Since prefixes.nbytes can be bigger than NUM_INSN_FIELD_BYTES when some
> + * prefixes are repeated, it can not be used for looping over the prefixes.
> + */
> +#define for_each_insn_prefix(insn, idx, prefix)				\
> +	for (idx = 0;							\
> +	     idx < MAX_LEGACY_PREFIX_GROUPS &&				\

The problem I see here is that you check for the index limit to be
< MAX_LEGACY_PREFIX_GROUPS but the array itself is defined using
NUM_INSN_FIELD_BYTES, and that is confusing.

I guess this should be:

#define MAX_LEGACY_PREFIX_GROUPS	4
#define NUM_INSN_FIELD_BYTES		MAX_LEGACY_PREFIX_GROUPS

and later, iff the legacy prefixes array size needs separating from the
insn field array size, then the defines would need to change too.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
