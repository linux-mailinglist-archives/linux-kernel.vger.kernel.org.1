Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD487297882
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 22:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465529AbgJWUzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 16:55:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47141 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S462608AbgJWUzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 16:55:19 -0400
Received: from wld157.hos.anvin.org (c-24-6-168-49.hsd1.ca.comcast.net [24.6.168.49])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 09NKsgWu3976618
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 23 Oct 2020 13:54:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 09NKsgWu3976618
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020092401; t=1603486482;
        bh=ZOOtQrsH7mcC2JSPLq5yn6VuzlEVDtNqMVM/VKublt4=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=iBW4IVfYoyUtsiG7AsjLuucyH3Py/r7EBrc2OxiN15Rv5VvS2Zm3I8v74KiMByNPP
         omZ64p+xf9vrYogvcbuKLbC2pE1osZl3tVQWz7RzuHxptQtR3fobs20DAczZnTJ/5U
         F4Zoipw9RtOBAp2ZiyUu7h7VZA0BMaWQ0k5i6sf54eP+WOoGbwcwi3GCZihUi9LNEB
         AbpKGRjbj8/6bDx+SjroUVJwxZQV5UhbCouGWid6kHX3eTZkXkGm22cA9rYt7pgQlh
         s1MBLyORtJl3Dh7Apb/7CggFTTTGj1ODdyGCnnSUbruQB5TIG2mOLCy53RkVzyTano
         oLwjJaeoHNDDQ==
Date:   Fri, 23 Oct 2020 13:54:39 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CALCETrV2rzowdWqhEG7v-hmbUOpNHsBz-hR1RdxBFKuwU6rDTA@mail.gmail.com>
References: <20201023203154.27335-1-linux@rasmusvillemoes.dk> <CALCETrV2rzowdWqhEG7v-hmbUOpNHsBz-hR1RdxBFKuwU6rDTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] x86/uaccess: fix code generation in put_user()
To:     Andy Lutomirski <luto@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   hpa@zytor.com
Message-ID: <AD6F6BCA-B614-4218-9C0C-D2B8A1D7F338@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 23, 2020 1:42:39 PM PDT, Andy Lutomirski <luto@kernel=2Eorg> wro=
te:
>On Fri, Oct 23, 2020 at 1:32 PM Rasmus Villemoes
><linux@rasmusvillemoes=2Edk> wrote:
>>
>> Quoting
>> https://gcc=2Egnu=2Eorg/onlinedocs/gcc/Local-Register-Variables=2Ehtml:
>>
>>   You can define a local register variable and associate it with a
>>   specified register=2E=2E=2E
>>
>>   The only supported use for this feature is to specify registers for
>>   input and output operands when calling Extended asm (see Extended
>>   Asm)=2E This may be necessary if the constraints for a particular
>>   machine don't provide sufficient control to select the desired
>>   register=2E
>>
>> On 32-bit x86, this is used to ensure that gcc will put an 8-byte
>> value into the %edx:%eax pair, while all other cases will just use
>the
>> single register %eax (%rax on x86-64)=2E While the _ASM_AX actually
>just
>> expands to "%eax", note this comment next to get_user() which does
>> something very similar:
>>
>>  * The use of _ASM_DX as the register specifier is a bit of a
>>  * simplification, as gcc only cares about it as the starting point
>>  * and not size: for a 64-bit value it will use %ecx:%edx on 32 bits
>>  * (%ecx being the next register in gcc's x86 register sequence), and
>>  * %rdx on 64 bits=2E
>>
>> However, getting this to work requires that there is no code between
>> the assignment to the local register variable and its use as an input
>> to the asm() which can possibly clobber any of the registers involved
>> - including evaluation of the expressions making up other inputs=2E
>
>This looks like the patch is an improvement, but this is still IMO
>likely to be very fragile=2E  Can we just do the size-dependent "a" vs
>"A" selection method instead?  Sure, it's a little more code, but it
>will be Obviously Correct=2E  As it stands, I can easily see our code
>failing on some gcc or clang version and the compiler authors telling
>us that we're relying on unsupportable behavior=2E

Yeah, the reason get_user hacks it is because there is no equivalent to "A=
" for other register pairs, but not using it for dx:ax is just silly=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
