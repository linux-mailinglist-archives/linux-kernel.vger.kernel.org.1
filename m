Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614282FA4FB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393488AbhARPkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:40:47 -0500
Received: from foss.arm.com ([217.140.110.172]:38070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388441AbhARPgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:36:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1ACD21FB;
        Mon, 18 Jan 2021 07:35:58 -0800 (PST)
Received: from [10.37.8.29] (unknown [10.37.8.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66E603F68F;
        Mon, 18 Jan 2021 07:35:55 -0800 (PST)
Subject: Re: [PATCH v3 3/4] arm64: mte: Enable async tag check fault
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Alexander Potapenko <glider@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
References: <20210115120043.50023-1-vincenzo.frascino@arm.com>
 <20210115120043.50023-4-vincenzo.frascino@arm.com>
 <20210118125715.GA4483@gaia> <c076b1cc-8ce5-91a0-9957-7dcd78026b18@arm.com>
 <20210118141429.GC31263@C02TD0UTHF1T.local>
 <1c0577c1-bf73-2c00-b137-9f7251afd20e@arm.com>
Message-ID: <ff8c61b3-1374-29c7-a4f3-9e37b61e5f3a@arm.com>
Date:   Mon, 18 Jan 2021 15:39:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1c0577c1-bf73-2c00-b137-9f7251afd20e@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/21 2:48 PM, Vincenzo Frascino wrote:
>> Are you aware of cases where the TFSR_EL1 value is read other than by an
>> MRS? e.g. are there any cases where checks are elided if TF1 is set? If
>> so, we may need the ISB to order the direct write against subsequent
>> indirect reads.
>>
> Thank you for the explanation. I am not aware of any case in which TFSR_EL1 is
> read other then by an MRS. Based on the ARM DDI 0487F.c (J1-7626) TF0/TF1 are
> always set to '1' without being accessed before. I will check with the
> architects for further clarification and if this is correct I will remove the
> isb() in the next version.
> 

I spoke to the architects and I confirm that the isb() can be removed.

-- 
Regards,
Vincenzo
