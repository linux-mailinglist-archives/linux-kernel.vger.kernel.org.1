Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1654C2AB220
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 09:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbgKIIFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 03:05:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20640 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727077AbgKIIFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 03:05:41 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A982iCk189398;
        Mon, 9 Nov 2020 03:05:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=87J1wDOc2xZ/H1t8T4gbnWyj4rUKf8mWcUi8PTJ/KRA=;
 b=XVdKQBOm4KkUPbDVENWCZMoHFzMEq4YP883AkxRO4BmJ56b5dZ681s6JSF/rFUUQ1yp7
 0m8UxYUmHbXncEEgBhZzclRFziUeMtyUzNNc3L/SE9w4pIKdN9t0Lz137U4e+kYDH9e+
 QBZQHh9qH5k2VzEKBHXbicr5PXyKh5IptuYt+0Lq5f76UjyEMyPHvt1WSiQvVP7BxPX6
 0LOCMVWTnCrIW1n+NbqsHKSW2eqkSteLTCijbN6lca0MnGEC/saPEt/n0njB+nZUN/+q
 Fvrt1PY/l04666Hzsci4R/PA8bBo0qgVAkyBCDFD+6QUh92KtbBH5ZOa6AkYGJle4MyY WQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34p9gt9c2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Nov 2020 03:05:23 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A9840lX196133;
        Mon, 9 Nov 2020 03:05:22 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34p9gt9c1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Nov 2020 03:05:22 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A982KG6006612;
        Mon, 9 Nov 2020 08:05:19 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 34nk78htb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Nov 2020 08:05:19 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A985G1L57934198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Nov 2020 08:05:16 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75D644205E;
        Mon,  9 Nov 2020 08:05:16 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE3F142076;
        Mon,  9 Nov 2020 08:05:15 +0000 (GMT)
Received: from [9.145.159.20] (unknown [9.145.159.20])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  9 Nov 2020 08:05:15 +0000 (GMT)
Subject: Re: [PATCH] s390/qeth: remove useless if/else
To:     xiakaixu1987@gmail.com, hca@linux.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
References: <1604817287-11258-1-git-send-email-kaixuxia@tencent.com>
From:   Julian Wiedmann <jwi@linux.ibm.com>
Message-ID: <8390c0e9-d91c-91ff-11d0-4fe0b01a4722@linux.ibm.com>
Date:   Mon, 9 Nov 2020 10:05:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1604817287-11258-1-git-send-email-kaixuxia@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-09_02:2020-11-05,2020-11-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 phishscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011090050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.11.20 08:34, xiakaixu1987@gmail.com wrote:
> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> Fix the following coccinelle report:
> 
> ./drivers/s390/net/qeth_l3_main.c:107:2-4: WARNING: possible condition with no effect (if == else)
> 
> Both branches are the same, so remove them.
> 

Indeed, missed that in commit
ab29c480b194 ("s390/qeth: replace deprecated simple_stroul()")

Applied, thanks!

> Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> ---
>  drivers/s390/net/qeth_l3_main.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
> index b1c1d2510d55..264b6c782382 100644
> --- a/drivers/s390/net/qeth_l3_main.c
> +++ b/drivers/s390/net/qeth_l3_main.c
> @@ -104,10 +104,7 @@ static bool qeth_l3_is_addr_covered_by_ipato(struct qeth_card *card,
>  		qeth_l3_convert_addr_to_bits(ipatoe->addr, ipatoe_bits,
>  					  (ipatoe->proto == QETH_PROT_IPV4) ?
>  					  4 : 16);
> -		if (addr->proto == QETH_PROT_IPV4)
> -			rc = !memcmp(addr_bits, ipatoe_bits, ipatoe->mask_bits);
> -		else
> -			rc = !memcmp(addr_bits, ipatoe_bits, ipatoe->mask_bits);
> +		rc = !memcmp(addr_bits, ipatoe_bits, ipatoe->mask_bits);
>  		if (rc)
>  			break;
>  	}
> 

