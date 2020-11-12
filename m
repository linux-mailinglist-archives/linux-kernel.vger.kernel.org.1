Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81B02B0811
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgKLPEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:04:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40814 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728284AbgKLPEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:04:14 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ACEVmCw014412;
        Thu, 12 Nov 2020 10:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=IPujSi3x6A4jX1jC3ND/CHuY8u9bHDgcVwgmoZ6SlV8=;
 b=cdoEDJJcGiO8DTtv2sEfcUxXH/5hL67cuoqpo4Pje9nqlO74Mbqv4XcaIal5KfnFiZpp
 kSwGL1d4UKes4TMi92+ZSoucEPPEo5nV5T2TkDcRn432OwXT5MaW1vKvSxKOrWdZmoEL
 eXbeOy/VkkZpqk8fgnDEaWjPCeSwaR0mCegZF6WHz7jTuOySecSO3zlN+odIChsHNhoF
 QEQnrnnELyQBQO2d2xvJgI7AOSR2BgYUM4rsnsgEjrPZUA34psWOLQgiF+BZFwBBXp0q
 i+c4RkK8JC8uP2b7bn3QDZegNEXReDnnxAiIkWoNxpuZbCeBy8hPCxOBAjuA9W0TU9TL Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34s2wq8eya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 10:04:12 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0ACEW3rA015775;
        Thu, 12 Nov 2020 10:04:11 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34s2wq8exa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 10:04:11 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0ACF2k1U017528;
        Thu, 12 Nov 2020 15:04:09 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 34njuh5sxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 15:04:09 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0ACF47v047055244
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Nov 2020 15:04:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5ED6042042;
        Thu, 12 Nov 2020 15:04:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 346E242041;
        Thu, 12 Nov 2020 15:04:07 +0000 (GMT)
Received: from [9.145.71.125] (unknown [9.145.71.125])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Nov 2020 15:04:07 +0000 (GMT)
Subject: Re: [PATCH] gcov: remove support for GCC < 4.9
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
References: <20201111030557.2015680-1-ndesaulniers@google.com>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <122d1259-19d5-008d-d290-62e22f279ffe@linux.ibm.com>
Date:   Thu, 12 Nov 2020 16:04:07 +0100
MIME-Version: 1.0
In-Reply-To: <20201111030557.2015680-1-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-12_05:2020-11-12,2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1011 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011120084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.11.2020 04:05, Nick Desaulniers wrote:
> Since
> commit 0bddd227f3dc ("Documentation: update for gcc 4.9 requirement")
> the minimum supported version of GCC is gcc-4.9. It's now safe to remove
> this code.
> 
> Similar to
> commit 10415533a906 ("gcov: Remove old GCC 3.4 support")
> but that was for GCC 4.8 and this is for GCC 4.9.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/427
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Looks good, thanks!

Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>

Andrew, could you pick this up via your tree?

> ---
>  kernel/gcov/gcc_4_7.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/gcov/gcc_4_7.c b/kernel/gcov/gcc_4_7.c
> index 53c67c87f141..0da0aacc1f26 100644
> --- a/kernel/gcov/gcc_4_7.c
> +++ b/kernel/gcov/gcc_4_7.c
> @@ -25,10 +25,8 @@
>  #define GCOV_COUNTERS			9
>  #elif (__GNUC__ > 5) || (__GNUC__ == 5 && __GNUC_MINOR__ >= 1)
>  #define GCOV_COUNTERS			10
> -#elif __GNUC__ == 4 && __GNUC_MINOR__ >= 9
> -#define GCOV_COUNTERS			9
>  #else
> -#define GCOV_COUNTERS			8
> +#define GCOV_COUNTERS			9
>  #endif
>  
>  #define GCOV_TAG_FUNCTION_LENGTH	3
> 


-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany
