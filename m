Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324C2202FB2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 08:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731272AbgFVG2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 02:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731244AbgFVG2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 02:28:07 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42B3C061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 23:28:06 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id d67so14629194oig.6
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 23:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bBeZtgAb2UNyQsPAk8bOgNUxMw9atU2V4z23o4bn6XI=;
        b=XpfBsbheJAYZrbK/j5IY5yMhOIOhPfZ/M7slKgD99C+U30Bca2GdZYM+IgyjfZqOcz
         NnjoH0pjO99FBV0xZt2hpJ7aRxXVxDTIW+I/CwUs+XoT78QKEuJHMD1dW753BAM+O6u+
         kzxY2NsU0JUIoAYg1OgG8X1xz5Y+xs5dxq/KzRBIi2uUKzdTQZQkU++y4+yoGIvqWLqp
         jwvlpBx0J6POiXhKB/tnBZvK3jfJholo08tKIVzSfuBLDMKH6BwO3p6Bb5X/VB6gEfFW
         nnWEafuX5l10Fa5JUJrQJo0klSUaflvs5rptLLwNEgE8PWWxeRkPw54LIbvprajD3cbz
         U3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bBeZtgAb2UNyQsPAk8bOgNUxMw9atU2V4z23o4bn6XI=;
        b=otkZwOgXbBxaDe+vk051mGalYXBDI0pxyD1hOi0lTiWm2yAmTvTRKNZkgg0xLgkhIn
         VB8krgCUNOuyjPERywQKHlmWRg0uFc30v3D+m1QHDknP+jGyqzM9ABx/KptxPFmC3KMp
         Y31muHW3l3ERxqlXV4pQostCetobw1FI7XTX6CiDp0utaE9kf6nFBYIlUXpmENfK+Gp3
         xYRGY/dCEzFua3ytOxks0Py4TiPQbTX3cBoGkSVW/DWVFVlS7TQ+bcMCbQ/Z2UHxh6iQ
         rkjdjIzcBIsWFfUgO80pkRIOcmx4QhAHpHlIshz5xgqX6gQIVUIYDUv3nwTFGuTQd97b
         1chA==
X-Gm-Message-State: AOAM531mQ/I+pW2mynxMrhOohgvlOmTa3gYURtx/UplZkpHgadgSqVxh
        FjryKp8jBJqgV9LXljtWO/pRPQ==
X-Google-Smtp-Source: ABdhPJx9x//osLbnYbR5OAnNACxidGIX37VhvaHF67pUSeaNzIOWnZGZ+S4wjOC6Rbzpp5uBkUCKUQ==
X-Received: by 2002:aca:c203:: with SMTP id s3mr11807861oif.95.1592807286045;
        Sun, 21 Jun 2020 23:28:06 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w1sm3237052ooq.1.2020.06.21.23.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 23:28:05 -0700 (PDT)
Date:   Sun, 21 Jun 2020 23:25:19 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.pallardy@st.com,
        arnaud.pouliquen@st.com, s-anna@ti.com
Subject: Re: [PATCH v4 1/9] remoteproc: Add new RPROC_DETACHED state
Message-ID: <20200622062519.GB149351@builder.lan>
References: <20200601175139.22097-1-mathieu.poirier@linaro.org>
 <20200601175139.22097-2-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601175139.22097-2-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01 Jun 10:51 PDT 2020, Mathieu Poirier wrote:

> Add a new RPROC_DETACHED state to take into account scenarios
> where the remoteproc core needs to attach to a remote processor
> that is booted by another entity.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/remoteproc/remoteproc_sysfs.c | 1 +
>  include/linux/remoteproc.h            | 5 ++++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
> index 7f8536b73295..8b462c501465 100644
> --- a/drivers/remoteproc/remoteproc_sysfs.c
> +++ b/drivers/remoteproc/remoteproc_sysfs.c
> @@ -71,6 +71,7 @@ static const char * const rproc_state_string[] = {
>  	[RPROC_RUNNING]		= "running",
>  	[RPROC_CRASHED]		= "crashed",
>  	[RPROC_DELETED]		= "deleted",
> +	[RPROC_DETACHED]	= "detached",
>  	[RPROC_LAST]		= "invalid",
>  };
>  
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index e7b7bab8b235..21182ad2d059 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -400,6 +400,8 @@ struct rproc_ops {
>   * @RPROC_RUNNING:	device is up and running
>   * @RPROC_CRASHED:	device has crashed; need to start recovery
>   * @RPROC_DELETED:	device is deleted
> + * @RPROC_DETACHED:	device has been booted by another entity and waiting
> + *			for the core to attach to it
>   * @RPROC_LAST:		just keep this one at the end
>   *
>   * Please note that the values of these states are used as indices
> @@ -414,7 +416,8 @@ enum rproc_state {
>  	RPROC_RUNNING	= 2,
>  	RPROC_CRASHED	= 3,
>  	RPROC_DELETED	= 4,
> -	RPROC_LAST	= 5,
> +	RPROC_DETACHED	= 5,
> +	RPROC_LAST	= 6,
>  };
>  
>  /**
> -- 
> 2.20.1
> 
