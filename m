Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94051BEE70
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 05:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgD3DAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 23:00:17 -0400
Received: from foss.arm.com ([217.140.110.172]:48020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgD3DAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 23:00:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8F5B1063;
        Wed, 29 Apr 2020 20:00:15 -0700 (PDT)
Received: from [10.163.71.104] (unknown [10.163.71.104])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56ACE3F68F;
        Wed, 29 Apr 2020 20:00:13 -0700 (PDT)
Subject: Re: [PATCH V2 00/16] arm64/cpufeature: Introduce ID_PFR2, ID_DFR1,
 ID_MMFR5 and other changes
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, maz@kernel.org, suzuki.poulose@arm.com,
        James Morse <james.morse@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
References: <1586857710-17154-1-git-send-email-anshuman.khandual@arm.com>
 <6749304e-8a4d-f4b9-eb40-91f0dd13166e@arm.com>
 <20200429212614.GD8604@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <da15c0f0-f8ec-c2bc-bd5b-907a75119dc1@arm.com>
Date:   Thu, 30 Apr 2020 08:29:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200429212614.GD8604@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/30/2020 02:56 AM, Will Deacon wrote:
> Hi Anshuman,
> 
> On Wed, Apr 29, 2020 at 03:07:15PM +0530, Anshuman Khandual wrote:
>> On 04/14/2020 03:18 PM, Anshuman Khandual wrote:
>>> This series is primarily motivated from an adhoc list from Mark Rutland
>>> during our previous ID_ISAR6 discussion [1]. The current proposal also
>>> accommodates some more suggestions from Will and Suzuki.
>>>
>>> This series adds missing 32 bit system registers (ID_PFR2, ID_DFR1 and
>>> ID_MMFR5), adds missing features bits on all existing system registers
>>> (32 and 64 bit) and some other miscellaneous changes. While here it also
>>> includes a patch which does macro replacement for various open bits shift
>>> encodings for various CPU ID registers. There is a slight re-order of the
>>> patches here as compared to the previous version (V1).
>>>
>>> This series is based on v5.7-rc1. All feature bits enabled here can be
>>> referred in ARM DDI 0487F.a specification. Though I have tried to select
>>> appropriate values for each new feature being added here, there might be
>>> some inconsistencies (or mistakes). In which case, please do let me know
>>> if anything needs to change. Thank you.
>>>
>>> [1] https://patchwork.kernel.org/patch/11287805/
>>>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Mark Rutland <mark.rutland@arm.com> 
>>> Cc: Marc Zyngier <maz@kernel.org>
>>> Cc: James Morse <james.morse@arm.com>
>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Cc: kvmarm@lists.cs.columbia.edu
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-kernel@vger.kernel.org
>>>
>>> Changes in V2:
>>>
>>> - Added Suggested-by tag from Mark Rutland for all changes he had proposed
>>> - Added comment for SpecSEI feature on why it is HIGHER_SAFE per Suzuki
>>> - Added a patch which makes ID_AA64DFR0_DOUBLELOCK a signed feature per Suzuki
>>> - Added ID_DFR1 and ID_MMFR5 system register definitions per Will
>>> - Added remaining features bits for relevant 64 bit system registers per Will
>>> - Changed commit message on [PATCH 5/7] regarding TraceFilt feature per Suzuki
>>> - Changed ID_PFR2.CSV3 (FTR_STRICT -> FTR_NONSTRICT) as 64 bit registers per Will
>>> - Changed ID_PFR0.CSV2 (FTR_STRICT -> FTR_NONSTRICT) as 64 bit registers per Will 
>>> - Changed some commit messages
>>
>> Just a gentle ping. I am wondering if you had a chance to glance
>> through this updated series.
> 
> Please can you resend based on for-next/cpufeature?

Sure, will do.
