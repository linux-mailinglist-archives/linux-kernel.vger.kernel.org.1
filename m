Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB582DB428
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 20:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbgLOS7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 13:59:40 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:52855 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbgLOS7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 13:59:03 -0500
Received: from [192.168.1.155] ([95.118.67.37]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M3UdI-1kpnS11rLW-000egT; Tue, 15 Dec 2020 19:55:54 +0100
Subject: Re: [PATCH] arch: x86: entry: vdso: fix type conversion on printf()
 call
To:     Andy Lutomirski <luto@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
References: <20201215160314.18773-1-info@metux.net>
 <41ef1cd1-017d-a0d4-91d3-a1183bd2ab01@infradead.org>
 <CALCETrXhZxyPUcrBaO=mzvANC72uXNBrivo7hGmdkV2bgdFxjw@mail.gmail.com>
 <1297989c-6a9e-0804-82a5-d55cc7502b77@infradead.org>
 <CALCETrUgbz8LWraKyVFcVJik=d5zOJTeXHvm6oM9T4ym=66LcA@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <957d36a7-4555-e5d1-ed51-948e01fbd247@metux.net>
Date:   Tue, 15 Dec 2020 19:55:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CALCETrUgbz8LWraKyVFcVJik=d5zOJTeXHvm6oM9T4ym=66LcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:k8Fgp5u5dw8zqS+o4v+wMrkTjZO+VPVeykva3uXpgneSmjesvzS
 /hGqmk92O8Ga6Vksc5dVijUwFI7vMFqfULdHzIcToBcBwmGvF63d6/sFmzzFG7VExICmJqN
 /AYSpqg+P4cI562rqd2yDnQrdpANW/peTh+Ph6NPpyl5uehp2GCrPuKK631vrHMQxXnGhp1
 O6oZ2ptdchxvUXpGXsGgA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8uDmxRMSkLM=:chkBleZ0EPZRVrttUOuITU
 IA4VUO2wZD8qDwL9TSk5LeFMaFG1jQo+FavFOwa6EhEF+EqQTOwChuGdoMIlzZ16nb8jvyRXr
 35qq/Ac15PPTZh8wcLrsmYxZBwTvuHl/KTptir0buqNTvXuCIO7H92z53ARim1zemdkhFRzsg
 arq0Tt7FBhZMPQmP/FodvBgHNQazoqFVS9yBKLb8pgORWi+ruYDwdNYwWgd9qiIw6bR5hJdPL
 +zZqPBBRSCSjvwnr9vR8V75+PwCnEDwJ9m/wxDaj9YCtpzM1dTo96kCIzQkNjbWvxSQrjR+i7
 8vmoxNgu8Xsc8itSA0UE8buvpGqcm35dztEE/yPMFrLp+G6WDmnU8maWBEOj8d+7eltNixH+c
 EyzDqCsCvh18RkDH9e0zQatuWyq2lYCzjc1mfrFqcQ3uXHCvmNmPI6CJtJD6v
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.12.20 17:55, Andy Lutomirski wrote:
>>>> size_t is normally printed with %zu.
>>>> Is there some reason that isn't being used here?
>>>
>>> No.  Want to send a patch?
>>>
>>
>> I was hoping that Enrico would fix this and maybe address your other comment,
>> although I'm not so sure that I agree with it.
> 
> Using %zu would get rid of the line break entirely.  Enrico?

you're both rigth. I'll send a v2 of the patch


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
