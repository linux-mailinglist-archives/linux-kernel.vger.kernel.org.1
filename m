Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0219C2733BD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 22:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgIUUot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 16:44:49 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37470 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgIUUot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 16:44:49 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08LKdCRp085819;
        Mon, 21 Sep 2020 20:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=7ujMtTvfd+IOkCnn7iI/GoTDPJ8pxvj1u7VSyDhDIiE=;
 b=TgUfJcvqhnH4X5TErTOA7ctRXSXQGoVSuGYWQLux1TS6gP/EFUFQnZPW1RbI+0E3cL3B
 in/KONvWNSkpL0McwdWOCYcEE71inohanA9TuEaBwbVsC+zymxPchZWkmSx8xBtSpz45
 n4nSBlQUHVmHXIe079bdqGiphbvhJyNT4NA7Zc1AGj/hU0sZ8Gjz7k8rSC1nxwxqxoDc
 M/3OmSs0Xen7YIDCD5IseKHAjxpvC1Wd93RKD+UTZE2zo/tF5x3Gs3ujB2MuqgPbpVVb
 G2l9kt0/DZBWdfye+7ecmzj4ylCxjUBE6JtHlfJDOmpinNW39aF0e9JhEBK/pXjcS2Z0 kg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33n9xks3vf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Sep 2020 20:44:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08LKdmAx065052;
        Mon, 21 Sep 2020 20:44:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 33nuw1usdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Sep 2020 20:44:24 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08LKiFvM023808;
        Mon, 21 Sep 2020 20:44:20 GMT
Received: from [10.74.86.189] (/10.74.86.189)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Sep 2020 13:44:14 -0700
Subject: Re: [PATCH 6/6] x86/xen: open code alloc_vm_area in
 arch_gnttab_valloc
To:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org
References: <20200918163724.2511-1-hch@lst.de>
 <20200918163724.2511-7-hch@lst.de>
From:   boris.ostrovsky@oracle.com
Organization: Oracle Corporation
Message-ID: <0833b9a8-5096-d105-a850-1336150eada1@oracle.com>
Date:   Mon, 21 Sep 2020 16:44:10 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200918163724.2511-7-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=2 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009210152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 suspectscore=2 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1011
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009210152
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/18/20 12:37 PM, Christoph Hellwig wrote:
>  
> +static int gnttab_apply(pte_t *pte, unsigned long addr, void *data)
> +{
> +	pte_t ***p = data;
> +
> +	**p = pte;
> +	(*p)++;
> +	return 0;
> +}
> +
>  static int arch_gnttab_valloc(struct gnttab_vm_area *area, unsigned nr_frames)
>  {
>  	area->ptes = kmalloc_array(nr_frames, sizeof(*area->ptes), GFP_KERNEL);
>  	if (area->ptes == NULL)
>  		return -ENOMEM;
> -
> -	area->area = alloc_vm_area(PAGE_SIZE * nr_frames, area->ptes);
> -	if (area->area == NULL) {
> -		kfree(area->ptes);
> -		return -ENOMEM;
> -	}
> -
> +	area->area = get_vm_area(PAGE_SIZE * nr_frames, VM_IOREMAP);
> +	if (!area->area)
> +		goto out_free_ptes;
> +	if (apply_to_page_range(&init_mm, (unsigned long)area->area->addr,
> +			PAGE_SIZE * nr_frames, gnttab_apply, &area->ptes))


This will end up incrementing area->ptes pointer. So perhaps something like


pte_t **ptes = area->ptes;

if (apply_to_page_range(&init_mm, (unsigned long)area->area->addr,
                        PAGE_SIZE * nr_frames, gnttab_apply, &ptes)) {

       ...

}


-boris
