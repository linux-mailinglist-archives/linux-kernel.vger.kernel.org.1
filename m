Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393CA2B6EF0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgKQTl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:41:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:54010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbgKQTl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:41:27 -0500
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C3D820888;
        Tue, 17 Nov 2020 19:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605642086;
        bh=xeIePTaKBoDlMkpkc1YVny+UD79ipIwa6haKrulQGeA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gMKqsgsBm+aPbwxvhQZmyG5Yx62VJYs+C4oWgAwTonBU/D/UPmfJSrzSabtzrYL9Z
         GGY1lnwQNPecH3bkOWwZLsdJPVegjNF/CQ24Gsi6uu9Al7OwFnu2EJvEkZXlPPS+kK
         +fbcJHvELzwHKlp9ESZClPYhY+BinZ+RnhIdst1U=
Date:   Tue, 17 Nov 2020 21:41:18 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jethro Beekman <jethro@fortanix.com>,
        Cedric Xing <cedric.xing@intel.com>, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, asapek@google.com,
        chenalexchen@google.com, conradparker@google.com,
        cyhanish@google.com, dave.hansen@intel.com, haitao.huang@intel.com,
        kai.huang@intel.com, kai.svahn@intel.com, kmoy@google.com,
        ludloff@google.com, luto@kernel.org, nhorman@redhat.com,
        npmccallum@redhat.com, puiterwijk@redhat.com, rientjes@google.com,
        tglx@linutronix.de, yaozhangx@google.com, mikko.ylinen@intel.com
Subject: Re: [PATCH v41 19/24] x86/vdso: Implement a vDSO for Intel SGX
 enclave call
Message-ID: <20201117194118.GF10393@kernel.org>
References: <20201112220135.165028-1-jarkko@kernel.org>
 <20201112220135.165028-20-jarkko@kernel.org>
 <20201117131402.GD5719@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117131402.GD5719@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 02:14:02PM +0100, Borislav Petkov wrote:
> On Fri, Nov 13, 2020 at 12:01:30AM +0200, Jarkko Sakkinen wrote:
> > diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
> > index 2ad757fb3c23..9915fbd34264 100644
> > --- a/arch/x86/entry/vdso/Makefile
> > +++ b/arch/x86/entry/vdso/Makefile
> > @@ -27,6 +27,7 @@ VDSO32-$(CONFIG_IA32_EMULATION)	:= y
> >  vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o
> >  vobjs32-y := vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
> >  vobjs32-y += vdso32/vclock_gettime.o
> > +vobjs-$(VDSO64-y)		+= vsgx.o
> 
> Why?
> 
> This needs to be CONFIG_X86_SGX as you need this vdso functionality only
> when SGX is enabled.

Agreed.

> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

/Jarkko
