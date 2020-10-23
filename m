Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C72296E27
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 14:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463388AbgJWMER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 08:04:17 -0400
Received: from foss.arm.com ([217.140.110.172]:50622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S370157AbgJWMEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 08:04:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87366101E;
        Fri, 23 Oct 2020 05:04:15 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 676B53F66B;
        Fri, 23 Oct 2020 05:04:15 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 27C6C683248; Fri, 23 Oct 2020 13:04:14 +0100 (BST)
Date:   Fri, 23 Oct 2020 13:04:14 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     James Qian Wang <james.qian.wang@arm.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] drm/komeda: Convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20201023120414.GJ1008493@e110455-lin.cambridge.arm.com>
References: <20200917123949.101925-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200917123949.101925-1-miaoqinglang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 08:39:49PM +0800, Qinglang Miao wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
> v2: based on linux-next(20200917), and can be applied to
>     mainline cleanly now.
> 
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> index 1d767473b..4a10e6b9e 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -41,18 +41,7 @@ static int komeda_register_show(struct seq_file *sf, void *x)
>  	return 0;
>  }
>  
> -static int komeda_register_open(struct inode *inode, struct file *filp)
> -{
> -	return single_open(filp, komeda_register_show, inode->i_private);
> -}
> -
> -static const struct file_operations komeda_register_fops = {
> -	.owner		= THIS_MODULE,
> -	.open		= komeda_register_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(komeda_register);

Hi Qinglang,

Sorry for the belated response!

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

>  
>  #ifdef CONFIG_DEBUG_FS
>  static void komeda_debugfs_init(struct komeda_dev *mdev)
> -- 
> 2.23.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
