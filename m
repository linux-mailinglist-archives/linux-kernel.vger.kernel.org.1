Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAC92DB410
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 19:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731789AbgLOSxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 13:53:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34474 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731767AbgLOSxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 13:53:14 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BFIYoAP131577;
        Tue, 15 Dec 2020 13:52:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=PcVoxPd+ouBc/AI8p99dbs+lJQKrEG95kYdrjQrEewo=;
 b=Dzq4TAQjDuXa62CHAy2cPPYdo+lWkGfWVNsYsWIT/4ZNIoMLZavq0zXRBpAsWFFakzVh
 t1i3drNhytHRpSVPYhFfL9RZFlEyF0L7mRZ9ycS5m60RsdgeXiuwxZOY8IE5qlPsCqPF
 N/nUws/WSxzjW82gu7Ii14T3txOVnYW0mFTAEAi99tAu17sDwREfD1DLLf8PpRGpAW/2
 0x15AEwbTVTgi7x1I91bfMp6IkFGzz6WECv0qNXXLXHdjZ06OPJXL1uxeury7UH/qb9T
 QG8FEsbJb6lKlBVmgmBFsv9qCSJ36qduYoWkUzaGAudUbKHgjSW2PBm1cTa+wT3PEltm Gw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35f093q9j3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 13:52:32 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BFIpwrG000961;
        Tue, 15 Dec 2020 18:52:30 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 35cng8bhbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 18:52:30 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BFIqSC423462160
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Dec 2020 18:52:28 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09633A4040;
        Tue, 15 Dec 2020 18:52:28 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A3C0A4051;
        Tue, 15 Dec 2020 18:52:27 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.171.18.42])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Dec 2020 18:52:27 +0000 (GMT)
Subject: Re: [PATCH] lib/zlib: fix inflating zlib streams on s390
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20201215155551.894884-1-iii@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <ea249b70-5b47-8e7c-b667-1146d20a0a65@de.ibm.com>
Date:   Tue, 15 Dec 2020 19:52:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201215155551.894884-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-15_12:2020-12-15,2020-12-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=919
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012150122
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.12.20 16:55, Ilya Leoshkevich wrote:
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

With a zlib compressed squashfs:

Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

We should add

Cc: <stable@vger.kernel.org> # 5.6

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
