Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B125F2E6C91
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgL1Xnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 18:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbgL1Xnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 18:43:55 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E3BC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 15:43:15 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id lj6so529896pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 15:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KdY1wS/rYHCSOYMjTfERbDcI4DcnIWo+QIgBl5bB1jk=;
        b=m3vcS6BdgKS/yXLIAFn813WCIsq5OH+pHCKKlaNiR2DS1+eQ2ZnBLlJjsyVySlR3yd
         mGWr5lqARNOyxyOxRjMBGktmWPJglvCsXELZiplMlTqm2pvbDBp8dt0H3Lk7TcBUSzUv
         HRBEQj7W5PE1LdivHNia0mBR4/gAkSyEDZr+CRwzcnNEuPIfRu3lnh3E735i7o31gybX
         cxDX+LSlBUoA490QABXtbf5jthT/xhjSH+b43QNH/2BXseS3WM3bj9AQ5/qLMPGSCxSj
         Gk8BxCinLZOrFOSJnKAwvpTcAAMtC8LRO/ZMLyy4rL1oaJpA19B0xbgCZYvxm4L2ztBq
         4nCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KdY1wS/rYHCSOYMjTfERbDcI4DcnIWo+QIgBl5bB1jk=;
        b=aQ98clSk+OGhRLuIHfeGP10ViqnMttFU2AtLF3B3eFKE9xNgUa00bKAnKmXxw1CA/j
         TwfEJyBjw4VfaTpYYd5idggBBupp4GfbBlwEDsvTZreOGD1s7HyaWqUiNCsDoPH48YKc
         YfqClyVnYd6LPiAJGeHmvJR6x+P/EW9h9s4F2cOuPEhf8nGzoYih/dB+V2WgKpEeXuFU
         0Qc8V9czbzKrCGzqqFYDQCxyKI70SvppYrM5MdU1SyDQeduBhMgj0c40sxyKB1YOAggv
         1pRmrVHrgEPuXnnkkObCK4c6r6HvhM2gf+P9j5A4rogbtfd0k09z2kuIui/mh4cCsJ4R
         grDQ==
X-Gm-Message-State: AOAM531pRchB4BgSWJKFvmcD8SlQimN3wursASgw9IiDgZHDTKOhDJTg
        T66mMNK7cVcdzKXoZ7/KO33RCg==
X-Google-Smtp-Source: ABdhPJxsOfbVzxtX2HuIMp1swW4UR0Sw8DZgM8XhIRjOer9pEP5QBUwuO3Udr/qv3GLZI5avkNyACw==
X-Received: by 2002:a17:902:12c:b029:da:e63c:dc92 with SMTP id 41-20020a170902012cb02900dae63cdc92mr46845987plb.71.1609198993698;
        Mon, 28 Dec 2020 15:43:13 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id 8sm21335103pfz.93.2020.12.28.15.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 15:43:13 -0800 (PST)
Date:   Mon, 28 Dec 2020 15:43:06 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] x86/sev-es: Fix SEV-ES OUT/IN immediate opcode vc
 handling
Message-ID: <X+ptiuVAMXJ3uBX8@google.com>
References: <20201217010409.3675060-1-pgonda@google.com>
 <X9uTESe5n3ApvnOD@google.com>
 <20201228223650.GD20321@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201228223650.GD20321@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020, Borislav Petkov wrote:
> On Thu, Dec 17, 2020 at 09:19:13AM -0800, Sean Christopherson wrote:
> > On Wed, Dec 16, 2020, Peter Gonda wrote:
> > > 
> > > The IN and OUT immediate instructions only use an 8-bit immediate. The
> > > current VC handler uses the entire 32-bit immediate value. These
> > > instructions only set the first bytes.
> > > 
> > > Tested with a loop back port with "outb %0,$0xe0". Before the port seen
> > > by KVM was 0xffffffffffffffe0 instead of 0xe0. After the correct port
> > > was seen by KVM and the guests loop back OUT then IN were equal.
> > > 
> > > 
> > > Signed-off-by: Peter Gonda <pgonda@google.com>
> > > Acked-by: David Rientjes <rientjes@google.com>
> > > 
> > > 
> > > ---
> > >  arch/x86/kernel/sev-es-shared.c | 8 ++++++--
> > >  drivers/Makefile                | 1 +
> > >  2 files changed, 7 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/x86/kernel/sev-es-shared.c b/arch/x86/kernel/sev-es-shared.c
> > > index 7d04b356d44d..6c790377c55c 100644
> > > --- a/arch/x86/kernel/sev-es-shared.c
> > > +++ b/arch/x86/kernel/sev-es-shared.c
> > > @@ -305,14 +305,14 @@ static enum es_result vc_ioio_exitinfo(struct es_em_ctxt *ctxt, u64 *exitinfo)
> > >  	case 0xe4:
> > >  	case 0xe5:
> > >  		*exitinfo |= IOIO_TYPE_IN;
> > > -		*exitinfo |= (u64)insn->immediate.value << 16;
> > > +		*exitinfo |= insn->immediate.bytes[0] << 16;
> > 
> > Can't we just drop the explicit cast to u64?  Or explicitly cast to u8?  Doesn't
> > really matter, but poking into the backing bytes feels a bit backwards.
> 
> GHCB spec says for IOIO_PROT (exit code 0x7b):
> 
> "SW_EXITINFO1 will be set as documented in AMD64 Architecture
> Programmer’s Manual Volume 2: System Programming, Section 15.10.2"
> 
> That section has "Figure 15-2. EXITINFO1 for IOIO Intercept" where
> [31:16] is the intercepted I/O port.
> 
> Now, insn->immediate.value is a union between a signed int and a
> unsigned char bytes[4] array so in order to be absolutely correct, that
> should use:
> 
> 	insn->immediate.bytes[0]

Eh, casting to u8 is "absolutely correct" as well.  I don't like using bytes[]
because it feels like accessing the raw data as opposed to the end result of
decoding, but it's not a sticking point.

> (u64) cast doesn't matter because *exitinfo = 0 at function entry and
> that is part of the first assignment afterwards.
> 
> I still don't see how that sign extension 0xffffffffffffffe0 can happen,
> though. Maybe something gets added during instruction decoding...

Yes, insn_get_immediate() sets insn->immediate.value directly and sign extends
the imm8 (which is correct, e.g. for "AND r/m64, imm8"). 

	switch (inat_immediate_size(insn->attr)) {
	case INAT_IMM_BYTE:
		insn->immediate.value = get_next(signed char, insn);
		insn->immediate.nbytes = 1;
		break;
	...
	}
> 
> Hmmm.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
