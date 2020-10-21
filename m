Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B16294728
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 06:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406955AbgJUENx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 00:13:53 -0400
Received: from foss.arm.com ([217.140.110.172]:58556 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404232AbgJUENx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 00:13:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66AE01FB;
        Tue, 20 Oct 2020 21:13:52 -0700 (PDT)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85AA13F66E;
        Tue, 20 Oct 2020 21:13:50 -0700 (PDT)
Subject: Re: [PATCH] arm64: NUMA: Kconfig: Increase max number of nodes
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Cc:     linux-arm-kernel@lists.infradead.org, patches@amperecomputing.com,
        linux-kernel@vger.kernel.org
References: <20201020173409.1266576-1-vanshikonda@os.amperecomputing.com>
 <jhj7drkrcpr.mognet@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <9e14c0d3-9204-fb32-31db-5b3f98639cba@arm.com>
Date:   Wed, 21 Oct 2020 09:43:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <jhj7drkrcpr.mognet@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/2020 11:39 PM, Valentin Schneider wrote:
> 
> Hi,
> 
> Nit on the subject: this only increases the default, the max is still 2¹⁰.

Agreed.

> 
> On 20/10/20 18:34, Vanshidhar Konda wrote:
>> The current arm64 max NUMA nodes default to 4. Today's arm64 systems can
>> reach or exceed 16. Increase the number to 64 (matching x86_64).
>>
>> Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
>> ---
>>  arch/arm64/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 893130ce1626..3e69d3c981be 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -980,7 +980,7 @@ config NUMA
>>  config NODES_SHIFT
>>       int "Maximum NUMA Nodes (as a power of 2)"
>>       range 1 10
>> -	default "2"
>> +	default "6"
> 
> This leads to more statically allocated memory for things like node to CPU
> maps (see uses of MAX_NUMNODES), but that shouldn't be too much of an
> issue.

The smaller systems should not be required to waste those memory in
a default case, unless there is a real and available larger system
with those increased nodes.

> 
> AIUI this also directly correlates to how many more page->flags bits are
> required: are we sure the max 10 works on any aarch64 platform? I'm

We will have to test that. Besides 256 (2 ^ 8) is the first threshold
to be crossed here.

> genuinely asking here, given that I'm mostly a stranger to the mm
> world. The default should be something we're somewhat confident works
> everywhere.

Agreed. Do we really need to match X86 right now ? Do we really have
systems that has 64 nodes ? We should not increase the default node
value and then try to solve some new problems, when there might not
be any system which could even use that. I would suggest increase
NODES_SHIFT value upto as required by a real and available system.

> 
>>       depends on NEED_MULTIPLE_NODES
>>       help
>>         Specify the maximum number of NUMA Nodes available on the target
>
