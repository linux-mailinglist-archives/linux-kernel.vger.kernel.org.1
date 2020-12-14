Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B22D2DA029
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 20:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408609AbgLNTSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 14:18:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2395515AbgLNTSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 14:18:06 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BEJ401a139997;
        Mon, 14 Dec 2020 14:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=WrOwBoFCwI3SA55EGJncCQLR8+cLdeS5UZBeJeSdkKw=;
 b=hXU24HNZYhJVo5ZydCgzW92kTU9c+GvVdNu8hRLyg1whjO/lKJnEKE0QsbiGLsKemeJ9
 +9XzA2Nc30qwc1vZ6C77EskX8BqHyFhBtfAKQHopQGvFiBADvylYRM/QBuL5aZYOaLGR
 nQwJzGgmN4+jjhYUXVbZjekILGDYs1SNr2bGrt6GOQyywxernOoXO4fELbx+6hS8bICq
 BtqIdjxrw+/KVahZvx7BsfT5YYFv/Wjf9Q0qwHNN5bCTwcXbNts/kZ0/4v8FEtgHWal/
 uRXF8Cf4p6OeBIQFD61T95qX++qUeylr8LVy1UhWMGIeK14jlYvdLVbblPSzYKLqV++8 0Q== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35ectuj3t1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Dec 2020 14:17:17 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BEJBo2Y028456;
        Mon, 14 Dec 2020 19:17:15 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 35cng8aew4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Dec 2020 19:17:15 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BEJHDXX32571844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Dec 2020 19:17:13 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F21942045;
        Mon, 14 Dec 2020 19:17:13 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3088A42042;
        Mon, 14 Dec 2020 19:17:13 +0000 (GMT)
Received: from funtu.home (unknown [9.145.22.106])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Dec 2020 19:17:13 +0000 (GMT)
Subject: Re: [PATCH -next] s390/crypto/zcrypt_cex2a: convert comma to
 semicolon
To:     Zheng Yongjun <zhengyongjun3@huawei.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201214134403.4723-1-zhengyongjun3@huawei.com>
From:   Harald Freudenberger <freude@linux.ibm.com>
Message-ID: <3012ad5b-d667-2d27-9c4c-93742f25d1e3@linux.ibm.com>
Date:   Mon, 14 Dec 2020 20:17:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201214134403.4723-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-14_10:2020-12-11,2020-12-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012140125
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

applied to the s390 subsystem. This will go upstream with the next kernel merge window.
Thanks

On 14.12.20 14:44, Zheng Yongjun wrote:
> Replace a comma between expression statements by a semicolon.
>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/s390/crypto/zcrypt_cex2a.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/s390/crypto/zcrypt_cex2a.c b/drivers/s390/crypto/zcrypt_cex2a.c
> index 226a5612e855..62ceeb7fc125 100644
> --- a/drivers/s390/crypto/zcrypt_cex2a.c
> +++ b/drivers/s390/crypto/zcrypt_cex2a.c
> @@ -175,7 +175,7 @@ static int zcrypt_cex2a_queue_probe(struct ap_device *ap_dev)
>  	atomic_set(&zq->load, 0);
>  	ap_queue_init_state(aq);
>  	ap_queue_init_reply(aq, &zq->reply);
> -	aq->request_timeout = CEX2A_CLEANUP_TIME,
> +	aq->request_timeout = CEX2A_CLEANUP_TIME;
>  	aq->private = zq;
>  	rc = zcrypt_queue_register(zq);
>  	if (rc) {
