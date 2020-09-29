Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8544727BEB3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgI2IBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:01:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53640 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgI2IBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:01:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08T7sSxD021216;
        Tue, 29 Sep 2020 08:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=fS3sbliVrTas/8VSegnyz4QBH86Z2DLuW1uqKlImwtk=;
 b=UKijo+cC2Ku0I41FnXqYiG8QlG6AwNpBQ/Erc9zLcjBZGWNhbgxCm0+ucWSWKzpbPXtt
 GrxbAYQyEGYeSpH58fSaPYTyL65vfHFLDYTpXxwgnXWFKfZufAID8F7oe85BAWZRsRbu
 su/DZdwoqs35cxASqaxTz7L6fi8eT9cvr3ST5+h61hrlVn/jJcmshxTiNnmnP4qHmrpa
 i1FcEmLZ+4Z3eOv682d6JU5oWdBPSdRnnayegXR7VFq37tt3J1ywh+L+vtCa7zgSwueO
 hS3FhbZK6Td62Gq2TaWs+NtzC1nTOCWodznJ4DbEW1sA458h/bAKkp/WN3piYpKqkwWY xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33swkks40t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Sep 2020 08:01:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08T7uPbb185869;
        Tue, 29 Sep 2020 08:01:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 33tfhx8dwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Sep 2020 08:01:15 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08T81Er7000851;
        Tue, 29 Sep 2020 08:01:14 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Sep 2020 01:01:13 -0700
Date:   Tue, 29 Sep 2020 11:01:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     mchehab+huawei@kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: mfd: hi6421-spmi-pmic: Fix error return in
 hi6421_spmi_pmic_probe()
Message-ID: <20200929080107.GX4282@kadam>
References: <20200929074847.47124-1-jingxiangfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929074847.47124-1-jingxiangfeng@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9758 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290073
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9758 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290073
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 03:48:47PM +0800, Jing Xiangfeng wrote:
> Fix to return error code -ENOMEM from the error handling case instead
> of 0.
> 
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> ---
>  drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
> index 64b30d263c8d..4f34a5282970 100644
> --- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
> +++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
> @@ -262,8 +262,10 @@ static int hi6421_spmi_pmic_probe(struct spmi_device *pdev)
>  	hi6421_spmi_pmic_irq_prc(pmic);
>  
>  	pmic->irqs = devm_kzalloc(dev, HISI_IRQ_NUM * sizeof(int), GFP_KERNEL);
> -	if (!pmic->irqs)
> +	if (!pmic->irqs) {
> +		ret = -ENOMEM;
>  		goto irq_malloc;

It shouldn't do a goto, it should just return directly.  The goto
releases an IRQ which isn't acquired until later in the function.

regards,
dan carpenter

