Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96591EB6EB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 10:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgFBIBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 04:01:34 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60000 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgFBIBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 04:01:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0527uY1u088522;
        Tue, 2 Jun 2020 08:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=hxfcsqFFJfllZ2M4bcJmu85MukQ2QTy19xfU8ihmlac=;
 b=yP+4LxNp9BykBqQNCtQkgojOF47zsIzMDQ+taKumcqlXNS21E46lD5cnaMh5J2Og0QCG
 Aozuu6QuAh8Azen2R2FWmgwtqSG3ZoS49eodK+ErixVOikZgM9J9gcYpaYMG516mkxdT
 4fRDsgjElCvL26PVHzOYaYDI/nEuxn+1LgMxXbQoW84S5Ji2kqO9azmGQpoe9yKLrR7k
 fwhfw3LW+fLpdbTN0PJ3nF50SgGrIXdgEryHYhbXJgquPC9SdAZFGAytpx+c0KUhxQ8m
 nP+vNedgA40oYrqivZ7z8fdIYEikx9aH6PMjTkO1bT35IEEtE3akcQ/X2yQHTFvHD6BE xA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 31bfem2hdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 02 Jun 2020 08:01:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0527vtAJ126069;
        Tue, 2 Jun 2020 08:01:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 31c25n4ygb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jun 2020 08:01:23 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05281MLN028195;
        Tue, 2 Jun 2020 08:01:22 GMT
Received: from [192.168.0.110] (/183.246.144.78)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Jun 2020 01:01:22 -0700
Subject: Re: [PATCH] block/bio-integrity: don't free 'buf' if
 bio_integrity_add_page() failed
To:     yu kuai <yukuai3@huawei.com>, axboe@kernel.dk, ming.lei@redhat.com,
        martin.petersen@oracle.com, wenwen@cs.uga.edu
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20200601123856.3895734-1-yukuai3@huawei.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <28b53354-7012-4559-943e-21526864dd10@oracle.com>
Date:   Tue, 2 Jun 2020 16:01:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200601123856.3895734-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9639 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=2 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006020051
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9639 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=2
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1011
 impostorscore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006020051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/20 8:38 PM, yu kuai wrote:
> commit e7bf90e5afe3 ("block/bio-integrity: fix a memory leak bug") add a
> kree() for 'buf' if bio_integrity_add_page() return '0'. However, the
> object will be freed in bio_integrity_free() since 'bio->bi_opf' and
> 'bio->bi_integrity' was set previousy in bio_integrity_alloc().
> 
> Fixes: commit e7bf90e5afe3 ("block/bio-integrity: fix a memory leak bug")
> Signed-off-by: yu kuai <yukuai3@huawei.com>> ---
>  block/bio-integrity.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index bf62c25cde8f..ae07dd78e951 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -278,7 +278,6 @@ bool bio_integrity_prep(struct bio *bio)
>  
>  		if (ret == 0) {
>  			printk(KERN_ERR "could not attach integrity payload\n");
> -			kfree(buf);
>  			status = BLK_STS_RESOURCE;
>  			goto err_end_io;
>  		}
> 

Looks good to me.
Reviewed-by: Bob Liu <bob.liu@oracle.com>

