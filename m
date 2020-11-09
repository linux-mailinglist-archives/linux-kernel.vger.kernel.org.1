Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC392AC05F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 17:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbgKIQBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 11:01:09 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:42670 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726410AbgKIQBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 11:01:08 -0500
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A9FrVHn019543;
        Mon, 9 Nov 2020 16:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=8bQpy7by82Vd1CK+FzoGvxlH3x1i+7WMlJUyitAjISk=;
 b=MySd1f55DFmhRGrs7vw+M7katowo9XPyIF4tW9qjWR9Ka3h2o698KoVlIJYuPljcQHDO
 ebhbqmfp+zx8rfzssltrwwCM3b5Ix/lfSLUBFtriTMwlAYyeSsVgTZBcP9ASHb6N5zDh
 mayGK+wfo5j3Pr74jFn7Z3/pvfpSi7Sndd4vH20pqO9Q0QeqZdphCagRwbQZcGeFVlt3
 ODSW+kqGjFSR7LTslaQqQuuw+Tggzcpb8qJbZIuFjEgxov7ZSBbvz5owmPvOGV50a/df
 BIg3gVX+J0SaEfjcfrN697yL/PfIgQZGQeah0bttefweIvW/J9kIFMLPaoposHq71LxT 2w== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0a-002e3701.pphosted.com with ESMTP id 34p5evtgt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Nov 2020 16:00:45 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id CCB6E8B;
        Mon,  9 Nov 2020 16:00:43 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.214.129.62])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 84D3237;
        Mon,  9 Nov 2020 16:00:42 +0000 (UTC)
Date:   Mon, 9 Nov 2020 10:00:41 -0600
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     bp@alien8.de, linux-kernel@vger.kernel.org,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/platform/uv: drop last traces of uv_flush_tlb_others
Message-ID: <20201109160041.GS1468175@swahl-home.5wahls.com>
References: <20201109093653.2042-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109093653.2042-1-jslaby@suse.cz>
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-09_08:2020-11-05,2020-11-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=1 mlxlogscore=857 priorityscore=1501 spamscore=0 adultscore=0
 clxscore=1011 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011090109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Steve Wahl <steve.wahl@hpe.com>

On Mon, Nov 09, 2020 at 10:36:53AM +0100, Jiri Slaby wrote:
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
>  arch/x86/include/asm/uv/uv.h | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/arch/x86/include/asm/uv/uv.h b/arch/x86/include/asm/uv/uv.h
> index 172d3e4a9e4b..648eb23fe7f0 100644
> --- a/arch/x86/include/asm/uv/uv.h
> +++ b/arch/x86/include/asm/uv/uv.h
> @@ -2,14 +2,8 @@
>  #ifndef _ASM_X86_UV_UV_H
>  #define _ASM_X86_UV_UV_H
>  
> -#include <asm/tlbflush.h>
> -
>  enum uv_system_type {UV_NONE, UV_LEGACY_APIC, UV_X2APIC};
>  
> -struct cpumask;
> -struct mm_struct;
> -struct flush_tlb_info;
> -
>  #ifdef CONFIG_X86_UV
>  #include <linux/efi.h>
>  
> @@ -44,10 +38,6 @@ static inline int is_uv_system(void)	{ return 0; }
>  static inline int is_uv_hubbed(int uv)	{ return 0; }
>  static inline void uv_cpu_init(void)	{ }
>  static inline void uv_system_init(void)	{ }
> -static inline const struct cpumask *
> -uv_flush_tlb_others(const struct cpumask *cpumask,
> -		    const struct flush_tlb_info *info)
> -{ return cpumask; }
>  
>  #endif	/* X86_UV */
>  
> -- 
> 2.29.2
> 

-- 
Steve Wahl, Hewlett Packard Enterprise
