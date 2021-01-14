Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14DA2F6A80
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbhANTG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbhANTG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:06:26 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E54C061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:05:46 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id c13so3891198pfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9eQpCXhKjCHwg9nJ0ZvUFOOkfeOuaFDT4T5heWosDRk=;
        b=sqRjubUVFoI42sWF35FLYlG5wrhrTfG4ofY/KnCDSFr1CiweQKiYdOu+Y2g9Vkw1rB
         j7tJuC9H85ZI5gZGIIU0Mm0pdWrGni6WCcHB+VdhE2tw5zihK4JpZc3CFOZm2UWTUwvo
         DmYW8eIXE2s2a1Yhi6JaR5ZYDO5ykeGGQ+0I48muB+KYO1rEim4vfFR2jkcg7RhjsKYI
         LDIM4WFj0a5rXDo0jXymb8cAGEzd9ffnhKW/U0FletCAqcqQyh4QfZEHGvJHPBGpsjB+
         pH+8We+T8OTCPqxvCCpb/DQ+Tzf5JXWQm7T8FBKtW0opDpEhrvqXH3Keaf09io5M3uVK
         YLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9eQpCXhKjCHwg9nJ0ZvUFOOkfeOuaFDT4T5heWosDRk=;
        b=uBjJWadP6PjfWO6h8yoRd1TU8Fcj2WVHWu6BQPugytglIJsCUqk4eysBLTmO08NJ2o
         MLmwAKocQC5GQ33kmEuJcN2Vgli7JlCXBR2DLcDJmHXdrFAkJW8REAKcxoppqrZFVzN0
         6j96NYaR+89ZuLZ7/kZH+YSIL0N3prKTExza5GwM33kmRAlNpywh4Grqdh0b+c+yPEDW
         YBry+fbxEB8VsfNZ1nmdVPYMvVe+/KcyRInp33g0Nh3Jid7jzwV947VXR0ehBC+OPA7/
         NcV9KBsfHvCKa0yHgxrrVxfSQKoKFB+kzu5RN3yDgcWS9S9yWohAwicWUxqlovTVlteZ
         izGQ==
X-Gm-Message-State: AOAM531Ms2inhaYhDCvktVoptg2PzM6tehv2chOCQ4gBqZaLxQEJIDG7
        Id2bfiWjJhkFI66753eJdUQ2DA==
X-Google-Smtp-Source: ABdhPJyn8ffJyXOF9cK+jocYwrLCcfz6CojMYiM4QGvdeTEZoBPlKtMfSWkixhuPd+fqpuT7Av6Hpw==
X-Received: by 2002:a63:7904:: with SMTP id u4mr8851614pgc.41.1610651145903;
        Thu, 14 Jan 2021 11:05:45 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id g30sm5504881pfr.152.2021.01.14.11.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 11:05:45 -0800 (PST)
Date:   Thu, 14 Jan 2021 12:05:43 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] rpmsg: char: return an error if device already open
Message-ID: <20210114190543.GB255481@xps15>
References: <20210106133714.9984-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106133714.9984-1-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 02:37:14PM +0100, Arnaud Pouliquen wrote:
> The rpmsg_create_ept function is invoked when the device is opened.
> As only one endpoint must be created per device. It is not
> possible to open the same device twice.
> The fix consists in returning -EBUSY when device is already
> opened.
> 
> Fixes: c0cdc19f84a4 ("rpmsg: Driver for user space endpoint interface")
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/rpmsg/rpmsg_char.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index 4bbbacdbf3bb..360a1ab0a9c4 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -127,6 +127,9 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
>  	struct rpmsg_device *rpdev = eptdev->rpdev;
>  	struct device *dev = &eptdev->dev;
>  
> +	if (eptdev->ept)
> +		return -EBUSY;
> +

I rarely had to work so hard to review a 2 line patch...

As far as I can tell the actual code is doing the right thing.  If user space is
trying to open the same eptdev more than once function rpmsg_create_ept() should
complain and the operation denied, wich is what the current code is doing.  

There is currently two customers for this API - SMD and GLINK.  The SMD code is
quite clear that if the channel is already open, the operation will be
denied [1].  The GLINK code isn't as clear but the fact that it returns NULL on
error conditions [2] is a good indication that things are working the same way.

What kind of use case are you looking to address?  Is there any way you can use
rpdev->ops->create_ept() as it is currently done?

Thanks,
Mathieu

[1]. https://elixir.bootlin.com/linux/v5.11-rc3/source/drivers/rpmsg/qcom_smd.c#L920
[2]. https://elixir.bootlin.com/linux/v5.11-rc3/source/drivers/rpmsg/qcom_glink_native.c#L1149

>  	get_device(dev);
>  
>  	ept = rpmsg_create_ept(rpdev, rpmsg_ept_cb, eptdev, eptdev->chinfo);
> -- 
> 2.17.1
> 
