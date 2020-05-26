Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F5D1A9C56
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 13:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408851AbgDOLdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 07:33:11 -0400
Received: from foss.arm.com ([217.140.110.172]:42644 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393930AbgDOLct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:32:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8470B1063;
        Wed, 15 Apr 2020 04:32:45 -0700 (PDT)
Received: from [10.37.12.1] (unknown [10.37.12.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCAB13F68F;
        Wed, 15 Apr 2020 04:32:42 -0700 (PDT)
Subject: Re: [PATCH 7/8] arm64: cpufeature: Relax checks for AArch32 support
 at EL[0-2]
To:     will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com, maz@kernel.org,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        saiprakash.ranjan@codeaurora.org, dianders@chromium.org,
        kernel-team@android.com
References: <20200414213114.2378-1-will@kernel.org>
 <20200414213114.2378-8-will@kernel.org>
 <714f124c-7eb7-b750-e98c-63da64ddae75@arm.com>
 <20200415105843.GE12621@willie-the-truck>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <d1f538ec-e956-c136-d0f8-54e7351a28a9@arm.com>
Date:   Wed, 15 Apr 2020 12:37:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200415105843.GE12621@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/15/2020 11:58 AM, Will Deacon wrote:
> On Wed, Apr 15, 2020 at 11:50:58AM +0100, Suzuki K Poulose wrote:
>> On 04/14/2020 10:31 PM, Will Deacon wrote:
>>> We don't need to be quite as strict about mismatched AArch32 support,
>>> which is good because the friendly hardware folks have been busy
>>> mismatching this to their hearts' content.
>>>
>>>     * We don't care about EL2 or EL3 (there are silly comments concerning
>>>       the latter, so remove those)
>>>
>>>     * EL1 support is gated by the ARM64_HAS_32BIT_EL1 capability and handled
>>>       gracefully when a mismatch occurs
>>>
>>>     * EL1 support is gated by the ARM64_HAS_32BIT_EL0 capability and handled
>>
>> s/EL1/EL0
>>
>>>       gracefully when a mismatch occurs
>>>
>>> Relax the AArch32 checks to FTR_NONSTRICT.
>>
>> Agreed. We should do something similar for the features exposed by the
>> ELF_HWCAP, of course in a separate series.
> 
> Hmm, I didn't think we needed to touch the HWCAPs, as they're derived from
> the sanitised feature register values. What am I missing?

sorry, that was cryptic. I was suggesting to relax the ftr fields to
NONSTRICT for the fields covered by ELF HWCAPs (and other CPU hwcaps).

Suzuki
