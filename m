Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2628271292
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 08:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgITGD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 02:03:59 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:16380 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgITGD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 02:03:59 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f66f0720000>; Sat, 19 Sep 2020 23:02:27 -0700
Received: from [10.2.52.182] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 20 Sep
 2020 06:03:52 +0000
Subject: Re: [PATCH] misc: mic: scif: Fix error handling path
To:     Souptick Joarder <jrdr.linux@gmail.com>, <sudeep.dutt@intel.com>,
        <ashutosh.dixit@intel.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <lee.jones@linaro.org>,
        <gustavoars@kernel.org>, <nikhil.rao@intel.com>
CC:     <linux-kernel@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
References: <1600570295-29546-1-git-send-email-jrdr.linux@gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <f00be8f7-fb23-c9f0-1c5a-bfb77e5c5594@nvidia.com>
Date:   Sat, 19 Sep 2020 23:03:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1600570295-29546-1-git-send-email-jrdr.linux@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600581747; bh=KbImiUwhXWlcKBGpiL7VfZvBmQXTgZmoISfT3gNPwgU=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=WHSeylpVQMvyVJl6zHUdmfUEjV3hSTBvKsdN/6IMF6UQqOToscj7DbcOaPhqxoHZX
         o4oHnJZAbCpFUUXKfZw9OO3qUZ+Tx76Hnkob/YpBr+YGukOCCg7D0THoPLyypuqDMM
         96SoNeaaYZ4ouwZQmKUWGRg15KlLaSxzrGBD4kZKeTd9EOOmgrJCD1yp/WfG6rvz5E
         G+ive9yhVcdOdGxS1yXrQS7wP0PrrOJ2YmoKtxcuOsTIb75qhg979n4GY3aNNtGtcG
         6jT70zwXH6TC1shq6p0EKgjlFml1PSEvSAJqtJ5aM3TnyL8zfxKYv4jlqfr6BV1Wjo
         DR+wrlXc45i+Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/20 7:51 PM, Souptick Joarder wrote:
> Inside __scif_pin_pages(), when map_flags != SCIF_MAP_KERNEL it
> will call pin_user_pages_fast() to map nr_pages. However,
> pin_user_pages_fast() might fail with a return value -ERRNO.
> 
> The return value is stored in pinned_pages->nr_pages. which in
> turn is passed to unpin_user_pages(), which expects
> pinned_pages->nr_pages >=0, else disaster.
> 
> Fix this by assigning pinned_pages->nr_pages to 0 if
> pin_user_pages_fast() returns -ERRNO.
> 
> Fixes:	ba612aa8b487 ("misc: mic: SCIF memory registration and
> unregistration")
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> ---

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

>   drivers/misc/mic/scif/scif_rma.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/mic/scif/scif_rma.c b/drivers/misc/mic/scif/scif_rma.c
> index 2da3b47..18fb9d8 100644
> --- a/drivers/misc/mic/scif/scif_rma.c
> +++ b/drivers/misc/mic/scif/scif_rma.c
> @@ -1392,6 +1392,8 @@ int __scif_pin_pages(void *addr, size_t len, int *out_prot,
>   				(prot & SCIF_PROT_WRITE) ? FOLL_WRITE : 0,
>   				pinned_pages->pages);
>   		if (nr_pages != pinned_pages->nr_pages) {
> +			if (pinned_pages->nr_pages < 0)
> +				pinned_pages->nr_pages = 0;
>   			if (try_upgrade) {
>   				if (ulimit)
>   					__scif_dec_pinned_vm_lock(mm, nr_pages);
> @@ -1408,7 +1410,6 @@ int __scif_pin_pages(void *addr, size_t len, int *out_prot,
>   
>   	if (pinned_pages->nr_pages < nr_pages) {
>   		err = -EFAULT;
> -		pinned_pages->nr_pages = nr_pages;
>   		goto dec_pinned;
>   	}
>   
> @@ -1421,7 +1422,6 @@ int __scif_pin_pages(void *addr, size_t len, int *out_prot,
>   		__scif_dec_pinned_vm_lock(mm, nr_pages);
>   	/* Something went wrong! Rollback */
>   error_unmap:
> -	pinned_pages->nr_pages = nr_pages;
>   	scif_destroy_pinned_pages(pinned_pages);
>   	*pages = NULL;
>   	dev_dbg(scif_info.mdev.this_device,
> 

