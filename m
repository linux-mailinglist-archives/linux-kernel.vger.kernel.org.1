Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE89D2CFAFC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 11:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgLEKYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 05:24:12 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48698 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729022AbgLEKPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 05:15:33 -0500
Received: from zn.tnic (p200300ec2f21ef0015054ed9185c317a.dip0.t-ipconnect.de [IPv6:2003:ec:2f21:ef00:1505:4ed9:185c:317a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3E3C81EC043F;
        Sat,  5 Dec 2020 11:14:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607163280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0+RQceyNN3YTSvBdh4T4cQY4hNuuvTh0TJrn8lauovA=;
        b=GdD+8aKXku1fx/hd4C2RKl3LK/5ChSJS2Y7xqcmpuBKrkqK8IhBnentoB8p9FqbYrhQHFy
        2VZMC47fscpPiNJg962Dz7pYVtmIIZUTaFslvTuzQC2cZ4KOheaGfX7Sx8dehHmRdLir+i
        /GsMoZk3INraEKi/sZRv+drHijE1Lpw=
Date:   Sat, 5 Dec 2020 11:14:35 +0100
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
Message-ID: <20201205101435.GA26409@zn.tnic>
References: <160707930875.3296595.12884856538916078988.stgit@devnote2>
 <160707931985.3296595.4852247459424743502.stgit@devnote2>
 <20201204150522.GG31534@zn.tnic>
 <20201205091032.6956a5bad9330ec7b9b84dc5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201205091032.6956a5bad9330ec7b9b84dc5@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 05, 2020 at 09:10:32AM +0900, Masami Hiramatsu wrote:
> In the future, if x86 ISA is expanded and add a legacy prefix
> groups,

Very unlikely.

> then we have to add new insn_prefix_field data structure, which
> size will not depend on NUM_INSN_FIELD_BYTES, but still depend on
> MAX_LEGACY_PREFIX_GROUPS (and that will be 5).

Isn't that what I'm saying too?

Bottomline is, legacy prefixes should not use insn_field but a separate
element which array size is independent of insn_byte_t bytes[4].

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
