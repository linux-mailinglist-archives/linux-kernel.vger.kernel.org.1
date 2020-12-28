Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6B42E6B2F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732231AbgL1W4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 17:56:32 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38262 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729646AbgL1Whh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 17:37:37 -0500
Received: from zn.tnic (p200300ec2f07e40057167202136ef09a.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:e400:5716:7202:136e:f09a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C75CC1EC03CF;
        Mon, 28 Dec 2020 23:36:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1609195015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tSgkfnt/UUQvT/KFBsvO/zmoogVrWDacpZ6DI9jEwds=;
        b=ZxXMghFnydpnNENMksdGavQD2HydkvIiYYBVjV9WiPF7fAp5DRon05Gpog+NDfSP2futZ1
        r+o6ezqycG7bl5oVkhwdl4fi4rAj0S10/eGMUk31Aij+cOg29rKvSIihuoiZLMsfzxMQnK
        7IugC3Bgp2AeXnzyKMAgslWUWIISoHA=
Date:   Mon, 28 Dec 2020 23:36:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <seanjc@google.com>,
        Peter Gonda <pgonda@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] x86/sev-es: Fix SEV-ES OUT/IN immediate opcode vc
 handling
Message-ID: <20201228223650.GD20321@zn.tnic>
References: <20201217010409.3675060-1-pgonda@google.com>
 <X9uTESe5n3ApvnOD@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X9uTESe5n3ApvnOD@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 09:19:13AM -0800, Sean Christopherson wrote:
> On Wed, Dec 16, 2020, Peter Gonda wrote:
> > 
> > The IN and OUT immediate instructions only use an 8-bit immediate. The
> > current VC handler uses the entire 32-bit immediate value. These
> > instructions only set the first bytes.
> > 
> > Tested with a loop back port with "outb %0,$0xe0". Before the port seen
> > by KVM was 0xffffffffffffffe0 instead of 0xe0. After the correct port
> > was seen by KVM and the guests loop back OUT then IN were equal.
> > 
> > 
> > Signed-off-by: Peter Gonda <pgonda@google.com>
> > Acked-by: David Rientjes <rientjes@google.com>
> > 
> > 
> > ---
> >  arch/x86/kernel/sev-es-shared.c | 8 ++++++--
> >  drivers/Makefile                | 1 +
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/sev-es-shared.c b/arch/x86/kernel/sev-es-shared.c
> > index 7d04b356d44d..6c790377c55c 100644
> > --- a/arch/x86/kernel/sev-es-shared.c
> > +++ b/arch/x86/kernel/sev-es-shared.c
> > @@ -305,14 +305,14 @@ static enum es_result vc_ioio_exitinfo(struct es_em_ctxt *ctxt, u64 *exitinfo)
> >  	case 0xe4:
> >  	case 0xe5:
> >  		*exitinfo |= IOIO_TYPE_IN;
> > -		*exitinfo |= (u64)insn->immediate.value << 16;
> > +		*exitinfo |= insn->immediate.bytes[0] << 16;
> 
> Can't we just drop the explicit cast to u64?  Or explicitly cast to u8?  Doesn't
> really matter, but poking into the backing bytes feels a bit backwards.

GHCB spec says for IOIO_PROT (exit code 0x7b):

"SW_EXITINFO1 will be set as documented in AMD64 Architecture
Programmer’s Manual Volume 2: System Programming, Section 15.10.2"

That section has "Figure 15-2. EXITINFO1 for IOIO Intercept" where
[31:16] is the intercepted I/O port.

Now, insn->immediate.value is a union between a signed int and a
unsigned char bytes[4] array so in order to be absolutely correct, that
should use:

	insn->immediate.bytes[0]

instead, to get the port byte only, before shifting it into [31:16]. The
(u64) cast doesn't matter because *exitinfo = 0 at function entry and
that is part of the first assignment afterwards.

I still don't see how that sign extension 0xffffffffffffffe0 can happen,
though. Maybe something gets added during instruction decoding...

Hmmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
