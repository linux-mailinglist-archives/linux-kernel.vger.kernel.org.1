Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272E92979B8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 01:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758776AbgJWXkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 19:40:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52977 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758769AbgJWXkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 19:40:08 -0400
Received: from wld181.hos.anvin.org (c-24-6-168-49.hsd1.ca.comcast.net [24.6.168.49])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 09NNdmko4027135
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 23 Oct 2020 16:39:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 09NNdmko4027135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020092401; t=1603496390;
        bh=xs7I8/gVse4gEGgN1UPUZ5pidIDY93X/cDXaJPe3IHI=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=fEyUymfLPdEmDFJqxGGHZXooSsKNiRyv4V5jNNRdk5L0faMhyx04NG6dyaP4PqFOk
         HO/YrJ7CRZt+FASviYZQl7o4X4VfsL9RQLpXY47nvQ0Y7xEMRugkFkZGW1zXPxC/7x
         s9gNYnPwG4OxvvqwVG6tleFp6r0XpJm18zROHN0tc/EXqm4AfkfZgsBqqljX9TXxC/
         RNff/je/pwsxsR3QPq1i0AYSHkfhCBUZCpObx7QW9n9Xxy5QdYeevc1+2+gtcX22fZ
         QU0nFMs9qT+f78tYctJdPmWGDAaS3VphOvAZg4mDa+ADH1JJc8hVkMD3BmjsREDojM
         XM8ib9rSxAH0Q==
Date:   Fri, 23 Oct 2020 16:39:46 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <bca28d6e33a3475193478e762214c6ea@AcuMS.aculab.com>
References: <20201023203154.27335-1-linux@rasmusvillemoes.dk> <CAHk-=wj1m3cvS-3dOYzNavYWLFu=9fwo0-6HTHJhG-X5B73gZg@mail.gmail.com> <8820745F-E761-42E6-8A70-7B04EE70692C@zytor.com> <CAHk-=wg9L3EZk=cBjt5R3LkE8Y6swwOZ8sxhpQYcJO3Fj1wLbQ@mail.gmail.com> <bca28d6e33a3475193478e762214c6ea@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] x86/uaccess: fix code generation in put_user()
To:     David Laight <David.Laight@ACULAB.COM>,
        "'Linus Torvalds'" <torvalds@linux-foundation.org>
CC:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   hpa@zytor.com
Message-ID: <3F1D3946-E7B8-4F77-9189-D49E1ECE0B0D@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 23, 2020 2:52:16 PM PDT, David Laight <David=2ELaight@ACULAB=2EC=
OM> wrote:
>From: Linus Torvalds
>> Sent: 23 October 2020 22:11
>>=20
>> On Fri, Oct 23, 2020 at 2:00 PM <hpa@zytor=2Ecom> wrote:
>> >
>> > There is no same reason to mess around with hacks when we are
>talking about dx:ax, though=2E
>>=20
>> Sure there is=2E
>>=20
>> "A" doesn't actually mean %edx:%eax like you seem to think=2E
>>=20
>> It actually means %eax OR %edx, and then if given a 64-bit value, it
>> will use the combination (with %edx being the high bits)=2E
>>=20
>> So using "A" unconditionally doesn't work - it gives random behavior
>> for 32-bit (or smaller) types=2E
>>=20
>> Or you'd have to cast the value to always be 64-bit, and have the
>> extra code generation=2E
>>=20
>> IOW, an unconditional "A" is wrong=2E
>>=20
>> And the alternative is to just duplicate things, and go back to the
>> explicit size testing, but honestly, I really think that's much worse
>> than relying on a documented feature of "register asm()" that gcc
>> _documents_ is for this kind of inline asm use=2E
>
>Could do_put_user() do an initial check for 64 bit
>then expand a different #define that contains the actual
>code passing either "a" or "A" for the constriant=2E
>
>Apart from another level of indirection nothing is duplicated=2E
>
>	David
>
>-
>Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes,
>MK1 1PT, UK
>Registration No: 1397386 (Wales)

Maybe #define ASM_AX64 or some such=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
