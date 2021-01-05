Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73C52EA212
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 02:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbhAEBAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 20:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbhAEBAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 20:00:33 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BCEC061795
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 16:59:53 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id q205so34235871oig.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 16:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/ZJWgGFgObsIw1imh280z+QHHcfXF2+K3sjXY7L8jjU=;
        b=DwA/22V9/zKhYF2ZDzW/pKpR7uFNGBf6lz4GprBVZHDsoH7mqfT7xozJpkkymSb1yq
         5NnNs3PKjF2Rf5T6VrW8CjC7JKmeFbBTywxc/x9jwK30EbmN8l0xEPBYXlpx+bHNEX5g
         RYUitIgerbogFwDRCwNsccP+7WFeMu8p1NWoJh3PAYO1EHley1bio3+bgzKQbqQeoOU2
         VZFmmxd4dbEjAPct/zeFUUJBAH/RpfAURO3TBtQS8OBVJzeB/OC5Am9FfmelUc5aI3So
         l9UkjFCm31BJwLDJtiisXGSKg0iXhjcXkEzUDiA3ay1vXOhZjjJ3AI6oHSOmfFcOUQco
         39/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/ZJWgGFgObsIw1imh280z+QHHcfXF2+K3sjXY7L8jjU=;
        b=I6EyB4vckJjTdyf14Zo8KBvbMZkEmggEEFHsRqz+bzCXAge9JizU2A+XFuFD+6sRpe
         QCbfSNPtmGsGzcH/jNIROZWX/XU91J7jwVm/lSAQXGWuAAPgkUtfrYDHdP5ywZM4uv12
         hRIee/dCPGyuXbR4Ox2r0JTNkX7//Bb54qQWQfGp5absPOq9U7JfSoXQu7N9+5Mmd0aT
         L5Kz8elmRTYMNEsnw4Z6YcrZV2GMtSzOat+XD859LF+g8Zrwquf6DJ9ioD3NVmciQwhM
         fbkT+2rreMGcVIbLJE1iYjX/MVdJs5U9vUfJxupW20G+supNxzZDlkGTp/DJi92xuhTy
         47MA==
X-Gm-Message-State: AOAM530SlynvWSjSbJ39VY74FD9bpIoUplAovgDw6EO59iYAInxsNmmB
        3cz/AOgLAWT7Sn9UTd8X3Vuc0Q==
X-Google-Smtp-Source: ABdhPJwVr5QmC4AvHoez2dCA0E2+/7dRHHYK+WIjRYyarUuJUQT8qygD+yamLnCrf/UenjJGaXbNvg==
X-Received: by 2002:aca:ec13:: with SMTP id k19mr1093947oih.97.1609808392407;
        Mon, 04 Jan 2021 16:59:52 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t25sm12029981oic.15.2021.01.04.16.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 16:59:51 -0800 (PST)
Date:   Mon, 4 Jan 2021 18:59:50 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 10/16] rpmsg: char: allow only one endpoint per device
Message-ID: <X/O6BvP+vqLvbi5f@builder.lan>
References: <20201222105726.16906-1-arnaud.pouliquen@foss.st.com>
 <20201222105726.16906-11-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222105726.16906-11-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22 Dec 04:57 CST 2020, Arnaud Pouliquen wrote:

> Only one endpoint can be created per device, prevent from multi open.
> 

Having multiple invocations of rpmsg_create_ept() with the same chinfo
sounds like a bad idea. I think in the SMD and GLINK case the underlying
transport would complain that the related chinfo is already "busy", but
this seems like an appropriate fix regardless.

Please add a proper Fixes: tag and send this outside of this patch
series.

Thanks,
Bjorn

> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/rpmsg/rpmsg_char.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index 66e01b979e72..4b0674a2e3e9 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -122,6 +122,9 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
>  	struct rpmsg_device *rpdev = eptdev->rpdev;
>  	struct device *dev = &eptdev->dev;
>  
> +	if (eptdev->ept)
> +		return -EBUSY;
> +
>  	get_device(dev);
>  
>  	ept = rpmsg_create_ept(rpdev, rpmsg_ept_cb, eptdev, eptdev->chinfo);
> -- 
> 2.17.1
> 
