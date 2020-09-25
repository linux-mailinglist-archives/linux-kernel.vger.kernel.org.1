Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56732789AC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 15:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgIYNeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 09:34:18 -0400
Received: from foss.arm.com ([217.140.110.172]:45862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728893AbgIYNeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 09:34:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B12AB11B3;
        Fri, 25 Sep 2020 06:33:59 -0700 (PDT)
Received: from [10.37.12.53] (unknown [10.37.12.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB5953F73B;
        Fri, 25 Sep 2020 06:33:56 -0700 (PDT)
Subject: Re: [PATCH v3 24/39] arm64: mte: Add in-kernel MTE helpers
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1600987622.git.andreyknvl@google.com>
 <ae603463aed82bdff74942f23338a681b8ed8820.1600987622.git.andreyknvl@google.com>
 <20200925101558.GB4846@gaia> <e41f2af1-f208-cc99-64f9-2311ad7d50bf@arm.com>
 <20200925125059.GM4846@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <a2c5d41e-1895-2e3f-5624-4f277066f98c@arm.com>
Date:   Fri, 25 Sep 2020 14:36:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200925125059.GM4846@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/25/20 1:50 PM, Catalin Marinas wrote:
>>>> + */
>>>> +SYM_FUNC_START(mte_assign_mem_tag_range)
>>>> +	/* if (src == NULL) return; */
>>>> +	cbz	x0, 2f
>>>> +	/* if (size == 0) return; */
>>>> +	cbz	x1, 2f
>>> I find these checks unnecessary, as I said a couple of times before,
>>> just document the function pre-conditions. They are also incomplete
>>> (i.e. you check for NULL but not alignment).
>>>
>> I thought we agreed to harden the code further, based on [1]. Maybe I
>> misunderstood. I am going to remove them and extend the comment in the next version.
>>
>> [1]
>> https://lore.kernel.org/linux-arm-kernel/921c4ed0-b5b5-bc01-5418-c52d80f1af59@arm.com/
> Well, you concluded that but I haven't confirmed ;). Since it's called
> from a single place which does the checks already, I don't see the point
> in duplicating them. Documenting should be sufficient.

Have you ever heard about "tacit consent"? ;) Anw, fine by me, I will add a
comment here.

-- 
Regards,
Vincenzo
