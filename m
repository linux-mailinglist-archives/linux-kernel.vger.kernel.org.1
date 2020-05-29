Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C319F1E7578
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 07:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgE2Fil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 01:38:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbgE2Fil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 01:38:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AE4F207D3;
        Fri, 29 May 2020 05:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590730720;
        bh=/fKQMprH9ovouXwnZqfLNPZqBBlKDw2tKnzoercUSc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A4NnlXdEJnz8oswfce4HesrmHx7xFhcJAFpIs+ZQ4/+FoGJsZbhxNWh9LyAB9YP06
         q59Cx/gSG01Qfdabq91yHDiiCcX+tK0bHGh5tl/4n4DMAzABu4b9odUD5NylIu2NR5
         0mFpywAP/qujaW1eCwC99D9PXzu4jWSk0D0t7E0A=
Date:   Fri, 29 May 2020 07:38:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        alexios.zavras@intel.com, tglx@linutronix.de, allison@lohutok.net,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.liang82@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>
Subject: Re: [PATCH] misc: mic: Replace kmalloc with kzalloc in the error
 message
Message-ID: <20200529053836.GA525659@kroah.com>
References: <1590714081-15574-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590714081-15574-1-git-send-email-wang.yi59@zte.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 09:01:21AM +0800, Yi Wang wrote:
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
> 
> Use kzalloc instead of kmalloc in the error message according to
> the previous kzalloc() call.
> 
> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
> ---
>  drivers/misc/mic/host/mic_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/mic/host/mic_main.c b/drivers/misc/mic/host/mic_main.c
> index be0784f..8296f31 100644
> --- a/drivers/misc/mic/host/mic_main.c
> +++ b/drivers/misc/mic/host/mic_main.c
> @@ -164,7 +164,7 @@ static int mic_probe(struct pci_dev *pdev,
>  	mdev = kzalloc(sizeof(*mdev), GFP_KERNEL);
>  	if (!mdev) {
>  		rc = -ENOMEM;
> -		dev_err(&pdev->dev, "mdev kmalloc failed rc %d\n", rc);
> +		dev_err(&pdev->dev, "mdev kzalloc failed rc %d\n", rc);

The message should just be dropped as the call will print the failure
message anyway.

thanks,

greg k-h
