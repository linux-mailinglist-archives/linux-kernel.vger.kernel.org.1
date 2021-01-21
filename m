Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65032FE160
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 06:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbhAUFHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 00:07:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:46410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbhAUFEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 00:04:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74F82238EC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 05:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611205427;
        bh=94YeBMSzv92qhY9JatZVlAan+mZeXOSvArlajLJhBtU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V2wb8Ha27SJms0uYAndcrDAQYEYoVKXtrLi+x2t0/EB6SUfLg6eV5lV5f9YaiJYno
         Yy4fT5tfeurGkLvBpCuiQNT56sHDFVmF6s1j0rxxT7hUIMk5pcKoD8JG07Hf2Bg98x
         weFAWVL8S+mY9UnHKpuHEMcJzWdWmv77+plJC1mCqc3TTI5dzo85Dbc2wEfhV5KELH
         Uh32uDlL+o+sn3lAt2zHm9p+wa6uUdWAURr1d7J6vdYX84wWAHhwo3uFpZghYfv+S/
         DCId1BxunT3Pkp8GHFmKhI6o0qII9w5MEhl4glRvELFifNmnTuK4o05/pMc3JSoL0Q
         yNAD0vN/rrbYA==
Received: by mail-ed1-f41.google.com with SMTP id h16so935251edt.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 21:03:47 -0800 (PST)
X-Gm-Message-State: AOAM532VWcEANiPPCo4YDt3LAzFPl7xhIGLAGpJXVgLpMHSv+/0uCc+Y
        ruyooaeoNieM1yiV9dzgdpNzBuz451jEMVGqvRtfCA==
X-Google-Smtp-Source: ABdhPJwAl8n82bSI7v73reK/F7VUgFtGqSwQdOLnDfF0wBwhMFvtmTrdn6BFY+hPXNKj+m+g/tmGurTl3FoKBbYJvHo=
X-Received: by 2002:aa7:c60a:: with SMTP id h10mr9659208edq.263.1611205426034;
 Wed, 20 Jan 2021 21:03:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1611077835.git.luto@kernel.org> <e4b495a8-a23a-3c8c-e9c0-3f23b21d41a4@ans.pl>
In-Reply-To: <e4b495a8-a23a-3c8c-e9c0-3f23b21d41a4@ans.pl>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 20 Jan 2021 21:03:35 -0800
X-Gmail-Original-Message-ID: <CALCETrU+Ny=a4G6Axx7JMLDaZEx0HQxiSuw-D_wMaugkkcODAw@mail.gmail.com>
Message-ID: <CALCETrU+Ny=a4G6Axx7JMLDaZEx0HQxiSuw-D_wMaugkkcODAw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] x86/fpu: Reduce unnecessary FNINIT and MXCSR usage
To:     =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Mazur <krzysiek@podlesie.net>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 11:51 PM Krzysztof Ol=C4=99dzki <ole@ans.pl> wrote:
>
> On 2021-01-19 at 09:38, Andy Lutomirski wrote:
> > This series fixes two regressions: a boot failure on AMD K7 and a
> > performance regression on everything.
> >
> > I did a double-take here -- the regressions were reported by different
> > people, both named Krzysztof :)
> >
> > Changes from v1:
> >   - Fix MMX better -- MMX really does need FNINIT.
> >   - Improve the EFI code.
> >   - Rename the KFPU constants.
> >   - Changelog improvements.
> >
> > Andy Lutomirski (4):
> >    x86/fpu: Add kernel_fpu_begin_mask() to selectively initialize state
> >    x86/mmx: Use KFPU_387 for MMX string operations
> >    x86/fpu: Make the EFI FPU calling convention explicit
> >    x86/fpu/64: Don't FNINIT in kernel_fpu_begin()
>
> Hi Andy.
>
> I have quickly tested the new version on E3-1280 V2.
>
> * 5.10.9 + 7ad816762f9bf89e940e618ea40c43138b479e10 reverted (aka unfixed=
)
> xor: measuring software checksum speed
>     avx             : 38616 MB/sec
>     prefetch64-sse  : 25797 MB/sec
>     generic_sse     : 23147 MB/sec
> xor: using function: avx (38616 MB/sec)
>
> * 5.10.9 (the original)
> xor: measuring software checksum speed
>     avx             : 23318 MB/sec
>     prefetch64-sse  : 22562 MB/sec
>     generic_sse     : 20431 MB/sec
> xor: using function: avx (23318 MB/sec)
>
> * 5.10.9 + "Reduce unnecessary FNINIT and MXCSR usage" v2
> xor: measuring software checksum speed
>     avx             : 26451 MB/sec
>     prefetch64-sse  : 25777 MB/sec
>     generic_sse     : 23178 MB/sec
> xor: using function: avx (26451 MB/sec)
>
> Overall, kernel xor benchmark reports better performance on 5.10.9 than
> on 5.4.90 (see my prev e-mail), but the general trend is the same.
>
> The "unfixed" kernel is much faster for all of avx, prefetch64-sse and
> generic_sse. With the fix, we see the expected perf regression.
>
> Now, with your patchset, both prefetch64-sse and generic_sse are able to
> recover the full performance, as seen on 5.4. However, this is not the
> case for avx. While there is still an improvement, it is nowhere close
> to where it used to be.
>
> I wonder why AVX still sees a regression and if anything more can be
> done about it?
>
> Will do more tests tomorrow.

I'm moderately confident that the problem is that LDMXCSR is
considered a "legacy SSE" instruction and it's triggering the
VEX-to-SSE and SSE-to-VEX penalties.  perf could tell you for sure,
and testing with VLDMXCSR might be informative.

I'm not sure whether the best solution is to try to use VLDMXCSR, to
throw some VZEROUPPER instructions in, or to try to get rid of MXCSR
initialization entirely for integer code.  VZEROUPPER might be good
regardless, since for all we know, we're coming from user mode and
user mode could have been using SSE.  If we do the latter, we should
probably arrange to do it just once per user-FP-to-kernel-FP
transition.

--Andy
