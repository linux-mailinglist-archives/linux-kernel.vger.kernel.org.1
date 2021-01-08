Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BE52EF0D1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 11:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbhAHKpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 05:45:23 -0500
Received: from foss.arm.com ([217.140.110.172]:48898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727203AbhAHKpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 05:45:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E267D6E;
        Fri,  8 Jan 2021 02:44:36 -0800 (PST)
Received: from [10.37.8.22] (unknown [10.37.8.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F5D03F70D;
        Fri,  8 Jan 2021 02:44:34 -0800 (PST)
Subject: Re: [PATCH 2/4] arm64: mte: Add asynchronous mode support
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
References: <20210106115519.32222-1-vincenzo.frascino@arm.com>
 <20210106115519.32222-3-vincenzo.frascino@arm.com>
 <CAAeHK+xuGRzkLdrfGZVo-RVfkH31qUrNdBaPd4k5ffMKHWGfTQ@mail.gmail.com>
 <c4f04127-a682-d809-1dad-5ee1f51d3e0a@arm.com>
 <CAAeHK+xBrCX1Ly0RU-=ySEU8SsyyRkMdOYrN52ONc4DeRJA5eg@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <c3efaa8d-cb3a-0c2a-457e-bfba60551d80@arm.com>
Date:   Fri, 8 Jan 2021 10:48:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+xBrCX1Ly0RU-=ySEU8SsyyRkMdOYrN52ONc4DeRJA5eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On 1/7/21 7:18 PM, Andrey Konovalov wrote:
>> Boolean arguments are generally bad for legibility, hence I tend to avoid them.
>> In this case exposing the constants does not seem a big issue especially because
>> the only user of this code is "KASAN_HW_TAGS" and definitely improves its
>> legibility hence I would prefer to keep it as is.
>
> I don't like that this spills KASAN internals to the arm64 code.

Could you please elaborate a bit more on this?

If I understand it correctly these enumerations I exposed are the direct
representation of a kernel command line parameter which, according to me, should
not be considered an internal interface.
Seems that in general the kernel subsystems expose the interface for the
architectures to consume which is the same design pattern I followed in this case.

> Let's add another enum with two values and pass it as an argument then.
> Something like:
> 
> enum mte_mode {
>   ARM_MTE_SYNC,
>   ARM_MTE_ASYNC
> }

I had something similar at the beginning of the development but I ended up in a
situation in which the generic kasan code had to know about "enum mte_mode",
hence I preferred to keep kasan agnostic to the hw implementation details.

What do you think?

-- 
Regards,
Vincenzo
