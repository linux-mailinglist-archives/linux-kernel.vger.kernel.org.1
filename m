Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3F528AF75
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 09:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgJLHvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 03:51:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13786 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726530AbgJLHvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 03:51:45 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09C7XiVM076390;
        Mon, 12 Oct 2020 03:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=u1AAwpu4LsbKtAdN1fPev9PoRGSnGCL7NgWQ0+UvmcI=;
 b=Lrn0UKa8+3jtl8/uBFJmdpkeB8Mc6+2XhhO5IlBx0H6SPPXm07+Y8Zr5NFam36LUiefV
 wwkyW5auQW/Blxomz9cpA+5XHAN4rZ9bkkk2+Kz8qkWg1XcrZqwho9NZcnMJf3pmtmOx
 UnD9wWslAFIGYGgCKabrZpZzkujQ4bmmXwY4rKlAr2BpILRPkLld8ERz1fO8eQx+BVZH
 ZUE9dgKFkde3t4z7bGOz/tLMMl3i5dxFbhY5DMaL9SygV/zBTJglk70ouiCsfstvbiUM
 /scGxXzO4yjqU9ixibGNhX5v+X6ctqFUbYROxFf2GKo5d77cXhGzdxigeVGm58+FgHdu wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 344gxcuwne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 03:51:35 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09C7ZUBT082969;
        Mon, 12 Oct 2020 03:51:35 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 344gxcuwn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 03:51:35 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09C7lnQU031220;
        Mon, 12 Oct 2020 07:51:34 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02dal.us.ibm.com with ESMTP id 3434k91ghw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 07:51:34 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09C7pW1j64094488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Oct 2020 07:51:32 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A07AC6A047;
        Mon, 12 Oct 2020 07:51:32 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 714F96A057;
        Mon, 12 Oct 2020 07:51:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.46.237])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 12 Oct 2020 07:51:27 +0000 (GMT)
Subject: Re: [PATCH] perf vendor events: Fix typos in power8 PMU events
To:     Sandipan Das <sandipan@linux.ibm.com>, acme@kernel.org
Cc:     mpe@ellerman.id.au, ravi.bangoria@linux.ibm.com,
        sukadev@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20201012050205.328523-1-sandipan@linux.ibm.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <badc113f-3024-1317-af16-c3714605ac74@linux.ibm.com>
Date:   Mon, 12 Oct 2020 13:21:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201012050205.328523-1-sandipan@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_03:2020-10-12,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010120065
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/20 10:32 AM, Sandipan Das wrote:
> This replaces the incorrectly spelled word "localtion"
> with "location" in some power8 PMU event descriptions.

Patch looks good to me, Thanks for correcting it.

