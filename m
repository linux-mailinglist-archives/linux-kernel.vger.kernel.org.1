Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA01C299FAE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 01:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441483AbgJ0AYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 20:24:00 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47558 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441474AbgJ0AX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 20:23:57 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09R0FbBB078392;
        Tue, 27 Oct 2020 00:23:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=uRAj/oUYU6Qz08rcDbzfHpSL0p2/DhZAjTpOfARCJQw=;
 b=GfZl03HzSCgWF0Lo8+RjVohok+486IHirPaWiPb9ggCRw8nVKkUSMRC31G/DM2MPM06z
 3qUEpaUcpwboKaU1KcVN/WiffziCZqSLeem4OL6KtdO2jXncKXESIpQXp3rTP+qJ1dc9
 oeQIBuyozcp7kA7Uc9bVXY3IQ2BwtQqscRgBV1+VXpGYn2C+bl9AwMlVW5HVn5Mj+b8W
 8CJABqpXU/93b3IebV2iSBeMOc2QMzQBTrC9w/bMTnKutqTX8XlAoCu+6qlRMAITiQvs
 mcWqrhp01Nv/69UhAdS6PCoDyXR9sflVKWC6x0tzI9O6n1lo9eZqPFTBZu2NFiu2963b iA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 34c9saqfq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Oct 2020 00:23:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09R0G0as025472;
        Tue, 27 Oct 2020 00:23:45 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 34cx5wgp8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Oct 2020 00:23:45 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09R0NihM030423;
        Tue, 27 Oct 2020 00:23:44 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Oct 2020 17:23:44 -0700
Subject: Re: [PATCH] mm/hugetable.c: align some prints
To:     Hui Su <sh_def@163.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20201009162359.GA19686@rlk>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <cf3e63c8-836c-1112-c7da-ae375ac43b65@oracle.com>
Date:   Mon, 26 Oct 2020 17:23:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20201009162359.GA19686@rlk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=2 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010270000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011 suspectscore=2
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010270000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/20 9:23 AM, Hui Su wrote:
> in old code, it shows like:
> Node 0 ShmemHugePages:        0 kB
> Node 0 ShmemPmdMapped:        0 kB
> Node 0 FileHugePages:        0 kB
> Node 0 FilePmdMapped:        0 kB
> Node 0 HugePages_Total:     0
> Node 0 HugePages_Free:      0
> Node 0 HugePages_Surp:      0
> 
> which is not align. So we align it.
> 
> Signed-off-by: Hui Su <sh_def@163.com>

Apologies for the late reply.

I assume you you just want to make the output look better.  Correct?

To be honest, I am not sure about the policy for changing the output
of sysfs files.  My preference would be to not change the output.  Why?
When the output is changed there is always the possibility that someone
may have written code that depends on the current format.  It looks like
the output has been misaligned since the day the code was first written.

This code was recently changed to use sysfs_emit_at() instead of
sprintf().  At that time Greg noted that this also violates the sysfs
rule of one value per file.  So, it appears there may be a bigger issue
than alignment.

Greg,
Is it OK to break up these sysfs files to be one value per file if they
contained multiple values from day 1 of their existence?  I would prefer
not to touch them in case some is depending on current format.

-- 
Mike Kravetz

> ---
>  drivers/base/node.c | 4 ++--
>  mm/hugetlb.c        | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 50af16e68d98..b5453c372c5b 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -430,8 +430,8 @@ static ssize_t node_read_meminfo(struct device *dev,
>  		       "Node %d AnonHugePages:  %8lu kB\n"
>  		       "Node %d ShmemHugePages: %8lu kB\n"
>  		       "Node %d ShmemPmdMapped: %8lu kB\n"
> -		       "Node %d FileHugePages: %8lu kB\n"
> -		       "Node %d FilePmdMapped: %8lu kB\n"
> +		       "Node %d FileHugePages:  %8lu kB\n"
> +		       "Node %d FilePmdMapped:  %8lu kB\n"
>  #endif
>  			,
>  		       nid, K(node_page_state(pgdat, NR_FILE_DIRTY)),
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 67fc6383995b..077860ea2452 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3588,9 +3588,9 @@ int hugetlb_report_node_meminfo(int nid, char *buf)
>  	if (!hugepages_supported())
>  		return 0;
>  	return sprintf(buf,
> -		"Node %d HugePages_Total: %5u\n"
> -		"Node %d HugePages_Free:  %5u\n"
> -		"Node %d HugePages_Surp:  %5u\n",
> +		"Node %d HugePages_Total:%8u\n"
> +		"Node %d HugePages_Free: %8u\n"
> +		"Node %d HugePages_Surp: %8u\n",
>  		nid, h->nr_huge_pages_node[nid],
>  		nid, h->free_huge_pages_node[nid],
>  		nid, h->surplus_huge_pages_node[nid]);
> 
