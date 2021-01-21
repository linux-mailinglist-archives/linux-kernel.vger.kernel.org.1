Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310FB2FF22E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388555AbhAURlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:41:20 -0500
Received: from foss.arm.com ([217.140.110.172]:42424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388887AbhAURkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:40:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5982611B3;
        Thu, 21 Jan 2021 09:39:39 -0800 (PST)
Received: from [10.37.8.32] (unknown [10.37.8.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6869F3F66E;
        Thu, 21 Jan 2021 09:39:37 -0800 (PST)
Subject: Re: [PATCH v2 1/2] arm64: Fix kernel address detection of
 __is_lm_address()
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrey Konovalov <andreyknvl@google.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
References: <20210121131956.23246-1-vincenzo.frascino@arm.com>
 <20210121131956.23246-2-vincenzo.frascino@arm.com>
 <20210121151206.GI48431@C02TD0UTHF1T.local>
 <95727b4c-4578-6eb5-b518-208482e8ba62@arm.com>
 <20210121154938.GJ48431@C02TD0UTHF1T.local>
 <5a389787-4f6a-7577-22fc-f5594409e1ae@arm.com>
Message-ID: <ecbc7651-82c4-6518-d4a9-dbdbdf833b5b@arm.com>
Date:   Thu, 21 Jan 2021 17:43:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5a389787-4f6a-7577-22fc-f5594409e1ae@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/21/21 4:02 PM, Vincenzo Frascino wrote:
>> I think it'd be worth checking, if we're going to use this in common
>> code.
>>
> Ok, I will run some tests and let you know.
> 

I checked on x86_64 and ppc64 (they both have KASAN implementation):

I added the following:

printk("%s: %d\n", __func__, virt_addr_valid(0));

in x86_64: sounds/last.c
in pp64: arch/powerpc/kernel/setup-common.c

and in both the cases the output is 0 (false) when the same in arm64 is 1
(true). Therefore I think we should proceed with the change.

-- 
Regards,
Vincenzo
