Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A937A300452
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 14:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbhAVNge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 08:36:34 -0500
Received: from foss.arm.com ([217.140.110.172]:48080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727756AbhAVNfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 08:35:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 461F511B3;
        Fri, 22 Jan 2021 05:34:50 -0800 (PST)
Received: from [10.37.8.28] (unknown [10.37.8.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCC263F66E;
        Fri, 22 Jan 2021 05:34:47 -0800 (PST)
Subject: Re: [PATCH v5 3/6] kasan: Add report for async mode
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
References: <20210121163943.9889-1-vincenzo.frascino@arm.com>
 <20210121163943.9889-4-vincenzo.frascino@arm.com>
 <20210122131933.GD8567@gaia> <6ccde9db-98cd-5a56-b93d-0b79f4df56a7@arm.com>
Message-ID: <7a04c826-6351-7a28-867c-fe415aae8aae@arm.com>
Date:   Fri, 22 Jan 2021 13:38:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6ccde9db-98cd-5a56-b93d-0b79f4df56a7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/22/21 1:27 PM, Vincenzo Frascino wrote:
>> It looks like the original kasan_report() prototype is declared in two
>> places (second one in mm/kasan/kasan.h). I'd remove the latter and try
>> to have a consistent approach for kasan_report() and
>> kasan_report_async().
>>
> Ok, I will remove it.

I just realized that the internal interface exposes the kasan_report() interface
for the GENERIC KASAN implementation. If I remove it that does not work anymore:

/data1/Projects/LinuxKernel/linux-mte/mm/kasan/common.c: In function
‘__kasan_check_byte’:
/data1/Projects/LinuxKernel/linux-mte/mm/kasan/common.c:503:17: error: implicit
declaration of function ‘kasan_report’ [-Werror=implicit-function-declaration]
  503 |                 kasan_report((unsigned long)address, 1, false, ip);
      |                 ^~~~~~~~~~~~
/data1/Projects/LinuxKernel/linux-mte/mm/kasan/generic.c: In function
‘check_region_inline’:
/data1/Projects/LinuxKernel/linux-mte/mm/kasan/generic.c:170:25: error: implicit
declaration of function ‘kasan_report’ [-Werror=implicit-function-declaration]
  170 |                 return !kasan_report(addr, size, write, ret_ip);
      |                         ^~~~~~~~~~~~
/data1/Projects/LinuxKernel/linux-mte/mm/kasan/report_generic.c: In function
‘__asan_report_load1_noabort’:
/data1/Projects/LinuxKernel/linux-mte/mm/kasan/report_generic.c:295:9: error:
implicit declaration of function ‘kasan_report’
[-Werror=implicit-function-declaration]
  295 |         kasan_report(addr, size, false, _RET_IP_);        \
      |         ^~~~~~~~~~~~
/data1/Projects/LinuxKernel/linux-mte/mm/kasan/report_generic.c:306:1: note: in
expansion of macro ‘DEFINE_ASAN_REPORT_LOAD’
  306 | DEFINE_ASAN_REPORT_LOAD(1);

To do that cleanly few things need to be shuffled around, Andrey or I can take
care of it but if you agree we shall look into this after -rc1.

Thanks!

-- 
Regards,
Vincenzo
