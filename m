Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9896D2A7CFD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 12:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbgKEL0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 06:26:51 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:40529 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbgKEL0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 06:26:51 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CRh7927Qnz9sVS;
        Thu,  5 Nov 2020 22:26:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1604575608;
        bh=N3LQMBxz53FTAnoaW8tqbR9RuS1nFNL/IBcDzTEmo04=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=EuqJG+oW9YMlU/9C7w+LY7w/BEHnurdsiXw5EYLeUouxUmPtg9DLXMDz6koBzkxFP
         /0Tdhcy4LzU97SCf0ag1B9XfPPfCzdauwZdXGomHJaB/s4VOtaFYmryYlWheiAwxAJ
         p8ydnxllcULes9/vYcWWndvJDvPUHHyKjqOJu4D4txoq8JMyMyAYRkm2ASAbiHYP/r
         GEtXi5DM2CcI3+gnulMIrGgHvItowZwos2kYpEtDoZEq4gCyyvNWlgTXF8G8V9vkaZ
         hRWv8Cs33o7XpzNAIdrgVm40jwWUQSU2QFGO1+x3JhRd8lyIbpOhMPgjlpYFqdu77L
         khu7frJN8nxJg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        linux-sh@vger.kernel.org, Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        linux-riscv@lists.infradead.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-s390@vger.kernel.org, YiFei Zhu <yifeifz2@illinois.edu>,
        linux-csky@vger.kernel.org, Tianyin Xu <tyxu@illinois.edu>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Valentin Rothberg <vrothber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Will Drewry <wad@chromium.org>, linux-parisc@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        David Laight <David.Laight@aculab.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH seccomp 3/8] powerpc: Enable seccomp architecture tracking
In-Reply-To: <CABqSeAQ+3sjLXH7GVt_tZrFT_e0nNMm8QgT+FBNQYSOc8viM=A@mail.gmail.com>
References: <cover.1604410035.git.yifeifz2@illinois.edu> <4ec2970fcc819eb4d5dac2bd35233ccdadfda845.1604410035.git.yifeifz2@illinois.edu> <87wnz1to9n.fsf@mpe.ellerman.id.au> <CABqSeAQ+3sjLXH7GVt_tZrFT_e0nNMm8QgT+FBNQYSOc8viM=A@mail.gmail.com>
Date:   Thu, 05 Nov 2020 22:26:44 +1100
Message-ID: <87ft5ot56z.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YiFei Zhu <zhuyifei1999@gmail.com> writes:
> On Wed, Nov 4, 2020 at 4:22 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>> > +#ifdef __LITTLE_ENDIAN__
>>
>> As Kees mentioned this should (must?!) match the configured endian.
>>
>> But I think it would still be better to use the CONFIG symbol, which is
>> CONFIG_CPU_LITTLE_ENDIAN.
>
> My attempt here is to be consistent with asm/syscall.h
> syscall_get_arch [1]. Would it make sense to change that to
> CONFIG_CPU_LITTLE_ENDIAN then?
>
> [1] https://elixir.bootlin.com/linux/latest/source/arch/powerpc/include/asm/syscall.h#L116

Looking across the tree with have thousands of usages of
__LITTLE_ENDIAN__, so it's probably not worth converting to
CONFIG_CPU_LITTLE_ENDIAN.

>> > +# define SECCOMP_ARCH_NATIVE         (AUDIT_ARCH_PPC64 | __SECCOMP_ARCH_LE)
>>
>> You use __SECCOMP_ARCH_LE there, but previously you only defined
>> __SECCOMP_ARCH_LE_BIT.
>>
>> Is there some magic somewhere that defines __SECCOMP_ARCH_LE based on
>> __SECCOMP_ARCH_LE_BIT ?
>
> Oops, my bad here.

OK :)

>> > +# define SECCOMP_ARCH_NATIVE_NR              NR_syscalls
>> > +# define SECCOMP_ARCH_NATIVE_NAME    "ppc64"
>>
>> What's the name used for?
>
> This is used in the last patch in this series to report in procfs the
> name of each architecture tracked by the bitmap cache.

OK, yeah I think it would be better if the matched the uname -m values.

>> Usually we use "ppc64" for 64-bit big endian and "ppc64le" for 64-bit
>> little endian.
>>
>> And usually we use "ppc" for 32-bit.
>
> Ok.


cheers
