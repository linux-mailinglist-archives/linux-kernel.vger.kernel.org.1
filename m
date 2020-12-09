Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F152D3BB7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 07:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgLIGzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 01:55:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26580 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728030AbgLIGzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 01:55:09 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B96XEpJ069636;
        Wed, 9 Dec 2020 01:54:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=WdX3L/WSQdO5P0ctdus2bU5+lEs5bSrzR+Pktb9wal8=;
 b=TrqRg24Tb0jAr4qlgzOcIOpJ9gOuqJoiN8s2yp82GK2VA7ZDWgIy6U4YDE7AiU/tTU2a
 fZdrlP1leZZR1dHIXbho3rcBO/wk4VPsdSHwhQ8o65ytshdmkl+Ljg58+9I2AUREL026
 NvJvpXksUnfX59AoXn/nx4J9JFBRNvOa+jFc462qPkom3RtOc8nDJYkNr8tDVT+F1hb3
 hjSiANsryTBjlqzNxNbQqgkZS5YMD8mphxiMDESfs1kNAT1kgQybp0THEqiyZ65cRZic
 2uLjhdjFIk3fT3JlQXUL9wgEoJFd7PtOy06YF1Mc25SmzvC1DcT/DyIAlUwwPgB/34zc MA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35aqjytwge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Dec 2020 01:54:28 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B96XY1D073602;
        Wed, 9 Dec 2020 01:54:28 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35aqjytwfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Dec 2020 01:54:28 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B96lQic030048;
        Wed, 9 Dec 2020 06:54:26 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 3581fhj78c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Dec 2020 06:54:26 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B96sNM211535042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Dec 2020 06:54:23 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 174A011C04C;
        Wed,  9 Dec 2020 06:54:23 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B02F211C050;
        Wed,  9 Dec 2020 06:54:22 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.171.15.225])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Dec 2020 06:54:22 +0000 (GMT)
Subject: Re: [PATCH 1/1] crypto: Fix possible buffer overflows in
 pkey_protkey_aes_attr_read
To:     Xiaohui Zhang <ruc_zhangxiaohui@163.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201209064714.33380-1-ruc_zhangxiaohui@163.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <04b376ce-bb1c-f7ff-a41a-8905badd9dba@de.ibm.com>
Date:   Wed, 9 Dec 2020 07:54:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201209064714.33380-1-ruc_zhangxiaohui@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-09_06:2020-12-08,2020-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09.12.20 07:47, Xiaohui Zhang wrote:
> From: Zhang Xiaohui <ruc_zhangxiaohui@163.com>
> 
> pkey_protkey_aes_attr_read() calls memcpy() without checking the
> destination size may trigger a buffer overflower.

To me it looks like protkey.len is generated programmatically in pkey_genprotkey/pkey_clr2protkey
and this purely depends on the keytype and we do check for known ones.
Not sure how this can happen.

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
> 
