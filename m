Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771BC28DD41
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgJNJX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731272AbgJNJW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:22:56 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3151C002154
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 18:47:15 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id p3so471590pjd.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 18:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=qCsKokdPjnp8TP3wf5PnST42XjOymf3yeUGYkyZbV2o=;
        b=mFTokw5RApYPGMT3T3Oj6BSU5f1paNh0rMNn9VMxLctVwG7K4kzAye0YxmmL1987lO
         X5uwRptWm8DJ/cqGRKx9lP9Z7OvbLL8/V5bPSQC6iFWOltDanRtxWLrZFlKALpB78CeZ
         w8Al5qXs4mtlg9lyP/rmN395NQ8x6CcioHEzU6zLIJk5OtDu9nJWaaO+zf4aQtDfBT8U
         EkKzJL87BYuoPELORN3+ZvaPbnprKAxwGAqpwLo1+0L4UZrt2hoPLNyqDKN86hYqlAzh
         c8Vg5nmsh6pS4uFZdmwCSuiZFjbfBIOYDNCoDk4B3smpx0ezA+in5LMjtwkaSwIBi8L8
         qlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=qCsKokdPjnp8TP3wf5PnST42XjOymf3yeUGYkyZbV2o=;
        b=O5fRo5Gewk0J7r0TxP4kghfxK1Ugv64ZyHF8y8tLytCBCYPyNiHvqvhxqugLPHH4f6
         KjxujsVdWzlvvsoFYPNwkTO2+rg5c5EszC5iQp4ZZQx66gqIoyEUQE0GYIKW4n5+jAuX
         +IVoFumQefknupKPUn2Ogz1sFShk4cslcT+FeG1hQ1/423hF+SUv4QYjsVxpna0JjySw
         X1J5GEqbdDvEJRyeeDl35UN0+luJvzojbOnKNd2Z1hC9ca3imYRfiQyjBCg9+O8inR0C
         YgY+z2QXZ7M0P6i6Vs+e9ELR4c0vjFQp+UvSwPlIxMqKzTdnZUkusew2fXWuLaMtkIsv
         flWA==
X-Gm-Message-State: AOAM532bEvCCJe5ql0iltv1g+47X8YCRozPJ+Vzp2KwLO1H5dOY4JMO+
        9jArTtP6yIH/UikJcc8m/4+r1g==
X-Google-Smtp-Source: ABdhPJw6UPe7ce5rUUzA2OutawyRxzSX/xqomDBbkIMfmWZpPSlgTZ4w26SUaFYDXLGNcjZU09/N0w==
X-Received: by 2002:a17:902:8698:b029:d3:b362:7342 with SMTP id g24-20020a1709028698b02900d3b3627342mr2454658plo.50.1602640035390;
        Tue, 13 Oct 2020 18:47:15 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:6de6:2b7a:f0be:2adc? ([2601:646:c200:1ef2:6de6:2b7a:f0be:2adc])
        by smtp.gmail.com with ESMTPSA id c17sm996998pfj.220.2020.10.13.18.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 18:47:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 13/22] x86/fpu/xstate: Expand dynamic user state area on first use
Date:   Tue, 13 Oct 2020 18:47:13 -0700
Message-Id: <89AB5807-E295-4AB2-9568-9B6306E896F8@amacapital.net>
References: <BYAPR11MB346371298609756EFD2DDA1EE0040@BYAPR11MB3463.namprd11.prod.outlook.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        X86 ML <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <BYAPR11MB346371298609756EFD2DDA1EE0040@BYAPR11MB3463.namprd11.prod.outlook.com>
To:     "Brown, Len" <len.brown@intel.com>
X-Mailer: iPhone Mail (18A393)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Oct 13, 2020, at 3:31 PM, Brown, Len <len.brown@intel.com> wrote:
>=20
> =EF=BB=BF
>>=20
>> From: Andy Lutomirski <luto@kernel.org>=20
>=20
>>> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
>>> @@ -518,3 +518,40 @@ int fpu__exception_code(struct fpu *fpu, int trap_n=
r)
> ..
>>> +bool xfirstuse_event_handler(struct fpu *fpu)
>>> +{
>>> +       bool handled =3D false;
>>> +       u64 event_mask;
>>> +
>>> +       /* Check whether the first-use detection is running. */
>>> +       if (!static_cpu_has(X86_FEATURE_XFD) || !xfirstuse_enabled())
>>> +               return handled;
>>> +
>=20
>> MSR_IA32_XFD_ERR needs to be wired up in the exception handler, not in
>> some helper called farther down the stack
>=20
> xfirstuse_event_handler() is called directly from the IDTENTRY exc_device_=
not_available():
>=20
>>> @@ -1028,6 +1028,9 @@ DEFINE_IDTENTRY(exc_device_not_available)
>>> {
>>>    unsigned long cr0 =3D read_cr0();
>>>=20
>>> +    if (xfirstuse_event_handler(&current->thread.fpu))
>>> +        return;
>=20
> Are you suggesting we should instead open code it inside that routine?

MSR_IA32_XFD_ERR is like CR2 and DR6 =E2=80=94 it=E2=80=99s functionally a p=
art of the exception. Let=E2=80=99s handle it as such.  (And, a bit like DR6=
, it=E2=80=99s a bit broken.)

>=20
>> But this raises an interesting point -- what happens if allocation
>> fails?  I think that, from kernel code, we simply cannot support this
>> exception mechanism.  If kernel code wants to use AMX (and that would
>> be very strange indeed), it should call x86_i_am_crazy_amx_begin() and
>> handle errors, not rely on exceptions.  =46rom user code, I assume we
>> send a signal if allocation fails.
>=20
> The XFD feature allows us to transparently expand the kernel context switc=
h buffer
> for a user task, when that task first touches this associated hardware.
> It allows applications to operate as if the kernel had allocated the backi=
ng AMX
> context switch buffer at initialization time.  However, since we expect on=
ly
> a sub-set of tasks to actually use AMX, we instead defer allocation until
> we actually see first use for that task, rather than allocating for all ta=
sks.

I sure hope that not all tasks use it. Context-switching it will be absurdly=
 expensive.

>=20
> While we currently don't propose AMX use inside the kernel, it is conceiva=
ble
> that could be done in the future, just like AVX is used by the RAID code;
> and it would be done the same way -- kernel_fpu_begin()/kernel_fpu_end().
> Such future Kernel AMX use would _not_ arm XFD, and would _not_ provoke th=
is fault.
> (note that we context switch the XFD-armed state per task)

How expensive is *that*?  Can you give approximate cycle counts for saving, r=
estoring, arming and disarming?

This reminds me of TS.  Writing TS was more expensive than saving the whole =
FPU state.  And, for kernel code, we can=E2=80=99t just =E2=80=9Cnot arm=E2=80=
=9D the XFD =E2=80=94 we would have to disarm it.



>=20
> vmalloc() does not fail, and does not return an error, and so there is no c=
oncept
> of returning a signal.  If we got to the point where vmalloc() sleeps, the=
n the system
> has bigger OOM issues, and the OOM killer would be on the prowl.
>=20
> If we were concerned about using vmalloc for a couple of pages in the task=
 structure,
> Then we could implement a routine to harvest unused buffers and free them

Kind of like we vmalloc a couple pages for kernel stacks, and we carefully c=
ache them.  And we handle failure gracefully.=