Reviewed-By: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain
> 
> Fixes: 2a81fa3bb5ed ("perf vendor events: Add power8 PMU events")
> Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
> ---
>  .../pmu-events/arch/powerpc/power8/cache.json    | 10 +++++-----
>  .../pmu-events/arch/powerpc/power8/frontend.json | 12 ++++++------
>  .../pmu-events/arch/powerpc/power8/marked.json   | 10 +++++-----
>  .../pmu-events/arch/powerpc/power8/other.json    | 16 ++++++++--------
>  .../arch/powerpc/power8/translation.json         |  2 +-
>  5 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/powerpc/power8/cache.json b/tools/perf/pmu-events/arch/powerpc/power8/cache.json
> index 6b792b2c87e2..05a17084d939 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power8/cache.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power8/cache.json
> @@ -32,8 +32,8 @@
>    {
>      "EventCode": "0x1c04e",
>      "EventName": "PM_DATA_FROM_L2MISS_MOD",
> -    "BriefDescription": "The processor's data cache was reloaded from a localtion other than the local core's L2 due to a demand load",
> -    "PublicDescription": "The processor's data cache was reloaded from a localtion other than the local core's L2 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
> +    "BriefDescription": "The processor's data cache was reloaded from a location other than the local core's L2 due to a demand load",
> +    "PublicDescription": "The processor's data cache was reloaded from a location other than the local core's L2 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
>    },
>    {
>      "EventCode": "0x3c040",
> @@ -74,8 +74,8 @@
>    {
>      "EventCode": "0x4c04e",
>      "EventName": "PM_DATA_FROM_L3MISS_MOD",
> -    "BriefDescription": "The processor's data cache was reloaded from a localtion other than the local core's L3 due to a demand load",
> -    "PublicDescription": "The processor's data cache was reloaded from a localtion other than the local core's L3 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
> +    "BriefDescription": "The processor's data cache was reloaded from a location other than the local core's L3 due to a demand load",
> +    "PublicDescription": "The processor's data cache was reloaded from a location other than the local core's L3 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
>    },
>    {
>      "EventCode": "0x3c042",
> @@ -134,7 +134,7 @@
>    {
>      "EventCode": "0x4e04e",
>      "EventName": "PM_DPTEG_FROM_L3MISS",
> -    "BriefDescription": "A Page Table Entry was loaded into the TLB from a localtion other than the local core's L3 due to a data side request",
> +    "BriefDescription": "A Page Table Entry was loaded into the TLB from a location other than the local core's L3 due to a data side request",
>      "PublicDescription": ""
>    },
>    {
> diff --git a/tools/perf/pmu-events/arch/powerpc/power8/frontend.json b/tools/perf/pmu-events/arch/powerpc/power8/frontend.json
> index 1ddc30655d43..1c902a8263b6 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power8/frontend.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power8/frontend.json
> @@ -116,8 +116,8 @@
>    {
>      "EventCode": "0x1404e",
>      "EventName": "PM_INST_FROM_L2MISS",
> -    "BriefDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L2 due to an instruction fetch (not prefetch)",
> -    "PublicDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L2 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
> +    "BriefDescription": "The processor's Instruction cache was reloaded from a location other than the local core's L2 due to an instruction fetch (not prefetch)",
> +    "PublicDescription": "The processor's Instruction cache was reloaded from a location other than the local core's L2 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
>    },
>    {
>      "EventCode": "0x34040",
> @@ -158,8 +158,8 @@
>    {
>      "EventCode": "0x4404e",
>      "EventName": "PM_INST_FROM_L3MISS_MOD",
> -    "BriefDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L3 due to a instruction fetch",
> -    "PublicDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L3 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
> +    "BriefDescription": "The processor's Instruction cache was reloaded from a location other than the local core's L3 due to a instruction fetch",
> +    "PublicDescription": "The processor's Instruction cache was reloaded from a location other than the local core's L3 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
>    },
>    {
>      "EventCode": "0x34042",
> @@ -320,7 +320,7 @@
>    {
>      "EventCode": "0x1504e",
>      "EventName": "PM_IPTEG_FROM_L2MISS",
> -    "BriefDescription": "A Page Table Entry was loaded into the TLB from a localtion other than the local core's L2 due to a instruction side request",
> +    "BriefDescription": "A Page Table Entry was loaded into the TLB from a location other than the local core's L2 due to a instruction side request",
>      "PublicDescription": ""
>    },
>    {
> @@ -344,7 +344,7 @@
>    {
>      "EventCode": "0x4504e",
>      "EventName": "PM_IPTEG_FROM_L3MISS",
> -    "BriefDescription": "A Page Table Entry was loaded into the TLB from a localtion other than the local core's L3 due to a instruction side request",
> +    "BriefDescription": "A Page Table Entry was loaded into the TLB from a location other than the local core's L3 due to a instruction side request",
>      "PublicDescription": ""
>    },
>    {
> diff --git a/tools/perf/pmu-events/arch/powerpc/power8/marked.json b/tools/perf/pmu-events/arch/powerpc/power8/marked.json
> index 94dc58b83b7e..6de61a797bbd 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power8/marked.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power8/marked.json
> @@ -92,7 +92,7 @@
>    {
>      "EventCode": "0x4c12e",
>      "EventName": "PM_MRK_DATA_FROM_L2MISS_CYC",
> -    "BriefDescription": "Duration in cycles to reload from a localtion other than the local core's L2 due to a marked load",
> +    "BriefDescription": "Duration in cycles to reload from a location other than the local core's L2 due to a marked load",
>      "PublicDescription": ""
>    },
>    {
> @@ -158,13 +158,13 @@
>    {
>      "EventCode": "0x201e4",
>      "EventName": "PM_MRK_DATA_FROM_L3MISS",
> -    "BriefDescription": "The processor's data cache was reloaded from a localtion other than the local core's L3 due to a marked load",
> +    "BriefDescription": "The processor's data cache was reloaded from a location other than the local core's L3 due to a marked load",
>      "PublicDescription": ""
>    },
>    {
>      "EventCode": "0x2d12e",
>      "EventName": "PM_MRK_DATA_FROM_L3MISS_CYC",
> -    "BriefDescription": "Duration in cycles to reload from a localtion other than the local core's L3 due to a marked load",
> +    "BriefDescription": "Duration in cycles to reload from a location other than the local core's L3 due to a marked load",
>      "PublicDescription": ""
>    },
>    {
> @@ -392,7 +392,7 @@
>    {
>      "EventCode": "0x1f14e",
>      "EventName": "PM_MRK_DPTEG_FROM_L2MISS",
> -    "BriefDescription": "A Page Table Entry was loaded into the TLB from a localtion other than the local core's L2 due to a marked data side request",
> +    "BriefDescription": "A Page Table Entry was loaded into the TLB from a location other than the local core's L2 due to a marked data side request",
>      "PublicDescription": ""
>    },
>    {
> @@ -416,7 +416,7 @@
>    {
>      "EventCode": "0x4f14e",
>      "EventName": "PM_MRK_DPTEG_FROM_L3MISS",
> -    "BriefDescription": "A Page Table Entry was loaded into the TLB from a localtion other than the local core's L3 due to a marked data side request",
> +    "BriefDescription": "A Page Table Entry was loaded into the TLB from a location other than the local core's L3 due to a marked data side request",
>      "PublicDescription": ""
>    },
>    {
> diff --git a/tools/perf/pmu-events/arch/powerpc/power8/other.json b/tools/perf/pmu-events/arch/powerpc/power8/other.json
> index f4e760cab111..84a0cedf1fd9 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power8/other.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power8/other.json
> @@ -410,8 +410,8 @@
>    {
>      "EventCode": "0x61c04e",
>      "EventName": "PM_DATA_ALL_FROM_L2MISS_MOD",
> -    "BriefDescription": "The processor's data cache was reloaded from a localtion other than the local core's L2 due to either demand loads or data prefetch",
> -    "PublicDescription": "The processor's data cache was reloaded from a localtion other than the local core's L2 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
> +    "BriefDescription": "The processor's data cache was reloaded from a location other than the local core's L2 due to either demand loads or data prefetch",
> +    "PublicDescription": "The processor's data cache was reloaded from a location other than the local core's L2 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
>    },
>    {
>      "EventCode": "0x63c040",
> @@ -470,8 +470,8 @@
>    {
>      "EventCode": "0x64c04e",
>      "EventName": "PM_DATA_ALL_FROM_L3MISS_MOD",
> -    "BriefDescription": "The processor's data cache was reloaded from a localtion other than the local core's L3 due to either demand loads or data prefetch",
> -    "PublicDescription": "The processor's data cache was reloaded from a localtion other than the local core's L3 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
> +    "BriefDescription": "The processor's data cache was reloaded from a location other than the local core's L3 due to either demand loads or data prefetch",
> +    "PublicDescription": "The processor's data cache was reloaded from a location other than the local core's L3 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
>    },
>    {
>      "EventCode": "0x63c042",
> @@ -1280,8 +1280,8 @@
>    {
>      "EventCode": "0x51404e",
>      "EventName": "PM_INST_ALL_FROM_L2MISS",
> -    "BriefDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L2 due to instruction fetches and prefetches",
> -    "PublicDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L2 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
> +    "BriefDescription": "The processor's Instruction cache was reloaded from a location other than the local core's L2 due to instruction fetches and prefetches",
> +    "PublicDescription": "The processor's Instruction cache was reloaded from a location other than the local core's L2 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
>    },
>    {
>      "EventCode": "0x534040",
> @@ -1340,8 +1340,8 @@
>    {
>      "EventCode": "0x54404e",
>      "EventName": "PM_INST_ALL_FROM_L3MISS_MOD",
> -    "BriefDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L3 due to a instruction fetch",
> -    "PublicDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L3 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
> +    "BriefDescription": "The processor's Instruction cache was reloaded from a location other than the local core's L3 due to a instruction fetch",
> +    "PublicDescription": "The processor's Instruction cache was reloaded from a location other than the local core's L3 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
>    },
>    {
>      "EventCode": "0x534042",
> diff --git a/tools/perf/pmu-events/arch/powerpc/power8/translation.json b/tools/perf/pmu-events/arch/powerpc/power8/translation.json
> index 623e7475b010..a1657f5fdc6b 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power8/translation.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power8/translation.json
> @@ -44,7 +44,7 @@
>    {
>      "EventCode": "0x1e04e",
>      "EventName": "PM_DPTEG_FROM_L2MISS",
> -    "BriefDescription": "A Page Table Entry was loaded into the TLB from a localtion other than the local core's L2 due to a data side request",
> +    "BriefDescription": "A Page Table Entry was loaded into the TLB from a location other than the local core's L2 due to a data side request",
>      "PublicDescription": ""
>    },
>    {
> 
