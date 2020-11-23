Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366062C0E94
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 16:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732149AbgKWPPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 10:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729718AbgKWPPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 10:15:21 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D01C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 07:15:21 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id p6so6611101plr.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 07:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=9/7B9fYOBF3iBNDP75oo3XjDT3J214mKbuz8gALB4vU=;
        b=yVT8mRm3Z3LX4kK+1gmW0OdDkKPQsxQqCiNqqyao3OeXSp3AeU/oUDBO2LFha72Ykg
         hfakFOwwGzMWTxhbJ9u4ZRrLs9E+AUi3bUdWX7FF9C1AL9DI7uzuPx703IMYlUpEfQ0R
         cKbQk2gp7fkskTTopdejNkIPV40k3NdJdEWpv8NlYlb+lwXNFQ7m4QTsPwnXAY41XDjo
         ie2xHVuANYQFTwR5JV4GsFGoOojFILHnydRahEGFMrSdyzuTcX1MyaggfyX5GhzN48f7
         dxYqGPnL5YK+lGPBgsFICbFcJ3HdWvHqDNfvP4QmHS7Z6Td+jfStdZ8S8kzdPOmMP3XW
         IYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=9/7B9fYOBF3iBNDP75oo3XjDT3J214mKbuz8gALB4vU=;
        b=UZI4tj9BfbiOdJB4bhB5mSyRCnHNxB0xTK1p7WWlHVPbkzmBNksMghTrgOImb23lxW
         LVkb9SVaaDbukjHbcjZFGQ40gk6H+mMkwMU263pbggg3Bn46pg63oPzDvq/qluGbc+va
         n7KDoWsfS1Ey6P6sBMUbuHsXR+YYZNPuYfnqcR30zc+R8E/MEYhBN7roxNLdfdi9uus0
         ElOgPcqqJDi+mIZa7FqsRvWfLFkrgb8vxbxCwdBLSL0YVDzbtw+CEcXaOAe724P+6dOj
         osF3BY0Fze4W/HYAI3c5efEd7HG2Be150JVTk6g2vQEH+j1c6ApvN1RQ9wF6Jo4PP0Ji
         Fiew==
X-Gm-Message-State: AOAM533wspOgTk+83CyoEMApoVFSbnndh1dHUylyh+K0nt5R9iBTNZlY
        v++VOROdvp4zS8xY2bT030KSOQ==
X-Google-Smtp-Source: ABdhPJzPXkVRGeAzX8ONsYwMK6/RMdfFNxyslupj1imDDyoMb4VPUrwfTY+HgnKVxxx/unH4Oe4Vhw==
X-Received: by 2002:a17:902:d207:b029:da:13cb:e182 with SMTP id t7-20020a170902d207b02900da13cbe182mr1831784ply.69.1606144520547;
        Mon, 23 Nov 2020 07:15:20 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:344b:912a:a361:223f? ([2601:646:c200:1ef2:344b:912a:a361:223f])
        by smtp.gmail.com with ESMTPSA id g3sm3460848pfr.145.2020.11.23.07.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 07:15:19 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 05/12] x86: rework arch_local_irq_restore() to not use popf
Date:   Mon, 23 Nov 2020 07:15:18 -0800
Message-Id: <DD12CB44-457E-4FE1-8240-B334B785A93C@amacapital.net>
References: <894a4cec-8426-4152-d391-474711040c5b@suse.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "VMware, Inc." <pv-drivers@vmware.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <894a4cec-8426-4152-d391-474711040c5b@suse.com>
To:     =?utf-8?Q?J=C3=BCrgen_Gro=C3=9F?= <jgross@suse.com>
X-Mailer: iPhone Mail (18B92)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org





> On Nov 22, 2020, at 9:22 PM, J=C3=BCrgen Gro=C3=9F <jgross@suse.com> wrote=
:
>=20
> =EF=BB=BFOn 22.11.20 22:44, Andy Lutomirski wrote:
>>> On Sat, Nov 21, 2020 at 10:55 PM J=C3=BCrgen Gro=C3=9F <jgross@suse.com>=
 wrote:
>>>=20
>>> On 20.11.20 12:59, Peter Zijlstra wrote:
>>>> On Fri, Nov 20, 2020 at 12:46:23PM +0100, Juergen Gross wrote:
>>>>> +static __always_inline void arch_local_irq_restore(unsigned long flag=
s)
>>>>> +{
>>>>> +    if (!arch_irqs_disabled_flags(flags))
>>>>> +            arch_local_irq_enable();
>>>>> +}
>>>>=20
>>>> If someone were to write horrible code like:
>>>>=20
>>>>       local_irq_disable();
>>>>       local_irq_save(flags);
>>>>       local_irq_enable();
>>>>       local_irq_restore(flags);
>>>>=20
>>>> we'd be up some creek without a paddle... now I don't _think_ we have
>>>> genius code like that, but I'd feel saver if we can haz an assertion in=

>>>> there somewhere...
>>>>=20
>>>> Maybe something like:
>>>>=20
>>>> #ifdef CONFIG_DEBUG_ENTRY // for lack of something saner
>>>>       WARN_ON_ONCE((arch_local_save_flags() ^ flags) & X86_EFLAGS_IF);
>>>> #endif
>>>>=20
>>>> At the end?
>>>=20
>>> I'd like to, but using WARN_ON_ONCE() in include/asm/irqflags.h sounds
>>> like a perfect receipt for include dependency hell.
>>>=20
>>> We could use a plain asm("ud2") instead.
>> How about out-of-lining it:
>> #ifdef CONFIG_DEBUG_ENTRY
>> extern void warn_bogus_irqrestore();
>> #endif
>> static __always_inline void arch_local_irq_restore(unsigned long flags)
>> {
>>        if (!arch_irqs_disabled_flags(flags)) {
>>                arch_local_irq_enable();
>>        } else {
>> #ifdef CONFIG_DEBUG_ENTRY
>>                if (unlikely(arch_local_irq_save() & X86_EFLAGS_IF))
>>                     warn_bogus_irqrestore();
>> #endif
>> }
>=20
> This couldn't be a WARN_ON_ONCE() then (or it would be a catch all).

If you put the WARN_ON_ONCE in the out-of-line helper, it should work reason=
ably well.

> Another approach might be to open-code the WARN_ON_ONCE(), like:
>=20
> #ifdef CONFIG_DEBUG_ENTRY
> extern void warn_bogus_irqrestore(bool *once);
> #endif
>=20
> static __always_inline void arch_local_irq_restore(unsigned long flags)
> {
>    if (!arch_irqs_disabled_flags(flags))
>        arch_local_irq_enable();
> #ifdef CONFIG_DEBUG_ENTRY
>    {
>        static bool once;
>=20
>        if (unlikely(arch_local_irq_save() & X86_EFLAGS_IF))
>            warn_bogus_irqrestore(&once);
>    }
> #endif
> }
>=20

I don=E2=80=99t know precisely what a static variable in an __always_inline f=
unction will do, but I imagine it will be, at best, erratic, especially when=
 modules are involved.

>=20
> Juergen
> <OpenPGP_0xB0DE9DD628BF132F.asc>
