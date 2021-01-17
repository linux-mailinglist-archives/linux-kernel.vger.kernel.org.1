Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F082F924F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 13:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbhAQMYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 07:24:11 -0500
Received: from foss.arm.com ([217.140.110.172]:43802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbhAQMYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 07:24:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DABEC1FB;
        Sun, 17 Jan 2021 04:23:22 -0800 (PST)
Received: from [10.37.8.4] (unknown [10.37.8.4])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C10153F719;
        Sun, 17 Jan 2021 04:23:20 -0800 (PST)
Subject: Re: [PATCH v3 4/4] arm64: mte: Optimize mte_assign_mem_tag_range()
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
References: <20210115120043.50023-1-vincenzo.frascino@arm.com>
 <20210115120043.50023-5-vincenzo.frascino@arm.com>
 <20210115154520.GD44111@C02TD0UTHF1T.local>
 <4b1a5cdf-e1bf-3a7e-593f-0089cedbbc03@arm.com>
Message-ID: <0c1b9a6b-0326-a24f-6418-23a0723adecf@arm.com>
Date:   Sun, 17 Jan 2021 12:27:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4b1a5cdf-e1bf-3a7e-593f-0089cedbbc03@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 1/16/21 2:22 PM, Vincenzo Frascino wrote:
>> Is there any chance that this can be used for the last bytes of the
>> virtual address space? This might need to change to `_addr == _end` if
>> that is possible, otherwise it'll terminate early in that case.
>>
> Theoretically it is a possibility. I will change the condition and add a note
> for that.
> 

I was thinking to the end of the virtual address space scenario and I forgot
that if I use a condition like `_addr == _end` the tagging operation overflows
to the first granule of the next allocation. This disrupts tagging accesses for
that memory area hence I think that `_addr < _end` is the way to go.

-- 
Regards,
Vincenzo
