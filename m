Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412D12CB8E6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 10:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgLBJbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:31:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14350 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725933AbgLBJbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:31:48 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B2974ev057931;
        Wed, 2 Dec 2020 04:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XxaPJFdIMj03wiPkR94xduSAaB2Nr3+hESgg+Js918I=;
 b=RL02g1YOxSjCr4wSPyEGoYBByVqulNtwJPG7TvyI50l5dMDI4eGqi/RuaRP+GwJDHdU5
 3cIdypr48Ufd4f1gQ6gfvC7rK7knFNBHGpSadeoMGnz28C733exKB2O3A0nz9yhRN7+l
 1hIuJl/FyPdQ+q8gmKHoYvjC0jNa14FR36/bzF+WuBT4oQ9UkVrbCmQXNVM6tzAh8B4G
 2Az+GkB6wvyoPQa+aT9PUbn87F3eZxwauFVwCXydOXBqGgOmOeJlG02OY0L3wwz6DhO8
 SZP16aq8+GRw+bfWhjaGQEk1F1tWOCOBnCY5+0Rsrn/e4Rq4zSCpxFBEX4bkXgoRPTv8 FQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3567ypgmy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 04:30:58 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B29E0nn084120;
        Wed, 2 Dec 2020 04:30:58 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3567ypgmxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 04:30:58 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B29RnEJ028901;
        Wed, 2 Dec 2020 09:30:56 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 353e6842e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 09:30:56 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B29Urlm5505728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Dec 2020 09:30:53 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45D694C040;
        Wed,  2 Dec 2020 09:30:53 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5F274C044;
        Wed,  2 Dec 2020 09:30:52 +0000 (GMT)
Received: from oc6887364776.ibm.com (unknown [9.145.74.189])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Dec 2020 09:30:52 +0000 (GMT)
Subject: Re: [PATCH] s390: cio: fix use-after-free in
 ccw_device_destroy_console
To:     Qinglang Miao <miaoqinglang@huawei.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201201063150.82128-1-miaoqinglang@huawei.com>
From:   Vineeth Vijayan <vneethv@linux.vnet.ibm.com>
Message-ID: <5081f172-32e6-dda5-4937-4d5c70e7f660@linux.vnet.ibm.com>
Date:   Wed, 2 Dec 2020 10:30:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201201063150.82128-1-miaoqinglang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-02_01:2020-11-30,2020-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=2 phishscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 adultscore=0 clxscore=1011 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you.With a very minor modification in the commit-message,

Reviewed-by: Vineeth Vijayan <vneethv@linux.ibm.com>

I will push this and Vasliy/Heiko will take this up for the next 
s390-tree upstream-release.


On 12/1/20 7:31 AM, Qinglang Miao wrote:
> put_device calls release function which do kfree() inside.
> So following use of sch&cdev would cause use-after-free bugs.
>
> Fix these by simply adjusting the position of put_device.

Modified the commit-message as below. Just for the clarification.

--

Use of sch->dev reference after the put_device() call could trigger
the use-after-free bugs.

Fix this by simply adjusting the position of put_device.
--
>
> Fixes: 37db8985b211 ("s390/cio: add basic protected virtualization support")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Suggested-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>   This patch is indeed a v2 of older one. Considering that the
>   patch's name has changed, I think a normal prefix 'PATCH' is
>   better.
>
>   drivers/s390/cio/device.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
> index b29fe8d50..33280ca18 100644
> --- a/drivers/s390/cio/device.c
> +++ b/drivers/s390/cio/device.c
> @@ -1664,10 +1664,10 @@ void __init ccw_device_destroy_console(struct ccw_device *cdev)
>   	struct io_subchannel_private *io_priv = to_io_private(sch);
>   
>   	set_io_private(sch, NULL);
> -	put_device(&sch->dev);
> -	put_device(&cdev->dev);
>   	dma_free_coherent(&sch->dev, sizeof(*io_priv->dma_area),
>   			  io_priv->dma_area, io_priv->dma_area_dma);
> +	put_device(&sch->dev);
> +	put_device(&cdev->dev);
>   	kfree(io_priv);
>   }
>   
