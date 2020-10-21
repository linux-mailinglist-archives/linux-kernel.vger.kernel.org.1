Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAB429554A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 01:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507164AbgJUXoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 19:44:19 -0400
Received: from foss.arm.com ([217.140.110.172]:42682 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439942AbgJUXoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 19:44:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09DC5D6E;
        Wed, 21 Oct 2020 16:44:18 -0700 (PDT)
Received: from [10.57.50.191] (unknown [10.57.50.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0BD03F66B;
        Wed, 21 Oct 2020 16:44:16 -0700 (PDT)
Subject: Re: [PATCH] arm64: NUMA: Kconfig: Increase max number of nodes
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
References: <20201020173409.1266576-1-vanshikonda@os.amperecomputing.com>
 <jhj7drkrcpr.mognet@arm.com> <9e14c0d3-9204-fb32-31db-5b3f98639cba@arm.com>
 <20201021110201.00002092@Huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <da1b140c-fdd9-5970-fe83-02f33c3d8251@arm.com>
Date:   Thu, 22 Oct 2020 00:44:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201021110201.00002092@Huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-21 12:02, Jonathan Cameron wrote:
> On Wed, 21 Oct 2020 09:43:21 +0530
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
>> On 10/20/2020 11:39 PM, Valentin Schneider wrote:
>>>
>>> Hi,
>>>
>>> Nit on the subject: this only increases the default, the max is still 2¹⁰.
>>
>> Agreed.
>>
>>>
>>> On 20/10/20 18:34, Vanshidhar Konda wrote:
>>>> The current arm64 max NUMA nodes default to 4. Today's arm64 systems can
>>>> reach or exceed 16. Increase the number to 64 (matching x86_64).
>>>>
>>>> Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
>>>> ---
>>>>   arch/arm64/Kconfig | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>>> index 893130ce1626..3e69d3c981be 100644
>>>> --- a/arch/arm64/Kconfig
>>>> +++ b/arch/arm64/Kconfig
>>>> @@ -980,7 +980,7 @@ config NUMA
>>>>   config NODES_SHIFT
>>>>        int "Maximum NUMA Nodes (as a power of 2)"
>>>>        range 1 10
>>>> -	default "2"
>>>> +	default "6"
>>>
>>> This leads to more statically allocated memory for things like node to CPU
>>> maps (see uses of MAX_NUMNODES), but that shouldn't be too much of an
>>> issue.
>>
>> The smaller systems should not be required to waste those memory in
>> a default case, unless there is a real and available larger system
>> with those increased nodes.
>>
>>>
>>> AIUI this also directly correlates to how many more page->flags bits are
>>> required: are we sure the max 10 works on any aarch64 platform? I'm
>>
>> We will have to test that. Besides 256 (2 ^ 8) is the first threshold
>> to be crossed here.
>>
>>> genuinely asking here, given that I'm mostly a stranger to the mm
>>> world. The default should be something we're somewhat confident works
>>> everywhere.
>>
>> Agreed. Do we really need to match X86 right now ? Do we really have
>> systems that has 64 nodes ? We should not increase the default node
>> value and then try to solve some new problems, when there might not
>> be any system which could even use that. I would suggest increase
>> NODES_SHIFT value upto as required by a real and available system.
> 
> I'm not going to give precise numbers on near future systems but it is public
> that we ship 8 NUMA node ARM64 systems today.  Things will get more
> interesting as CXL and CCIX enter the market on ARM systems,
> given chances are every CXL device will look like another NUMA
> node (CXL spec says they should be presented as such) and you
> may be able to rack up lots of them.
> 
> So I'd argue minimum that makes sense today is 16 nodes, but looking forward
> even a little and 64 is not a great stretch.
> I'd make the jump to 64 so we can forget about this again for a year or two.
> People will want to run today's distros on these new machines and we'd
> rather not have to go around all the distros asking them to carry a patch
> increasing this count (I assume they are already carrying such a patch
> due to those 8 node systems)

Nit: I doubt any sane distro is going to carry a patch to adjust the 
*default* value of a Kconfig option. They might tune the actual value in 
their config, but, well, isn't that the whole point of configs? ;)

Robin.

> 
> Jonathan
> 
>>
>>>    
>>>>        depends on NEED_MULTIPLE_NODES
>>>>        help
>>>>          Specify the maximum number of NUMA Nodes available on the target
>>>   
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
