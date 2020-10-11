Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EE928A74E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 14:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387767AbgJKMUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 08:20:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44014 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387744AbgJKMUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 08:20:30 -0400
Received: from zn.tnic (p200300ec2f2354003014631d5e977466.dip0.t-ipconnect.de [IPv6:2003:ec:2f23:5400:3014:631d:5e97:7466])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 866481EC0407;
        Sun, 11 Oct 2020 14:20:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602418829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jixq01sMsKGEAuLRIcsPbYfdp2qRTUaRSujjQkfZrD4=;
        b=QJrngtxmGccgncJieutzXRRgh57jYJFX2eqlkYb2a5zwJuL34vTzGCdSwEuuYZKY/4+mqn
        6TprJpeAoiTSq/L1zA9oDlbNU1Rbyk7V6JqJ6SYUN/A+5kHZkyuRVwZrB8UA0d+MoFJDr/
        7IqqZ7vW8a5NoTR9qVDilY+ORY93Om0=
Date:   Sun, 11 Oct 2020 14:20:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Collabora Kernel ML <kernel@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Diego Elio =?utf-8?Q?Petten=C3=B2?= <flameeyes@flameeyes.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH] x86/x86_64_defconfig: Enable the serial console
Message-ID: <20201011122020.GA15925@zn.tnic>
References: <20201008162206.862203-1-enric.balletbo@collabora.com>
 <20201008164044.GE5505@zn.tnic>
 <4162cfa4-7bf2-3e6e-1b8c-e19187e6fa10@infradead.org>
 <2538da14-0f4b-5d4a-c7bf-6fdb46ba2796@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2538da14-0f4b-5d4a-c7bf-6fdb46ba2796@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 11, 2020 at 01:43:44PM +0200, Enric Balletbo i Serra wrote:
> We're also probably lacking a definition of what normal users mean, because I
> don't think normal users build their own kernel.

You'd be surprised.

> I think that at least X86_AMD_PLATFORM_DEVICE and MFD_INTEL_LPSS_PCI
> could be common enough to match within the category of needed to run
> in normal (or common) user mode(s). I can send a patch with only these
> two options.

How do you quantify those things are common enough?

> But, yes, the main purpose after this patch is the serial console for CI. I saw
> that there are already some configs with a specific purpose (tiny.config and
> xen.config). So, I am wondering if would be acceptable support another specific
> config for CI (i.e kernelci.config). Will it be acceptable?

Why does this config have to be upstream? Can't your build process
supply it? Also, can your config be of any use outside of kernel CI?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
