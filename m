Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9B32A255A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 08:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgKBHhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 02:37:20 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6725 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbgKBHhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 02:37:20 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CPl9k5112zkdRv;
        Mon,  2 Nov 2020 15:37:14 +0800 (CST)
Received: from [10.63.139.185] (10.63.139.185) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 2 Nov 2020 15:37:10 +0800
Subject: Re: [PATCH v3 1/2] uacce: delete some redundant code.
To:     Kai Ye <yekai13@huawei.com>, <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangfei.gao@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1600855762-10031-1-git-send-email-yekai13@huawei.com>
 <1600855762-10031-2-git-send-email-yekai13@huawei.com>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5F9FB725.5000002@hisilicon.com>
Date:   Mon, 2 Nov 2020 15:37:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1600855762-10031-2-git-send-email-yekai13@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/9/23 18:09, Kai Ye wrote:
> Delete some redundant code.
> 
> Signed-off-by: Kai Ye <yekai13@huawei.com>
> Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  drivers/misc/uacce/uacce.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index 107028e..9b83bc5 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -239,17 +239,6 @@ static int uacce_fops_mmap(struct file *filep, struct vm_area_struct *vma)
>  
>  	switch (type) {
>  	case UACCE_QFRT_MMIO:
> -		if (!uacce->ops->mmap) {
> -			ret = -EINVAL;
> -			goto out_with_lock;
> -		}
> -
> -		ret = uacce->ops->mmap(q, vma, qfr);
> -		if (ret)
> -			goto out_with_lock;
> -
> -		break;
> -
>  	case UACCE_QFRT_DUS:
>  		if (!uacce->ops->mmap) {
>  			ret = -EINVAL;
> 

Hi Hartman,

Could you take this patch?

Best,
Zhou
