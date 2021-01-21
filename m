Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6F72FF78C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 22:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbhAUVqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 16:46:21 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:31655 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbhAUVbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 16:31:23 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611264658; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=tq0FX0gjjypNx35NWziv3I0HuJg9vmylS8439Swmh1c=;
 b=uXDQNruC5jKlBPz3/862djrn9UHchaZzXBeQYcIPb9158nLZM4DH2ASUk7HScVPvP5KnXNvc
 rSDdyuQGpGChOr3A3aalXGBlfHQvBLBzXDwH8WLMzCvTu4xiRe5YCbkvt9pLHZ7+bgF6QNg+
 H4ebexU7jIDeegk098I9gv4bnoc=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 6009f2662c36b2106d4d1aff (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 21 Jan 2021 21:30:14
 GMT
Sender: isaacm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 70486C43462; Thu, 21 Jan 2021 21:30:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: isaacm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6DC07C43461;
        Thu, 21 Jan 2021 21:30:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 21 Jan 2021 13:30:12 -0800
From:   isaacm@codeaurora.org
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     will@kernel.org, joro@8bytes.org, iommu@lists.linux-foundation.org,
        pratikp@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, pdaly@codeaurora.org
Subject: Re: [PATCH v2 0/5] Optimize iommu_map_sg() performance
In-Reply-To: <8ad6db90-1d86-db2a-ccb5-dc3f01213289@arm.com>
References: <1610376862-927-1-git-send-email-isaacm@codeaurora.org>
 <8ad6db90-1d86-db2a-ccb5-dc3f01213289@arm.com>
Message-ID: <2580095e227403893b78856edbaeb77b@codeaurora.org>
X-Sender: isaacm@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-12 08:00, Robin Murphy wrote:
> On 2021-01-11 14:54, Isaac J. Manjarres wrote:
>> The iommu_map_sg() code currently iterates through the given
>> scatter-gather list, and in the worst case, invokes iommu_map()
>> for each element in the scatter-gather list, which calls into
>> the IOMMU driver through an indirect call. For an IOMMU driver
>> that uses a format supported by the io-pgtable code, the IOMMU
>> driver will then call into the io-pgtable code to map the chunk.
>> 
>> Jumping between the IOMMU core code, the IOMMU driver, and the
>> io-pgtable code and back for each element in a scatter-gather list
>> is not efficient.
>> 
>> Instead, add a map_sg() hook in both the IOMMU driver ops and the
>> io-pgtable ops. iommu_map_sg() can then call into the IOMMU driver's
>> map_sg() hook with the entire scatter-gather list, which can call
>> into the io-pgtable map_sg() hook, which can process the entire
>> scatter-gather list, signficantly reducing the number of indirect
>> calls, and jumps between these layers, boosting performance.
> 
> Out of curiosity, how much of the difference is attributable to actual
> indirect call overhead vs. the additional massive reduction in visits
> to arm_smmu_rpm_{get,put} that you fail to mention?There are ways to
I did an experiment where I compared the two approaches without any 
calls
to arm_smmu_rpm_[get/put]. There's still a large amount of difference
without the overhead incurred by power management calls. Here are the 
results:

no optimizations and no power management calls:
  size        iommu_map_sg
       4K            0.609 us
      64K            8.583 us
       1M          136.083 us
       2M          273.145 us
      12M         1442.119 us
      24M         2876.078 us
      32M         3832.041 us

iommu_map_sg optimizations and no power management calls:
size        iommu_map_sg
       4K            0.645 us
      64K            1.229 us
       1M            9.531 us
       2M           23.198 us
      12M           99.250 us
      24M          185.713 us
      32M          248.781 us

 From here, we can see that the amount of latency incurred by the 
indirect
calls is fairly large.

> optimise indirect calling that would benefit *all* cases, rather than
> just one operation for one particular driver.
Do you mind sharing some more information on how to optimize the 
existing
approach further, such that it benefits other drivers as well?
> 
>> On a system that uses the ARM SMMU driver, and the ARM LPAE format,
>> the current implementation of iommu_map_sg() yields the following
>> latencies for mapping scatter-gather lists of various sizes. These
>> latencies are calculated by repeating the mapping operation 10 times:
>> 
>>      size        iommu_map_sg latency
>>        4K            0.624 us
>>       64K            9.468 us
>>        1M          122.557 us
>>        2M          239.807 us
>>       12M         1435.979 us
>>       24M         2884.968 us
>>       32M         3832.979 us
>> 
>> On the same system, the proposed modifications yield the following
>> results:
>> 
>>      size        iommu_map_sg latency
>>        4K            3.645 us
>>       64K            4.198 us
>>        1M           11.010 us
>>        2M           17.125 us
>>       12M           82.416 us
>>       24M          158.677 us
>>       32M          210.468 us
>> 
>> The procedure for collecting the iommu_map_sg latencies is
>> the same in both experiments. Clearly, reducing the jumps
>> between the different layers in the IOMMU code offers a
>> signficant performance boost in iommu_map_sg() latency.
> 
> Presumably those are deliberately worst-case numbers? After all, a
> 32MB scatterlist *could* incur less overhead than a 64KB one if things
> line up just right (still 16 ->map calls, but each with one fewer
Yes, these are worst case numbers (i.e. a buffer is composed entirely
of 4 KB pages, so higher order mappings don't get used).
> level of pagetable to traverse). TBH I find the significant regression
> of the 4KB case the most interesting - what's going on there?
That was an error on my part. After fixing my error, I observed that the
time spent mapping the 4 KB buffer is comparable with and without 
optimizations,
which is expected.
> 
> My main reservation here is that we get an explosion of duplicate
> copies of almost the same code, and it's code that's just non-trivial
> enough to start being bug-prone. And it's all still only for one
> specific operation - your argument about calling through multiple
> layers for each element applies just as much to iommu_map() itself, so
> why aren't we trying to make more fundamental improvements with wider
> benefits? Indeed I can't imagine the existing iommu_map_sg() loop
> really adds significant overhead compared to a single iommu_map() call
> that results in the equivalent set of ->map calls to the driver.
> 
> At a glance, I reckon that simply extending the internal ->map and
> ->unmap interfaces to encode a number of consecutive identical pages
> would already get us a large chunk of the way there; then we'd be in a
> better place to consider options for the io-pgtable interface.
> 
Do you mean physically contiguous pages? If so, that still wouldn't help 
the
case where a buffer is composed entirely of 4 KB pages, correct?
> Robin.
> 
>> Changes since v1:
>> 
>> -Fixed an off by one error in arm_[lpae/v7s]_map_by_pgsize
>> when checking if the IOVA and physical address ranges being
>> mapped are within the appropriate limits.
>> -Added Sai Prakash Ranjan's "Tested-by" tag.
>> 
>> Thanks,
>> Isaac
>> 
>> Isaac J. Manjarres (5):
>>    iommu/io-pgtable: Introduce map_sg() as a page table op
>>    iommu/io-pgtable-arm: Hook up map_sg()
>>    iommu/io-pgtable-arm-v7s: Hook up map_sg()
>>    iommu: Introduce map_sg() as an IOMMU op for IOMMU drivers
>>    iommu/arm-smmu: Hook up map_sg()
>> 
>>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 19 ++++++++
>>   drivers/iommu/io-pgtable-arm-v7s.c    | 90 
>> +++++++++++++++++++++++++++++++++++
>>   drivers/iommu/io-pgtable-arm.c        | 86 
>> +++++++++++++++++++++++++++++++++
>>   drivers/iommu/iommu.c                 | 25 ++++++++--
>>   include/linux/io-pgtable.h            |  6 +++
>>   include/linux/iommu.h                 | 13 +++++
>>   6 files changed, 234 insertions(+), 5 deletions(-)
>> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
