Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B252B020E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 10:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgKLJg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 04:36:59 -0500
Received: from foss.arm.com ([217.140.110.172]:45262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbgKLJg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 04:36:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 932FD139F;
        Thu, 12 Nov 2020 01:36:58 -0800 (PST)
Received: from [10.37.12.33] (unknown [10.37.12.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C3EF3F73C;
        Thu, 12 Nov 2020 01:36:55 -0800 (PST)
Subject: Re: [PATCH v9 28/44] arm64: mte: Reset the page tag in page->flags
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1605046192.git.andreyknvl@google.com>
 <4a7819f8942922451e8075d7003f7df357919dfc.1605046192.git.andreyknvl@google.com>
 <20201112093130.GD29613@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <cbc140bf-a949-d9cb-3c9e-92304ee40c8e@arm.com>
Date:   Thu, 12 Nov 2020 09:39:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201112093130.GD29613@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/20 9:31 AM, Catalin Marinas wrote:
> On Tue, Nov 10, 2020 at 11:10:25PM +0100, Andrey Konovalov wrote:
>> diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
>> index 70a71f38b6a9..f0efa4847e2f 100644
>> --- a/arch/arm64/mm/copypage.c
>> +++ b/arch/arm64/mm/copypage.c
>> @@ -23,6 +23,7 @@ void copy_highpage(struct page *to, struct page *from)
>>  
>>  	if (system_supports_mte() && test_bit(PG_mte_tagged, &from->flags)) {
>>  		set_bit(PG_mte_tagged, &to->flags);
>> +		page_kasan_tag_reset(to);
>>  		mte_copy_page_tags(kto, kfrom);
> 
> Any reason why this doesn't have an smp_wmb() between resetting the tags
> and copying them into kto?
> 

Yes, the reason is I am not sure why it disappeared from the submitted patch ;)
I am going to respin the patch.

-- 
Regards,
Vincenzo
