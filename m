Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43AB92742D0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgIVNUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgIVNUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:20:50 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD653C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 06:20:49 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z4so17045982wrr.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 06:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=PDxFBsdzhqglAsjtf28c/y3OAG0uxodhHBxS0E/7Jd8=;
        b=Q8ohkniG1biUWmKbxmcgW6iu6A0ozWJ/wHbh5EdHbq6YPm1Yqokf5Smqn2f95gloMG
         rz59LDzWOW5FyxiGvmOxb09m3asZZ+c8dE4v6Da7LR43jnsTcohAjfHekidB265iA1i4
         q7ehVTT6jRwetK5Bl/gV5z11+qR3EmSw2/9wU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=PDxFBsdzhqglAsjtf28c/y3OAG0uxodhHBxS0E/7Jd8=;
        b=P6KZvs7W/N3wAdokrzYVBLMFipEJO/oduyYd8pM+7PA7bUifw6C6NlhQVbjBSz3dT3
         a5tGosAXjnBiLpNjuRcdmPI1Z0Us+18KMquodkTND8xhDTwrEBBwonf0JLBaqAVYphNz
         m3Z0Nvm5yCwtp1IdaCjJurxIYXoIMF2m0nIRmBRQy9gMltuMb5CitYqkswj6pvfTxGQA
         DYeGIouliMNnNzOQjZ1I5vsA0W90YUP4Ku2qoJO4EUyoWbL4GCYDFhI4PpLaObo2cUnM
         xo8HeZH0FBzkwazEdhTeiDsUswerBeg/MEJqImw3rD/8C6V3R/nduKucRppdxzf8NMSM
         /4tQ==
X-Gm-Message-State: AOAM530xh3a17GULDWyOJ6hHvIxVgCFih7knHDINQUVuTWmCwgB6W4zg
        LSPdbOFVCLfH2SESLsmJCzasng==
X-Google-Smtp-Source: ABdhPJweoQg7bZ8uxspQfUQZW9VTW/MLMSfQJQqzN87TEoP+S1zXqDNPAKFWlHYxU6MMPyWrf4dpoQ==
X-Received: by 2002:adf:f34f:: with SMTP id e15mr5121626wrp.387.1600780848571;
        Tue, 22 Sep 2020 06:20:48 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id n3sm4461810wmn.28.2020.09.22.06.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 06:20:47 -0700 (PDT)
Date:   Tue, 22 Sep 2020 15:20:45 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Lukas Wunner <lukas@wunner.de>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] vga_switcheroo: simplify the return expression of
 vga_switcheroo_runtime_resume
Message-ID: <20200922132045.GN438822@phenom.ffwll.local>
Mail-Followup-To: Qinglang Miao <miaoqinglang@huawei.com>,
        Lukas Wunner <lukas@wunner.de>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200921131110.93365-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921131110.93365-1-miaoqinglang@huawei.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 09:11:10PM +0800, Qinglang Miao wrote:
> Simplify the return expression.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>

Pushed to drm-misc-next, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/vga/vga_switcheroo.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
> index 087304b1a..1401fd52f 100644
> --- a/drivers/gpu/vga/vga_switcheroo.c
> +++ b/drivers/gpu/vga/vga_switcheroo.c
> @@ -1034,17 +1034,12 @@ static int vga_switcheroo_runtime_suspend(struct device *dev)
>  static int vga_switcheroo_runtime_resume(struct device *dev)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> -	int ret;
>  
>  	mutex_lock(&vgasr_mutex);
>  	vga_switcheroo_power_switch(pdev, VGA_SWITCHEROO_ON);
>  	mutex_unlock(&vgasr_mutex);
>  	pci_wakeup_bus(pdev->bus);
> -	ret = dev->bus->pm->runtime_resume(dev);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return dev->bus->pm->runtime_resume(dev);
>  }
>  
>  /**
> -- 
> 2.23.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
