Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1A22DA027
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 20:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408563AbgLNTSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 14:18:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2342 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408255AbgLNTR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 14:17:29 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BEJ29Gv134912;
        Mon, 14 Dec 2020 14:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=8TNoTTpphjYGasZ0TVSUKL0xTPzkNq3PU6nTofzyAac=;
 b=F3ODhpMNZOboqCQ7ZUVlahagVlqrcjd0lXzohj8iHUUXBXbDrfF4q19gFeZe4gW5Opzz
 FI6fKr4pGEix0xUATL1HpSZxVN2xGXOjGkeHHmy9c13CPBEJSM+lsf41Yf82sXfVx56I
 YR2iMG0wZHQVboBk0hNa/MWuNpfGVchejFlN93b9RIIBFyXzAmCk5kdqlZ8z4DHzf7KT
 t7V5m0Tt8bkqNy0jgnDX+IMEfp5+TaS6VEC5ijcjevkeT30gd4IJn2XnCebDBJa0N3xx
 sXSEmjiUlrSJNxxlnoYLeT65atPHdpcM3QNNo5Jvyg/4xMWQ1rcvHJ7IqE+DfUxpFN9R 8g== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35ea250jmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Dec 2020 14:16:43 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BEJD0v5001215;
        Mon, 14 Dec 2020 19:16:41 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 35cng89974-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Dec 2020 19:16:41 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BEJGdNb34472382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Dec 2020 19:16:39 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F7B74203F;
        Mon, 14 Dec 2020 19:16:39 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F088442042;
        Mon, 14 Dec 2020 19:16:38 +0000 (GMT)
Received: from funtu.home (unknown [9.145.22.106])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Dec 2020 19:16:38 +0000 (GMT)
Subject: Re: [PATCH -next] s390/crypto/zcrypt_cex4: convert comma to semicolon
To:     Zheng Yongjun <zhengyongjun3@huawei.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201214134341.4671-1-zhengyongjun3@huawei.com>
From:   Harald Freudenberger <freude@linux.ibm.com>
Message-ID: <b3da0c24-056a-7975-07b8-7096cd7f26b7@linux.ibm.com>
Date:   Mon, 14 Dec 2020 20:16:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201214134341.4671-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-14_09:2020-12-11,2020-12-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012140121
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

applied to the s390 subsystem. This will go upstream with the next kernel merge window.
Thanks

On 14.12.20 14:43, Zheng Yongjun wrote:
> Replace a comma between expression statements by a semicolon.
>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/s390/crypto/zcrypt_cex4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/s390/crypto/zcrypt_cex4.c b/drivers/s390/crypto/zcrypt_cex4.c
> index f5195bca1d85..f4a6d3744241 100644
> --- a/drivers/s390/crypto/zcrypt_cex4.c
> +++ b/drivers/s390/crypto/zcrypt_cex4.c
> @@ -631,7 +631,7 @@ static int zcrypt_cex4_queue_probe(struct ap_device *ap_dev)
>  	atomic_set(&zq->load, 0);
>  	ap_queue_init_state(aq);
>  	ap_queue_init_reply(aq, &zq->reply);
> -	aq->request_timeout = CEX4_CLEANUP_TIME,
> +	aq->request_timeout = CEX4_CLEANUP_TIME;
>  	aq->private = zq;
>  	rc = zcrypt_queue_register(zq);
>  	if (rc) {
