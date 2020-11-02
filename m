Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0562A255F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 08:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgKBHi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 02:38:27 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7029 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgKBHi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 02:38:26 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CPlC42tNszhfZc;
        Mon,  2 Nov 2020 15:38:24 +0800 (CST)
Received: from [10.63.139.185] (10.63.139.185) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Mon, 2 Nov 2020 15:38:14 +0800
Subject: Re: [PATCH v3 2/2] uacce: modify the module author information.
To:     Kai Ye <yekai13@huawei.com>, <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangfei.gao@linaro.org>,
        "gregkh@linuxfoundation.org >> Greg Kroah-Hartman" 
        <gregkh@linuxfoundation.org>
References: <1600855762-10031-1-git-send-email-yekai13@huawei.com>
 <1600855762-10031-3-git-send-email-yekai13@huawei.com>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5F9FB766.6010900@hisilicon.com>
Date:   Mon, 2 Nov 2020 15:38:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1600855762-10031-3-git-send-email-yekai13@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/9/23 18:09, Kai Ye wrote:
> The spelling of "Hisilicon" is modified.
> 
> Signed-off-by: Kai Ye <yekai13@huawei.com>
> Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  drivers/misc/uacce/uacce.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index 9b83bc5..1d09707 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -530,5 +530,5 @@ subsys_initcall(uacce_init);
>  module_exit(uacce_exit);
>  
>  MODULE_LICENSE("GPL");
> -MODULE_AUTHOR("Hisilicon Tech. Co., Ltd.");
> +MODULE_AUTHOR("HiSilicon Tech. Co., Ltd.");
>  MODULE_DESCRIPTION("Accelerator interface for Userland applications");
> 

Hi Hartman,

Could you take this patch?

Best,
Zhou
