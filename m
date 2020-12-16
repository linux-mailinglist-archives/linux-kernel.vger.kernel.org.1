Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E252DC371
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 16:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgLPPwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 10:52:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56096 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726588AbgLPPwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 10:52:11 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BGFmGld088188;
        Wed, 16 Dec 2020 10:51:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=p7vlv5ObQcx8ENP+5QNUyc3+HEaSDTcPof+0nzOPxd4=;
 b=oZgXirULPmIlly6NzAtCJN6ETOoZ0+jz6RVPn2MqtsD32cuItJV56ZopHGoIIURx8k4F
 fOkKzkk/SpBNeWSyqxgYp6sxEPP/pekssqiZZTM6i80vdjzJS7hxlTy0O/Pb2Zxrk3Y9
 BJ+zzv2n9xhfGeI3xFRToQhDVHE23GGEFog1e7rIH2rduJ0yzoIsgm5hGjBA7lfFGNeR
 83TRSf8DDO8ylyd7eaaXrPJ8VkzZC/KXo0sToPIF/+LUwqJjMlL6HGF3D98UP45F10LG
 5BSDVMAePatU/y9HlArw4CaDqvlwY1aBCavE9R+8h9umfCrrkjXrQ6ml9uu8t+BDUlJE GA== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35fn6sr1up-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Dec 2020 10:51:29 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BGFWsrK008845;
        Wed, 16 Dec 2020 15:51:28 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02dal.us.ibm.com with ESMTP id 35d52634ep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Dec 2020 15:51:28 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BGFpRV311796900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Dec 2020 15:51:27 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42C1A136055;
        Wed, 16 Dec 2020 15:51:27 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 039A7136051;
        Wed, 16 Dec 2020 15:51:25 +0000 (GMT)
Received: from [9.145.24.37] (unknown [9.145.24.37])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Dec 2020 15:51:25 +0000 (GMT)
Subject: Re: [PATCH] lib/zlib: fix inflating zlib streams on s390
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20201215155551.894884-1-iii@linux.ibm.com>
From:   Zaslonko Mikhail <zaslonko@linux.ibm.com>
Message-ID: <3994efae-3699-7a50-6081-3eeb3272c947@linux.ibm.com>
Date:   Wed, 16 Dec 2020 16:51:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201215155551.894884-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-16_05:2020-12-15,2020-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=956
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160101
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>

Please, also add:
Cc: <stable@vger.kernel.org> # 5.6

On 15.12.2020 16:55, Ilya Leoshkevich wrote:
> Decompressing zlib streams on s390 fails with "incorrect data check"
> error.
> 
> Userspace zlib checks inflate_state.flags in order to byteswap checksums
> only for zlib streams, and s390 hardware inflate code, which was ported
> from there, tries to match this behavior. At the same time, kernel zlib
> does not use inflate_state.flags, so it contains essentially random
> values. For many use cases either zlib stream is zeroed out or checksum
> is not used, so this problem is masked, but at least SquashFS is still
> affected.
> 
> Fix by always passing a checksum to and from the hardware as is, which
> matches zlib_inflate()'s expectations.
> 
> Fixes: 126196100063 ("lib/zlib: add s390 hardware support for kernel zlib_inflate")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  lib/zlib_dfltcc/dfltcc_inflate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/zlib_dfltcc/dfltcc_inflate.c b/lib/zlib_dfltcc/dfltcc_inflate.c
> index db107016d29b..fb60b5a6a1cb 100644
> --- a/lib/zlib_dfltcc/dfltcc_inflate.c
> +++ b/lib/zlib_dfltcc/dfltcc_inflate.c
> @@ -125,7 +125,7 @@ dfltcc_inflate_action dfltcc_inflate(
>      param->ho = (state->write - state->whave) & ((1 << HB_BITS) - 1);
>      if (param->hl)
>          param->nt = 0; /* Honor history for the first block */
> -    param->cv = state->flags ? REVERSE(state->check) : state->check;
> +    param->cv = state->check;
>  
>      /* Inflate */
>      do {
> @@ -138,7 +138,7 @@ dfltcc_inflate_action dfltcc_inflate(
>      state->bits = param->sbb;
>      state->whave = param->hl;
>      state->write = (param->ho + param->hl) & ((1 << HB_BITS) - 1);
> -    state->check = state->flags ? REVERSE(param->cv) : param->cv;
> +    state->check = param->cv;
>      if (cc == DFLTCC_CC_OP2_CORRUPT && param->oesc != 0) {
>          /* Report an error if stream is corrupted */
>          state->mode = BAD;
> 
