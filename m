Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D903F1B147D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 20:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgDTSaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 14:30:24 -0400
Received: from mail-mw2nam10on2051.outbound.protection.outlook.com ([40.107.94.51]:7403
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725784AbgDTSaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 14:30:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NaX6wQuqKGsYtkY1aIGYp5lxj80MRK/w/2M6RycHH1jKKqo0KnCJrpDwzKbOlji4oWXSP7WlZmgzBN5d5LGimZse9bsL69zg72GjkaObVG47nGcE9sGNQP/sOMJ/u7fsWeoCKsGtj3BDqhkI/GyAm1dsfnAE8CuBVc9o51CJeUfhmfiRYGj0c6u7oVpBwHB6TyQNxDss6DslbwrQE/brVSOeuJjGal2N3WKucCwu02Tk2z0wHak3/ZT8B+yaU7GD8I2/pCk1aQ+4UayXjB3H0HdKOgzJjBXREVEwrd52T6a96qS57r1ir2dZADnC7Cf80JGoRClq26nezBMCNRY2tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kx4MWY/p8ZITWZ2rXucoFJkEVxytvsfrFFCfs4FaFCw=;
 b=XxZ3mJXUE/Sd8ezTSQQSl6TKF3Btu2C1BqT2TyLXrjPC37yFmZxu5QDhIudbUroTGXzVg8jjyDhrGaoX1xtk6Q05N5N+Oc/QGcSlLa9wsWQ7vsYoL2jfcvNO7KL4Gy0GTVMfSxiSumxDkeZF3+5M6t4l3ATNfvbRLFTMXyuL1yWSIVTrh2W51SxU7ZSGzxq45gD9nNmpYoE6bdkMnBdxAhykdsWDm2R5Bium//OI68g8TQKl6ICsMEgfIkmfGOkKhVD2vt+ozH/+/J30TVJ2UsZeJBnOXJPkzcNi8q9wGMiwXWJ6etiyXC6SVbYMZNroJVBZgZh8APbNbmPhvAb80w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kx4MWY/p8ZITWZ2rXucoFJkEVxytvsfrFFCfs4FaFCw=;
 b=mbeyI8QXB8P0bqX0rXbnYr13ba9wsHOh6rcItEu4Wb3n8lsyth0b44RjnsA7aVwCNzWjW9rPHGNMeP8y11uJVS50UlAWNGtBqcfAEtYeuxtt+0BdHlE0ZtixEkU5015cBOC6k/l0N9r0CRKg0gq3Aqrdv8vrDf/2fh6QKT3Mep0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
 by DM6PR12MB3018.namprd12.prod.outlook.com (2603:10b6:5:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 18:30:20 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9ae:cb95:c925:d5bf]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9ae:cb95:c925:d5bf%4]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 18:30:20 +0000
Subject: Re: [patch 05/15] x86/tlb: Move __flush_tlb() out of line
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20200419203137.214111265@linutronix.de>
 <20200419203336.134117165@linutronix.de>
 <5857df01-abeb-c6cd-8e92-64eb365dc835@amd.com>
 <fab4e80a-3df2-a177-c5fe-1ab995953727@suse.com>
 <852c1af7-bc1c-a86c-d390-7547563bdde4@amd.com>
 <76124c5d-d5ab-6ad0-b24b-4127894107e5@suse.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <c6fe82c6-060e-f16f-bbeb-25d85948c4c7@amd.com>
