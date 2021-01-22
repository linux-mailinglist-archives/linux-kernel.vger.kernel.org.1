Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70ED6300192
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbhAVL3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 06:29:33 -0500
Received: from foss.arm.com ([217.140.110.172]:42258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728253AbhAVLVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 06:21:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C691911D4;
        Fri, 22 Jan 2021 03:20:39 -0800 (PST)
Received: from [10.37.8.28] (unknown [10.37.8.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D45203F719;
        Fri, 22 Jan 2021 03:20:37 -0800 (PST)
Subject: Re: [PATCH v5 4/6] arm64: mte: Enable async tag check fault
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
 <20210121163943.9889-5-vincenzo.frascino@arm.com>
 <CAAeHK+y9HbV6yVJ0f819Y=_6ijkKq06rqJSY+mh4NF4qd8t_oA@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <04eba2be-641b-ee23-7fa0-436c33168cd8@arm.com>
Date:   Fri, 22 Jan 2021 11:24:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+y9HbV6yVJ0f819Y=_6ijkKq06rqJSY+mh4NF4qd8t_oA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/21 5:38 PM, Andrey Konovalov wrote:
>> +       if (unlikely(tfsr_el1 & SYS_TFSR_EL1_TF1)) {
>> +               /*
>> +                * Note: isb() is not required after this direct write
>> +                * because there is no indirect read subsequent to it
>> +                * (per ARM DDI 0487F.c table D13-1).
>> +                */
>> +               write_sysreg_s(0, SYS_TFSR_EL1);
>> +
>> +               kasan_report_async();
> Do we need a static bool reported like in do_tag_recovery() here?
> 

I would say not because async mode does not get disabled after the first fault.

-- 
Regards,
Vincenzo
