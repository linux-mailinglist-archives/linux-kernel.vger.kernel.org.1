Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500C328764A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbgJHOmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:42:55 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41583 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbgJHOmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:42:55 -0400
Received: by mail-lf1-f66.google.com with SMTP id d24so6768509lfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 07:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6GCfcGuGhykUPUz2Gv9W+UDODiHTW35rWixaMNAJTfY=;
        b=HcjKEt4fH29+FLfaK92TfW2hpWlHN/lLzI1Qaj87mUR6WEJECFMRSj6rT8K7sIkSoz
         Nm9KEd0sw0glxMqFtRTxa6O8TR+Oejn28fEcxh+RVyo8eDw717p21TQvYTRMRALrGBlV
         lj/uGjhXHc+yn0Amcd+CxCBYQvbfhihUFoS5+sxl26ul0k3+is+w7FrUq4zz9vi3oYSM
         WjCbJcjDzXre9U6oitOxhGpYuIHpQ2c6A1ZHoCBQ+nc/K6WusM2/dibtiYQXXsyEbZxh
         NR8XqaMGwacV9Y3IWMsbkJhTqZDH/753ftPD+bskfMld9dlyu2Apr1Pwc2nhABlITYr0
         x4IA==
X-Gm-Message-State: AOAM532ayeCh1fy0Y6b3s4wC610iXZS62xE76bjtCeSi94xUScG7zm9L
        OXoYZ3AiE6ZaTa/hqMiRbCU=
X-Google-Smtp-Source: ABdhPJxIdg5H71Do4072xgufwFOzSgs0WbvVdnbdHeTbloVbwEd3SbDA0DnZHXleyK1YS7YjlPCGBw==
X-Received: by 2002:a19:c1d7:: with SMTP id r206mr2514118lff.87.1602168173005;
        Thu, 08 Oct 2020 07:42:53 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id d21sm365053lfl.62.2020.10.08.07.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 07:42:52 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kQX83-000716-RE; Thu, 08 Oct 2020 16:42:47 +0200
Date:   Thu, 8 Oct 2020 16:42:47 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] gnss: simplify the return expression of gnss_uevent
Message-ID: <20201008144247.GJ26280@localhost>
References: <20200921131028.91837-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921131028.91837-1-miaoqinglang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 09:10:28PM +0800, Qinglang Miao wrote:
> Simplify the return expression.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>

The current code was written with an explicit error path on purpose, and
there's no need to change it.

Same applies to your other gnss ubx patch.

> ---
>  drivers/gnss/core.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
> index e6f94501c..e6b9ac9da 100644
> --- a/drivers/gnss/core.c
> +++ b/drivers/gnss/core.c
> @@ -368,13 +368,8 @@ ATTRIBUTE_GROUPS(gnss);
>  static int gnss_uevent(struct device *dev, struct kobj_uevent_env *env)
>  {
>  	struct gnss_device *gdev = to_gnss_device(dev);
> -	int ret;
>  
> -	ret = add_uevent_var(env, "GNSS_TYPE=%s", gnss_type_name(gdev));
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return add_uevent_var(env, "GNSS_TYPE=%s", gnss_type_name(gdev));
>  }
>  
>  static int __init gnss_module_init(void)

Johan
