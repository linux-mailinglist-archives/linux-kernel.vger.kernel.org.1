Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357B723231A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 19:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgG2RFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 13:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbgG2RFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 13:05:20 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCE0C0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 10:05:20 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id c10so652258pjn.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 10:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M6BtaiknwGs6KJnTUty1mPDFt0kOkFw4Ty652Bj3Jlw=;
        b=Oj5/AMQs/EdhIKtDQs2sg5svN+Sq/SSjLpHjwmvxRafk2Z4uoeOqWzNJHphfWdJFuc
         X/JwqkfNbmWI1f2qhJe1fY+1H9jaMU5DXASP3y//T0YLLimftukyqQivRC65O0oEqRRy
         ofoaX1Xo8NuV5GjFzfWlw14ZHox9snOmfJOCxnKKsg3Wae4o+e9lbhOMKWybWuZdVlDL
         KmsfgoyFuZt2b2RfnXHWMspeKgZ1qfr985RXRsdIoFrzoXnrbnRoKaB6ZPnbnnhhMc97
         3OUIiDXS+ZDgt9d+/yx8Fd7MbhGp+q1v9cn0KOWn00ABo2bKZIID2CKE/MauDMy+UM5o
         kguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M6BtaiknwGs6KJnTUty1mPDFt0kOkFw4Ty652Bj3Jlw=;
        b=ocPCLOrFmx7+HxnGdhrW5Iaaf0d9Kv+THx1mp3bf5MWNcic7tgp5hGmB1Qjzs25/wC
         w5Zapwhhby53/Jz3N2AKSsCLJJY7RccNXZ4/++ERB1Gyl4KPFcA9Y7ZSZfeOH+b7FbZU
         JpbHn2MBMAydkQOAbI4xWa57NLANMSLINE+6e/UWlWS6agILgyKKYi1zrIEWdC90rI3N
         TMalFkHPPzBIUDniBiAe8BsXzYCCZd8CYRP4YeSYB/QKNUWSF8FYvMN94f3yYWp3oWSN
         2OXNQNDLjOtCO25i56I3gS45zcj06tpn0XzFZC92b6z4+SVx+jiiC5NtVMLf+Gdv6USm
         KMxQ==
X-Gm-Message-State: AOAM531HLSNXkISE0Fjfo3dM40Gz8/iRrt+dlkrV6XZOBquFxCtka3Vo
        tCPsYmpsHyEmmD3pyqbq5zXfsjvJW24=
X-Google-Smtp-Source: ABdhPJxzsbn23Bh544lHDk5xrQ8cmKHUKEFkb49jEXCzTPQhfEFeeo+ULdGpcLZtr6GQrtnGwpNOEA==
X-Received: by 2002:a17:902:7c8b:: with SMTP id y11mr27477408pll.142.1596042319556;
        Wed, 29 Jul 2020 10:05:19 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id d22sm3072044pfd.42.2020.07.29.10.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 10:05:18 -0700 (PDT)
Date:   Wed, 29 Jul 2020 11:05:16 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     bjorn.andersson@linaro.org, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: virtio: support sharing vdev buffer
Message-ID: <20200729170516.GA3059951@xps15>
References: <20200722131543.7024-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722131543.7024-1-peng.fan@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Wed, Jul 22, 2020 at 09:15:43PM +0800, Peng Fan wrote:
> Support sharing vdev buffer between multiple vdevs by using name
> "vdevbuffer".
> 
> Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/remoteproc_virtio.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index dfd3808c34fd..5d78ebea111e 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -343,6 +343,8 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
>  
>  	/* Try to find dedicated vdev buffer carveout */
>  	mem = rproc_find_carveout_by_name(rproc, "vdev%dbuffer", rvdev->index);
> +	if (!mem)
> +		mem = rproc_find_carveout_by_name(rproc, "vdevbuffer");

We already have a way to share buffers [1], do you think it would work for you?  I
would rather proceed that way to avoid introducing a 3rd way to deal with vdev
buffers.

Thanks,
Mathieu

[1]. https://elixir.bootlin.com/linux/v5.8-rc4/source/drivers/remoteproc/remoteproc_virtio.c#L389

>  	if (mem) {
>  		phys_addr_t pa;
>  
> -- 
> 2.16.4
> 
