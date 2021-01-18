Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB6E2FA4FE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393537AbhARPl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:41:56 -0500
Received: from foss.arm.com ([217.140.110.172]:38116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392507AbhARPh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:37:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA3EC1FB;
        Mon, 18 Jan 2021 07:37:09 -0800 (PST)
Received: from [10.37.8.29] (unknown [10.37.8.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AB043F68F;
        Mon, 18 Jan 2021 07:37:07 -0800 (PST)
Subject: Re: [PATCH v3 3/4] arm64: mte: Enable async tag check fault
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
References: <20210115120043.50023-1-vincenzo.frascino@arm.com>
 <20210115120043.50023-4-vincenzo.frascino@arm.com>
 <20210118125715.GA4483@gaia> <c076b1cc-8ce5-91a0-9957-7dcd78026b18@arm.com>
Message-ID: <330506b9-b7e9-8fda-889a-0827229e1a3d@arm.com>
Date:   Mon, 18 Jan 2021 15:40:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c076b1cc-8ce5-91a0-9957-7dcd78026b18@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/18/21 1:37 PM, Vincenzo Frascino wrote:
>> If a speculated load is allowed to update this reg, we'd probably need an
>> ISB+DSB (I don't think it does, something to check with the architects).
>>
> I will check this with the architects and let you know.

I spoke to the architects and no speculative load can update TFSR_EL1.

-- 
Regards,
Vincenzo
