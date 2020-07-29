Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A15231700
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 02:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbgG2A4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 20:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730766AbgG2A4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 20:56:39 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BDFC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 17:56:39 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t1so1836974plq.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 17:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=xMlai4+jYP0XrSSpHNRx/rApchrWP8YqEYA3eY+3yls=;
        b=UuNmFd9SMA7htAxW4sk6ClTo4x1omHZFcWzYRt5hGDpJxWyUpEoQdzPWx0yFpZcbh0
         /94zTKZffmlVR4Smb/AA0kX8EhNye1sQ9sMKtxxPavv8nWJR7iSJNVzKrFoHY0Dy2vCz
         stZ99OEFzbDDzy3KFzZZDdD+XRHc5I/Yd6PxtQ87OP9Qh0SHqTSnUNiSjryTQgJ3idJ5
         X4lqLMbels7SAPYzl5j6Cj6H9D0JtS5x8T1Y6+HK3iXK8Uv889tR8Ti9qsyP1Vp9Jl47
         WVml3qZbKUNVldZGnIeNy13uukFrf4dbWQcdD51ayCOqrgKQy1r80ODAFS3jPyCRL+EH
         U2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=xMlai4+jYP0XrSSpHNRx/rApchrWP8YqEYA3eY+3yls=;
        b=VClXky7jiGMEi+/4cR3f0Mk/3qmyBXnqNX3dIgtPGaOkHkBIL116xu/J2/9JtNYHXu
         mVN5/nf1lkuMtJtXAlDf6/q4PsWcPlSDO0pPxRN1DPpQw8qt1f/PP922or+8bp4DssR0
         hWx2xnmT7yAAS5W/iCVLkXBsijszEfl6Iyi9v/2EBEkQMfDNSk/8CALRNKMnP3926FrP
         45rx2r3hTk8T6YMlw4x0iCUC8ATJH+DvZ4kxNwJjLfo0dEM921iu+hgp9Sf2Yz3XZ10d
         LRz9uqUa0vcE1a0UWBJDMq8RULiq/eYehY1UqHuY+yO7DAk3+r1KtYyFmH/ZQ7xP17KG
         yD1g==
X-Gm-Message-State: AOAM531J02fSyBoOotHkfCj3U2dBVr0lCBqqrjoUQQba7YHWpEFK2qd8
        541/Tb/V1PBMvJym816vXloXiw==
X-Google-Smtp-Source: ABdhPJxyaClYApBVWjGKj622ZwObVsWm9VC/kN6X2i+bkoDF7/tTFZxO0l+X9QNHJaTFgoHn4lNZ+A==
X-Received: by 2002:a17:90a:8985:: with SMTP id v5mr6918771pjn.181.1595984198399;
        Tue, 28 Jul 2020 17:56:38 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:eca9:c737:f7c5:9694? ([2601:646:c200:1ef2:eca9:c737:f7c5:9694])
        by smtp.gmail.com with ESMTPSA id x15sm222810pfr.208.2020.07.28.17.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 17:56:37 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: Random shadow stack pointer corruption
Date:   Tue, 28 Jul 2020 17:56:20 -0700
Message-Id: <9CB08BDB-0245-474A-BE03-C529F659581F@amacapital.net>
References: <CAMe9rOr=WsOnKk3x8AK-iB5JLCjJ7FaDKXsFp01+3BbJvLZqMA@mail.gmail.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>
In-Reply-To: <CAMe9rOr=WsOnKk3x8AK-iB5JLCjJ7FaDKXsFp01+3BbJvLZqMA@mail.gmail.com>
To:     "H.J. Lu" <hjl.tools@gmail.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 28, 2020, at 5:36 PM, H.J. Lu <hjl.tools@gmail.com> wrote:
>=20
> =EF=BB=BFOn Sat, Jul 18, 2020 at 4:35 PM Yu-cheng Yu <yu-cheng.yu@intel.co=
m> wrote:
>>=20
>>> On Sat, 2020-07-18 at 15:41 -0700, Dave Hansen wrote:
>>> On 7/18/20 11:24 AM, Yu-cheng Yu wrote:
>>>> On Sat, 2020-07-18 at 11:00 -0700, Andy Lutomirski wrote:
>>>>> On Sat, Jul 18, 2020 at 10:58 AM Yu-cheng Yu <yu-cheng.yu@intel.com> w=
rote:
>>>>>> Hi,
>>>>>>=20
>>>>>> My shadow stack tests start to have random shadow stack pointer corru=
ption after
>>>>>> v5.7 (excluding).  The symptom looks like some locking issue or the k=
ernel is
>>>>>> confused about which CPU a task is on.  In later tip/master, this can=
 be
>>>>>> triggered by creating two tasks and each does continuous
>>>>>> pthread_create()/pthread_join().  If the kernel has max_cpus=3D1, the=
 issue goes
>>>>>> away.  I also checked XSAVES/XRSTORS, but this does not seem to be an=
 issue
>>>>>> coming from there.
>>>>>=20
>>>>> What do you mean "shadow stack pointer corruption"?  Is SSP itself
>>>>> corrupt while running in the kernel?  Is one of the MSRs getting
>>>>> corrupted?  Is the memory to which the shadow stack points getting
>>>>> corrupted? Is the CPU rejecting an attempt to change SSP?
>>>>=20
>>>> What I see is, a new thread after ret_from_fork() and iret back to ring=
-3,
>>>> its shadow stack pointer (MSR_IA32_PL3_SSP) is corrupted.
>>>=20
>>> Does corrupt mean random?  Or is it a valid stack address, just not for
>>> _this_ thread?  Or NULL?  Or is it a kernel address?  Have you tried
>>> tracing *ALL* the WRMSR's and XRSTOR's that write to the MSR?
>>=20
>> When a shadow stack address is changed, the address appears to be other t=
ask's.
>> I traced all WRMSR's and XRSTOR's.  I also verified there have not been a=
ny
>> XRSTORS from a wrong buffer.  When rc6 is tagged, I will re-base, test, a=
nd
>> share current patches.
>>=20
>=20
> We have identified that
>=20
> ommit 91eeafea1e4b7c95cc4f38af186d7d48fceef89a
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Thu May 21 22:05:28 2020 +0200
>=20
>    x86/entry: Switch page fault exception to IDTENTRY_RAW
>=20
>    Convert page fault exceptions to IDTENTRY_RAW:
>=20
>      - Implement the C entry point with DEFINE_IDTENTRY_RAW
>      - Add the CR2 read into the exception handler
>      - Add the idtentry_enter/exit_cond_rcu() invocations in
>        in the regular page fault handler and in the async PF
>        part.
>      - Emit the ASM stub with DECLARE_IDTENTRY_RAW
>      - Remove the ASM idtentry in 64-bit
>      - Remove the CR2 read from 64-bit
>      - Remove the open coded ASM entry code in 32-bit
>      - Fix up the XEN/PV code
>      - Remove the old prototypes
>=20
>    No functional change.
>=20
> triggered the shadow stack corruption when the process returned from sysca=
ll.
> SSP MSR somehow was changed between setting SSP MSR and IRET.    Could
> there be a page fault between setting SSP MSR and IRET?

Not upstream because there=E2=80=99s no SSP MSR.

>=20
> --=20
> H.J.
