Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4319C2F8DBF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 18:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbhAPRGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 12:06:17 -0500
Received: from foss.arm.com ([217.140.110.172]:52500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbhAPQnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 11:43:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 689B9D6E;
        Sat, 16 Jan 2021 05:37:07 -0800 (PST)
Received: from [10.37.8.30] (unknown [10.37.8.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7595D3F719;
        Sat, 16 Jan 2021 05:37:05 -0800 (PST)
Subject: Re: [PATCH v3 1/4] kasan, arm64: Add KASAN light mode
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
References: <20210115120043.50023-1-vincenzo.frascino@arm.com>
 <20210115120043.50023-2-vincenzo.frascino@arm.com>
 <CAAeHK+xt4MWuxAxx_5nJNvC5_d7tvZDqPaA19bV0GNXsAzYfOA@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <4335128b-60bf-a5c4-ddb5-154500cc4a22@arm.com>
Date:   Sat, 16 Jan 2021 13:40:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+xt4MWuxAxx_5nJNvC5_d7tvZDqPaA19bV0GNXsAzYfOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On 1/15/21 6:59 PM, Andrey Konovalov wrote:
> On Fri, Jan 15, 2021 at 1:00 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>

[...]
>> @@ -60,6 +61,8 @@ static int __init early_kasan_mode(char *arg)
>>
>>         if (!strcmp(arg, "off"))
>>                 kasan_arg_mode = KASAN_ARG_MODE_OFF;
>> +       else if (!strcmp(arg, "light"))
>> +               kasan_arg_mode = KASAN_ARG_MODE_LIGHT;
> 
> Hi Vincenzo,
> 
> I've just mailed the change to KASAN parameters [1] as discussed, so
> we should use a standalone parameter here (kasan.trap?).
> 
> Thanks!
> 
> [1] https://lkml.org/lkml/2021/1/15/1242
> 

Thanks for this. I will have a look into it today. In the meantime, could you
please elaborate a bit more on kasan.trap?

-- 
Regards,
Vincenzo
