Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212B81ED107
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 15:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgFCNk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 09:40:57 -0400
Received: from foss.arm.com ([217.140.110.172]:33682 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgFCNk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 09:40:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B1C255D;
        Wed,  3 Jun 2020 06:40:56 -0700 (PDT)
Received: from [10.57.0.45] (unknown [10.57.0.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9B3C3F52E;
        Wed,  3 Jun 2020 06:40:54 -0700 (PDT)
Subject: Re: [PATCH 2/2] coresight: tmc: Add shutdown callback for TMC ETR/ETF
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        Stephen Boyd <swboyd@chromium.org>
References: <cover.1590947174.git.saiprakash.ranjan@codeaurora.org>
 <28123d1e19f235f97555ee36a5ed8b52d20cbdea.1590947174.git.saiprakash.ranjan@codeaurora.org>
 <20200601212858.GB24287@xps15> <bf7e8ac2-51b2-d9cb-9c4f-c311297accac@arm.com>
 <1549935cf69ac3a006f32eb278821027@codeaurora.org>
 <6c1a4fbd-98cb-a49c-0ced-1318d5d5e7c8@arm.com>
 <7fe5762b5cb8f87e988232922d06c55d@codeaurora.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <68444180-3ebe-8988-493a-fdd1dff994b6@arm.com>
Date:   Wed, 3 Jun 2020 14:40:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <7fe5762b5cb8f87e988232922d06c55d@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-03 13:26, Sai Prakash Ranjan wrote:
> Hi Robin,
> 
> On 2020-06-03 17:51, Robin Murphy wrote:
>> On 2020-06-03 13:00, Sai Prakash Ranjan wrote:
>>> Hi Robin, Mathieu
>>>
>>> On 2020-06-03 17:07, Robin Murphy wrote:
>>>> On 2020-06-01 22:28, Mathieu Poirier wrote:
>>>>> That being said I'm sure that dependencies on an IOMMU isn't a 
>>>>> problem confined
>>>>> to coresight. I am adding Robin Murphy, who added this commit [1], 
>>>>> to the thread
>>>>> in the hope that he can provide guidance on the right way to do this.
>>>>
>>>> Right, it's not specific to CoreSight, and it's not even specific to
>>>> IOMMUs really. In short, blame kexec ;)
>>>>
>>>
>>> Yes it is not specific to coresight, we are targeting this for all
>>> consumers/clients of SMMU(atleast on SC7180 SoC). We have display 
>>> throwing
>>> NoC/interconnect errors[1] during reboot after SMMU is disabled.
>>> This is also not specific to kexec either as you explained here [2] 
>>> about
>>> a case with display which is exacly what is happening in our system [1].
>>
>> Sure, but those instances are begging the question of why the SMMU is
>> disabled at reboot in the first place ;)
>>
> 
> That is what happens in SMMU shutdown callback right? It is the 
> reboot/shutdown flow.

Yes, that's where it happens, but my point is *why* it happens at all.

hint: `git log --grep=shutdown drivers/iommu/`

If we could assume the system is always about to be powered off or 
reset, we wouldn't need to do anything to the SMMU either ;)

Robin.

> 
>     arm_smmu_device_shutdown()
>      platform_drv_shutdown()
>       device_shutdown()
>        kernel_restart_prepare()
>         kernel_restart()
> 
> Thanks,
> Sai
> 
