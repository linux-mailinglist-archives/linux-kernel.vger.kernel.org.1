Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E962A6DCA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbgKDTZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:25:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6692 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726604AbgKDTZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:25:48 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A4J2MFv161908;
        Wed, 4 Nov 2020 14:25:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Dd13+njnwpYwPf2e/d/TSON0FWEufciVHRrSOmk9gOI=;
 b=FHK8r4uHo/XC5b7G1PCuRNADE329Zs4PdAFyqURsFFg0YAmW45tR3fw/nFYKJ20RPd1u
 RlBCfOHxZg8OSQC7+JSvE1WKAPi1CNKZCOPCl7xa7M2nUv05bAmcOMKnrhakPZDlxOE5
 cHJUoBFvXPm/p/0pC2X6zQtoShl1G1KFkdXwT8fu+r0gBHOM4m2j3gaewPa6wTwLqUJw
 d5Ifxyv0LQF+IOT6KLyit1GNUB54Sb6NhqvWz1nUg1RTou5gp0ChQjkp3LGUSft4WpEC
 uzHsysI8JlQGkqeIeso9LCaLOpzXn+z1E+nNyiWjUswSxcv698LdBhZaOK2A50+9vPd1 Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34ksrutk1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 14:25:36 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A4J2b2O163457;
        Wed, 4 Nov 2020 14:25:36 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34ksrutk15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 14:25:36 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A4J755N021008;
        Wed, 4 Nov 2020 19:25:34 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 34h0fcvnc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 19:25:34 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A4JPWOc51052868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Nov 2020 19:25:32 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AD224C046;
        Wed,  4 Nov 2020 19:25:32 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 209CB4C040;
        Wed,  4 Nov 2020 19:25:31 +0000 (GMT)
Received: from localhost (unknown [9.145.163.252])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  4 Nov 2020 19:25:31 +0000 (GMT)
Date:   Wed, 4 Nov 2020 20:25:29 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 13/41] s390/kasan: include asm/page.h from asm/kasan.h
Message-ID: <your-ad-here.call-01604517929-ext-5900@work.hours>
References: <cover.1604333009.git.andreyknvl@google.com>
 <5e7c366e68844a0fe8e18371c5a76aef53905fae.1604333009.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5e7c366e68844a0fe8e18371c5a76aef53905fae.1604333009.git.andreyknvl@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-04_12:2020-11-04,2020-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 suspectscore=1 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040135
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 05:03:53PM +0100, Andrey Konovalov wrote:
> asm/kasan.h relies on pgd_t type that is defined in asm/page.h. Include
> asm/page.h from asm/kasan.h.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
> Change-Id: I369a8f9beb442b9d05733892232345c3f4120e0a
> ---
>  arch/s390/include/asm/kasan.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/s390/include/asm/kasan.h b/arch/s390/include/asm/kasan.h
> index e9bf486de136..a0ea4158858b 100644
> --- a/arch/s390/include/asm/kasan.h
> +++ b/arch/s390/include/asm/kasan.h
> @@ -2,6 +2,8 @@
>  #ifndef __ASM_KASAN_H
>  #define __ASM_KASAN_H
>  
> +#include <asm/page.h>

Could you please include
#include <asm/pgtable.h>

instead? This file is also using _REGION1_SHIFT which is defined there.
And I have some s390 kasan changes pending, which include
asm/pgtable.h as well, so this would make merging simpler. Thank you.

With that changed
Acked-by: Vasily Gorbik <gor@linux.ibm.com>
> +
>  #ifdef CONFIG_KASAN
>  
>  #define KASAN_SHADOW_SCALE_SHIFT 3

