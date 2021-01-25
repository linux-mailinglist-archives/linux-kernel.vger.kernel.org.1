Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A916302960
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 18:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbhAYRzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 12:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730733AbhAYRwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 12:52:34 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AB9C061793
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 09:51:53 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id j12so8810870pfj.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 09:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Lq7BulxN1R4lEKV1xZA2mtR1GA7MLBxCJ4KB2eBehaQ=;
        b=KGQRkEd2ieJx47uclyzjAAnonpsEb+QgFE0KxMTCK9kcDL8xt3cbhSNokwL7is6g2r
         /GtjnPdr/FtdtvFXTNGiXpATi/BWuHd1wqFbQxj+N/73pj8ENjW2ZVOu12f+EZccZdiL
         TetsrEs1oPtT7liQB+XVkReWWuUvzRpl6vOjr/KH4HE9DyvduKo6Sk+mJml6IDVhsrRn
         F2X9XXfIwNOB9QfHSQdeLOEo6fT+8svBPCnA3A1OAY0id5NbPje81f6GmPQ4bcMOzsVc
         ydKp8gBPHcAwoazm5k00a11hSHOojgbNY5I9jkKa1dcEf2r8Gs8FdmzC9bh6/hKQu6rN
         bHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Lq7BulxN1R4lEKV1xZA2mtR1GA7MLBxCJ4KB2eBehaQ=;
        b=ZzgRnps9VjG203etdylwAoBIZTff61UHxNlIi5tVn0T90adp/vqVS3ww7Ma1cUgCX1
         wAeEsvkBtc7be0ZsX+Eg8tVYZ/+1/27/j864tZxQ+8juG4YwcP8smYPuw6w2yv6FxwG/
         VVZPIuGwkkmb2wLKXZyhtXBBfFSI79Xu90ULG5v9rMrEncT4F9EyclAt+FyBwPRSWVat
         0VYaLscHD+hFEDtM1YEsiiG6M5dN+98GDTdFJu6UVQ7UBOVWX3iQTxbX8FUQf7CBL1Ka
         psd67tOIF6lwaZ/Uxv1034+mX4zumv3h0YlDEcddPMaSbKM+AQoYfB795z0jl/h7LCTg
         p1cQ==
X-Gm-Message-State: AOAM531acvzyYYdPMx/fSl8VjTZT6nAmfirtrl0JgdFvgvXpKEa/ZqQl
        +qpbkmg0lehjvKft2+YTj1nlAg==
X-Google-Smtp-Source: ABdhPJxx+Eh59ihZlE+D76ROQnS78Lt+vut1FVsZkoLdZnGLzRiFgtQy4gSGM7c8W9/cjZ6UEZ2ITg==
X-Received: by 2002:a62:380b:0:b029:1bc:98d8:4d25 with SMTP id f11-20020a62380b0000b02901bc98d84d25mr1440556pfa.28.1611597112677;
        Mon, 25 Jan 2021 09:51:52 -0800 (PST)
Received: from ?IPv6:2600:1010:b065:540e:3477:9a03:7aee:ee3? ([2600:1010:b065:540e:3477:9a03:7aee:ee3])
        by smtp.gmail.com with ESMTPSA id 184sm16930818pgi.92.2021.01.25.09.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 09:51:48 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V2] x86/entry/64: De-Xen-ify our NMI code further
