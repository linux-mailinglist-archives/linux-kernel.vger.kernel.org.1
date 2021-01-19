Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5AB2FAF60
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 05:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbhASEOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 23:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730108AbhASENd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 23:13:33 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B52C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 20:12:51 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id t29so6334728pfg.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 20:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M6wg7KNfJrhRT98STkAnP9vWGusvsL7OQAKWu6O9CHA=;
        b=IaHT39Qpq25b6amymPsV1bLYStO5CMCdF0Ioepx1JPlAN4KXF2kn79sKSaF73LX36c
         oHvws4EJdZ6xLo0Os/zH75JPDsBSeeldiQCojrerJYanjpXIXEN6pk9l8b9vd/TDWOku
         lpN0eKfHBEkklU95BpAfy6+PVMyDyXcWiLktnZd/L+vvudux0yfUsnMdhF4qXTRkBEGg
         Zd56r/CCHdyDgBUM2O8icYhiY1AYfVW9qX8P3bOWeqK3uN0cEdHDpnAgB8Ea64FLk1fD
         RpBqIQ9uC5tJbSzkMMbGotXGxVToVeTaI6d/qJPOfnh4Vcq7REaIidJrY7UpglRz2iGp
         QCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M6wg7KNfJrhRT98STkAnP9vWGusvsL7OQAKWu6O9CHA=;
        b=gAoLeu4ph+7Y/Si3duEzHskMXMiVTTWSelfnPiTAc+6OJmi8vMeNvsK648lAn2C2Is
         FWJGc/Pv8pUHzoP8uqLfUGWIxpW3qk0Su+s3w8s5uYQ9+YSSOc/PIbiROZPI781mwyUy
         BHYYK7CiURc87sKZRMy0uOMZbGl6s/S2i+D1sT5LHPl0iBFqhB3j5dQ29sXYq1BTcDCu
         MjBE74n3aUCeGCYnEqBkPLUGa6YuN67WCc0aN4TUuC+DFq2taKCN4AC6vdKTnzYYmtlT
         FJaIPGiCPobOvWW7COgYzt3equzRt4frs+4b4dcZTJlDx8P3cuJ27a6a4nGgS5b6DIir
         OjTQ==
X-Gm-Message-State: AOAM533V08HfDbBRveN5MnAHxIKJyKPKlgn+edr/7fYHJx+mjV2GuND2
        P3fJVHdJEca2JiIB/CCXjY0V8OOxHAuHbQ==
X-Google-Smtp-Source: ABdhPJwPi7EKjYj5bKldJy64UEaeECn0qMvLnLpLsdFNIjPjZioy9ncEoGiZx7gyRRQn0lk14mjLiw==
X-Received: by 2002:aa7:8813:0:b029:19d:cd3b:6f89 with SMTP id c19-20020aa788130000b029019dcd3b6f89mr2626386pfo.42.1611029570699;
        Mon, 18 Jan 2021 20:12:50 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id 32sm17582105pgq.80.2021.01.18.20.12.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 20:12:49 -0800 (PST)
Date:   Tue, 19 Jan 2021 09:42:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        Alex Elder <elder@linaro.org>
Subject: Re: [greybus-dev] [PATCH] greybus: es2: drop short control-transfer
 checks
Message-ID: <20210119041247.pyfgiwyegijye327@vireshk-i7>
References: <20210118144629.25533-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118144629.25533-1-johan@kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-01-21, 15:46, Johan Hovold wrote:
> There's no need to check for short USB control transfers when sending
> data using so remove the redundant sanity checks.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/greybus/es2.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/greybus/es2.c b/drivers/greybus/es2.c
> index 1df6ab5d339d..48ad154df3a7 100644
> --- a/drivers/greybus/es2.c
> +++ b/drivers/greybus/es2.c
> @@ -567,12 +567,9 @@ static int cport_enable(struct gb_host_device *hd, u16 cport_id,
>  			      USB_DIR_OUT | USB_TYPE_VENDOR |
>  			      USB_RECIP_INTERFACE, cport_id, 0,
>  			      req, sizeof(*req), ES2_USB_CTRL_TIMEOUT);
> -	if (ret != sizeof(*req)) {
> +	if (ret < 0) {
>  		dev_err(&udev->dev, "failed to set cport flags for port %d\n",
>  			cport_id);
> -		if (ret >= 0)
> -			ret = -EIO;
> -
>  		goto out;
>  	}
>  
> @@ -961,12 +958,10 @@ static int arpc_send(struct es2_ap_dev *es2, struct arpc *rpc, int timeout)
>  				 0, 0,
>  				 rpc->req, le16_to_cpu(rpc->req->size),
>  				 ES2_USB_CTRL_TIMEOUT);
> -	if (retval != le16_to_cpu(rpc->req->size)) {
> +	if (retval < 0) {
>  		dev_err(&udev->dev,
>  			"failed to send ARPC request %d: %d\n",
>  			rpc->req->type, retval);
> -		if (retval > 0)
> -			retval = -EIO;
>  		return retval;
>  	}

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
