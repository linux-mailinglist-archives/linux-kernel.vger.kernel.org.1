Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD2F203D7A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 19:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbgFVRJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 13:09:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46366 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729840AbgFVRJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:09:12 -0400
Received: from zn.tnic (p200300ec2f0a2500329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:2500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B9E141EC0283;
        Mon, 22 Jun 2020 19:09:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592845750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Y3LIWY+KnYvD5SmbVfic/Btuy5xncoQOY7OQQwRbvX0=;
        b=i2/KkFrfoUY4Gm7+vsS+DhMOqAxrQJ3GDR4nNNh9ZeY0p1Pq7EQzLEm1NNkNa+n0CBe7p7
        lvVAq8r3213Y49iamCrLnk4B5DBrCcW3MLLJplti2WAZ183ra7AY9sEk3rsPHzPMffHptg
        P1zEmlxLUHqehLwkoLQ2CU5vgOC4yoE=
Date:   Mon, 22 Jun 2020 19:09:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, jpa@kernelbug.mail.kapsi.fi,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/fpu: Reset MXCSR to default in kernel_fpu_begin()
Message-ID: <20200622170908.GH32200@zn.tnic>
References: <20200619174127.22304-1-bp@alien8.de>
 <20200619174127.22304-2-bp@alien8.de>
 <CALCETrXZhFJGJA2h4zP743KYTtni-rQSUME8mtSYUdk1-ZTauQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrXZhFJGJA2h4zP743KYTtni-rQSUME8mtSYUdk1-ZTauQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 11:01:44AM -0700, Andy Lutomirski wrote:
> On Fri, Jun 19, 2020 at 10:41 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > From: Petteri Aimonen <jpa@git.mail.kapsi.fi>
> >
> > Previously, kernel floating point code would run with the MXCSR control
> > register value last set by userland code by the thread that was active
> > on the CPU core just before kernel call. This could affect calculation
> > results if rounding mode was changed, or a crash if a FPU/SIMD exception
> > was unmasked.
> >
> > Restore MXCSR to the kernel's default value.
> >
> >  [ bp: Carve out from a bigger patch by Petteri, add feature check, add
> >    FNINIT call too (amluto). ]
> 
> Acked-by: Andy Lutomirski <luto@kernel.org>
> 
> but:
> 
> shouldn't kernel_fpu_begin() end with a barrier()?

the "fninit" thing is already asm volatile or do you want the explicit
memory clobber of barrier?

If so, why?

The LDMXCSR and FNINIT have effect only on hardware state...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
