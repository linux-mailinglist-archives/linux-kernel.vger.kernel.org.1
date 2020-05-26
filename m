Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6BE31A213D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 14:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgDHMDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 08:03:01 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:8014 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726521AbgDHMDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 08:03:01 -0400
X-IronPort-AV: E=Sophos;i="5.72,358,1580745600"; 
   d="scan'208";a="88690985"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 Apr 2020 20:02:56 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 0208F49DF129;
        Wed,  8 Apr 2020 19:52:33 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 8 Apr 2020 20:02:55 +0800
Subject: Re: Question about prefill_possible_map
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <687566a8-cacd-e0db-6914-d547853c7555@cn.fujitsu.com>
Message-ID: <2911d6a8-b0fd-6ee4-40d3-a86e1096de80@cn.fujitsu.com>
Date:   Wed, 8 Apr 2020 20:07:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <687566a8-cacd-e0db-6914-d547853c7555@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 0208F49DF129.A05B2
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

  Seems you helped improve 2a51fe083eba7f, could you help with this question?

-- 
Sincerely,
Cao jin

On 3/27/20 2:38 PM, Cao jin wrote:
> Hi,
> 
> At the beginning of this function, there is:
> 
>     /* No boot processor was found in mptable or ACPI MADT */
>     if (!num_processors) {
>         if (boot_cpu_has(X86_FEATURE_APIC)) {
>             int apicid = boot_cpu_physical_apicid;
>             int cpu = hard_smp_processor_id();
> 
>             pr_warn("Boot CPU (id %d) not listed by BIOS\n", cpu);
> 
>             /* Make sure boot cpu is enumerated */
>             if (apic->cpu_present_to_apicid(0) == BAD_APICID &&
>                 apic->apic_id_valid(apicid))
>                 generic_processor_info(apicid, boot_cpu_apic_version);
>         }
> 
>         if (!num_processors)
>             num_processors = 1;
>     }
> 
> I see 3 cases will go through this code chunk,
> 
> 1. UP, has no APCI MADT & MP table, but has APIC
> 2. 2a51fe083eba7f: kdump kernel running on the hot-plugged CPU
> 3. normal UP(No table, no APIC)
> 
> And "if (boot_cpu_has(X86_FEATURE_APIC))" covers case 1 & 2 to my
> understanding.
> 
> But both cases 1 & 2 already have boot_cpu_physical_apicid initialized
> from APIC ID register:
> 1. init_apic_mappings --> register_lapic_address
> 2. early_acpi_boot_init --> early_acpi_process_madt -->...-->
>    register_lapic_address
> 
> So my question is: is variable "cpu" redundant? Could it be:
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 69881b2d446c..99fc03511568 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1456,9 +1456,9 @@ __init void prefill_possible_map(void)
>         if (!num_processors) {
>                 if (boot_cpu_has(X86_FEATURE_APIC)) {
>                         int apicid = boot_cpu_physical_apicid;
> -                       int cpu = hard_smp_processor_id();
> 
> -                       pr_warn("Boot CPU (id %d) not listed by BIOS\n", cpu);
> +                       pr_warn("Boot CPU (id %d) not listed by BIOS\n", \
> +                                boot_cpu_physical_apicid);
> 
>                         /* Make sure boot cpu is enumerated */
>                         if (apic->cpu_present_to_apicid(0) == BAD_APICID &&
> 





