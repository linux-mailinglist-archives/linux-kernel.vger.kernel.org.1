Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65F72A228A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 01:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbgKBANs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 19:13:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:36782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbgKBANs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 19:13:48 -0500
Received: from [10.44.0.192] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3416B21D91;
        Mon,  2 Nov 2020 00:13:45 +0000 (UTC)
Subject: Re: [PATCH 2/2] m68k: m68328: remove duplicate code
To:     Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20201015123258.2644027-1-arnd@arndb.de>
 <20201015123258.2644027-2-arnd@arndb.de>
 <ab3a33d0-7a3a-f12b-244d-24195c06f3fc@linux-m68k.org>
 <CAK8P3a2X3R1Rg3=FFaPQd4MHNJgBMDoVwcq+Fk8fNPoA42tTJQ@mail.gmail.com>
 <CAK8P3a3POARBq+6HxRyqPb3Vs93pTnmAm8ecMN2PpbQtgU4VCA@mail.gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <f832d98d-d189-7562-f63a-638491eee690@linux-m68k.org>
Date:   Mon, 2 Nov 2020 10:13:42 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3POARBq+6HxRyqPb3Vs93pTnmAm8ecMN2PpbQtgU4VCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 31/10/20 12:25 am, Arnd Bergmann wrote:
> On Mon, Oct 19, 2020 at 2:06 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Mon, Oct 19, 2020 at 1:45 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
>>> On 15/10/20 10:32 pm, Arnd Bergmann wrote:
>>
>>>> diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
>>>> index 17e8c3a292d7..1851c66e8667 100644
>>>> --- a/arch/m68k/Kconfig.machine
>>>> +++ b/arch/m68k/Kconfig.machine
>>>> @@ -136,14 +136,13 @@ config SUN3
>>>>
>>>>          If you don't want to compile a kernel exclusively for a Sun 3, say N.
>>>>
>>>> -endif # M68KCLASSIC
>>>> -
>>>>    config PILOT
>>>>        bool
>>>>
>>>>    config PILOT3
>>>>        bool "Pilot 1000/5000, PalmPilot Personal/Pro, or PalmIII support"
>>>> -     depends on M68328
>>>> +     depends on !MMU
>>>> +     select M68328
>>>
>>> Given that M68328 depends on !MMU do you also need or want that here?
>>
>> Yes, that is exactly the reason: if M68328 depends on !MMU and gets
>> selected by something that lacks the !MMU dependency, we'd get a
>> Kconfig warning and a failed build when enabling PILOT3 with MMU
>> enabled.
> 
> It looks like my reply never made it out because of mail server issues.
> I hope the above answers your question.
> 
> I'm rebasing this series (along with some others) now, and will resend in a bit.

Ok, no worries.
Otherwise looked good.

I will review v2 and most likely push into the m68knommu git tree.

Regards
Greg
