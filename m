Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379D9272A4B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 17:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbgIUPfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 11:35:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48258 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726611AbgIUPfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 11:35:02 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08LFW5AR065829;
        Mon, 21 Sep 2020 11:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=eOuvleoisJLOkfYrr6Wvhr73JMHk+mzZFLo3r3/rWr4=;
 b=WdGI3zK/c0E1ppXDH4DtIKE2zjXpjdGbWjCU59mI8AYUqlWJmMLs59GJfMs1ceH19J76
 TbGZfJY3Rsw8mRMnVqmzXnzbNfYjkVnuS2vsz62OomaBzyuSmqcWTTe9N5LmsDbhorfI
 v+8AfSVoMJ3J5zl+1Y5m1eijZZl/Em86wCylQdcjqxlxprth9xsExitCP29lwYIHeMCg
 BtEkLuxPG2Rr6BCz8+eKECd2oveK/dq2H+5NVvCHMTupp84wCEWGxC4Xf1lDwRBBoN//
 wIaZA1l+0VOOIATsDpN9XI9yvkpjoy3bdyy0iAQkfOZltfw7tXH9V8HTx5jNIOr7CFIN xg== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33pxw902ss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 11:34:39 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08LFUJqZ002660;
        Mon, 21 Sep 2020 15:34:37 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 33n9m7s4dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 15:34:37 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08LFYZlS32113026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Sep 2020 15:34:35 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AF094C046;
        Mon, 21 Sep 2020 15:34:35 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D85F54C04A;
        Mon, 21 Sep 2020 15:34:34 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.187.68])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 21 Sep 2020 15:34:34 +0000 (GMT)
Subject: Re: [PATCH -next] ocxl: simplify the return expression of
 free_function_dev()
To:     Qinglang Miao <miaoqinglang@huawei.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20200921131047.92526-1-miaoqinglang@huawei.com>
From:   Frederic Barrat <fbarrat@linux.ibm.com>
Message-ID: <0dbda6be-6b5f-aeb7-76fa-39c5637fd758@linux.ibm.com>
Date:   Mon, 21 Sep 2020 17:34:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200921131047.92526-1-miaoqinglang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-21_05:2020-09-21,2020-09-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 priorityscore=1501 adultscore=0 clxscore=1011 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=2 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009210110
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 21/09/2020 à 15:10, Qinglang Miao a écrit :
> Simplify the return expression.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---


Thanks!
Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>


>   drivers/misc/ocxl/core.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/misc/ocxl/core.c b/drivers/misc/ocxl/core.c
> index b7a09b21a..aebfc53a2 100644
> --- a/drivers/misc/ocxl/core.c
> +++ b/drivers/misc/ocxl/core.c
> @@ -327,14 +327,9 @@ static void free_function_dev(struct device *dev)
>   
>   static int set_function_device(struct ocxl_fn *fn, struct pci_dev *dev)
>   {
> -	int rc;
> -
>   	fn->dev.parent = &dev->dev;
>   	fn->dev.release = free_function_dev;
> -	rc = dev_set_name(&fn->dev, "ocxlfn.%s", dev_name(&dev->dev));
> -	if (rc)
> -		return rc;
> -	return 0;
> +	return dev_set_name(&fn->dev, "ocxlfn.%s", dev_name(&dev->dev));
>   }
>   
>   static int assign_function_actag(struct ocxl_fn *fn)
> 
