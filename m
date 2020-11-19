Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B642B9DC4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 23:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgKSWoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 17:44:34 -0500
Received: from mail-eopbgr700063.outbound.protection.outlook.com ([40.107.70.63]:50400
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726466AbgKSWod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 17:44:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrChG9Gui87Q1LNURA9gygQkOyt7lBdLCNNcCdOr4vUIgVQVUtsAwJSYar0s2bKqzk4tbYobFeckpmnKlTOilT5KaDVg6zTg6y1dUGLWSCH8KkrCXt43T0653ElWa5zSsn3I5PqryzfVD+sU2zIeTC1/lYHYhghx+bQTvAX2x9DOT2yOZxfl0B7QMSq/B+pAaFfcBKpGpRVfAr4wTwjmvqI89a0ZgisA5Ye8cYflM38dO/J0ZOfYvXzXAcdHq080A0ltWHT7BHvHcJui2WUhi3Z4CXkgOcTkz9jPH2c7Q4eOJL0E7VhMCieHcdGjwtN+NjQ1YVRuOqLYSbK3kxBmuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cW/IsZQOBL1eInDFr0Dag7QzCehwkVDwrd44qsYmbkM=;
 b=Koc7DsqjtJZOX31OO0kTtiyXM45ZUxXr4rZk0KsyFlXDa28HD/WjMzsf3v4LELzigPCKsKxzm70jJWXaTTl6Na9T/ojPdje0HsvymHUvRfQiGzhCfNBY6ENvo8TyytcnKOZzzELvD1C7o9G75GRmTlQpTDIXykCNJl9maGGGP/sF2e6CJ78+B3wHlW2fno0HXxiTKKUM0ECzFH3CS+MLmcFdOPBaWKy8IrPdJF76mr4aZLbPRgRYCaFcXVmMsmmwl0DUydadTBNdtiBZwzPcAd+hYHLPgnnU4d1+op4t8ViQ6VJKgBd6xpsY8FiKbugHt6VHVstc0Xf0FZ7vLAmd7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cW/IsZQOBL1eInDFr0Dag7QzCehwkVDwrd44qsYmbkM=;
 b=nBGQQDWhJFd0Lh5buRja1G06beSpsG6enhBKgnjNXaHpvqCgwpNcELVqfoBSAWV3Y8QneASQeR1G+iFH3fumKXLfBwZDT9dTwza38c4hRdSsRXTCRXNyOjT6iViGe6Btehl2Ecz+dVztJMWcn0XsJr4EV3RXXAh1tVN+wigFyKw=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2382.namprd12.prod.outlook.com (2603:10b6:802:2e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Thu, 19 Nov
 2020 22:44:29 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::d877:baf6:9425:ece]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::d877:baf6:9425:ece%3]) with mapi id 15.20.3564.028; Thu, 19 Nov 2020
 22:44:28 +0000
Subject: Re: [PATCH] x86/resctrl: Fix AMD L3 QOS CDP enable/disable
To:     Reinette Chatre <reinette.chatre@intel.com>, bp@alien8.de
Cc:     fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de
References: <160469365104.21002.2901190946502347327.stgit@bmoger-ubuntu>
 <d03ac86a-5e7b-8319-7747-4b0299aaa625@intel.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <225f198d-092d-437d-9c5b-015517201218@amd.com>
