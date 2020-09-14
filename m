Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BAB2686B2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 10:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgINIAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 04:00:44 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2809 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725989AbgINIAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 04:00:42 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 714EFA3C76FE0AD723C2;
        Mon, 14 Sep 2020 09:00:41 +0100 (IST)
Received: from localhost (10.52.126.156) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 14 Sep
 2020 09:00:41 +0100
Date:   Mon, 14 Sep 2020 08:59:05 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Kai Ye <yekai13@huawei.com>
CC:     <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangfei.gao@linaro.org>
Subject: Re: [PATCH] uacce: fix some coding styles
Message-ID: <20200914085905.00005338@Huawei.com>
In-Reply-To: <1600050547-32577-1-git-send-email-yekai13@huawei.com>
References: <1600050547-32577-1-git-send-email-yekai13@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.156]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Sep 2020 10:29:07 +0800
Kai Ye <yekai13@huawei.com> wrote:

> 1. delete some redundant code.
> 2. modify the module author information.
> 
> Signed-off-by: Kai Ye <yekai13@huawei.com>
> Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
> Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Two things, so should really be two patches.

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


