Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C870233D4A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 04:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731231AbgGaClE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 22:41:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45440 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730820AbgGaClE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 22:41:04 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3DAB5CA23216DB556543;
        Fri, 31 Jul 2020 10:41:00 +0800 (CST)
Received: from [10.63.139.185] (10.63.139.185) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 31 Jul 2020 10:40:49 +0800
Subject: Re: [PATCH] uacce: fix some coding styles
To:     Kai Ye <yekai13@huawei.com>, <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangfei.gao@linaro.org>
References: <1596089583-32687-1-git-send-email-yekai13@huawei.com>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5F2384B1.3040301@hisilicon.com>
Date:   Fri, 31 Jul 2020 10:40:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1596089583-32687-1-git-send-email-yekai13@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/30 14:13, Kai Ye wrote:
> 1. delete some redundant code.
> 2. modify the module author information.
> 
> Signed-off-by: Kai Ye <yekai13@huawei.com>

Fine to me.

Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>

Thanks,
Zhou

> ---
> Changes in V2:
> 	deleted extra NULL pointer check in uacce_fops.
> 
>  drivers/misc/uacce/uacce.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index 107028e..1d09707 100644
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
> @@ -541,5 +530,5 @@ subsys_initcall(uacce_init);
>  module_exit(uacce_exit);
>  
>  MODULE_LICENSE("GPL");
> -MODULE_AUTHOR("Hisilicon Tech. Co., Ltd.");
> +MODULE_AUTHOR("HiSilicon Tech. Co., Ltd.");
>  MODULE_DESCRIPTION("Accelerator interface for Userland applications");
> 
