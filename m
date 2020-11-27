Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4102A2C67B3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 15:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730792AbgK0OS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 09:18:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15726 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730635AbgK0OS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 09:18:58 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ARDVi6R017731;
        Fri, 27 Nov 2020 09:18:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=dUmvWqDzi1ZABRhpZlOITmoAbYPRf4UOUowQy1Jn18E=;
 b=Pd8k7OskiyLL5V7jQVJ8zyc4pw0sigN5MUPtXj9CFHlbH8uNB43uD+yjuWLtoBuxDbFY
 zrOuoX4yolJJoeE/zZ7sI+hoZHPT3g7SJfLsNb3lSt2uyvzw5ZQc8fUMLDm7XXg4Er4Y
 aKwNI3eML2zdgf/hHS5b3KPixh3bSHvxmfmPKyIjPZrKjk5UR5GAiUQ9hnIcV+2uDJgc
 f+PuTU648lYrRbK+xajY1Tl9h5qXn3IF1LnWyXGuG3JTO6qU9G0if5P9EwomBJxi1szE
 34iGazyYNC6IIFMWpKyl4Si9+opZ4N67jiNDrN5kL4wNqXcx7hyWuNmMcO1sbeft2ssa 6w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35304w4qqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Nov 2020 09:18:56 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0ARDWFWM019902;
        Fri, 27 Nov 2020 09:18:56 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35304w4qqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Nov 2020 09:18:56 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AREIH93008214;
        Fri, 27 Nov 2020 14:18:54 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 352jgsh2ud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Nov 2020 14:18:54 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AREHbZM8651480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Nov 2020 14:17:37 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0027611C05B;
        Fri, 27 Nov 2020 14:17:37 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE53F11C04A;
        Fri, 27 Nov 2020 14:17:36 +0000 (GMT)
Received: from oc4120165700.ibm.com (unknown [9.145.71.148])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 27 Nov 2020 14:17:36 +0000 (GMT)
Subject: Re: [PATCH] scsi: zfcp: fix indentation coding style issue
To:     Yevhen Viktorov <yevhen.viktorov@virginmedia.com>
Cc:     bblock@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201127130646.11427-1-yevhen.viktorov@virginmedia.com>
From:   Steffen Maier <maier@linux.ibm.com>
Message-ID: <5e866838-9b62-f1fe-d2a5-70c0df232857@linux.ibm.com>
Date:   Fri, 27 Nov 2020 15:17:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201127130646.11427-1-yevhen.viktorov@virginmedia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-27_06:2020-11-26,2020-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011270078
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, will queue it for our next cleanup submission.

On 11/27/20 2:06 PM, Yevhen Viktorov wrote:
> code indent should use tabs where possible
> 
> Signed-off-by: Yevhen Viktorov <yevhen.viktorov@virginmedia.com>
> ---
>   drivers/s390/scsi/zfcp_def.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/s390/scsi/zfcp_def.h b/drivers/s390/scsi/zfcp_def.h
> index da8a5ceb615c..a2a59cbb330a 100644
> --- a/drivers/s390/scsi/zfcp_def.h
> +++ b/drivers/s390/scsi/zfcp_def.h
> @@ -157,7 +157,7 @@ struct zfcp_adapter {
>   	u32			fsf_lic_version;
>   	u32			adapter_features;  /* FCP channel features */
>   	u32			connection_features; /* host connection features */
> -        u32			hardware_version;  /* of FCP channel */
> +	u32			hardware_version;  /* of FCP channel */
>   	u32			fc_security_algorithms; /* of FCP channel */
>   	u32			fc_security_algorithms_old; /* of FCP channel */
>   	u16			timer_ticks;       /* time int for a tick */
> @@ -181,7 +181,7 @@ struct zfcp_adapter {
>   	rwlock_t		erp_lock;
>   	wait_queue_head_t	erp_done_wqh;
>   	struct zfcp_erp_action	erp_action;	   /* pending error recovery */
> -        atomic_t                erp_counter;
> +	atomic_t                erp_counter;
>   	u32			erp_total_count;   /* total nr of enqueued erp
>   						      actions */
>   	u32			erp_low_mem_count; /* nr of erp actions waiting
> @@ -217,7 +217,7 @@ struct zfcp_port {
>   	u32		       d_id;	       /* D_ID */
>   	u32		       handle;	       /* handle assigned by FSF */
>   	struct zfcp_erp_action erp_action;     /* pending error recovery */
> -        atomic_t               erp_counter;
> +	atomic_t               erp_counter;
>   	u32                    maxframe_size;
>   	u32                    supported_classes;
>   	u32                    connection_info;
> 


-- 
Mit freundlichen Gruessen / Kind regards
Steffen Maier

Linux on IBM Z Development

https://www.ibm.com/privacy/us/en/
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
