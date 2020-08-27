Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C714F254946
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 17:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgH0PXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 11:23:30 -0400
Received: from foss.arm.com ([217.140.110.172]:57092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728465AbgH0L36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:29:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD5041045;
        Thu, 27 Aug 2020 04:03:44 -0700 (PDT)
Received: from [192.168.1.190] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 858883F68F;
        Thu, 27 Aug 2020 04:03:42 -0700 (PDT)
Subject: Re: [PATCH 26/35] kasan, arm64: Enable TBI EL1
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
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
References: <cover.1597425745.git.andreyknvl@google.com>
 <518da1e5169a4e343caa3c37feed5ad551b77a34.1597425745.git.andreyknvl@google.com>
 <20200827104033.GF29264@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <9c53dfaa-119e-b12e-1a91-1f67f4aef503@arm.com>
Date:   Thu, 27 Aug 2020 12:05:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827104033.GF29264@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/20 11:40 AM, Catalin Marinas wrote:
> On Fri, Aug 14, 2020 at 07:27:08PM +0200, Andrey Konovalov wrote:
>> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
>> index 152d74f2cc9c..6880ddaa5144 100644
>> --- a/arch/arm64/mm/proc.S
>> +++ b/arch/arm64/mm/proc.S
>> @@ -38,7 +38,7 @@
>>  /* PTWs cacheable, inner/outer WBWA */
>>  #define TCR_CACHE_FLAGS	TCR_IRGN_WBWA | TCR_ORGN_WBWA
>>  
>> -#ifdef CONFIG_KASAN_SW_TAGS
>> +#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
>>  #define TCR_KASAN_FLAGS TCR_TBI1
>>  #else
>>  #define TCR_KASAN_FLAGS 0
> 
> I prefer to turn TBI1 on only if MTE is present. So on top of the v8
> user series, just do this in __cpu_setup.
> 

Not sure I understand... Enabling TBI1 only if MTE is present would break
KASAN_SW_TAGS which is based on TBI1 but not on MTE.

-- 
Regards,
Vincenzo