Date:   Mon, 20 Apr 2020 13:30:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <76124c5d-d5ab-6ad0-b24b-4127894107e5@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0601CA0011.namprd06.prod.outlook.com
 (2603:10b6:803:2f::21) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:15e::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SN4PR0601CA0011.namprd06.prod.outlook.com (2603:10b6:803:2f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27 via Frontend Transport; Mon, 20 Apr 2020 18:30:19 +0000
X-Originating-IP: [67.79.209.213]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ef2f50ed-d88d-4f1b-3f8a-08d7e558e187
X-MS-TrafficTypeDiagnostic: DM6PR12MB3018:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3018B24ACB203B68D60508A5ECD40@DM6PR12MB3018.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(81156014)(478600001)(110136005)(316002)(8676002)(4326008)(31686004)(54906003)(66476007)(956004)(2616005)(8936002)(186003)(53546011)(6506007)(66946007)(66556008)(16526019)(26005)(52116002)(66574012)(5660300002)(2906002)(31696002)(36756003)(6486002)(86362001)(6512007);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2dC4n2goHR7XTDPP7IttGOjj0plvtWsVLdN1M0WzPrI9iYnkxIYHEe8HZkn/de6S0E0KQblV+1CpX8wcd7+qq58i3nqhctrdKFwZjYWc5oWd0EBRogICEE4IMa4DABcPrYasszz90DahI+BQn7PIfyRyqR6/KaXXVIsS8rshI63/ONMlSL68oCQ801rJZyLeXO1fmj/dk9tkGDhE3ue3NzDUF95czHrxtUhRYUN1ksv/ndSzubYHMG5NRATRCD56DeM8xQbTc3ZI70QKXqTKZgrySRNrEJZuHE4Pm7TVDhj0u2I8I+kzInPYGtDXHEoQLA+PhBFw53c+usKAMny/71qDfq4W2E/kkph4reiz9WhdgWqxoc5lQeHlyuNcThEnwwFr4YOLzoux7+hnNSjKCarkK4mmG7Vs4qhada5l9QKDm1ZSm947/2NgGUiwm182
X-MS-Exchange-AntiSpam-MessageData: 5MzaAIGal1/9nc/Y2tHdcJJePw65GjHedk7K2G0nVyZfQ4/FgbJPqfSEMml6pm0k8t5gJzK47OpkuZpWG7BurgsS4c53DkLzN/o/yvPhsNR22zd/8BqnkpkaJhNJ6bGsyvh3joHO9Hfn/ymnpa0AQw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2f50ed-d88d-4f1b-3f8a-08d7e558e187
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 18:30:20.1983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+csIDX7p+OzNFP543LkbK/TFAcUbpVSqWWviq/PIjUGZuDpOSAMXwVA32l5fU4MX+qxnngdCgCtdKGUslPkqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/20 9:38 AM, Jürgen Groß wrote:
> On 20.04.20 16:26, Tom Lendacky wrote:
>> On 4/20/20 9:03 AM, Jürgen Groß wrote:
>>> On 20.04.20 15:48, Tom Lendacky wrote:
>>>> On 4/19/20 3:31 PM, Thomas Gleixner wrote:
>>>>> cpu_tlbstate is exported because various TLB related functions need 
>>>>> access
>>>>> to it, but cpu_tlbstate is sensitive information which should only be
>>>>> accessed by well contained kernel functions and not be directly 
>>>>> exposed to
>>>>> modules.
>>>>>
>>>>> The various TLB flush functions need access to cpu_tlbstate. As a first
>>>>> step move __flush_tlb() out of line and hide the native function. The
>>>>> latter can be static when CONFIG_PARAVIRT is disabled.
>>>>>
>>>>> Consolidate the name space while at it and remove the pointless extra
>>>>> wrapper in the paravirt code.
>>>>>
>>>>> No functional change.
>>>>>
>>>>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>>>>> Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
>>>>> Cc: Juergen Gross <jgross@suse.com>
>>>>> ---
>>>>>   arch/x86/include/asm/paravirt.h    |    4 +++-
>>>>>   arch/x86/include/asm/tlbflush.h    |   29 
>>>>> +++++------------------------
>>>>>   arch/x86/kernel/cpu/mtrr/generic.c |    4 ++--
>>>>>   arch/x86/kernel/paravirt.c         |    7 +------
>>>>>   arch/x86/mm/mem_encrypt.c          |    2 +-
>>>>>   arch/x86/mm/tlb.c                  |   33 
>>>>> ++++++++++++++++++++++++++++++++-
>>>>>   arch/x86/platform/uv/tlb_uv.c      |    2 +-
>>>>>   7 files changed, 45 insertions(+), 36 deletions(-)
>>>>>
>>>>> --- a/arch/x86/include/asm/paravirt.h
>>>>> +++ b/arch/x86/include/asm/paravirt.h
>>>>> @@ -47,7 +47,9 @@ static inline void slow_down_io(void)
>>>>>   #endif
>>>>>   }
>>>>> -static inline void __flush_tlb(void)
>>>>> +void native_flush_tlb_local(void);
>>>>> +
>>>>> +static inline void __flush_tlb_local(void)
>>>>>   {
>>>>>       PVOP_VCALL0(mmu.flush_tlb_user);
>>>>>   }
>>>>> --- a/arch/x86/include/asm/tlbflush.h
>>>>> +++ b/arch/x86/include/asm/tlbflush.h
>>>>> @@ -140,12 +140,13 @@ static inline unsigned long build_cr3_no
>>>>>       return __sme_pa(pgd) | kern_pcid(asid) | CR3_NOFLUSH;
>>>>>   }
>>>>> +void flush_tlb_local(void);
>>>>> +
>>>>>   #ifdef CONFIG_PARAVIRT
>>>>>   #include <asm/paravirt.h>
>>>>>   #else
>>>>> -#define __flush_tlb() __native_flush_tlb()
>>>>> -#define __flush_tlb_global() __native_flush_tlb_global()
>>>>> -#define __flush_tlb_one_user(addr) __native_flush_tlb_one_user(addr)
>>>>> +#define __flush_tlb_global()        __native_flush_tlb_global()
>>>>> +#define __flush_tlb_one_user(addr) __native_flush_tlb_one_user(addr)
>>>>>   #endif
>>>>>   struct tlb_context {
>>>>> @@ -371,24 +372,6 @@ static inline void invalidate_user_asid(
>>>>>   }
>>>>>   /*
>>>>> - * flush the entire current user mapping
>>>>> - */
>>>>> -static inline void __native_flush_tlb(void)
>>>>> -{
>>>>> -    /*
>>>>> -     * Preemption or interrupts must be disabled to protect the access
>>>>> -     * to the per CPU variable and to prevent being preempted between
>>>>> -     * read_cr3() and write_cr3().
>>>>> -     */
>>>>> -    WARN_ON_ONCE(preemptible());
>>>>> -
>>>>> -    invalidate_user_asid(this_cpu_read(cpu_tlbstate.loaded_mm_asid));
>>>>> -
>>>>> -    /* If current->mm == NULL then the read_cr3() "borrows" an mm */
>>>>> -    native_write_cr3(__native_read_cr3());
>>>>> -}
>>>>> -
>>>>> -/*
>>>>>    * flush everything
>>>>>    */
>>>>>   static inline void __native_flush_tlb_global(void)
>>>>> @@ -461,7 +444,7 @@ static inline void __flush_tlb_all(void)
>>>>>           /*
>>>>>            * !PGE -> !PCID (setup_pcid()), thus every flush is total.
>>>>>            */
>>>>> -        __flush_tlb();
>>>>> +        flush_tlb_local();
>>>>>       }
>>>>>   }
>>>>> @@ -537,8 +520,6 @@ struct flush_tlb_info {
>>>>>       bool            freed_tables;
>>>>>   };
>>>>> -#define local_flush_tlb() __flush_tlb()
>>>>> -
>>>>>   #define flush_tlb_mm(mm)                        \
>>>>>           flush_tlb_mm_range(mm, 0UL, TLB_FLUSH_ALL, 0UL, true)
>>>>> --- a/arch/x86/kernel/cpu/mtrr/generic.c
>>>>> +++ b/arch/x86/kernel/cpu/mtrr/generic.c
>>>>> @@ -761,7 +761,7 @@ static void prepare_set(void) __acquires
>>>>>       /* Flush all TLBs via a mov %cr3, %reg; mov %reg, %cr3 */
>>>>>       count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
>>>>> -    __flush_tlb();
>>>>> +    flush_tlb_local();
>>>>>       /* Save MTRR state */
>>>>>       rdmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
>>>>> @@ -778,7 +778,7 @@ static void post_set(void) __releases(se
>>>>>   {
>>>>>       /* Flush TLBs (no need to flush caches - they are disabled) */
>>>>>       count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
>>>>> -    __flush_tlb();
>>>>> +    flush_tlb_local();
>>>>>       /* Intel (P6) standard MTRRs */
>>>>>       mtrr_wrmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
>>>>> --- a/arch/x86/kernel/paravirt.c
>>>>> +++ b/arch/x86/kernel/paravirt.c
>>>>> @@ -160,11 +160,6 @@ unsigned paravirt_patch_insns(void *insn
>>>>>       return insn_len;
>>>>>   }
>>>>> -static void native_flush_tlb(void)
>>>>> -{
>>>>> -    __native_flush_tlb();
>>>>> -}
>>>>> -
>>>>>   /*
>>>>>    * Global pages have to be flushed a bit differently. Not a real
>>>>>    * performance problem because this does not happen often.
>>>>> @@ -359,7 +354,7 @@ struct paravirt_patch_template pv_ops =
>>>>>   #endif /* CONFIG_PARAVIRT_XXL */
>>>>>       /* Mmu ops. */
>>>>> -    .mmu.flush_tlb_user    = native_flush_tlb,
>>>>> +    .mmu.flush_tlb_user    = native_flush_tlb_local,
>>>>>       .mmu.flush_tlb_kernel    = native_flush_tlb_global,
>>>>>       .mmu.flush_tlb_one_user    = native_flush_tlb_one_user,
>>>>>       .mmu.flush_tlb_others    = native_flush_tlb_others,
>>>>> --- a/arch/x86/mm/mem_encrypt.c
>>>>> +++ b/arch/x86/mm/mem_encrypt.c
>>>>> @@ -134,7 +134,7 @@ static void __init __sme_early_map_unmap
>>>>>           size = (size <= PMD_SIZE) ? 0 : size - PMD_SIZE;
>>>>>       } while (size);
>>>>> -    __native_flush_tlb();
>>>>> +    flush_tlb_local();
>>>>
>>>> This invoked __native_flush_tlb() because of how early it is called 
>>>> and the paravirt ops support isn't set up yet, resulting in a crash if 
>>>> not invoking the native version directly. So this needs a "native" 
>>>> version of the tlb flush to invoke.
>>>
>>> I don't think this is still true. With my rework of pvops to have all
>>> functions in one struct which is initialized statically initially
>>> everything should work from the time the kernel is mapped.
>>>
>>> In case it doesn't there is something very wrong IMO.
>>
>> The memory encryption support was implemented in 4.14, so it's quite 
>> possible that this isn't an issue now. I'll test out the patch and 
>> verify it. What release did your pvops rework land in?
> 
> 4.20.

Ok, my (limited) testing appears good at this point. I see a couple of 
calls to ftrace (__fentry__) that just return before invoking the native 
version of the TLB flushing function.

I don't remember what the original problem was that required the call to 
__native_flush_tlb(), maybe some overall kernel instrumentation that once 
removed via the Makefile took care of it. But it appears ok now, so 
disregard my original comment.

Thanks,
Tom

> 
> 
> Juergen
> 
