Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9EA2CBA98
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 11:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbgLBKaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 05:30:25 -0500
Received: from mail-vi1eur05on2061.outbound.protection.outlook.com ([40.107.21.61]:35329
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728490AbgLBKaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 05:30:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzekZpwimYDiRNJHgWsZ1LaajV+cjjilPEMJtj397J+sil7v8O9H5QtJAPUMmHPg9JJkFPRgTnDhBXoDLKLsMwmMeqh1cle40GRStLy7U2NZltQjpg/1vXi37vRCpZ+uE1h6QssDZD/z71SzHMd4Gu/V0XrgreCZTCaPw/dp0ejX3wOLLH62z9JMlMttqWc3BvaNpI2zNaxza1kS0F8E0e9fExKQlBnQbMcMMlZjAj7dgBFZn+CjLFAwIvnaRwOCnMz/M3lpX9wp2cfZkENiH9ThXnwXn322ac6yLLk1elsV6nPauLH8E6eFnAhYvYYukStCMU/Kzo5wQcucWBlmow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6RPdFe492QyL7bjb1cwo6/Rl9vjifuf3p+So0eSeys=;
 b=WNQtYOuwqn8I7riJ9VhA8lUnOjNXFo2v5rapgZmE48A8uR/CmFAFm0QzrBaq4CZpg2FuSowguDsucwmGK70tTEExLzSjlq1yThQG3/6l+enxkp5EwtLwGrZdLRZsPJQcAMIgRKqH5uzNP1CYlw9UgCYeBQKkQVCeSqSbv60s217dtPmM7kZuYog/BKBM7eLMa2F/7+/W4rgjs6CDUhBkbvqE4t7oAywaVxChUYr3Droyok2bMJ/YuuCw8WvYM+DZ3/LDq0rpD+L0eeb9km1ktPmWRnObONprVTWTedwyXtaQM12L8D+KFlLO+1HmMsf02emrvKMVzf2yRtov+p562g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6RPdFe492QyL7bjb1cwo6/Rl9vjifuf3p+So0eSeys=;
 b=hhKkiO5TTRAVdKzL/Etwz6S/cUaLMzlTQ4FMInq5MyCcYlAg71wmQchI91R2afUyKeuOZsqUfRAjFtQj2nHc4iog9BevlWQGc9IZu/rGxaQGy7rH0TRngXoC0wDnZ8xR3fiS6FgxQNdgvFmHW558mM6AcmDWmEKh9bpAcrO23Sw=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR0402MB3792.eurprd04.prod.outlook.com (2603:10a6:803:20::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Wed, 2 Dec
 2020 10:29:32 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::6467:fb5:1181:e8b2]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::6467:fb5:1181:e8b2%7]) with mapi id 15.20.3611.032; Wed, 2 Dec 2020
 10:29:32 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH] iommu: arm-smmu-impl: add NXP hook to preserve
 bootmappings
To:     Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
        joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     diana.craciun@nxp.com
References: <20201125155009.18453-1-laurentiu.tudor@nxp.com>
 <30296756-9b8d-4851-87f0-8c4bd41110e9@arm.com>
