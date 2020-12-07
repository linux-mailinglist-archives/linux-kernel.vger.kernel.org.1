Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283532D1840
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 19:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgLGSMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 13:12:20 -0500
Received: from foss.arm.com ([217.140.110.172]:57344 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgLGSMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 13:12:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 031441042;
        Mon,  7 Dec 2020 10:11:34 -0800 (PST)
Received: from [10.57.61.6] (unknown [10.57.61.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE4623F66B;
        Mon,  7 Dec 2020 10:11:32 -0800 (PST)
Subject: Re: [PATCH] iommu: arm-smmu-impl: add NXP hook to preserve
 bootmappings
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>, will@kernel.org,
        joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     diana.craciun@nxp.com
References: <20201125155009.18453-1-laurentiu.tudor@nxp.com>
 <30296756-9b8d-4851-87f0-8c4bd41110e9@arm.com>
 <74e4f42a-83bf-fa88-a807-5c3a60aad4e6@nxp.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <04a0e0d7-cf83-e0a1-78dc-034289e8d0e4@arm.com>
Date:   Mon, 7 Dec 2020 18:11:24 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <74e4f42a-83bf-fa88-a807-5c3a60aad4e6@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-02 10:29, Laurentiu Tudor wrote:
> Hi Robin,
> 
> Sorry for the late reply, we had a few days of over here. Comments inline.
> 
> On 11/25/2020 8:10 PM, Robin Murphy wrote:
>> On 2020-11-25 15:50, laurentiu.tudor@nxp.com wrote:
>>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>
>>> Add a NXP specific hook to preserve SMMU mappings present at
>>> boot time (created by the boot loader). These are needed for
>>> MC firmware present on some NXP chips to continue working
>>> across kernel boot and SMMU initialization.
>>>
>>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>> ---
>>>    drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 33 ++++++++++++++++++++++
>>>    1 file changed, 33 insertions(+)
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
>>> b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
>>> index 7fed89c9d18a..ca07d9d4be69 100644
>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
>>> @@ -187,6 +187,36 @@ static const struct arm_smmu_impl
>>> mrvl_mmu500_impl = {
>>>        .reset = arm_mmu500_reset,
>>>    };
>>>    +static int nxp_cfg_probe(struct arm_smmu_device *smmu)
>>> +{
>>> +    int i, cnt = 0;
>>> +    u32 smr;
>>> +
>>> +    for (i = 0; i < smmu->num_mapping_groups; i++) {
>>> +        smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
>>> +
>>> +        if (FIELD_GET(ARM_SMMU_SMR_VALID, smr)) {
>>
>> I bet this is fun over kexec...
> 
> Right. I haven't even considered kexec.
> 
>> Note that the Qualcomm special case got a bit of a free pass since it
>> involves working around a totally broken hypervisor, plus gets to play
>> the "nobody sane will run an enterprise distro on their phone" card to
>> an extent; I don't think the likes of Layerscape kit get it quite so
>> easy ;)
> 
> I agree that this is not ideal, but the plan here was to have something
> to boot vanilla kernel OOB on our chips, which is something on my mind
> for quite a while now. I do realize that we won't get away with it
> in the long run.
> 
>>> +            smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
>>> +            smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
>>> +            smmu->smrs[i].valid = true;
>>> +
>>> +            smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
>>> +            smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
>>> +            smmu->s2crs[i].cbndx = 0xff;
>>> +
>>> +            cnt++;
>>> +        }
>>> +    }
>>> +
>>> +    dev_notice(smmu->dev, "\tpreserved %d boot mapping%s\n", cnt,
>>> +           cnt == 1 ? "" : "s");
>>
>> That gets you around the initial SMMU reset, but what happens for the
>> arbitrarily long period of time between the MC device getting attached
>> to a default domain and the MC driver actually probing and (presumably)
>> being able to map and reinitialise its firmware?
> 
> Perhaps I'm missing something, but won't the MC firmware live based on
> this bypass mapping created by the bootloader and that gets preserved?

All you're doing here is effectively forcing "arm-smmu.disable_bypass=0" 
for the specific streams identified by the boot-time SMR state. Once 
iommu_probe_device() gets called and the SMMU driver becomes aware of 
those streams, that initial state becomes moot.

What I just now realise, however, is that in this specific case you 
probably do get away with it as a dirty trick because there is no 
visible association between the MC *platform device* and the SMMU. Thus 
as it stands today, nobody will be calling iommu_probe_device() for any 
of the relevant streams until the MC driver has probed and can start 
creating the fsl_mc_bus devices and interpreting the iommu-map - 
presumably by that point the platform driver has had plenty of time to 
quiesce DMA and grovel the physical address of the firmware region out 
of the hardware, such that it can then be remapped from the perspective 
of the new fsl_mc_bus device to continue.

>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static const struct arm_smmu_impl nxp_impl = {
>>> +    .cfg_probe = nxp_cfg_probe,
>>> +};
>>
>> I believe you're mostly using MMU-500, so you probably don't want to
>> simply throw out the relevant errata workarounds.
>>
>>>    struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device
>>> *smmu)
>>>    {
>>> @@ -226,5 +256,8 @@ struct arm_smmu_device *arm_smmu_impl_init(struct
>>> arm_smmu_device *smmu)
>>>        if (of_device_is_compatible(np, "marvell,ap806-smmu-500"))
>>>            smmu->impl = &mrvl_mmu500_impl;
>>>    +    if (of_property_read_bool(np, "nxp,keep-boot-mappings"))
>>> +        smmu->impl = &nxp_impl;
>>
>> Normally you'd get a "what about ACPI?" here, but given the number of
>> calls and email threads we've had specifically about trying to make ACPI
>> support for these platforms work, that gets upgraded to at least a "WHAT
>> ABOUT ACPI!?" :P
> I do have ACPI in mind, but for now I just wanted to have a
> first impression on the approach. One idea I was pondering on was to
> have this property in the MC node (quick reminder: MC is exposed as a NC
> in ACPI, should be able to replicate the property in there too). In the
> mean time, we are in collaboration with our partners on using RMRR by
> adding support for it in the arm-smmu-v2 driver.

I feel pretty confident in saying that nobody's going to agree to add a 
platform-specific property to IORT to describe one case of the exact 
thing that RMRs were specced out to deal with in general.

>> But seriously, the case of device firmware in memory being active before
>> handover to Linux is *literally* the original reason behind IORT RMRs.
>> We already know we need a way to specify the equivalent thing for DT
>> systems, such that both can be handled commonly. I really don't want to
>> have to support a vendor-specific mechanism for not-even-fully-solving a
>> completely generic issue, sorry.
>>
> 
> I remember that some months ago there was a proposal from nvidia [1] to
> map per-device reserved memory into SMMU. Would it make sense to revive
> it as it seemed a viable solution for our case too?

Note that there's already been a newer spin on that. The discussion is 
spread around a few places ([1] and [2] at least), but I think it's 
clear that Thierry's case is just another flavour of the same overall 
problem, so if we can figure out robust DT bindings to convey the 
equivalent information to IORT RMRs then it largely all falls in together.

Thanks,
Robin.

[1] 
https://lore.kernel.org/linux-iommu/20200904130000.691933-1-thierry.reding@gmail.com/
[2] 
https://lore.kernel.org/linux-iommu/20201027112646.44680-1-shameerali.kolothum.thodi@huawei.com/
