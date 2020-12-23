Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319B22E1FCC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 18:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgLWRRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 12:17:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61352 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726012AbgLWRRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 12:17:11 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BNH2xUr001091;
        Wed, 23 Dec 2020 12:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=wZ/er/0/M4r2p33K9bkRZvIZvNiN0ENPgw3pdqo3T7M=;
 b=d0gFgAIt4lkcjAsSpwpgmlo0lPixzenLxbMEU/JwQnUsVfab+59wPJ/2Ux7EbEXgfvzi
 eSwCfb3g62RoBBHe4DFlPNnhcsrgGyZ0+5yRxJNqUROryaD4VWVEQy3W6Cebb6IocqTW
 SLKpItbIBNI+SlB2oocf0EUif/Zdw46GwHFIiVTASsyxTy/g5+3bWnBe39lSUzqYsW24
 YLDkQIE3P9qDnNLWOqiaLymqYD2AS+VGUxH/qUUMrdZU+eOt4XG979L1u35GuWLJT9K4
 Dzm+DyQVtshlYXljGL0nkemud/2yQI1F1rtGvP+F1avf8+U37EDIhsIGjFYhb+RBWFQ4 0Q== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35m7xxbgph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Dec 2020 12:16:24 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BNHDMjU005772;
        Wed, 23 Dec 2020 17:16:22 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 35h958a5ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Dec 2020 17:16:22 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BNHGIPT18416124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Dec 2020 17:16:18 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B979AE051;
        Wed, 23 Dec 2020 17:16:19 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3399AE045;
        Wed, 23 Dec 2020 17:16:18 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.171.59.200])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Dec 2020 17:16:18 +0000 (GMT)
Subject: Re: [PATCH] zlib: move EXPORT_SYMBOL() and MODULE_LICENSE() out of
 dfltcc_syms.c
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Zaslonko Mikhail <zaslonko@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Acked-by : Ilya Leoshkevich" <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20201219052530.28461-1-rdunlap@infradead.org>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <ec3e254f-c84f-33e3-138a-980d7eea796b@de.ibm.com>
Date:   Wed, 23 Dec 2020 18:16:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201219052530.28461-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-23_07:2020-12-23,2020-12-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012230125
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.12.20 06:25, Randy Dunlap wrote:
> In 11fb479ff5d9 ("zlib: export S390 symbols for zlib modules"), I added
> EXPORT_SYMBOL()s to dfltcc_inflate.c but then Mikhail said that these
> should probably be in dfltcc_syms.c with the other EXPORT_SYMBOL()s.
> 
> However, that is contrary to the current kernel style, which places
> EXPORT_SYMBOL() immediately after the function that it applies to,
> so move all EXPORT_SYMBOL()s to their respective function locations
> and drop the dfltcc_syms.c file. Also move MODULE_LICENSE() from the
> deleted file to dfltcc.c.
> 
> Fixes: 11fb479ff5d9 ("zlib: export S390 symbols for zlib modules")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Zaslonko Mikhail <zaslonko@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>

Makes sense
I see that Andrew has already picked this up, in case this helps

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  lib/zlib_dfltcc/dfltcc.c         |    6 +++++-
>  lib/zlib_dfltcc/dfltcc_deflate.c |    3 +++
>  lib/zlib_dfltcc/dfltcc_syms.c    |   17 -----------------
>  3 files changed, 8 insertions(+), 18 deletions(-)
> 
> --- linux-next-20201218.orig/lib/zlib_dfltcc/dfltcc.c
> +++ linux-next-20201218/lib/zlib_dfltcc/dfltcc.c
> @@ -1,7 +1,8 @@
>  // SPDX-License-Identifier: Zlib
>  /* dfltcc.c - SystemZ DEFLATE CONVERSION CALL support. */
>  
> -#include <linux/zutil.h>
> +#include <linux/export.h>
> +#include <linux/module.h>
>  #include "dfltcc_util.h"
>  #include "dfltcc.h"
>  
> @@ -53,3 +54,6 @@ void dfltcc_reset(
>      dfltcc_state->dht_threshold = DFLTCC_DHT_MIN_SAMPLE_SIZE;
>      dfltcc_state->param.ribm = DFLTCC_RIBM;
>  }
> +EXPORT_SYMBOL(dfltcc_reset);
> +
> +MODULE_LICENSE("GPL");
> --- linux-next-20201218.orig/lib/zlib_dfltcc/dfltcc_deflate.c
> +++ linux-next-20201218/lib/zlib_dfltcc/dfltcc_deflate.c
> @@ -4,6 +4,7 @@
>  #include "dfltcc_util.h"
>  #include "dfltcc.h"
>  #include <asm/setup.h>
> +#include <linux/export.h>
>  #include <linux/zutil.h>
>  
>  /*
> @@ -34,6 +35,7 @@ int dfltcc_can_deflate(
>  
>      return 1;
>  }
> +EXPORT_SYMBOL(dfltcc_can_deflate);
>  
>  static void dfltcc_gdht(
>      z_streamp strm
> @@ -277,3 +279,4 @@ again:
>          goto again; /* deflate() must use all input or all output */
>      return 1;
>  }
> +EXPORT_SYMBOL(dfltcc_deflate);
> --- linux-next-20201218.orig/lib/zlib_dfltcc/dfltcc_syms.c
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * linux/lib/zlib_dfltcc/dfltcc_syms.c
> - *
> - * Exported symbols for the s390 zlib dfltcc support.
> - *
> - */
> -
> -#include <linux/init.h>
> -#include <linux/module.h>
> -#include <linux/zlib.h>
> -#include "dfltcc.h"
> -
> -EXPORT_SYMBOL(dfltcc_can_deflate);
> -EXPORT_SYMBOL(dfltcc_deflate);
> -EXPORT_SYMBOL(dfltcc_reset);
> -MODULE_LICENSE("GPL");
> 
