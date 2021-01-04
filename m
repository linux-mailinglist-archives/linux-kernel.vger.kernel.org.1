Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176DD2E931E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 11:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbhADKIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 05:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbhADKIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 05:08:40 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16092C061793
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 02:08:00 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id e25so18771934wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 02:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=miG7CO4g5j20n9mrQMJx+RS21ZtCLqOgtOcLQw9KSDs=;
        b=Lg7fUwr3AMMbu21IW1G8pugaRA5SNCJaW71dzVrsNi0eLfCFI6DLso9TPduv3Fwl+d
         F8LBc9rpDsiZlgcDymsDqFXHeGQ9r79AQg0D8eJtYMk+fRn4gqtUSNEW4zSUb4/s4UjB
         orcsSCCOenu3XQzjy1ErOHJIZAOdGEJ0t7uSFKz65w56ete2sthEifuLASHttKbuRRma
         paMnaDaig0mM0Qmd536zabVBAHcl9UN2JmSKpMU5UGtvh/aQGTcL7X24uRO6mYjwJdwW
         LQwH9V1M3c7Ky/qU9v0QCX1PAOJPuRZolAzh7zseO9iVcUu0SIVFcSPqQsWkkpbxubSu
         Rzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=miG7CO4g5j20n9mrQMJx+RS21ZtCLqOgtOcLQw9KSDs=;
        b=Dj0Met4chED+KsB83mNQM5nkVgsG8ELqwa4tmoKgrsE1acfdzikZV9IlVSH4SFaGRk
         wdah0supB+H+0cucwjneXkmWOOrutL61zVDCKcV5QWQEmdjQBG8G3rHHNSOanAwQLF5O
         BSRHhXSuavQpQcDi2Apl25HKoOmYP7bQsNOFDZLziDYrJGgsp0eR9M6NXhPajVJQn0ZS
         pz/qhZ9GlDX47AZrnQ2y1ivAzryIWCpUqu0EwKMTc+GYS7Wu+lAkO6htj75oi4BR1wM2
         1elm4NR1rI3YEHrNgMEn9izLf+j3WjUesGaNDWLrDEwjpgTm1ZAcnP8I9m2L39Pdw7c9
         9Kig==
X-Gm-Message-State: AOAM5337yxbwqw1rKzCT15MZG36I9xCnh2NeHBqGVU5lklrRQ8xz2zNM
        C8qXJNZ6+yBP0/JownYIbbHdYQ==
X-Google-Smtp-Source: ABdhPJzf1aX815VmR6wjjt7zvuM5RGyRKlwUh6d84TKCy6s8zu4m42oY9tKbexlZo9VISvD5GidvuQ==
X-Received: by 2002:a1c:7d58:: with SMTP id y85mr26041528wmc.50.1609754878758;
        Mon, 04 Jan 2021 02:07:58 -0800 (PST)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id o23sm95611006wro.57.2021.01.04.02.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 02:07:58 -0800 (PST)
Date:   Mon, 4 Jan 2021 10:07:56 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     lee.jones@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] video: backlight: use DEFINE_MUTEX (and
 mutex_init() had been too late)
Message-ID: <20210104100756.sjpzzchy4tklt2rd@holly.lan>
References: <20201223141035.32178-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223141035.32178-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 10:10:35PM +0800, Zheng Yongjun wrote:
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Can you explain the Subject for this patch in more detail?

If this patch is required to correct a bug then it looks to me like it
is incomplete.


Daniel.


> ---
>  drivers/video/backlight/backlight.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index 537fe1b376ad..d7a09c422547 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -64,7 +64,7 @@
>   */
>  
>  static struct list_head backlight_dev_list;
> -static struct mutex backlight_dev_list_mutex;
> +static DEFINE_MUTEX(backlight_dev_list_mutex);
>  static struct blocking_notifier_head backlight_notifier;
>  
>  static const char *const backlight_types[] = {
> @@ -757,7 +757,6 @@ static int __init backlight_class_init(void)
>  	backlight_class->dev_groups = bl_device_groups;
>  	backlight_class->pm = &backlight_class_dev_pm_ops;
>  	INIT_LIST_HEAD(&backlight_dev_list);
> -	mutex_init(&backlight_dev_list_mutex);
>  	BLOCKING_INIT_NOTIFIER_HEAD(&backlight_notifier);
>  
>  	return 0;
> -- 
> 2.22.0
> 
