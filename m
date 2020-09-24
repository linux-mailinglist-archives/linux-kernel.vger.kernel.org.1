Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9C4277930
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 21:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbgIXTZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 15:25:16 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9785 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbgIXTZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 15:25:14 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6cf28d0000>; Thu, 24 Sep 2020 12:25:01 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 24 Sep
 2020 19:25:12 +0000
Subject: Re: [PATCH v2] mm/hmm/test: use after free in
 dmirror_allocate_chunk()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20200924134651.GA1586456@mwanda>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <eb06e0c8-327e-6677-c393-139dffdf0dbe@nvidia.com>
Date:   Thu, 24 Sep 2020 12:25:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200924134651.GA1586456@mwanda>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600975501; bh=VxKXOti6LWxDsQHTJ8Vj6sJYvHX2OPdhnAxzokJEpJg=;
        h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=VWe62aC/uYbjVEz9Y/oRUv63BSpflwyw97N4YqYQZny3VxkgKrxHPAA2sEsXIvz/h
         9KL49FsSXjFOWcHW9XBFrqjqS5o3RMX3GEAv2i4YrAXVGyIATZqZt2MENtoJNpfoeg
         Pb9j1mTx6yZY+Mwa55uGK0YreUWiRnOqUs3dMNOyP2s9t63Ug8O2kC1i8/nDvsx9UD
         WgExzgVBLmlflvobXN7Y5DCdjjcXeQz7fgGopgKcmclxp+FDCVnFRV0jhJ/BUwx7yW
         9bjoQH9JPJROAhA42UdEOnmDFbynM5+V47+SVZ71utQpLDVVm7uIbp8QzvN9iRZZEm
         BSthl/AxF/aUw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/24/20 6:46 AM, Dan Carpenter wrote:
> The error handling code does this:
> 
> err_free:
> 	kfree(devmem);
>          ^^^^^^^^^^^^^
> err_release:
> 	release_mem_region(devmem->pagemap.range.start, range_len(&devmem->pagemap.range));
>                             ^^^^^^^^
> The problem is that when we use "devmem->pagemap.range.start" the
> "devmem" pointer is either NULL or freed.
> 
> Neither the allocation nor the call to request_free_mem_region() has to
> be done under the lock so I moved those to the start of the function.
> 
> Fixes: b2ef9f5a5cb3 ("mm/hmm/test: add selftest driver for HMM")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Looks good.
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
