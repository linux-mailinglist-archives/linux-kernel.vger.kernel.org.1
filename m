Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697E7287404
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 14:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbgJHM0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 08:26:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50964 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbgJHM0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 08:26:05 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 098CDOY5070464;
        Thu, 8 Oct 2020 08:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=F6YNLjbioP23STXKrHevQ+ZvsAZ4k3gkBTwXy9hVr5A=;
 b=p4kPOMh5fRcQWZGt33o85ijs9vmZWScNreETxJbGtMfJRWiwUet8qWcE9fhUe/4I2ZWj
 OiWR/3YiXh+JDK3iimGmKBZQhfvM9/YyHqeSayqsNCl4OrG28gaic5jO/5NKPKaj14Nl
 RuR6L7kv1reyJl/VNzDtBFeiVmyJ86zqNYsjm5vsJ4pp/CpW6qS8jII+7dwHctoy/Wxb
 bq+hWucsgkIiMB5X4wGEAX/IyYhy0A1jaR8m3DlBUqNu0G9xcB8fX5BREifZQOy1QYBk
 J4ibIzs7AXVJaa5aguR6Ye5CK1fjD5xzLVRzh0ZvBvRn2/bvAvQbQpCJZHPrfXiqxqaO zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3422k10cr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 08:25:44 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 098CF4av075520;
        Thu, 8 Oct 2020 08:25:43 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3422k10cqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 08:25:43 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 098CBdYN021179;
        Thu, 8 Oct 2020 12:25:42 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02dal.us.ibm.com with ESMTP id 33xgxa0k5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 12:25:42 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 098CPf6E21102992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Oct 2020 12:25:41 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52E76C6059;
        Thu,  8 Oct 2020 12:25:41 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6FB8C605A;
        Thu,  8 Oct 2020 12:25:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.87.145])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  8 Oct 2020 12:25:36 +0000 (GMT)
Subject: Re: [PATCH] perf/core: Fix hung issue on perf stat command during cpu
 hotplug
To:     acme@kernel.org, peterz@infradead.org
Cc:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        daniel@iogearbox.net, brho@google.com, srikar@linux.vnet.ibm.com
References: <20200827064732.20860-1-kjain@linux.ibm.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <931cf8fd-79e9-3cbd-0943-63abea31ee8d@linux.ibm.com>
Date:   Thu, 8 Oct 2020 17:55:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200827064732.20860-1-kjain@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-08_07:2020-10-08,2020-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 clxscore=1011 bulkscore=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010080091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/27/20 12:17 PM, Kajol Jain wrote:
> Commit 2ed6edd33a21 ("perf: Add cond_resched() to task_function_call()")
> added assignment of ret value as -EAGAIN in case function
> call to 'smp_call_function_single' fails.
> For non-zero ret value, it did
> 'ret = !ret ? data.ret : -EAGAIN;', which always
> assign -EAGAIN to ret and make second if condition useless.
> 
> In scenarios like when executing a perf stat with --per-thread option, and
> if any of the monitoring cpu goes offline, the 'smp_call_function_single'
> function could return -ENXIO, and with the above check,
> task_function_call hung and increases CPU
> usage (because of repeated 'smp_call_function_single()')
> 
> Recration scenario:
> 	# perf stat -a --per-thread && (offline a CPU )
> 
> Patch here removes the tertiary condition added as part of that
> commit and added a check for NULL and -EAGAIN.

Hi Peter,
     Please let me know if you have any comment on this patch.

Thanks,
Kajol Jain
> 
> Fixes: 2ed6edd33a21("perf: Add cond_resched() to task_function_call()")
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Reviewed-by: Barret Rhoden <brho@google.com>
> Tested-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> ---
>  kernel/events/core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Changelog:
> - Remove RFC tag
> - Resolve some nits issues like space after if and
>   added -ENXIO in comment msg of function 'task_function_call'
>   as suggested by Barret Rhoden.
> 
> Link to the RFC: https://lkml.org/lkml/2020/8/26/896
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 5bfe8e3c6e44..cef646084198 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -99,7 +99,7 @@ static void remote_function(void *data)
>   * retry due to any failures in smp_call_function_single(), such as if the
>   * task_cpu() goes offline concurrently.
>   *
> - * returns @func return value or -ESRCH when the process isn't running
> + * returns @func return value or -ESRCH or -ENXIO when the process isn't running
>   */
>  static int
>  task_function_call(struct task_struct *p, remote_function_f func, void *info)
> @@ -115,7 +115,8 @@ task_function_call(struct task_struct *p, remote_function_f func, void *info)
>  	for (;;) {
>  		ret = smp_call_function_single(task_cpu(p), remote_function,
>  					       &data, 1);
> -		ret = !ret ? data.ret : -EAGAIN;
> +		if (!ret)
> +			ret = data.ret;
>  
>  		if (ret != -EAGAIN)
>  			break;
> 
