Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95B92E9DF2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 20:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbhADTGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 14:06:02 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52572 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbhADTGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 14:06:01 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104Iip6V123418;
        Mon, 4 Jan 2021 19:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=yhPTFvwz/4vMrgApHjdyy2PkDKGwoNN6dlKktNif0Ew=;
 b=bDMxQBzRbPP5QOFrJmZpPg+j7BZMszR7p7Yj13F/0RhW6hvaTvcVkmn4GSoV98PgyCCm
 8u7+xyb8iKe8pNGby6scJFXMtjcMjelZMiy4sCaK82dVh9C04uX9dwzFKnkdLdKwe2Nj
 F/auxnl92pOQ5dMzAHGZmdNzvXSX9T5D6Is3PWg0aSxiTAlp/HeB5vJciNkPabaUWPWz
 GEtKMCO/OTG0AJ3l5L/RsfD/X/oKsh/lbiVAAm1aJXBjCRbTCzqC2yJAXAot/ozpyFH/
 NeFFdG49Yyjwhrn4l6hANVU2htZQliXIyNyEclWJOiI5sJJQXVhCekp7Tr+bAEtaoZva zA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 35tgsknrdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 04 Jan 2021 19:04:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104IkImH150511;
        Mon, 4 Jan 2021 19:02:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 35uxnrkgmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jan 2021 19:02:46 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 104J2fwX012636;
        Mon, 4 Jan 2021 19:02:41 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Jan 2021 11:02:41 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 544096A0067; Mon,  4 Jan 2021 14:02:40 -0500 (EST)
Date:   Mon, 4 Jan 2021 14:02:40 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, zhongjiang@huawei.com,
        joe@perches.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, iommu@lists.linux-foundation.org,
        dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        will@kernel.org
Subject: Re: [PATCH] x86/iommu: Fix two minimal issues in
 check_iommu_entries()
Message-ID: <20210104190240.GF6029@char.us.oracle.com>
References: <20201223062412.343-1-zhenzhong.duan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223062412.343-1-zhenzhong.duan@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 02:24:12PM +0800, Zhenzhong Duan wrote:
> check_iommu_entries() checks for cyclic dependency in iommu entries
> and fixes the cyclic dependency by setting x->depend to NULL. But
> this repairing isn't correct if q is in front of p, there will be
> "EXECUTION ORDER INVALID!" report following. Fix it by NULLing
> whichever in the front.
> 
> The second issue is about the report of exectuion order reverse,
> the order is reversed incorrectly in the report, fix it.

Heya!

When you debugged this, did you by any chance save the
serial logs and the debug logs to double-check it?

Thanks!
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> ---
>  arch/x86/kernel/pci-iommu_table.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/pci-iommu_table.c b/arch/x86/kernel/pci-iommu_table.c
> index 2e9006c..40c8249 100644
> --- a/arch/x86/kernel/pci-iommu_table.c
> +++ b/arch/x86/kernel/pci-iommu_table.c
> @@ -60,7 +60,10 @@ void __init check_iommu_entries(struct iommu_table_entry *start,
>  			printk(KERN_ERR "CYCLIC DEPENDENCY FOUND! %pS depends on %pS and vice-versa. BREAKING IT.\n",
>  			       p->detect, q->detect);
>  			/* Heavy handed way..*/
> -			x->depend = NULL;
> +			if (p > q)
> +				q->depend = NULL;
> +			else
> +				p->depend = NULL;
>  		}
>  	}
>  
> @@ -68,7 +71,7 @@ void __init check_iommu_entries(struct iommu_table_entry *start,
>  		q = find_dependents_of(p, finish, p);
>  		if (q && q > p) {
>  			printk(KERN_ERR "EXECUTION ORDER INVALID! %pS should be called before %pS!\n",
> -			       p->detect, q->detect);
> +			       q->detect, p->detect);
>  		}
>  	}
>  }
> -- 
> 1.8.3.1
> 
