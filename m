Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573F72F6CA5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 21:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbhANUzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 15:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbhANUzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 15:55:18 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CE3C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 12:54:38 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id cq1so3792492pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 12:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jD7vbDbD0h84CsDujjRSLvXMFR2wSvaymJTCUCRVyTg=;
        b=i4ANxg8Q3GY1CKfPo+klvkSjAhcsfVbNRqK+K/aQ/iToZldEMxU8NHBcNKw6UiXjq0
         JOaf8WHB+ZRym59WBEzqIO8fSNdU5TfCYCLb7V+NuC833UbYh+Qe4jnSCo5qbzILKgOe
         ZCtM7mU+AKviHFbajnRGNd9uuqwb5C2h5qCDtW8MiFGKZclK1cVhdY18laToooYZVFNe
         5gTSksJXBxPeXBQHIrvw8OvxYowfx5fNvMqwFL/B+6Xli9GAXFZNvxWFEVbJfqXw3Id+
         5rKeRDeu0YnRxzQ0ei0wp8zeAofbx/+H5ZTcajDcb6MvU6sbkRDUBWcGV2yCe5kwnyx4
         ShVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jD7vbDbD0h84CsDujjRSLvXMFR2wSvaymJTCUCRVyTg=;
        b=C/cowNxABT1mtHTLLMs5OjpRbtSMTFLRrhphWqFqJehtbSJ2Hq4+G7wMQTfoWgPhnE
         T6Gbxt24rGZrjv8z+DU8iICJ1uVXqA5yBSKCGrO/Ic/DmABQD6rZEhwS3TQ7ja0p6nTR
         DXNSpELPJU0/lNFKz54C6P5kBMbCu8IfDaG92XMHJB0SKJ5OLdfqzI2HjQzrD9faZW8e
         r6Lu0ohMcSTVTqX6ka+Vzh0wSBBo2w6O+enx/Xjo7NE9FfB4IACx7JOhXpBSwgLw0qGm
         31f4dmFU5xSEJbmzDwe6cyQBnkune3ayhmbn22hrZzVD+eG7A5emdVQjb29s4XvKgakO
         /+Mw==
X-Gm-Message-State: AOAM532sTjjMFfJOtsRUY3a2vGeN2J9k/4f/8uq6jTBdSPExzlqkzB0p
        zOf3AoGDiRueddq8wA/VESqy3Q==
X-Google-Smtp-Source: ABdhPJwHSp4h2t6bqX0badjP/w9fNcURWQGRTeksXWdcWRqrH8U8NT/f7kVg2Tt51R5DDZxijhwg+Q==
X-Received: by 2002:a17:90a:bf05:: with SMTP id c5mr6907923pjs.90.1610657677823;
        Thu, 14 Jan 2021 12:54:37 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id fv22sm6486172pjb.14.2021.01.14.12.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 12:54:37 -0800 (PST)
Date:   Thu, 14 Jan 2021 13:54:35 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     peng.fan@nxp.com
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        o.rempel@pengutronix.de, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, matthias.bgg@gmail.com, agross@kernel.org,
        patrice.chotard@st.com
Subject: Re: [PATCH V6 09/10] remoteproc: imx_rproc: ignore mapping vdev
 regions
Message-ID: <20210114205435.GC255481@xps15>
References: <1610444359-1857-1-git-send-email-peng.fan@nxp.com>
 <1610444359-1857-10-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610444359-1857-10-git-send-email-peng.fan@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 05:39:18PM +0800, peng.fan@nxp.com wrote:
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

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  		err = of_address_to_resource(node, 0, &res);
>  		if (err) {
>  			dev_err(dev, "unable to resolve memory region\n");
> -- 
> 2.28.0
> 
