Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E268300181
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbhAVL1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 06:27:15 -0500
Received: from foss.arm.com ([217.140.110.172]:42386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728224AbhAVLXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 06:23:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A04411509;
        Fri, 22 Jan 2021 03:23:02 -0800 (PST)
Received: from [10.37.8.28] (unknown [10.37.8.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE78F3F719;
        Fri, 22 Jan 2021 03:23:00 -0800 (PST)
Subject: Re: [PATCH v5 6/6] kasan: Forbid kunit tests when async mode is
 enabled
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
References: <20210121163943.9889-1-vincenzo.frascino@arm.com>
 <20210121163943.9889-7-vincenzo.frascino@arm.com>
 <CAAeHK+yaFtXUDVExoyqkYysOPdxLVhfY53nb-msFYEJLZx6k8Q@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <1586f5ed-c70d-ceb1-88c4-803ea8674dc0@arm.com>
Date:   Fri, 22 Jan 2021 11:26:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+yaFtXUDVExoyqkYysOPdxLVhfY53nb-msFYEJLZx6k8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/21/21 5:40 PM, Andrey Konovalov wrote:
>> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
>> index 7285dcf9fcc1..1306f707b4fe 100644
>> --- a/lib/test_kasan.c
>> +++ b/lib/test_kasan.c
>> @@ -52,6 +52,11 @@ static int kasan_test_init(struct kunit *test)
>>                 return -1;
>>         }
>>
>> +       if (!hw_is_mode_sync()) {
>> +               kunit_err(test, "can't run KASAN tests in async mode");
>> +               return -1;
>> +       }
> I'd rather implement this check at the KASAN level, than in arm64
> code. Just the way kasan_stack_collection_enabled() is implemented.
> 
> Feel free to drop this change and the previous patch, I'll implement
> this myself later.
> 

Fine by me, will drop 5 and 6 in v5.

-- 
Regards,
Vincenzo
