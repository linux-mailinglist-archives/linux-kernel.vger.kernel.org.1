Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0353C1A321E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 11:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgDIJyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 05:54:15 -0400
Received: from foss.arm.com ([217.140.110.172]:47778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgDIJyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:54:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6183431B;
        Thu,  9 Apr 2020 02:54:15 -0700 (PDT)
Received: from [10.57.55.221] (unknown [10.57.55.221])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 106B33F73D;
        Thu,  9 Apr 2020 02:54:13 -0700 (PDT)
Subject: Re: [RFC PATCH] perf/smmuv3: Fix shared interrupt handling
To:     John Garry <john.garry@huawei.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "harb@amperecomputing.com" <harb@amperecomputing.com>,
        "tuanphan@os.amperecomputing.com" <tuanphan@os.amperecomputing.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <d73dd8c3579fbf713d6215317404549aede8ad2d.1586363449.git.robin.murphy@arm.com>
 <34dd7c2e-b6db-684f-f0a2-73f2e6951308@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6bd103f2-1034-60f0-53a3-17162400a452@arm.com>
Date:   Thu, 9 Apr 2020 10:54:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <34dd7c2e-b6db-684f-f0a2-73f2e6951308@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-09 8:02 am, John Garry wrote:
> On 08/04/2020 17:49, Robin Murphy wrote:
>> IRQF_SHARED is dangerous, since it allows other agents to retarget the
>> IRQ's affinity without migrating PMU contexts to match, breaking the way
>> in which perf manages mutual exclusion for accessing events. Although
>> this means it's not realistically possible to support PMU IRQs being
>> shared with other drivers, we *can* handle sharing between multiple PMU
>> instances with some explicit affinity bookkeeping and manual interrupt
>> multiplexing.
> 
> Hi Robin,
> 
> Out of curiosity, do we even need to support shared interrupts for any 
> implementations today?

Not that I know of, but we need the mitigation in general for future 
drivers[1], and since this one already had a suspicious IRQF_SHARED it 
was the ideal victim for prototyping. I haven't dared ask about Ampere's 
SMMU story... :)

> D06 board:
> 
> john@ubuntu:~$ more /proc/interrupts | grep smmuv3-pmu
> 
>   989:  0  0  0  0  ITS-pMSI 133120 Edge  smmuv3-pmu
>   990:  0  0  0  0  ITS-pMSI 135168 Edge  smmuv3-pmu
>   991:  0  0  0  0  ITS-pMSI 137216 Edge  smmuv3-pmu
>   992:  0  0  0  0  ITS-pMSI 139264 Edge  smmuv3-pmu
>   993:  0  0  0  0  ITS-pMSI 141312 Edge  smmuv3-pmu
>   994:  0  0  0  0  ITS-pMSI 143360 Edge  smmuv3-pmu
>   995:  0  0  0  0  ITS-pMSI 145408 Edge  smmuv3-pmu
>   996:  0  0  0  0  ITS-pMSI 147456 Edge  smmuv3-pmu

Yeah, MSIs are the best way to defeat any interrupt wiring!

Robin.

[1] 
https://lore.kernel.org/linux-arm-kernel/3efa118a-5c85-6af9-e676-44087f1d398e@arm.com/
