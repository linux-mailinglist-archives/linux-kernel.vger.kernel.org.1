Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6F42FA1CC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404567AbhARNiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:38:03 -0500
Received: from foss.arm.com ([217.140.110.172]:36232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392311AbhARNee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:34:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4869E31B;
        Mon, 18 Jan 2021 05:33:49 -0800 (PST)
Received: from [10.37.8.29] (unknown [10.37.8.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57ABE3F719;
        Mon, 18 Jan 2021 05:33:47 -0800 (PST)
Subject: Re: [PATCH v3 3/4] arm64: mte: Enable async tag check fault
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
References: <20210115120043.50023-1-vincenzo.frascino@arm.com>
 <20210115120043.50023-4-vincenzo.frascino@arm.com>
 <20210118125715.GA4483@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <c076b1cc-8ce5-91a0-9957-7dcd78026b18@arm.com>
Date:   Mon, 18 Jan 2021 13:37:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210118125715.GA4483@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/21 12:57 PM, Catalin Marinas wrote:
>> +#ifdef CONFIG_KASAN_HW_TAGS
>> +void mte_check_tfsr_el1_no_sync(void)
>> +{
>> +	u64 tfsr_el1;
>> +
>> +	if (!system_supports_mte())
>> +		return;
>> +
>> +	tfsr_el1 = read_sysreg_s(SYS_TFSR_EL1);
>> +
>> +	/*
>> +	 * The kernel should never hit the condition TF0 == 1
>> +	 * at this point because for the futex code we set
>> +	 * PSTATE.TCO.
>> +	 */
>> +	WARN_ON(tfsr_el1 & SYS_TFSR_EL1_TF0);
> I'd change this to a WARN_ON_ONCE() in case we trip over this due to
> model bugs etc. and it floods the log.
> 

I will merge yours and Mark's comment using WARN_ONCE() here. Did not think of
potential bug in the model and you are completely right.

>> +	if (tfsr_el1 & SYS_TFSR_EL1_TF1) {
>> +		write_sysreg_s(0, SYS_TFSR_EL1);
>> +		isb();
> While in general we use ISB after a sysreg update, I haven't convinced
> myself it's needed here. There's no side-effect to updating this reg and
> a subsequent TFSR access should see the new value.

Why there is no side-effect?

> If a speculated load is allowed to update this reg, we'd probably need an
> ISB+DSB (I don't think it does, something to check with the architects).
> 

I will check this with the architects and let you know.

-- 
Regards,
Vincenzo
