Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F992B60F4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 14:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbgKQNOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 08:14:22 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60094 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730014AbgKQNOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 08:14:09 -0500
Received: from zn.tnic (p200300ec2f101300ba25257689a011f5.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:1300:ba25:2576:89a0:11f5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 391221EC03CE;
        Tue, 17 Nov 2020 14:14:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605618847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NZRrHH8K2bEHEC4a+tB6N/fq8gG+I38ysLFz2AOgP60=;
        b=P3gBbiSSrXE9y0CZO80SkiKExytqj+588g+/N4mZLLRjyWaKBGnaPDQihqm1uznAEIMsip
        0OdpSRCD3AqRAKTdptQfrZliOls4g7v7kCCsIVDt0uGMfg0Zhpc8sX79DS3XtfAQbCozLh
        dY/F9hAlqzUV8icvIlPInw5S3CALVXE=
Date:   Tue, 17 Nov 2020 14:14:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>
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
Message-ID: <20201117131402.GD5719@zn.tnic>
References: <20201112220135.165028-1-jarkko@kernel.org>
 <20201112220135.165028-20-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201112220135.165028-20-jarkko@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 12:01:30AM +0200, Jarkko Sakkinen wrote:
> diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
> index 2ad757fb3c23..9915fbd34264 100644
> --- a/arch/x86/entry/vdso/Makefile
> +++ b/arch/x86/entry/vdso/Makefile
> @@ -27,6 +27,7 @@ VDSO32-$(CONFIG_IA32_EMULATION)	:= y
>  vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o
>  vobjs32-y := vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
>  vobjs32-y += vdso32/vclock_gettime.o
> +vobjs-$(VDSO64-y)		+= vsgx.o

Why?

This needs to be CONFIG_X86_SGX as you need this vdso functionality only
when SGX is enabled.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
