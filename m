Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE86297897
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 23:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756551AbgJWVAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 17:00:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46567 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756459AbgJWVAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 17:00:17 -0400
Received: from wld157.hos.anvin.org (c-24-6-168-49.hsd1.ca.comcast.net [24.6.168.49])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 09NL00sd3977700
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 23 Oct 2020 14:00:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 09NL00sd3977700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020092401; t=1603486802;
        bh=9u/4bAHcrBBcc7goONQARCdwO+FUd0P7GG36TXEkpHY=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=gKnCvn2haztGzj+7RlTFTHDsXYJwAuq4PU+wKo7S3FTdvCAXvVfMAfeWEq542gu4Y
         RVxxkmefKR2XmdSdxFhF7EY7waiWoETQuhhlzpy1LfKBdVeqd96IcKBD1XzNll5zEk
         pAnJL3wHH5q8PqKYb8EaaTzTJ2uhaMPtw8VduB0ronP91vOIyc5gHe/FG2IGb33IFR
         Pzf4Bvaxi73tsZDKoIoIVgOKBYnLiwZO35EvmQfHJoMIrlpCP4DoVrX9YZ3ZY+bNmK
         6BEMsi+5twpsOmZp72hHJ9oV45sgyuVYOP56Gwe8GFSMISQFY9LiVn6dr9FIYEa26o
         RW96m+CngfF2Q==
Date:   Fri, 23 Oct 2020 13:59:58 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wj1m3cvS-3dOYzNavYWLFu=9fwo0-6HTHJhG-X5B73gZg@mail.gmail.com>
References: <20201023203154.27335-1-linux@rasmusvillemoes.dk> <CAHk-=wj1m3cvS-3dOYzNavYWLFu=9fwo0-6HTHJhG-X5B73gZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] x86/uaccess: fix code generation in put_user()
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   hpa@zytor.com
Message-ID: <8820745F-E761-42E6-8A70-7B04EE70692C@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 23, 2020 1:55:22 PM PDT, Linus Torvalds <torvalds@linux-foundati=
on=2Eorg> wrote:
>Thanks, applied=2E
>
>On Fri, Oct 23, 2020 at 1:32 PM Rasmus Villemoes
><linux@rasmusvillemoes=2Edk> wrote:
>>
>> I'm wondering if one would also need to make __ptr_pu and __ret_pu
>> explicitly "%"_ASM_CX"=2E
>
>No, the "c"/"0" thing is much better, and makes it properly atomic wrt
>the actual asm=2E
>
>As mentioned to Andy, the "register asm()" thing is not uncommon and
>often useful, but when you can specify the register directly in asm,
>that's certainly simpler and more straightforward and preferred=2E
>
>              Linus

There is no same reason to mess around with hacks when we are talking abou=
t dx:ax, though=2E We have to do pretty ugly hacks when other register pair=
s are involved, but "A" is there for a reason=2E _ASM_AX64 maybe=2E=2E=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
