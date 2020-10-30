Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B100C2A0EDF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 20:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgJ3TuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 15:50:06 -0400
Received: from mout.gmx.net ([212.227.17.21]:50435 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbgJ3TuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 15:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604087339;
        bh=cJgYMSlr7eXaH/4UpcYuUItCEe5TNfgOY9V68j78Zf0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CKnzaf9ZE+fw8A1Nv2cb0NimdIAXrw3d/QMuMoqkC3g08kOVzu7Ch+PkYm2Gi0ANN
         eohBCnc/zrsuHX45TDOT0hdu5TR3KpEMPMdn0aDvDxGUpn6anNVXjGm3c0p3KRQkZV
         rBHlqmZq8L/ymLJLfXOUGmqf+63fJ2UQyYhE+IAU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.183.159]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwQXN-1kGEEI2UYX-00sO6m; Fri, 30
 Oct 2020 20:48:59 +0100
Subject: Re: [PATCH v2 07/15] parisc: use legacy_timer_tick
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        Philip Blundell <philb@gnu.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-ia64@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20201030151758.1241164-1-arnd@kernel.org>
 <20201030151758.1241164-8-arnd@kernel.org>
 <2e2d7b65-0aa8-55aa-d395-52cfb048adef@gmx.de>
 <CAK8P3a0dPxWu6obX6jca8TsDQw6xsBmrihu8oH0TxR-BxYV3vw@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <b4779fce-5218-8aea-a416-b2806c9d062d@gmx.de>
Date:   Fri, 30 Oct 2020 20:48:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0dPxWu6obX6jca8TsDQw6xsBmrihu8oH0TxR-BxYV3vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yCyDuxLZO8nhsOzbHa0Nwu8CcimLZ8h4UJsLe0a9Idd+JEAEeSs
 ssq5Me2OGgm1UXSg92Jpc8jTrBmSPwoKRF7oDawlgMTxVcyD3EJp9Tc7VeETXQ9Bggr0mUQ
 HCaI/pLiahm19uDi8zlAQmgSZp1LJ6IIXQmckL7NBAZ5LmbNZrL/fFPCY8T2kQwxNiHByrJ
 flfs0XvrNlDH2y27vDsOQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IeZFZPBXPjk=:1pzx0IyRm7XUrwGfd2cs2D
 R2rAtyV/kEjmHnIGXa5cQq1gcl+HUHCcUcMAaxE/5WaAUbgSMmLvLxfstnZyLfzIRRkT5tmPg
 ey/0j6CU/ffuqCYeOOaUt8kauacnRvUcYPaIdCuBYE+0bRBEPsV6hVWm9rkN27EVTazJhrioc
 Of+jdsxGdNZh7Pdn5VFpz4x8mIh3c4qFumJwHSxbvvWxT+aSFzpSc6eSyfxP0C+RUeswwZZEC
 FRTVLQiRyRvRiHw1Lx9VVqvGQHnVKV43Jcoi0J+JTV89pRs29amJvyl+VDPaN1CCtCVvZV5aF
 YLKXtFn8EmLp6SOCn363+1ghX0AkNf8buoESQrNfPte0XSl0VU0qlX2ORXUE0Mj8HbvlIfozy
 ViE9n6ujBXnzFZAfAMGBDzs4V8tI1z/251tLHQWnfV3SuG5fmmYRBXD0COhFxCybyYhf7RX5P
 wG5px5ZqsoMEcb9OCQnf+kbX2BZl+0La6zhiBsW+IIxhMqh/Z6iMuo85PjMOgb/s/XBGuK3FM
 OZHKO3lOK7EJjtijZ2bgK7SQfgj9WkTnqxi9i/0AOUgGtQQDmUBVBP9o9DcWYB1m54cxYdG93
 aHq7bOetGqphL3bf3AD9KF6sOxrj8jt96u+QaVFnc2FxyanzZSkzhRu7oFmqS7MDZfnJDWKlz
 tq6wQVGKrRalM7z3XA+rkxK/dEQV7gkfK64jPmDmZvZ0wIs0xiqu+RpalVQSn+ghr3bAmIqM8
 IQ/BX1tDSxVkXcDNaPha2bv4eV3S1+9QwK1JlCHNIBI9enNObqS++/ULTB9Il3xShfcBycJ+5
 illrw346j0kvCjRwCru9MsV73kAxYESiyS3d7AsycC0P8dOuVOy6AvbGGXVXE1M/hJsFSv3/0
 xffB9rE56VdL60Z8TVHw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/20 8:33 PM, Arnd Bergmann wrote:
> On Fri, Oct 30, 2020 at 6:13 PM Helge Deller <deller@gmx.de> wrote:
>>
>> On 10/30/20 4:17 PM, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> parisc has selected CONFIG_GENERIC_CLOCKEVENTS since commit 43b1f6abd5=
90
>>> ("parisc: Switch to generic sched_clock implementation"), but does not
>>> appear to actually be using it, and instead calls the low-level
>>> timekeeping functions directly.
>>
>> Arnd, thank you for this patch!
>> It reminded me that I really missed to fully implement the clockevents =
on parisc!
>>
>> Your other patch ("RFC: m68k: mac: convert to generic clockevent")
>> was a big help too, as it showed how it might work on parisc as well.
>>
>> Here is now a current version of the clockevents-enabling-patch for par=
isc:
>> https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git=
/commit/?h=3Dfor-next&id=3D3b7ab4a74a2d1972dbeb33285d85f1500b2ff96a
>
> Ah, nice!
>
>>> Remove the GENERIC_CLOCKEVENTS select again, and instead convert to
>>> the newly added legacy_timer_tick() helper.
>>
>> My patch still needs more testing, but if it turns to work
>> out right, would you mind to drop your patch for parisc?
>
> I think it would be easier if you could base your patch on top of
> my series, as they would otherwise inevitably conflict. I could either
> add it to my tree, or you could merge my branch into your tree.

Couldn't you drop your patch and include mine in your tree instead?
That way nothing conflicts, and they get merged together?

Helge
