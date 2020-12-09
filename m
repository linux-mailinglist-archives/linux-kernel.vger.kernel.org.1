Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3512D3C76
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 08:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgLIHrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 02:47:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15082 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725953AbgLIHrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 02:47:03 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B97VrAo142055;
        Wed, 9 Dec 2020 02:46:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : cc : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HiZcqjVVSFZx3vpiETfcYEEZnCIcKPtoO7JExMeY5WU=;
 b=sgGtzGwUKrLdf4UwKMKwIdlFefutSN/jK7hNLjDuhqJVzSfMyvXoMdK+xoZg3NeC6EZO
 sHv4vs6SRVX/M+v9oQrYeJgAoiLn0Ae07M2ZLf43/xtKejrxGqRmCoBkQ4wjOCr0pupf
 BFWS5D7x7JyIpSrcxtwcFlHGse/d6whxJW1t3cOf6eyiN4PlNO/Jd8hQgwhkxagy1/+F
 GqzD24S3sLBwaBZoajK+s6oTGwG0j2xfLeTKekpqIJ5AMZtPvO1l9IZkvPZIjSMNxMVe
 HuOIrFkToan98dMcZ0V8YrBRG2K/0dgZVkqkbkUrw5yBMXCz/WK1xZHKewKGOBszyC8j aA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35afek8eku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Dec 2020 02:46:22 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B97X27i145889;
        Wed, 9 Dec 2020 02:46:21 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35afek8ejn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Dec 2020 02:46:21 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B97iV1e009710;
        Wed, 9 Dec 2020 07:46:19 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 3581fhj7ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Dec 2020 07:46:19 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B97kGBb3015324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Dec 2020 07:46:16 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C33442045;
        Wed,  9 Dec 2020 07:46:16 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5A9A4204C;
        Wed,  9 Dec 2020 07:46:15 +0000 (GMT)
Received: from funtu.home (unknown [9.145.62.115])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Dec 2020 07:46:15 +0000 (GMT)
Subject: Re: [PATCH 1/1] crypto: Fix possible buffer overflows in
 pkey_protkey_aes_attr_read
To:     Xiaohui Zhang <ruc_zhangxiaohui@163.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201209064714.33380-1-ruc_zhangxiaohui@163.com>
From:   Harald Freudenberger <freude@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <601cf44e-1de4-4550-2bad-8087092bd010@linux.ibm.com>
Date:   Wed, 9 Dec 2020 08:46:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201209064714.33380-1-ruc_zhangxiaohui@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-09_06:2020-12-08,2020-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090048
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.12.20 07:47, Xiaohui Zhang wrote:
> From: Zhang Xiaohui <ruc_zhangxiaohui@163.com>
>
> pkey_protkey_aes_attr_read() calls memcpy() without checking the
> destination size may trigger a buffer overflower.
>
> Signed-off-by: Zhang Xiaohui <ruc_zhangxiaohui@163.com>
> ---
>  drivers/s390/crypto/pkey_api.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
> index 99cb60ea6..abc237130 100644
> --- a/drivers/s390/crypto/pkey_api.c
> +++ b/drivers/s390/crypto/pkey_api.c
> @@ -1589,6 +1589,8 @@ static ssize_t pkey_protkey_aes_attr_read(u32 keytype, bool is_xts, char *buf,
>  	if (rc)
>  		return rc;
>  
> +	if (protkey.len > MAXPROTKEYSIZE)
> +		protkey.len = MAXPROTKEYSIZE;
>  	protkeytoken.len = protkey.len;
>  	memcpy(&protkeytoken.protkey, &protkey.protkey, protkey.len);
>  
> @@ -1599,6 +1601,8 @@ static ssize_t pkey_protkey_aes_attr_read(u32 keytype, bool is_xts, char *buf,
>  		if (rc)
>  			return rc;
>  
> +		if (protkey.len > MAXPROTKEYSIZE)
> +			protkey.len = MAXPROTKEYSIZE;
>  		protkeytoken.len = protkey.len;
>  		memcpy(&protkeytoken.protkey, &protkey.protkey, protkey.len);
>  
Thanks Xiaohui
but one rule within the kernel is to trust the other internal functions to do the right thing.
So usually only on entrance into the kernel the api parameters are checked but within the
kernel each function trusts the other and no further parameter check is done. Otherwise
endless checks of input parameters would take place which is killing the performance.
As you can see the protkey object is stored by the function pkey_genprotkey() which is
called just 2 lines above. An internal function the module should trust here. I don't think
there is an additional length check needed here.
However, Thanks for your contribution.
Harald Freudenberger
see this function calls another function in the very same file and
