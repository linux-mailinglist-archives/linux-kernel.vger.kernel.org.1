Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCF828C46C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 00:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731396AbgJLWAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 18:00:10 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:17608 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727457AbgJLWAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 18:00:10 -0400
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09CLukL1018528;
        Mon, 12 Oct 2020 22:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pps0720;
 bh=2ewB9L6N7SS53Tor3diDn70OSD/7Tr6m812rdTHQG90=;
 b=pgiTlZSLUe6UfZm58Q1dIO9MjWBI9OPIODbcD/cqDEL+YCCRGOq6ewixxOBqVVG4RrIN
 uzjkB4qRan26js3QMxNabkrrFnEN4k/bhQlmzsElB5lx9yPjsdyOv4g0BEbGWzD+XI+P
 ZvCx7BL5Yo+/2SWPT3XqnnSE+l9focQlGZRjXRHyUOhzI6i2ayxfanfzZ2HSCvBB//Hr
 sU/9/ERQZVQKtJr0JoE01NDeRLucg7p3T59kWtr3qKDdl4giif9oOpnEWmoC7OxNjCui
 o0dtpkRCKoF9T6199tC0CBAHFjtvfoCLF++oxi5GTSdU4hbRxDupNtoTLFtYJ62fEANb Ug== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 344e3brhq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 22:00:06 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 4593B7B;
        Mon, 12 Oct 2020 22:00:06 +0000 (UTC)
Received: from [16.99.129.135] (unknown [16.99.129.135])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id CA8209A;
        Mon, 12 Oct 2020 22:00:05 +0000 (UTC)
Subject: Re: [GIT PULL] x86/platform updates for v5.10
To:     Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
References: <20201012101012.GD25311@zn.tnic>
 <CAHk-=wiwBYoAKQ6H=n0ppZfMe6nVDwDw6cruv7jxZZw4XEmUsg@mail.gmail.com>
 <c8cfb3d2-d3c4-6d8d-1dfd-aeb349e26303@hpe.com>
 <20201012212709.GM25311@zn.tnic>
 <f778b25e-68e7-98ec-9032-b35696948405@hpe.com>
 <CAHk-=wg6MBLPzRrRYGQ6EeoUGV+-MdMraFiUiiQyenVk=t6=Bw@mail.gmail.com>
 <20201012215642.GN25311@zn.tnic>
From:   Mike Travis <mike.travis@hpe.com>
Message-ID: <335ef705-d395-1260-b668-2edab8bf32ff@hpe.com>
Date:   Mon, 12 Oct 2020 15:00:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20201012215642.GN25311@zn.tnic>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_18:2020-10-12,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010120162
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2020 2:56 PM, Borislav Petkov wrote:
> On Mon, Oct 12, 2020 at 02:46:10PM -0700, Linus Torvalds wrote:
>> At least "git grep" only shows two assignments to it.
>>
>> Of course, that would miss any cases that play games with preprocessor
>> token pasting etc, so it's not entirely meaningful, but it's certainly
>> a hint..
> 
>  From a quick staring at gcc asm, it looks write only. And gcc didn't
> warn because it optimized that assignment away completely AFAICT.
> 
>> And yes, I expect that the fix is to just make it "unsigned long", but
>> if it truly isn't actually used, maybe removal is better.
> 
> Yeah, below is a proper patch which builds fine with gcc and clang-10.
> You guys have fun - I'm going to bed. :-)
> 
> ---
> From: Mike Travis <mike.travis@hpe.com>
> Date: Mon, 12 Oct 2020 23:46:34 +0200
> Subject: [PATCH] x86/platform/uv: Correct uvh_nmi_mmrx_mask's type
> 
> Clang rightfully warns:
> 
>    arch/x86/platform/uv/uv_nmi.c:250:23: warning: implicit conversion
>    from 'unsigned long' to 'int' changes value from 1152921504606846976
>    to 0 [-Wconstant-conversion]
>                    uvh_nmi_mmrx_mask = UVH_EVENT_OCCURRED0_EXTIO_INT0_MASK;
>                                    ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Make the variable unsigned long.
> 
>   [ bp: Productize it. ]

Thanks, I will look at it (and test it on hardware and the UV5 simulator 
to make sure it's correct.)
> 
> Signed-off-by: Mike Travis <mike.travis@hpe.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>   arch/x86/platform/uv/uv_nmi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
> index 0f5cbcf0da63..8566730f154d 100644
> --- a/arch/x86/platform/uv/uv_nmi.c
> +++ b/arch/x86/platform/uv/uv_nmi.c
> @@ -59,7 +59,7 @@ DEFINE_PER_CPU(struct uv_cpu_nmi_s, uv_cpu_nmi);
>   static unsigned long uvh_nmi_mmrx;		/* UVH_EVENT_OCCURRED0/1 */
>   static unsigned long uvh_nmi_mmrx_clear;	/* UVH_EVENT_OCCURRED0/1_ALIAS */
>   static int uvh_nmi_mmrx_shift;			/* UVH_EVENT_OCCURRED0/1_EXTIO_INT0_SHFT */
> -static int uvh_nmi_mmrx_mask;			/* UVH_EVENT_OCCURRED0/1_EXTIO_INT0_MASK */
> +static unsigned long uvh_nmi_mmrx_mask;			/* UVH_EVENT_OCCURRED0/1_EXTIO_INT0_MASK */
>   static char *uvh_nmi_mmrx_type;			/* "EXTIO_INT0" */
>   
>   /* Non-zero indicates newer SMM NMI handler present */
> 
