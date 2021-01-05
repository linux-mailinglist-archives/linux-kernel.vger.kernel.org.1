Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E512D2EA18C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 01:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbhAEAjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 19:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbhAEAjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 19:39:17 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1203C061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 16:38:36 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id a109so27830630otc.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 16:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=27wBpppGsYVqhH9Tev4p91dfIlQ30H/+M8uOdR4nqag=;
        b=NE+fQuSOYQLbp22Vj1ifuOiTj3EgouqSiEOKuRuldyuaDevoKojUARocMb0UQ2QQPI
         g/9m8NWbT3ttoWh1J+fZ0nsdn6y1ZFbzeQLd9OVS4VtVt6D/3xBcpFw0408TA534aIqS
         DcZkDrumYyjhZhV1RcPZD6ZyTMC+9kCeTAx1XlDJ1ZQd08M32ZYMTzbWCIYQV17zUu5e
         VxIpZPXSUc/NWCCr79DMH8Rea/pymGm5l7cZlXIVOawAuSp+KQLXGlncbl99NCrFhtxM
         o0QGs/gO5X+b+37hvvSBY371rE+izdgqWxbh0Hy6I9TCPK4EtoyXzoSj9/po9l+aFGcp
         B1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=27wBpppGsYVqhH9Tev4p91dfIlQ30H/+M8uOdR4nqag=;
        b=cQ0e8pRteM0MK/7ewah8vcdTRAcSUKSKLudBsbnmhDfNmEhyDr+9RlZy9f9uCgzuPv
         pAdoQYqEwv/GpZ3/SZNEWFrk+qEsYuETy8rLGdyf9DrRNkWzozl8zoBIbumzUafCJsAn
         pMhnjXot/WYs5IUBSCA6euMy0eYDefOH/L8ej4Jk9RiZ1WxqQdSBCODqaZK0zQ6zuZGJ
         8XxETljWV3rqISvCP9Aap3nxnrDZ7yOVcdNn6TestGvi6GpRgwjV4zOtDLPyqY5FRYl+
         h01qpPpuFu9qt8U+Z/q46nXIWPB3FbpcA3igwg3dpD0QvCFSDTPg7yHMunNBI4eX/fRW
         Iw7g==
X-Gm-Message-State: AOAM531AtMR3CeR3+WgRE1EovLG0HlFSEUowv1bHoABoeIslXiwPnzh7
        FbAtRvVkMs2sLgKOHImT58+zVg==
X-Google-Smtp-Source: ABdhPJwzyq76S8h25XBXBt3EvdXIT7lM/bAZQGsQ/z66sUeQ2ltiUA7WRfzwckuKtOvKhdltLJxotQ==
X-Received: by 2002:a9d:74d3:: with SMTP id a19mr52939634otl.2.1609807116206;
        Mon, 04 Jan 2021 16:38:36 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id g92sm13707748otb.66.2021.01.04.16.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 16:38:35 -0800 (PST)
Date:   Mon, 4 Jan 2021 18:38:33 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 05/16] rpmsg: ns: initialize channel info override
 field
Message-ID: <X/O1CRjINeCG8PkA@builder.lan>
References: <20201222105726.16906-1-arnaud.pouliquen@foss.st.com>
 <20201222105726.16906-6-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222105726.16906-6-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22 Dec 04:57 CST 2020, Arnaud Pouliquen wrote:

> By default driver_override should be 0 to avoid to force
> the channel creation with a specified name.The local variable
> is not initialized.
> 

The same problem exists in qcom_glink_native, qcom_smd and rpmsg_char.

Regards,
Bjorn

> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/rpmsg/rpmsg_ns.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/rpmsg/rpmsg_ns.c b/drivers/rpmsg/rpmsg_ns.c
> index 762ff1ae279f..a526bff62947 100644
> --- a/drivers/rpmsg/rpmsg_ns.c
> +++ b/drivers/rpmsg/rpmsg_ns.c
> @@ -55,6 +55,7 @@ static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
>  	strncpy(chinfo.name, msg->name, sizeof(chinfo.name));
>  	chinfo.src = RPMSG_ADDR_ANY;
>  	chinfo.dst = rpmsg32_to_cpu(rpdev, msg->addr);
> +	chinfo.driver_override = NULL;
>  
>  	dev_info(dev, "%sing channel %s addr 0x%x\n",
>  		 rpmsg32_to_cpu(rpdev, msg->flags) & RPMSG_NS_DESTROY ?
> -- 
> 2.17.1
> 
