Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD6C2ABF75
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 16:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbgKIPJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 10:09:34 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:60260 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730125AbgKIPIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 10:08:00 -0500
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A9F6Zi0025736;
        Mon, 9 Nov 2020 15:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pps0720;
 bh=GOaU7SGwPN8LQow6XiEZ16xJeozSorokWikcY6tsuGA=;
 b=jdNdcrchUOamBgPY40grjBX4tCjTIgYipaKpl81DR81ZN41ahedCd768oqaC9QzOChnC
 /50/HCzgjX3ofTcem67VeJK9/x0PHFc9Ffo3iMRpSq2GWsPfuT7UIy6Mzm5loVD04deF
 dkOfDbt0+6jIbkNafsZxcUZO5Ez915oky14PG5EssVDwHucdFZgADkEvhW4X9hIuWOJ8
 kvuUnK8FDfKyHGLObnHE0UgA2VvuTwDibCWv1Kg7PubTAqxl77wc/q6q9UhOhQsHFEF2
 vLLZF1ZBEQlVu3WTjXqxDjS5CCxkLggqbmVvIrmsDczSgPEUcCflQ9OWIlmd0MbMcyci GA== 
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 34nmj3pg9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Nov 2020 15:07:27 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 3E18768;
        Mon,  9 Nov 2020 15:07:26 +0000 (UTC)
Received: from [16.99.146.76] (unknown [16.99.146.76])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 992BB56;
        Mon,  9 Nov 2020 15:07:24 +0000 (UTC)
Subject: Re: [PATCH] x86/platform/uv: drop last traces of uv_flush_tlb_others
To:     Jiri Slaby <jslaby@suse.cz>, bp@alien8.de
Cc:     linux-kernel@vger.kernel.org,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20201109093653.2042-1-jslaby@suse.cz>
From:   Mike Travis <mike.travis@hpe.com>
Message-ID: <5847a155-cb70-7795-235b-746a57f2dac2@hpe.com>
Date:   Mon, 9 Nov 2020 07:07:23 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20201109093653.2042-1-jslaby@suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-09_08:2020-11-05,2020-11-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 mlxscore=0 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011090105
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Jiri for catching that.

Acked-By: Mike Travis <mike.travis@hpe.com>

On 11/9/2020 1:36 AM, Jiri Slaby wrote:
> Commit 39297dde7390 ("x86/platform/uv: Remove UV BAU TLB Shootdown
> Handler") removed uv_flush_tlb_others. Its declaration was removed also
> from asm/uv/uv.h. But only for the CONFIG_X86_UV=y case. The inline
> definition (!X86_UV case) is still in place.
> 
> So remove this implementation with everything what was added to support
> uv_flush_tlb_others:
> * include of asm/tlbflush.h
> * forward declarations of struct cpumask, mm_struct, and flush_tlb_info
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Mike Travis <mike.travis@hpe.com>
> Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
> Cc: Steve Wahl <steve.wahl@hpe.com>
> Cc: Russ Anderson <russ.anderson@hpe.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> ---
>   arch/x86/include/asm/uv/uv.h | 10 ----------
>   1 file changed, 10 deletions(-)
> 
> diff --git a/arch/x86/include/asm/uv/uv.h b/arch/x86/include/asm/uv/uv.h
> index 172d3e4a9e4b..648eb23fe7f0 100644
> --- a/arch/x86/include/asm/uv/uv.h
> +++ b/arch/x86/include/asm/uv/uv.h
> @@ -2,14 +2,8 @@
>   #ifndef _ASM_X86_UV_UV_H
>   #define _ASM_X86_UV_UV_H
>   
> -#include <asm/tlbflush.h>
> -
>   enum uv_system_type {UV_NONE, UV_LEGACY_APIC, UV_X2APIC};
>   
> -struct cpumask;
> -struct mm_struct;
> -struct flush_tlb_info;
> -
>   #ifdef CONFIG_X86_UV
>   #include <linux/efi.h>
>   
> @@ -44,10 +38,6 @@ static inline int is_uv_system(void)	{ return 0; }
>   static inline int is_uv_hubbed(int uv)	{ return 0; }
>   static inline void uv_cpu_init(void)	{ }
>   static inline void uv_system_init(void)	{ }
> -static inline const struct cpumask *
> -uv_flush_tlb_others(const struct cpumask *cpumask,
> -		    const struct flush_tlb_info *info)
> -{ return cpumask; }
>   
>   #endif	/* X86_UV */
>   
> 
