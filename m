Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4FE27B6F4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 23:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgI1VUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 17:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgI1VUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 17:20:03 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24E3C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 14:20:01 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f18so2327729pfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 14:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=2+2An9KGoSP6S51iGyhlVQStV5BSsILsLY/d1IF6Z40=;
        b=ow7Yhe7Kf0k5AkDnGt3SMaKY52oPWuvOYXCgPixiZJhdBtyEs4ajDZ+lVZ2HK5V9um
         /CYJpV5jcUJmFfsyFkk/6/uRPkZERlWO1ugGWNGPbE+Ri+UTEuc8btLpBb/v/n635Z6c
         ForooQ9Hl6NWPmky+tr4k1swC6ycDacdl2W5LrRRc64Pxn8fow168e8AD0IiNo13i3z7
         BW2SMZbt89zG7U3c0+C2W/V+/Vx+As4Vwo/Bd11GtEx2eT5xM5VJp5uI3hsbfYgFA09a
         exwBgdbKqBtA1JWbT/dNnrgAjR9RSIMpEozOo8PY67L8MdL8J2XYOVbdfMDuy3DoRjet
         eYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=2+2An9KGoSP6S51iGyhlVQStV5BSsILsLY/d1IF6Z40=;
        b=RqcDKOdKAgpOxvVt+lMANCzhCNwOsiVHiSRySHbL7O+RMa+Q7lrsmWFBEUXRlJJQSG
         wtXBuIpVmEP1KCuv4Gk4Zj5xL9ColSJVdpkGc19xVOw11hNFiAoXfUpb+7wRz8GDV4H4
         0V8LGXB0FqYy1fD/M+BeR2DcIvfJcKKWzVef9tpQdkloTqfjjY7F3oDmJjDQ19v2EVyM
         jGHrO2099ucRcD5PDEJxz4cxsl/Q2QUupaDMlPaQtYcjkTexwrZ8th4rwuTflwDcZ0y8
         3CWrQnWvNJjfC9uk33VCme9c19qvBLyVF0frUBoIeM8hAJT7qwGJalqhJ/VjPuStzxvs
         beWA==
X-Gm-Message-State: AOAM531QZKkJ/kL7pjAzjKMmVOMZ2AA+A2yuwMKXJHU8p5W+5Bbj1BBi
        2msF7PRi1uJudHQhMBmYisQ8qw==
X-Google-Smtp-Source: ABdhPJzzZ29f+TNLY8J/8+49h2cFrjiLAWe/6D4b9LMUN1e94ZG/nh5HwikFLAMYARN+ciAZku1SNw==
X-Received: by 2002:a17:902:be0c:b029:d2:8ceb:f39c with SMTP id r12-20020a170902be0cb02900d28cebf39cmr1242485pls.71.1601328001370;
        Mon, 28 Sep 2020 14:20:01 -0700 (PDT)
Received: from ?IPv6:2600:1010:b00b:15a5:2004:5f47:98e:6069? ([2600:1010:b00b:15a5:2004:5f47:98e:6069])
        by smtp.gmail.com with ESMTPSA id j12sm261750pjs.21.2020.09.28.14.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 14:20:00 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: general protection fault in perf_misc_flags
Date:   Mon, 28 Sep 2020 14:19:57 -0700
Message-Id: <15CE600C-3006-4C4D-A65E-9B608D55DD35@amacapital.net>
References: <CAKwvOdmTm2rVdc2JTSVVadKP3DONRcPXSE-s3tFPqHgCSieH7Q@mail.gmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, Borislav Petkov <bp@alien8.de>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        syzbot <syzbot+ce179bc99e64377c24bc@syzkaller.appspotmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
In-Reply-To: <CAKwvOdmTm2rVdc2JTSVVadKP3DONRcPXSE-s3tFPqHgCSieH7Q@mail.gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
X-Mailer: iPhone Mail (18A393)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sep 28, 2020, at 1:52 PM, Nick Desaulniers <ndesaulniers@google.com> wr=
ote:
>=20
> =EF=BB=BFOn Mon, Sep 28, 2020 at 3:34 AM 'Dmitry Vyukov' via Clang Built L=
inux
> <clang-built-linux@googlegroups.com> wrote:
>>=20
>>> On Mon, Sep 28, 2020 at 10:54 AM Borislav Petkov <bp@alien8.de> wrote:
>>>=20
>>> On Mon, Sep 28, 2020 at 10:40:19AM +0200, Dmitry Vyukov wrote:
>>>> I meant the kernel self-corrupts itself, that just wasn't detected by
>>>> KASAN, page protections, etc.
>>>=20
>>> Well, Nick already asked this but we're marking all kernel text RO early=

>>> during boot. So it either is happening before that or something else
>>> altogether is going on.
>=20
>> On Sun, Sep 27, 2020 at 11:06 PM 'Dmitry Vyukov' via Clang Built Linux
>> <clang-built-linux@googlegroups.com> wrote:
>>=20
>> Interestingly there is a new crash, which looks similar:
>>=20
>> general protection fault in map_vdso
>> https://syzkaller.appspot.com/bug?extid=3Dc2ae01c2b1b385384a06
>>=20
>> The code is also with 4 0's:
>> Code: 00 00 00 48 b8 00 00 00 00 00 fc ff df 41 57 49 89 ff 41 56 41
>> 55 41 54 55 65 48 8b 2c 25 c0 fe 01 00 48 8d bd 28 04 00 00 53 <48> 00
>> 00 00 00 fa 48 83 ec 10 48 c1 ea 03 80 3c 02 00 0f 85 51 02
>>=20
>> But it happened with gcc.
>>=20
>> Also I found this older one:
>> general protection fault in map_vdso_randomized
>> https://syzkaller.appspot.com/bug?id=3D8366fd024559946137b9db23b26fd2235d=
43b383
>>=20
>> which also has code smashed and happened with gcc:
>> Code: 00 fc ff df 48 89 f9 48 c1 e9 03 80 3c 01 00 0f 85 eb 00 00 00
>> 65 48 8b 1c 25 c0 fe 01 00 48 8d bb 28 04 00 00 41 2b 54 24 20 <00> 00
>> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>=20
> If this is related to vdso's, they seem mapped as `r-xp` (not `w):
> $ sudo cat /proc/1/maps | grep vdso
> 7ffc667f5000-7ffc667f7000 r-xp 00000000 00:00 0                          [=
vdso]
>=20
> map_vdso() in arch/x86/entry/vdso/vma.c doesn't map the VMA as
> writable, but it uses VM_MAYWRITE with a comment about GDB setting
> breakpoints.
>=20
> So it sounds like the page protections on the vdso can be changed at
> runtime (via mprotect).  Maybe syzkaller is tickling that first?
>=20
> map_vdso_randomized() does call map_vdso().  Maybe if we mprotect the
> vdso to be writable, it may be easier to spot the write.
>=20
>=20

The kernel shouldn=E2=80=99t be executing the vDSO code.  Unless I=E2=80=99v=
e misread it, Te crash is that the map_vdso() text itself was corrupted.  Th=
is isn=E2=80=99t the same thing.

The VM_MAYWRITE means that a program may CoW the page and write to the copy,=
 which still won=E2=80=99t allow changing the vDSO text or executing it insi=
de the kernel.=
