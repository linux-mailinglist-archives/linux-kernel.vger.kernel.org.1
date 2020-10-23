Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C9629796F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 00:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758381AbgJWWwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 18:52:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37513 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758348AbgJWWwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 18:52:19 -0400
Received: from wld157.hos.anvin.org (c-24-6-168-49.hsd1.ca.comcast.net [24.6.168.49])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 09NMq3vn4013373
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 23 Oct 2020 15:52:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 09NMq3vn4013373
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020092401; t=1603493524;
        bh=EGRt4ztnZwAX3jt6Vs1L6I71nyIhTSB2Csb5qpzwG7c=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=apotMjaOLOewyHJ6I7jiM3el3vCLm1tB5bAtUZYVoAme0w+704l59xN02nygQoy+8
         mBtM/Sf8n44b9zTNAk1q3NA/8YanTUE7WrAiadFuJmkVLOzztoNfVbEsSUODb7Kj1v
         X/Znsp+ujjXpiFVDdjm6xfFwTNeT9shBYTVzp8AyCzgEbRFj1FmA0u+PE/07RGJ7oc
         tCTJ48DZgy7oOGCAOhBakYMN5mknxZq0MSr6poDFzqtOLZr5AgeCbMIiTnh287+jQn
         gEq6NgHBsAtuOVJFvOitwopMcBlvkfOV2R5+KOkQYtFcPCVLbYYZYcD/APrEXxhvlF
         EprCPOEXzOS6Q==
Date:   Fri, 23 Oct 2020 15:52:00 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wg9L3EZk=cBjt5R3LkE8Y6swwOZ8sxhpQYcJO3Fj1wLbQ@mail.gmail.com>
References: <20201023203154.27335-1-linux@rasmusvillemoes.dk> <CAHk-=wj1m3cvS-3dOYzNavYWLFu=9fwo0-6HTHJhG-X5B73gZg@mail.gmail.com> <8820745F-E761-42E6-8A70-7B04EE70692C@zytor.com> <CAHk-=wg9L3EZk=cBjt5R3LkE8Y6swwOZ8sxhpQYcJO3Fj1wLbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] x86/uaccess: fix code generation in put_user()
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   hpa@zytor.com
Message-ID: <06B6997A-81AC-409D-A654-309FA8697F0C@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 23, 2020 2:11:19 PM PDT, Linus Torvalds <torvalds@linux-foundati=
on=2Eorg> wrote:
>On Fri, Oct 23, 2020 at 2:00 PM <hpa@zytor=2Ecom> wrote:
>>
>> There is no same reason to mess around with hacks when we are talking
>about dx:ax, though=2E
>
>Sure there is=2E
>
>"A" doesn't actually mean %edx:%eax like you seem to think=2E
>
>It actually means %eax OR %edx, and then if given a 64-bit value, it
>will use the combination (with %edx being the high bits)=2E
>
>So using "A" unconditionally doesn't work - it gives random behavior
>for 32-bit (or smaller) types=2E
>
>Or you'd have to cast the value to always be 64-bit, and have the
>extra code generation=2E
>
>IOW, an unconditional "A" is wrong=2E
>
>And the alternative is to just duplicate things, and go back to the
>explicit size testing, but honestly, I really think that's much worse
>than relying on a documented feature of "register asm()" that gcc
>_documents_ is for this kind of inline asm use=2E
>
>So the "don't do pointless conditional duplication" is certainly a
>very sane reason for the code=2E
>
>            Linus

Unconditional "A" is definitely wrong, no argument there=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
