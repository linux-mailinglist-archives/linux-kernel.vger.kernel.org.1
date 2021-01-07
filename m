Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE40B2ED597
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 18:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbhAGR2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 12:28:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727959AbhAGR23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 12:28:29 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 107H8PxE069192;
        Thu, 7 Jan 2021 12:27:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=SFJ0drAgUkEw+VFOj0hRumM7RsaV232r2ZUNTrGEgnQ=;
 b=cnz+hdVABrM4TbTaaJl+oxp2ArIk+MilWUVC7SV9KAUHvzl75KrNQYRt3owBfO8BBkGu
 ynWdafyeqG5lQ68QaDDwZIAjGXTYd+CQK5V4lDViYFAGtLxkNtFI/QjX6id00EbFW1DD
 DDf7u2yX3/xdTyn53EntvN/ShqJI8NH+QkHw9Lq28u3MSeeyI9iZ0/I1PE0BWx7VUFoH
 B17ypHOdt4hnw+k5/sgyRHK3bqFn8QsefuC3VY76LeiUbXy4LclK4Dd1mfKnz8wZWdNr
 cjsWP6B+BQ62mOjWW2F6MJ4/5bOYIwLfJHA/f2+zFXnTNy5tdj2jL7kE6KrIIl7qmS/l Gg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35x5juj0fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jan 2021 12:27:37 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 107HBtHI025311;
        Thu, 7 Jan 2021 17:27:35 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 35wd379724-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jan 2021 17:27:35 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 107HRXrf32637436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jan 2021 17:27:33 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 861DF11C052;
        Thu,  7 Jan 2021 17:27:33 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F57111C050;
        Thu,  7 Jan 2021 17:27:33 +0000 (GMT)
Received: from [9.145.66.183] (unknown [9.145.66.183])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jan 2021 17:27:33 +0000 (GMT)
Subject: Re: [PATCH -next] s390: cio: Use DEFINE_SPINLOCK() for spinlock
To:     Zheng Yongjun <zhengyongjun3@huawei.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201223141512.1178-1-zhengyongjun3@huawei.com>
From:   Julian Wiedmann <jwi@linux.ibm.com>
Message-ID: <3aed4509-a903-5b26-3667-ad420b1bbb7b@linux.ibm.com>
Date:   Thu, 7 Jan 2021 18:27:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201223141512.1178-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-07_07:2021-01-07,2021-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101070100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.12.20 15:15, Zheng Yongjun wrote:
> spinlock can be initialized automatically with DEFINE_SPINLOCK()
> rather than explicitly calling spin_lock_init().
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/s390/cio/css.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
> index cca1a7c4bb33..022f573f0bcc 100644
> --- a/drivers/s390/cio/css.c
> +++ b/drivers/s390/cio/css.c
> @@ -647,13 +647,12 @@ static void css_sch_todo(struct work_struct *work)
>  }
>  
>  static struct idset *slow_subchannel_set;
> -static spinlock_t slow_subchannel_lock;
> +static DEFINE_SPINLOCK(slow_subchannel_lock);
>  static wait_queue_head_t css_eval_wq;
>  static atomic_t css_eval_scheduled;
>  
>  static int __init slow_subchannel_init(void)
>  {
> -	spin_lock_init(&slow_subchannel_lock);


>  	atomic_set(&css_eval_scheduled, 0);
>  	init_waitqueue_head(&css_eval_wq);

Mind turning these two into static initializations as well? Thanks.


>  	slow_subchannel_set = idset_sch_new();
> 
