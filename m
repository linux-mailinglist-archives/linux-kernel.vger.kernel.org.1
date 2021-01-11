Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88ADD2F2232
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 22:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387666AbhAKVvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 16:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbhAKVvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 16:51:06 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3107EC061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:50:26 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id x18so228325pln.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s0SkaAiQZlaYhLV8PnGXG9fGpLXxDyEs5jIvTxo5C0U=;
        b=HY48C+vkUOoOXKvSBec6tZF+71ijEm+10AJ0jVJqwbEPva54ohG1hYa6PVYmQixg9z
         bHywKXRMXoI0YwIXT4HnMMuCl0T+O1ClUZD+2wFza7Lsb+cky1HiPFY2dFznrOLmvwMa
         mhCBanWLe0PoEhg/fvJdvtkkiA0vV0Fhg6J6ipuFTtt8b2EeTji8vYWq5y/yK5bxTjVS
         So5e94k4DnCfTXQksfncfxPq8Z7rhYHvdczcItwVGoDi7C/j2SbebfXQhQO2AOAGGc4W
         eH2S9f29NZB5+BjKOXs5s3ijR4W8j24Hdp6Hwd0Fq3P7bpXpB0W8pKa/b41zzgEW2evU
         VYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s0SkaAiQZlaYhLV8PnGXG9fGpLXxDyEs5jIvTxo5C0U=;
        b=gDHXr/tBQK7UW9BK1elW6WpUVJguwYcJ0MZ1c/o5Mg5+eZbQYKuWL8U0IUsNoMXejJ
         4R3Y0hLhmahN2hViO/Y0JBLZHMAF83WgBnLdFRa/A5PVXLEcQqv/8qLvN5n70uxLWb0A
         UftoaJrTLqGYEFC6g/WUXY05NsSxbcQ2PiUBoG6rVMCLcUFfnwGsVR0DTBCUe7cRcssm
         7XVejS0gXsI6DhDurZnDBAuxoIh/BnYW95Q7DN28hFYYWiCNl2WcAWYoIKkAtSrRDelE
         8L32aCEgk8ISCrUxNSu1FIhIAVhmThjoXcDutdS1mZI6xqfqGfuJ028cIzP37D2UP+zl
         85Cg==
X-Gm-Message-State: AOAM533+cTNRPmlOrdjtnXxnV3+nclaQ0I8b5Cle2IRtt6qqw/cGCn+l
        5IbOi7OPNgLj75yGJN8WJsp/3J/GKh8AvQ==
X-Google-Smtp-Source: ABdhPJwACfaWjfASrS3k8kPK4dLbGEugjJw7pkf6DZz1Qej0wtaNMjP457NQvik56OuYH+TqragH8Q==
X-Received: by 2002:a17:90a:8b08:: with SMTP id y8mr941825pjn.42.1610401825693;
        Mon, 11 Jan 2021 13:50:25 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id k64sm612901pfd.75.2021.01.11.13.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 13:50:25 -0800 (PST)
Date:   Mon, 11 Jan 2021 14:50:23 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     peng.fan@nxp.com
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        o.rempel@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, matthias.bgg@gmail.com, agross@kernel.org,
        patrice.chotard@st.com
Subject: Re: [PATCH V5 7/8] remoteproc: imx_rproc: ignore mapping vdev regions
Message-ID: <20210111215023.GJ144935@xps15>
References: <20201229033019.25899-1-peng.fan@nxp.com>
 <20201229033019.25899-8-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229033019.25899-8-peng.fan@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 11:30:18AM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> vdev regions are vdev0vring0, vdev0vring1, vdevbuffer and similar.
> They are handled by remoteproc common code, no need to map in imx
> rproc driver.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index f80428afb8a7..e62a53ee128e 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -417,6 +417,9 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
>  		struct resource res;
>  
>  		node = of_parse_phandle(np, "memory-region", a);
> +		/* Not map vdev region */
> +		if (!strcmp(node->name, "vdev"))
> +			continue;

I am very confused and because I don't see an example for the DT in the
bindings document I have to guess what is going on.  

So I am guessing that you have laid out the memory regions for the vrings
and the vdev0buffer in the DT "memory-region".

For the vrings I don't see the allocation of a carveout, which means that you
will take the memory out of the DMA pool and the reserve memory will be wasted.

For the vdev0buffer, what you have will work *only* if that entry is the
first one in the list of memory regions, as we agreed here [2].

[1]. https://elixir.bootlin.com/linux/v5.11-rc3/source/drivers/remoteproc/remoteproc_core.c#L321
[2]. https://patchwork.kernel.org/project/linux-remoteproc/patch/20200722131543.7024-1-peng.fan@nxp.com/

>  		err = of_address_to_resource(node, 0, &res);
>  		if (err) {
>  			dev_err(dev, "unable to resolve memory region\n");
> -- 
> 2.28.0
> 
