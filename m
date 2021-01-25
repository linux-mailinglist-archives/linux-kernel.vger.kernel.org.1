Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C955302777
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 17:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbhAYQHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 11:07:07 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:49934 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730376AbhAYQF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 11:05:29 -0500
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10PFK43O002800;
        Mon, 25 Jan 2021 15:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=dsJ5c6z8E2D26JiA6krIDrztQfJIF7o7uMfeJJx/8GE=;
 b=GtCvChbEiJ8EB+t+RcpaUAwa7fmnq/UPwBnRs7hOnMLpPsybj+37MOKjFSHCgyLYttiG
 ISqc980CQru82qGcjoNHH2YhQH/05Af/L9zIATjjyqxYWJWtNWrj58fv7IMhQHpuezKm
 3RpoM0Jk4cUdmoTzbXrM7KI6wpOV8/W3tI64OG2KWh6/I09uR/U4Ej0L2Gybdz1M++pR
 uJndjvayn1pdBhP1VJXhdx0IhaObciKLE0ZdzRABior2w69qkh9yNhGo6FUrIAuuO5jU
 IVd0646hanMbYvHIrrrQNlGjWznGvkQBkMV1YDBHUA0mnhCDX2m73HlN3OWayGpwKErx Vw== 
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 368cf5x3w6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jan 2021 15:29:24 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 5B0534F;
        Mon, 25 Jan 2021 15:29:23 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.214.160.247])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id A710A4A;
        Mon, 25 Jan 2021 15:29:22 +0000 (UTC)
Date:   Mon, 25 Jan 2021 09:29:22 -0600
From:   Steve Wahl <steve.wahl@hpe.com>
To:     trix@redhat.com
Cc:     robinmholt@gmail.com, steve.wahl@hpe.com, mike.travis@hpe.com,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sgi-xp: remove h from printk format specifier
Message-ID: <20210125152922.GQ144275@swahl-home.5wahls.com>
References: <20210123160003.1777766-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210123160003.1777766-1-trix@redhat.com>
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-25_06:2021-01-25,2021-01-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101250089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-By: Steve Wahl <steve.wahl@hpe.com>

On Sat, Jan 23, 2021 at 08:00:03AM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> This change fixes the checkpatch warning described in this commit
> commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of
>   unnecessary %h[xudi] and %hh[xudi]")
> 
> Standard integer promotion is already done and %hx and %hhx is useless
> so do not encourage the use of %hh[xudi] or %h[xudi].
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/misc/sgi-xp/xpnet.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/sgi-xp/xpnet.c b/drivers/misc/sgi-xp/xpnet.c
> index 23837d0d6f4a..2508f83bdc3f 100644
> --- a/drivers/misc/sgi-xp/xpnet.c
> +++ b/drivers/misc/sgi-xp/xpnet.c
> @@ -208,7 +208,7 @@ xpnet_receive(short partid, int channel, struct xpnet_message *msg)
>  	} else {
>  		dst = (void *)((u64)skb->data & ~(L1_CACHE_BYTES - 1));
>  		dev_dbg(xpnet, "transferring buffer to the skb->data area;\n\t"
> -			"xp_remote_memcpy(0x%p, 0x%p, %hu)\n", dst,
> +			"xp_remote_memcpy(0x%p, 0x%p, %u)\n", dst,
>  					  (void *)msg->buf_pa, msg->size);
>  
>  		ret = xp_remote_memcpy(xp_pa(dst), msg->buf_pa, msg->size);
> @@ -218,7 +218,7 @@ xpnet_receive(short partid, int channel, struct xpnet_message *msg)
>  			 * !!! appears in_use and we can't just call
>  			 * !!! dev_kfree_skb.
>  			 */
> -			dev_err(xpnet, "xp_remote_memcpy(0x%p, 0x%p, 0x%hx) "
> +			dev_err(xpnet, "xp_remote_memcpy(0x%p, 0x%p, 0x%x) "
>  				"returned error=0x%x\n", dst,
>  				(void *)msg->buf_pa, msg->size, ret);
>  
> -- 
> 2.27.0
> 

-- 
Steve Wahl, Hewlett Packard Enterprise