Message-ID: <74e4f42a-83bf-fa88-a807-5c3a60aad4e6@nxp.com>
Date:   Wed, 2 Dec 2020 12:29:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
In-Reply-To: <30296756-9b8d-4851-87f0-8c4bd41110e9@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [188.25.99.172]
X-ClientProxiedBy: AM0PR04CA0093.eurprd04.prod.outlook.com
 (2603:10a6:208:be::34) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.103] (188.25.99.172) by AM0PR04CA0093.eurprd04.prod.outlook.com (2603:10a6:208:be::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18 via Frontend Transport; Wed, 2 Dec 2020 10:29:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1b21a36a-0fe0-4290-b740-08d896ad27f6
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3792:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB379227B54413FB1CEEB3F134ECF30@VI1PR0402MB3792.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Vl94ULevMTqxJMXYdTRxnTo1WGExAFbGDmPHS92DaC1feTDnFqsi+LSo69mWO8KsaEMmBTcxO1Q+CU5OBzgyKN8mBic3NMAxGtDFk8V5uejcemEP6i44LjNv3WhqbcEj0tjwIB0FFshjldDsixt7c2JWHNuFJsCQFD5a4SHtd1q244/Jxi1vxrf2fCt0kkBzn5I/uK1RxlnilZGLGoiPpkdVchsaVAQ9tWUvagd/HNY0actO3kQrzoiVdXb6oFnKPr53lKE18N+ANqypLJBsDLw8/HgoEK3K5k+PYyqmLn/s6JIYf7hQuvla30YI52dOuIBeqkjVnGYMEG0LctIRsmAQfTS7Bfh7TRP70lHWoY8j/TW/JCK2xKeqY1UUtwd/EoorKV6lVK4e+0eQqLLEksFQKJmmS+NPq8ElQsvXBSWYSqXyyJqYUmnXuHDykU74IULA5/GDYol2kSckqdfx+XbwtOAvChsVJsmhWEg4198lPqSbPDvnhccQny7Hh52
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(316002)(8676002)(2906002)(66556008)(6486002)(2616005)(956004)(966005)(86362001)(16576012)(8936002)(31696002)(66946007)(4001150100001)(36756003)(5660300002)(83380400001)(186003)(52116002)(66476007)(4326008)(53546011)(44832011)(16526019)(31686004)(478600001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dk1vYUNLV2I1eHYxM2s5aC9HUzJGd1VzVXkyV1NZaWtCVU5lMjhBd01DS0dJ?=
 =?utf-8?B?VVAxY09keGVaREVFMU81OEE2YllZd3gwdkMzWmU1N0dxdE9oM1hFRm1rK0Vi?=
 =?utf-8?B?T1dQb01ucUNXR0hjelZoaWEwSWN1M1YwWVI0MFdHU0JwTE42USt0eEl3VWx6?=
 =?utf-8?B?RFpvRjhwNHVYbUNjR01YaXpZQUJZbEJLMUpJNkp4TE5EaDdLZDhvMmt6OXQ5?=
 =?utf-8?B?dThVQjdsUXYxbkVFVXMwaUNMSzNOcUJpRjdYVnZHeTdObitEVXNwYkhzZ1BT?=
 =?utf-8?B?c3pWQVN1VndCckVOUEIwSStBekpoVU1COVc5L2FhVTUycXhGVDMvajltVXh4?=
 =?utf-8?B?Uk9SV1ZEVEVxSUhlM1FpQU5QeUMrMmZKNWdNb3BBVEltN3NhcW5qUERsMWhJ?=
 =?utf-8?B?cXhHMFJUbC93ZGNmanpFQi9Qd3hKMkJvSHB6RWNRdkRaMDRmOFhZU3JCWjlK?=
 =?utf-8?B?MUVZUDRjWkZOQ2NHenJRNlN1WXNIamx2ZnlhWWEyeGJKNnZjV3dDN05EWkxJ?=
 =?utf-8?B?a21sNGh0NmJYeXR1Uk9vL3hnNTVrQ213Q1ZuVzNkQWR6QlJEVkxJUjBWUjNY?=
 =?utf-8?B?SG9zYm9ZQUd6ek5TT2hPSW5ZcEJUeTFCQjhrMU5RdDd3VFF2bFV0T01uK0hi?=
 =?utf-8?B?OFViNFVxc1pMalVWWGkya2draXBxZnk5Z21NY0MzYzdoMW1ueXArQlVjTWIz?=
 =?utf-8?B?MVVHVjNlVzJaOWdHVmRFVmlXcXE0N0JBSmFVODNIeTErZmg3WWRHUndNd3B0?=
 =?utf-8?B?Q0V4bXo5ZlYySjlPWHVIN3JzdVI0NXdjeUxBdlhLUnFxYjJPRXo0ZHM4eXd1?=
 =?utf-8?B?OFdSWUVZclJML3pPTjV3VnlHNkd4WlNRaFlQNGRKZWI4N3lEM2dLalFML2pv?=
 =?utf-8?B?aklFVkxXcS9LZGpjYnZHY2tNLzhKZzJjejRrZndCTUhXYTFGVWtoZVF3TnhQ?=
 =?utf-8?B?cnpJZFZvS0tVYlNxUDJkUGdDK3RtbjFBdm9SVGhrcnpzdGJrTFArT0lDeEJw?=
 =?utf-8?B?TnRndm9odUdUQnNYRktVNDhySkE4OUtwUTFxQm53UmtXT0l5cGNKajQ5RC9R?=
 =?utf-8?B?VC9tKzM4Nm90NlpCU2hXb1Q2K0NMS2t5QWxqdVA2NjhMOTRnbE1ya3p2Y2J2?=
 =?utf-8?B?aW9JSTF3TG9uaVFZcEVBNHdDcGpodytvUUNKbUpROEkwcmNHOG82Vy95a0dv?=
 =?utf-8?B?V3BnWnRqN3IzV0Q3ZVBHRjM5SGxRdFhXejllSE45Q3VpRHZSMjZBT3piY2Rt?=
 =?utf-8?B?aUVnV3Erb3ZPVHVsNUllMlN1clp1S28wc0w1c1BVbGNja0YrV1Nrenkxd1F4?=
 =?utf-8?Q?651+cgXSDdjT6rsRifX/Qcxuy2IO0K4uQd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b21a36a-0fe0-4290-b740-08d896ad27f6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2020 10:29:32.3460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctZmzkTgDO8cBP94en+aNx8CqOFlFCvCM4OWj3ags8KSye99+Lg5vHF6+SBi1HepAnjRv4N9OAZWjYdgCVqTlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3792
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

Sorry for the late reply, we had a few days of over here. Comments inline.

On 11/25/2020 8:10 PM, Robin Murphy wrote:
> On 2020-11-25 15:50, laurentiu.tudor@nxp.com wrote:
>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>
>> Add a NXP specific hook to preserve SMMU mappings present at
>> boot time (created by the boot loader). These are needed for
>> MC firmware present on some NXP chips to continue working
>> across kernel boot and SMMU initialization.
>>
>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>> ---
>>   drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 33 ++++++++++++++++++++++
>>   1 file changed, 33 insertions(+)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
>> b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
>> index 7fed89c9d18a..ca07d9d4be69 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
>> @@ -187,6 +187,36 @@ static const struct arm_smmu_impl
>> mrvl_mmu500_impl = {
>>       .reset = arm_mmu500_reset,
>>   };
>>   +static int nxp_cfg_probe(struct arm_smmu_device *smmu)
>> +{
>> +    int i, cnt = 0;
>> +    u32 smr;
>> +
>> +    for (i = 0; i < smmu->num_mapping_groups; i++) {
>> +        smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
>> +
>> +        if (FIELD_GET(ARM_SMMU_SMR_VALID, smr)) {
> 
> I bet this is fun over kexec...

Right. I haven't even considered kexec.

> Note that the Qualcomm special case got a bit of a free pass since it
> involves working around a totally broken hypervisor, plus gets to play
> the "nobody sane will run an enterprise distro on their phone" card to
> an extent; I don't think the likes of Layerscape kit get it quite so
> easy ;)

I agree that this is not ideal, but the plan here was to have something
to boot vanilla kernel OOB on our chips, which is something on my mind
for quite a while now. I do realize that we won't get away with it
in the long run.

>> +            smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
>> +            smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
>> +            smmu->smrs[i].valid = true;
>> +
>> +            smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
>> +            smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
>> +            smmu->s2crs[i].cbndx = 0xff;
>> +
>> +            cnt++;
>> +        }
>> +    }
>> +
>> +    dev_notice(smmu->dev, "\tpreserved %d boot mapping%s\n", cnt,
>> +           cnt == 1 ? "" : "s");
> 
> That gets you around the initial SMMU reset, but what happens for the
> arbitrarily long period of time between the MC device getting attached
> to a default domain and the MC driver actually probing and (presumably)
> being able to map and reinitialise its firmware?

Perhaps I'm missing something, but won't the MC firmware live based on
this bypass mapping created by the bootloader and that gets preserved?

>> +
>> +    return 0;
>> +}
>> +
>> +static const struct arm_smmu_impl nxp_impl = {
>> +    .cfg_probe = nxp_cfg_probe,
>> +};
> 
> I believe you're mostly using MMU-500, so you probably don't want to
> simply throw out the relevant errata workarounds.
> 
>>   struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device
>> *smmu)
>>   {
>> @@ -226,5 +256,8 @@ struct arm_smmu_device *arm_smmu_impl_init(struct
>> arm_smmu_device *smmu)
>>       if (of_device_is_compatible(np, "marvell,ap806-smmu-500"))
>>           smmu->impl = &mrvl_mmu500_impl;
>>   +    if (of_property_read_bool(np, "nxp,keep-boot-mappings"))
>> +        smmu->impl = &nxp_impl;
> 
> Normally you'd get a "what about ACPI?" here, but given the number of
> calls and email threads we've had specifically about trying to make ACPI
> support for these platforms work, that gets upgraded to at least a "WHAT
> ABOUT ACPI!?" :P
I do have ACPI in mind, but for now I just wanted to have a
first impression on the approach. One idea I was pondering on was to
have this property in the MC node (quick reminder: MC is exposed as a NC
in ACPI, should be able to replicate the property in there too). In the
mean time, we are in collaboration with our partners on using RMRR by
adding support for it in the arm-smmu-v2 driver.

> But seriously, the case of device firmware in memory being active before
> handover to Linux is *literally* the original reason behind IORT RMRs.
> We already know we need a way to specify the equivalent thing for DT
> systems, such that both can be handled commonly. I really don't want to
> have to support a vendor-specific mechanism for not-even-fully-solving a
> completely generic issue, sorry.
> 

I remember that some months ago there was a proposal from nvidia [1] to
map per-device reserved memory into SMMU. Would it make sense to revive
it as it seemed a viable solution for our case too?

[1]
https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=213701&state=%2A&archive=both

---
Best Regards, Laurentiu
