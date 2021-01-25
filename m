Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B7E302E26
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732855AbhAYVlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:41:36 -0500
Received: from mout.gmx.net ([212.227.15.19]:42299 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733031AbhAYVjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:39:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611610663;
        bh=RDYY9el5f+nsgQ6gFiy8PMqsEn4/zhbkeCpd0ZbQhCY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZO9XCngGlkNJbXkECUsdz7FVc620gL0w2xoVjgYHEGGJ1AqwNPYDgMTO9vkHOT4Vx
         KV6TwmCp1HoPU7RZfaOvX+LXZyvs76f2IGdrDPJCXlPnzscZp9n1UVxmL3UKisFbcP
         jGer6OekjFdM19HrTxTJZJmuaxbYYil5mz6PXgTg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.169.109]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MsYqv-1ls7e01qzz-00tycj; Mon, 25
 Jan 2021 22:37:43 +0100
Subject: Re: hppa64-linux-ld: mm/hugetlb.o(.text+0x50dc): cannot reach printk
To:     John David Anglin <dave.anglin@bell.net>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>
References: <202101162230.XswE8zOX-lkp@intel.com>
 <CAKwvOd=rrTLc510cEA84BC_zzYVQ0ifPEMhRRtU-cyYPs_E4eA@mail.gmail.com>
 <bed0d008-c5c0-011e-6f1e-fb248f97c009@bell.net>
 <88735d3b-1b56-bc8a-2183-1f9549626002@gmx.de>
 <20210125204720.GA28462@ls3530.fritz.box>
 <4bdf35de-f804-4e9d-cde9-cc6785840a60@gmx.de>
 <627d4b69-79cf-371b-9aa7-d87f26e4f088@bell.net>
 <3564bcea-5781-123f-564e-53289967e9e4@gmx.de>
 <428d571c-1f68-7a59-3232-9bb362b51a5b@bell.net>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <2d1df226-275a-26f5-2f32-d2c3e591dbc6@gmx.de>
Date:   Mon, 25 Jan 2021 22:37:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <428d571c-1f68-7a59-3232-9bb362b51a5b@bell.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:62Ia8N38ga24tRZ0nWDpz1mwa0Kg2oqSfk+x0IiTrqTCdhRDf9G
 YdOMwLAYHdCUpJc37w6f1aCZY9CAhUoGZz+eSKBlUnoaQRrL4w559u+cR18hn0cAeUMI3zj
 Wn56V83PqNQXWIvp8luYEc1uZopq5f2M6aDL3ag/7ZAsVYalmCrNQURKyvCVgTNAs6BmzSM
 4HSqOU265IXh0/PQlF6xA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oHs7iHILS7Q=:s2WxnUovYcreJR0Qgiu5TD
 K64AGqbzbYwy1YkY1muDN3FR+UHNHMaBuC09eQGezSN3FBesSE11tbSYegS50XZBft7OlVCAg
 GMes+mZmhGzwOLQfBUcmz2+/mRtAGAZ8xP0fVpWh4pssPPMWPnxRz9ZR8GP4gQVy5985FijVv
 gmo76VEt8AoBZshfNIi8JcaXeB1ELJAOFgx+YGbc2/anDdVZaVNZb/aXIeRW7v6aZtG7rx3YE
 +N//qEnYXjOaglCVLNJpdtQ+ns4obei4vHKuLklgYgsofvX39Jq9Dx2EUjje77G+M0arbbU8x
 viJ3fyIEW5/MbjRGkXufJvxBiCorPVknW4+XbVRbM4XyB5ujS6VQz0VJRI9Bs9M3BlThSkKAh
 NxYT/d81AAvjOiOMQdxdEHRv4fx6zvlqD/k6Qz7o+w7fVRrzcNjjYJsbo7Dp0dAwPr9yrZQgA
 5BsUNWB5N7zVWRt3a1NCtQnqA8kPRboMBth1jFbjutMmmPDokEIdS9Jv+qAqkqNF+Uz/u0oTq
 C0fz7GO+mtXuCYYKJWth2Bi3xgPRe1Yt9EsQYWfRkyU5NWFpAvTqRlo0ZqQzP6ehJMuXN3L2P
 J0hp4o3FhKu4e+c5stF1dC5GMj+YkBt0TtZSopyjhFEkgMv8V4+EYiDOMZ0wI9HlC3SR5dLWj
 pFe3+LmjpMbgBMgQxqJITHcPyoF2ppWuTLTMbvr8/gANaXkUygjoZcaWfVYgs1yhRG6y6FrrT
 apYdSCTpDCzEJUlEMkLtxTJXZ7A3vIvI8oQcfryDNtkAeHJVM43rFRg4aQbqe/yZFx4cLS1w/
 bFgU7Qn3fWU8CnowDDa68iImOVjAWXnhvzpYtJn1D0QUNRFYImTl0aAR0O/MiGCQX4ixDg0fY
 WjukJxxnrpjzjWAcwv7Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/21 10:17 PM, John David Anglin wrote:
> On 2021-01-25 4:13 p.m., Helge Deller wrote:
>> On 1/25/21 10:08 PM, John David Anglin wrote:
>>> I would suggest the following for this hunk:
>>>
>>> +=C2=A0=C2=A0=C2=A0 ldil=C2=A0=C2=A0=C2=A0 L%intr_restore, %r2
>>> +=C2=A0=C2=A0=C2=A0 BL=C2=A0=C2=A0=C2=A0 preempt_schedule_irq
>>> +=C2=A0=C2=A0=C2=A0 ldo=C2=A0=C2=A0=C2=A0=C2=A0 R%intr_restore(%r2), %=
r2
>>>
>>> =C2=A0=C2=A0=C2=A0 ldil=C2=A0=C2=A0=C2=A0 L%intr_restore, %r1
>>> =C2=A0=C2=A0=C2=A0 b,l=C2=A0=C2=A0=C2=A0 preempt_schedule_irq,%r2
>>> =C2=A0=C2=A0=C2=A0 ldo=C2=A0=C2=A0=C2=A0=C2=A0 R%intr_restore(%r1), %r=
2
>>>
>>> On PA 2.0 hardware that gives a 22-bit call.
>> "BL" is already using "b,l", see #define in arch/parisc/include/asm/ass=
embly.h
>>
>> The 22-bit weren't sufficient, that's why I changed it too.
> Okay but "b,l" only provides a 22-bit branch with %r2 as link register.=
=C2=A0

Argh. Yes. Didn't know.
We have BL,%r25 in the same file.

> You also need to use %r1 in the ldil and ldo instructions.

Ok, will fix.

Helge
