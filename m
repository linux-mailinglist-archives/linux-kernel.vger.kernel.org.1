Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB55525C9B9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 21:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgICTxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 15:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgICTxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 15:53:30 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94B0C061244;
        Thu,  3 Sep 2020 12:53:27 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b124so3164456pfg.13;
        Thu, 03 Sep 2020 12:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oPyqrIZuFjAfVFg1FvzT2DAAuw6G4KrBAdUzRSV0jSg=;
        b=Bm36ZwHnsxFOOlZxZgnFhjnWxM598/edzy7AEd3aDbB8SClOkin956hExLLUMj0kK/
         2eToLVxF65uGPq9ktxFPZVlPfDb1pWYDzshrNcWW+QfIWNjSemEr4F4CATSo7LF87+8n
         9BOYhGNkNUA5Fil7LPeggFNMHJtLoECFktmAPCeQuhbmhx+S9kdOwXbBd+Na9/t5sn8E
         Aj13fSCnOT97hJnDlhLOGED0MoUqeojTWgrCi/QcF6loJmqqOr5twbO869SHNq6wEJkN
         NggKXrM0GEHgLPoP3//d1Va0GwohzSaLVLtJyM4jX34o5IouUJOz/+z4FHtv5Pqy0NKn
         L++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=oPyqrIZuFjAfVFg1FvzT2DAAuw6G4KrBAdUzRSV0jSg=;
        b=DHF5kXy5N6e6Q50OvakjDuo2TYxdiUmq0Nm4ZIegxRK2mRpE4ke5Q4udj0Z4xVi8jj
         NemOMDzLKcUl1/8nGxTEK7NFbc9YmTZrPneixZnb73eEP6uS51kn8ffRzE+EJ6uZauO2
         5pXwUl8g6su86NgWxx+mziHALYx30n5R+JsAK1kWzRixI/XGntFc2FPMFVrxZXvBCQjG
         ZnOHZhpZm6Ho1qb9EmWlJULvs1OfVXw1NzFYPKzNm/bCo1ZxedTl8+LoBefWtrIXSHYh
         1J3ce8PC9IeAYLF3DL2I9zQ+TXQxVFbkyvnfq5JRSFyMHCGmAiFdU6IC80QINwZdSqm3
         oKGQ==
X-Gm-Message-State: AOAM531NNjVGe12QHTrTGA7EJTiUOV+gCJkmoxf9Bg7vLbcfY3ySvLyK
        ISieJOBbqVexwhcvvJi4TnI=
X-Google-Smtp-Source: ABdhPJxY7GI7Xdk0q7NWYVWaCEru5rNbQgIFGF4Kzq86OrjN73P6or5I0cDb4k8Xs1A/GrEeF9Pj8A==
X-Received: by 2002:a17:902:a58c:: with SMTP id az12mr5516044plb.109.1599162806939;
        Thu, 03 Sep 2020 12:53:26 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id bx18sm3238787pjb.6.2020.09.03.12.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 12:53:25 -0700 (PDT)
Date:   Thu, 3 Sep 2020 12:53:23 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, xue.zhihong@zte.com.cn,
        jiang.xuexin@zte.com.cn, zhanglin <zhang.lin16@zte.com.cn>
Subject: Re: [PATCH] zram: add restriction on dynamic zram device creation
Message-ID: <20200903195323.GA2215546@google.com>
References: <1598942567-33440-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598942567-33440-1-git-send-email-wang.yi59@zte.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Yi,

On Tue, Sep 01, 2020 at 02:42:47PM +0800, Yi Wang wrote:
> From: zhanglin <zhang.lin16@zte.com.cn>
> 
> Add max_num_devices to limit dynamic zram device creation to prevent
>  potential OOM
> 
> Signed-off-by: zhanglin <zhang.lin16@zte.com.cn>
> ---
>  drivers/block/zram/zram_drv.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 36d49159140f..4f2c4eef5051 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -43,8 +43,9 @@ static DEFINE_MUTEX(zram_index_mutex);
>  static int zram_major;
>  static const char *default_compressor = "lzo-rle";
>  
> -/* Module params (documentation at end) */
>  static unsigned int num_devices = 1;
> +/* Module params (documentation at end) */
> +static unsigned int max_num_devices = 8;

It seems 8 is too small to me by default. How about 256?
Furthemore, I think it would be worth to have in Kconfig.

config ZRAM_DEV_MAX_COUNT
	int "Number of zram devices to be created"
	depends on ZRAM
	default 256
	help
	   blah blah

>  /*
>   * Pages that compress to sizes equals or greater than this are stored
>   * uncompressed in memory.
> @@ -2013,10 +2014,16 @@ static ssize_t hot_add_show(struct class *class,
>  			struct class_attribute *attr,
>  			char *buf)
>  {
> -	int ret;
> +	int ret = -ENOSPC;
>  
>  	mutex_lock(&zram_index_mutex);
> +	if (num_devices >= max_num_devices) {
> +		mutex_unlock(&zram_index_mutex);
> +		return ret;
> +	}
>  	ret = zram_add();
> +	if (ret >= 0)
> +		num_devices += 1;
>  	mutex_unlock(&zram_index_mutex);
>  
>  	if (ret < 0)
> @@ -2046,8 +2053,10 @@ static ssize_t hot_remove_store(struct class *class,
>  	zram = idr_find(&zram_index_idr, dev_id);
>  	if (zram) {
>  		ret = zram_remove(zram);
> -		if (!ret)
> +		if (!ret) {
>  			idr_remove(&zram_index_idr, dev_id);
> +			num_devices -= 1;
> +		}
>  	} else {
>  		ret = -ENODEV;
>  	}
> @@ -2089,6 +2098,7 @@ static void destroy_devices(void)
>  static int __init zram_init(void)
>  {
>  	int ret;
> +	unsigned int i;
>  
>  	ret = cpuhp_setup_state_multi(CPUHP_ZCOMP_PREPARE, "block/zram:prepare",
>  				      zcomp_cpu_up_prepare, zcomp_cpu_dead);
> @@ -2111,13 +2121,15 @@ static int __init zram_init(void)
>  		return -EBUSY;
>  	}
>  
> -	while (num_devices != 0) {
> +	if (num_devices > max_num_devices)
> +		num_devices = max_num_devices;

I am not sure the overriding is a good idea.
Just leave it but just return error if user wanted to pre-create
exceeding max size in configuration.

Thanks.

> +
> +	for (i = 0; i < num_devices; i++) {
>  		mutex_lock(&zram_index_mutex);
>  		ret = zram_add();
>  		mutex_unlock(&zram_index_mutex);
>  		if (ret < 0)
>  			goto out_error;
> -		num_devices--;
>  	}
>  
>  	return 0;
> @@ -2135,8 +2147,8 @@ static void __exit zram_exit(void)
>  module_init(zram_init);
>  module_exit(zram_exit);
>  
> -module_param(num_devices, uint, 0);
> -MODULE_PARM_DESC(num_devices, "Number of pre-created zram devices");
> +module_param(max_num_devices, uint, 0);
> +MODULE_PARM_DESC(max_num_devices, "Max number of created zram devices");
>  
>  MODULE_LICENSE("Dual BSD/GPL");
>  MODULE_AUTHOR("Nitin Gupta <ngupta@vflare.org>");
> -- 
> 2.17.1
> 
