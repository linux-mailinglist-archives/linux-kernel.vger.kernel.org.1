Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E432C146B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 20:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732258AbgKWTUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 14:20:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16690 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732174AbgKWTUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 14:20:52 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ANJ1WNc063253;
        Mon, 23 Nov 2020 14:20:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=pnZ3AgfzLhiXfwYzAIMOqGs96krbDkUWoIGUIFPGwYc=;
 b=Us56QZ65WpZ+f1mWNs/Z0wxpUJ9BhK10IfF9yjs7rw6lTu52iquoIFAWMrzM7qGEeT4u
 dBLuC+o3qO4m7yavEfNOA5sV8uR0nwT33MtRZRb3HCPhU8X3TOJuYmULeffjCZ+0C6sm
 7F8T7z1Eg7E685Q6c5vBiS/UgWi/XuQ1kdoDp6D11ki3ulaUSMZhUS/ubAvh6deVNOsz
 NmJtL+sErnO/EjNZcv+REK+BqPh43umqLcpjb9c5A/+Is9G2HlWK1aKY8iBvqMepQJfp
 tjsPxCtdyKLuy9zL6QI7QQnBzo3mjJn4+XP6NPUS+1w280ggAvOiOH0o9NuDjipZbhwe Cw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34ygtt3qrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 14:20:45 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0ANJC3BW027876;
        Mon, 23 Nov 2020 19:20:42 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 34xt5hauxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 19:20:42 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0ANJKdug6816472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Nov 2020 19:20:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0CD84C059;
        Mon, 23 Nov 2020 19:20:39 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F8D94C046;
        Mon, 23 Nov 2020 19:20:39 +0000 (GMT)
Received: from sig-9-145-42-202.uk.ibm.com (unknown [9.145.42.202])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 23 Nov 2020 19:20:39 +0000 (GMT)
Message-ID: <48fe521ac710f6a4d5e85a81109ef41f16dd2550.camel@linux.ibm.com>
Subject: Re: [PATCH] zlib: export S390 symbols for zlib modules
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Date:   Mon, 23 Nov 2020 20:20:38 +0100
In-Reply-To: <20201123191712.4882-1-rdunlap@infradead.org>
References: <20201123191712.4882-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-23_17:2020-11-23,2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 mlxscore=0 impostorscore=0 malwarescore=0 mlxlogscore=915 suspectscore=3
 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011230122
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-23 at 11:17 -0800, Randy Dunlap wrote:
> Fix build errors when ZLIB_INFLATE=m and ZLIB_DEFLATE=m
> and ZLIB_DFLTCC=y by exporting the 2 needed symbols in
> dfltcc_inflate.c.
> 
> Fixes these build errors:
> 
> ERROR: modpost: "dfltcc_inflate" [lib/zlib_inflate/zlib_inflate.ko]
> undefined!
> ERROR: modpost: "dfltcc_can_inflate"
> [lib/zlib_inflate/zlib_inflate.ko] undefined!
> 
> Fixes: 126196100063 ("lib/zlib: add s390 hardware support for kernel
> zlib_inflate")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---
>  lib/zlib_dfltcc/dfltcc_inflate.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> --- linux-next-20201120.orig/lib/zlib_dfltcc/dfltcc_inflate.c
> +++ linux-next-20201120/lib/zlib_dfltcc/dfltcc_inflate.c
> @@ -4,6 +4,7 @@
>  #include "dfltcc_util.h"
>  #include "dfltcc.h"
>  #include <asm/setup.h>
> +#include <linux/export.h>
>  #include <linux/zutil.h>
>  
>  /*
> @@ -29,6 +30,7 @@ int dfltcc_can_inflate(
>      return is_bit_set(dfltcc_state->af.fns, DFLTCC_XPND) &&
>                 is_bit_set(dfltcc_state->af.fmts, DFLTCC_FMT0);
>  }
> +EXPORT_SYMBOL(dfltcc_can_inflate);
>  
>  static int dfltcc_was_inflate_used(
>      z_streamp strm
> @@ -147,3 +149,4 @@ dfltcc_inflate_action dfltcc_inflate(
>      return (cc == DFLTCC_CC_OP1_TOO_SHORT || cc ==
> DFLTCC_CC_OP2_TOO_SHORT) ?
>          DFLTCC_INFLATE_BREAK : DFLTCC_INFLATE_CONTINUE;
>  }
> +EXPORT_SYMBOL(dfltcc_inflate);

Thanks for fixing this!

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

