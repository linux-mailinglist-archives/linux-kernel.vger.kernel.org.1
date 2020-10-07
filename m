Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E876F285FE7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 15:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgJGNPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 09:15:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48064 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728403AbgJGNPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 09:15:40 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 6380E28ADDD;
        Wed,  7 Oct 2020 14:15:37 +0100 (BST)
Date:   Wed, 7 Oct 2020 15:15:34 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     <pgaj@cadence.com>, <bbrezillon@kernel.org>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: master: Fix error return in
 cdns_i3c_master_probe()
Message-ID: <20201007151534.6fd4d5d7@collabora.com>
In-Reply-To: <20200911033350.23904-1-jingxiangfeng@huawei.com>
References: <20200911033350.23904-1-jingxiangfeng@huawei.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Sep 2020 11:33:50 +0800
Jing Xiangfeng <jingxiangfeng@huawei.com> wrote:

> Fix to return negative error code -ENOMEM from the error handling
> case instead of 0.
> 
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>

Queued to i3c/next.

Thanks,

Boris

> ---
>  drivers/i3c/master/i3c-master-cdns.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
> index 3fee8bd7fe20..3f2226928fe0 100644
> --- a/drivers/i3c/master/i3c-master-cdns.c
> +++ b/drivers/i3c/master/i3c-master-cdns.c
> @@ -1635,8 +1635,10 @@ static int cdns_i3c_master_probe(struct platform_device *pdev)
>  	master->ibi.slots = devm_kcalloc(&pdev->dev, master->ibi.num_slots,
>  					 sizeof(*master->ibi.slots),
>  					 GFP_KERNEL);
> -	if (!master->ibi.slots)
> +	if (!master->ibi.slots) {
> +		ret = -ENOMEM;
>  		goto err_disable_sysclk;
> +	}
>  
>  	writel(IBIR_THR(1), master->regs + CMD_IBI_THR_CTRL);
>  	writel(MST_INT_IBIR_THR, master->regs + MST_IER);