Date:   Thu, 19 Nov 2020 16:44:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <d03ac86a-5e7b-8319-7747-4b0299aaa625@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0501CA0065.namprd05.prod.outlook.com
 (2603:10b6:803:41::42) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.136] (165.204.77.1) by SN4PR0501CA0065.namprd05.prod.outlook.com (2603:10b6:803:41::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.11 via Frontend Transport; Thu, 19 Nov 2020 22:44:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 255f963c-f02b-4e06-6627-08d88cdcac6b
X-MS-TrafficTypeDiagnostic: SN1PR12MB2382:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2382E8305752964142B7FB3395E00@SN1PR12MB2382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: knP+lgvfGwmTYBl5Lnff5ZZ8kwkkkM8TxdDqG+WyIYWupQ92kvQyJOa7fryoS3i+sHmxbt7IOTMeL/yNQjmuH/HKtzH3R8l+VTglTJRq++X7PeP0RgZYtdOwRWw3AR63r0dz8WIxGO2yTf5V+wkFQwIGZL/LMwgRdrfMNyhUeYOAVNAh1NvK248mLL+kzFoK1K9DmV4In96q3IPek9xlvWf0yPf2ifZQJ7NmFSlHhyvGEUHK6Xg2d+zyMxDUh+0q90uAFQWtTFsr7sCOG/nJ+KL2zFcDTVK1ycYyA5mK6aUZKeeUkG4qGalJnLWtzerk6438AZIVi3s2lYZSZMT+WFbVkFU9zwaXtNzQj+ERdbOad979WUbh43X77fB5pi5BivtHdrbkWOOZ1rWQYZj8f8W+1uLrFV3mZa0GgojCK+JD70XaKoXNrLicexeyDdf4fO2yHRzuxpyMTmspYZfvRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(83380400001)(36756003)(16526019)(186003)(31696002)(8676002)(4326008)(16576012)(52116002)(26005)(5660300002)(956004)(53546011)(45080400002)(478600001)(966005)(2616005)(86362001)(2906002)(31686004)(8936002)(66476007)(316002)(6486002)(66556008)(66946007)(44832011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Vjg0LDnTua/H2qZW2Pa1hTyfxS5T+t1Z56NEBq2Vgc0JX/VN+JpYVLx+05XjJNTu9pDGHys8qx3k6i4Cky2HtS9d/Zh7EXTo1U9cWzrcHZ7qILxYp4Jyw9IKA6PB+p39VuUm7O+CDDrilreTQlFwAb+7xAzufFedFrI2hhfZyA4rQKBN8VM2AQuDqZYaeN/GnXkTGMOqhxb2psozmzhtw4wg9HakeBhIcog6Brt5dekWx9vvQdLqq6fdX21+t/WxsGmzyVIRxB9MPR0K3hz8GeQcM82Cikyvqg1aKQW5tG5Tl/npQk6FvDU5VjA1I1/dxkRXtBCFyE89cpZhGKpcwyYU9gE3BECHsK6Fjo1U2r2v6sP5BrgNSu9bcv6qCzfVQrdSooZWKN4M1q6vu28M9pky9friBXEtV2rhcAJ9N9LCuGyznfDPhWFA19xGxkj6a9xu7vViMHDmczfAMOZIW62xYRge5+LOXbwnM0oNpnztYI6nRIqHA8vNaqZ+TT0OtSKX3xGEWIRAJTN+c9fEWroD180GY8FUsnJCnG/G9wThBUyWW61hi1GkITXcJMz4BeT/63x3SV2gR8ygjIiEu+0FwgzqFZFJBnvi3zZtscKcl7vQbkcVMEBscAW6jDmUQ5dlG28mzrRi48eKdOq+Mg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 255f963c-f02b-4e06-6627-08d88cdcac6b
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2020 22:44:28.8867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kE+77uWKOgKKxPxFd3VNGyNW1SYbFCpUoSuiyZ3SBq+TWtwS31ORjyKYb8zukc2s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2382
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,


On 11/18/20 4:18 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 11/6/2020 12:14 PM, Babu Moger wrote:
>> When the AMD QoS feature CDP(code and data prioritization) is enabled
>> or disabled, the CDP bit in MSR 0000_0C81 is written on one of the
>> cpus in L3 domain(core complex). That is not correct. The CDP bit needs
>> to be updated all the logical cpus in the domain.
> 
> Could you please use CPU instead of cpu throughout, in commit message as
> well as the new code comments?

Sure. Will do.

> 
>>
>> This was not spelled out clearly in the spec earlier. The specification
>> has been updated. The updated specification, "AMD64 Technology Platform
>> Quality of Service Extensions Publication # 56375 Revision: 1.02 Issue
>> Date: October 2020" is available now. Refer the section: Code and Data
>> Prioritization.
>>
>> Fix the issue by adding a new flag arch_needs_update_all in rdt_cache
>> data structure.
> 
> I understand that naming is hard and could be a sticky point. Even so, I
> am concerned that this name is too generic. For example, there are other
> cache settings that are successfully set on a single CPU in the L3 domain
> (the bitmasks for example). This new name and its description in the code
> comments below does not make it clear which cache settings it applies to.
> 
> I interpret this change to mean that the L[23]_QOS_CFG MSR has CPU scope
> while the other L3 QoS configuration registers have the same scope as the
> L3 cache. Could this new variable thus perhaps be named
> "arch_has_per_cpu_cfg"? I considered "arch_has_per_cpu_cdp" but when a new
> field is added to that register it may cause confusion.

Sounds good. Will change it to arch_has_per_cpu_cfg.
> 
>> The documentation can be obtained at the links below:
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdeveloper.amd.com%2Fwp-content%2Fresources%2F56375.pdf&amp;data=04%7C01%7Cbabu.moger%40amd.com%7C3b793291233443b27f6d08d88c0fdc9f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637413347449195250%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=%2B4AUG%2FbAeq70s0XuZ9J%2FOTTEFO8EypLvcR6yBuWE8U4%3D&amp;reserved=0
>>
>> Link:
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D206537&amp;data=04%7C01%7Cbabu.moger%40amd.com%7C3b793291233443b27f6d08d88c0fdc9f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637413347449195250%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=4lzj2ivqxvFaLC99TOIJEGU3p6CmlBLCPHT80LlKsNE%3D&amp;reserved=0
>>
>>
>> Fixes: 4d05bf71f157 ("x86/resctrl: Introduce AMD QOS feature")
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>   arch/x86/kernel/cpu/resctrl/core.c     |    3 +++
>>   arch/x86/kernel/cpu/resctrl/internal.h |    3 +++
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c |    9 +++++++--
>>   3 files changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c
>> b/arch/x86/kernel/cpu/resctrl/core.c
>> index e5f4ee8f4c3b..142c92a12254 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -570,6 +570,8 @@ static void domain_add_cpu(int cpu, struct
>> rdt_resource *r)
>>         if (d) {
>>           cpumask_set_cpu(cpu, &d->cpu_mask);
>> +        if (r->cache.arch_needs_update_all)
>> +            rdt_domain_reconfigure_cdp(r);
>>           return;
>>       }
>>   @@ -943,6 +945,7 @@ static __init void rdt_init_res_defs_amd(void)
>>               r->rid == RDT_RESOURCE_L2CODE) {
>>               r->cache.arch_has_sparse_bitmaps = true;
>>               r->cache.arch_has_empty_bitmaps = true;
>> +            r->cache.arch_needs_update_all = true;
>>           } else if (r->rid == RDT_RESOURCE_MBA) {
>>               r->msr_base = MSR_IA32_MBA_BW_BASE;
>>               r->msr_update = mba_wrmsr_amd;
> 
> The current pattern is to set these flags on all the architectures. Could
> you thus please set the flag within rdt_init_defs_intel()? I confirmed
> that the scope is the same as the cache domain in Intel RDT so the flag
> should be false.

Yes, Will add that.

> 
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 80fa997fae60..d23262d59a51 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -360,6 +360,8 @@ struct msr_param {
>>    *            executing entities
>>    * @arch_has_sparse_bitmaps:    True if a bitmap like f00f is valid.
>>    * @arch_has_empty_bitmaps:    True if the '0' bitmap is valid.
>> + * @arch_needs_update_all:    True if arch needs to update the cache
>> + *                settings on all the cpus in the domain.
> 
> Please do update this to make it clear what "cache settings" are referred
> to. Since this is in struct rdt_cache perhaps something like "QOS_CFG
> register for this cache level has CPU scope."

Sure.
> 
>>    */
>>   struct rdt_cache {
>>       unsigned int    cbm_len;
>> @@ -369,6 +371,7 @@ struct rdt_cache {
>>       unsigned int    shareable_bits;
>>       bool        arch_has_sparse_bitmaps;
>>       bool        arch_has_empty_bitmaps;
>> +    bool        arch_needs_update_all;
>>   };
>>     /**
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index af323e2e3100..a005e90b373a 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1905,8 +1905,13 @@ static int set_cache_qos_cfg(int level, bool enable)
>>         r_l = &rdt_resources_all[level];
>>       list_for_each_entry(d, &r_l->domains, list) {
>> -        /* Pick one CPU from each domain instance to update MSR */
>> -        cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
>> +        if (r_l->cache.arch_needs_update_all)
>> +            /* Pick all the cpus in the domain instance */
>> +            for_each_cpu(cpu, &d->cpu_mask)
>> +                cpumask_set_cpu(cpu, cpu_mask);
>> +        else
>> +            /* Pick one CPU from each domain instance to update MSR */
>> +            cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
>>       }
>>       cpu = get_cpu();
>>       /* Update QOS_CFG MSR on this cpu if it's in cpu_mask. */
>>
> 
> The solution looks good to me, thank you very much.

Thanks for the review.
-Babu