Date:   Mon, 25 Jan 2021 09:51:45 -0800
Message-Id: <4415FFC4-995A-4C77-9A96-744ED697AF05@amacapital.net>
References: <20210125123859.39b244ca@gandalf.local.home>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20210125123859.39b244ca@gandalf.local.home>
To:     Steven Rostedt <rostedt@goodmis.org>
X-Mailer: iPhone Mail (18C66)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jan 25, 2021, at 9:39 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> =EF=BB=BFOn Mon, 25 Jan 2021 15:45:06 +0800
> Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>=20
>> From: Lai Jiangshan <laijs@linux.alibaba.com>
>>=20
>> The commit 929bacec21478("x86/entry/64: De-Xen-ify our NMI code") simplif=
ied
>> the NMI code by changing paravirt code into native code and left a commen=
t
>> about "inspecting RIP instead".  But until now, "inspecting RIP instead"
>> has not been made happened and this patch tries to complete it.
>>=20
>> Comments in the code was from Andy Lutomirski.  Thanks!
>>=20
>> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
>> ---
>> arch/x86/entry/entry_64.S | 44 ++++++++++-----------------------------
>> 1 file changed, 11 insertions(+), 33 deletions(-)
>>=20
>> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
>> index cad08703c4ad..21f67ea62341 100644
>> --- a/arch/x86/entry/entry_64.S
>> +++ b/arch/x86/entry/entry_64.S
>> @@ -1268,32 +1268,14 @@ SYM_CODE_START(asm_exc_nmi)
>>    je    nested_nmi
>>=20
>>    /*
>> -     * Now test if the previous stack was an NMI stack.  This covers
>> -     * the case where we interrupt an outer NMI after it clears
>> -     * "NMI executing" but before IRET.  We need to be careful, though:
>> -     * there is one case in which RSP could point to the NMI stack
>> -     * despite there being no NMI active: naughty userspace controls
>> -     * RSP at the very beginning of the SYSCALL targets.  We can
>> -     * pull a fast one on naughty userspace, though: we program
>> -     * SYSCALL to mask DF, so userspace cannot cause DF to be set
>> -     * if it controls the kernel's RSP.  We set DF before we clear
>> -     * "NMI executing".
>> +     * Now test if we interrupted an outer NMI that just cleared "NMI
>> +     * executing" and is about to IRET.  This is a single-instruction
>> +     * window.  This check does not handle the case in which we get a
>> +     * nested interrupt (#MC, #VE, #VC, etc.) after clearing
>> +     * "NMI executing" but before the outer NMI executes IRET.
>>     */
>> -    lea    6*8(%rsp), %rdx
>> -    /* Compare the NMI stack (rdx) with the stack we came from (4*8(%rsp=
)) */
>> -    cmpq    %rdx, 4*8(%rsp)
>> -    /* If the stack pointer is above the NMI stack, this is a normal NMI=
 */
>> -    ja    first_nmi
>> -
>> -    subq    $EXCEPTION_STKSZ, %rdx
>> -    cmpq    %rdx, 4*8(%rsp)
>> -    /* If it is below the NMI stack, it is a normal NMI */
>> -    jb    first_nmi
>> -
>> -    /* Ah, it is within the NMI stack. */
>> -
>> -    testb    $(X86_EFLAGS_DF >> 8), (3*8 + 1)(%rsp)
>> -    jz    first_nmi    /* RSP was user controlled. */
>=20
> So we no longer check to see if the current stack is on the NMI stack.
> Makes sense, since this beginning of the NMI code can not be interrupted,
> as there's no breakpoints or faults that can occur when that happens. The
> $nmi_executing is set in all other locations except for:
>=20
>  repeat_nmi - end_repeat_nmi
>  and for the iretq itself (.Lnmi_iret).
>=20
> Thus, by just checking the nmi_executing variable on the stack along with
> the RIP compared to repeat_nim-end_repeat_nmi + .Lnmi_iret, we can safely
> tell if the NMI is nested or not.
>=20
> I was working on rewriting the beginning comments to reflect these updates=
,
> and discovered a possible bug that exists (unrelated to this patch).
>=20
>> +    cmpq    $.Lnmi_iret, 8(%rsp)
>> +    jne    first_nmi
>>=20
>=20
> On triggering an NMI from user space, I see the switch to the thread stack=

> is done, and "exc_nmi" is called.
>=20
> The problem I see with this is that exc_nmi is called with the thread
> stack, if it were to take an exception, NMIs would be enabled allowing for=

> a nested NMI to run. =46rom what I can tell, I don't see anything stopping=

> that NMI from executing over the currently running NMI. That is, this mean=
s
> that NMI handlers are now re-entrant.

That was intentional in my part. The C code checks for this condition and ha=
ndles it, just like it does on 32-bit kernels.
