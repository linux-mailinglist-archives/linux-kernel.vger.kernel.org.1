Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17B32A9504
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 12:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgKFLIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 06:08:25 -0500
Received: from foss.arm.com ([217.140.110.172]:35324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgKFLIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 06:08:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E412E147A;
        Fri,  6 Nov 2020 03:08:23 -0800 (PST)
Received: from [10.37.12.46] (unknown [10.37.12.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62E103F719;
        Fri,  6 Nov 2020 03:08:21 -0800 (PST)
Subject: Re: [PATCH v8 30/43] arm64: kasan: Allow enabling in-kernel MTE
To:     Andrey Konovalov <andreyknvl@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <cover.1604531793.git.andreyknvl@google.com>
 <5e3c76cac4b161fe39e3fc8ace614400bc2fb5b1.1604531793.git.andreyknvl@google.com>
 <20201105172549.GE30030@gaia>
 <CAAeHK+x0pQyQFG9e9HRxW5p8AYamPFmP-mKpHDWTwL_XUq7msA@mail.gmail.com>
 <20201105173901.GH30030@gaia>
 <CAAeHK+wOyPYP=BkhratZwR=NKyzLWzwTTbyGtqQ75tJyM1D=rg@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <c8a28305-eac6-54a6-3071-9768a9774a5c@arm.com>
Date:   Fri, 6 Nov 2020 11:11:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+wOyPYP=BkhratZwR=NKyzLWzwTTbyGtqQ75tJyM1D=rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 11/5/20 6:09 PM, Andrey Konovalov wrote:
>> Ah, I got there eventually in patch 38. Too many indirections ;) (I'm
>> sure we could have trimmed them down a bit, hw_init_tags ==
>> arch_init_tags == mte_init_tags).
> The idea with these indirections was to make hw_tags.c to not directly
> call MTE stuff and abstract away the underlying memory tagging
> implementation. We won't know for sure how fitting these abstractions
> are before we add another memory tagging implementation though :)
> 

I agree with Andrey, because in future the sparc architecture might want to
support HW KASAN hence keeping a generic infrastructure adds some value.

-- 
Regards,
Vincenzo
