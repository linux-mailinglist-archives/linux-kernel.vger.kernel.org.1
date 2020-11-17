Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558B12B60DB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 14:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbgKQNNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 08:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbgKQNNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 08:13:14 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737B0C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 05:13:14 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id s25so29314177ejy.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 05:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-powerpc-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pg/yyi9JRP4LZiCpylSmbD4jIZutsHvW/MdxJPfPpUc=;
        b=aYBMoo77/5cNRmKDqoRDn52XAF6qiK7a2CG8tcb9nCrnDdPwd9StGwg/UPm4gkWfGF
         IpXgsBjhfRj+JzjmAtYinBAHUpclRlPRDF4+Sq/kG1c8ECezftKvqbb4UrqMu3NaR1r7
         qQgF86VBPOqshZ0hqdaQz70pgz+Xrq8Ut+y1Nj+QtWTa0dLNBw7i5fuXl3apLFXTuPD9
         tEji99OSDyT3xWx+m+ka8y9WO+/iP3YpyL2IJqUgOBwSfim9lckTd9mxSEpgYExCwqVH
         ttmwxo+TJIHJSX8k+V9p769+N9ElTIg4K6BYMmPKvsXgo98JLEaGTpCQx5GJwh36CRPv
         uubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pg/yyi9JRP4LZiCpylSmbD4jIZutsHvW/MdxJPfPpUc=;
        b=CBnxObw9U+n1uIiBXh83wPpr6sltygtMRZWGANJXYbbjgsyUdjFpa/zQXGdAKL0eGC
         Mx393+ss4Z/HpHQmpXQ0K2KgULJDkA4wpHyoEgwO0YKEvgG8enB4z6s7QmsVsSati3Vh
         9E4+M2eThefSDOx4Nf6hfQA4SmYDrsVLUkoC0vSgfdCFrqa/dyYoHRiGCQIh2lmtT3bq
         1c+SQTK0mp4KYj0WNQwhawlp5BsMXXf9X8g0iD5JKqIb5eiiIqOJ9Tx15O7DlQ7es09u
         UFxewICe25DcVmdBiGajYtAJrZjg5GtKm+uaYOj/GUJaXGKaPyDKru2nkDEpB3teUfud
         Od+A==
X-Gm-Message-State: AOAM533UrHakmV/VnzH0lDSyQqrzaY998LlJ+D/qE++cgeT9R/aC1Dlv
        ddSKoTx8aYyDTy8+3LusG2AhH5LSGJRg+tjjFpsfcA==
X-Google-Smtp-Source: ABdhPJwYHXeILii9dacTYuuNdTsqcVHIh+cc1ehWXbhUtGjuEQ3DdoJwrDQx4o0HUxpKBFo31uFVOZC4HPSPVrtrVVc=
X-Received: by 2002:a17:906:1b09:: with SMTP id o9mr20092638ejg.79.1605618793059;
 Tue, 17 Nov 2020 05:13:13 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a54:380d:0:0:0:0:0 with HTTP; Tue, 17 Nov 2020 05:13:12
 -0800 (PST)
X-Originating-IP: [5.35.10.61]
In-Reply-To: <1605614877-5670-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1605614877-5670-1-git-send-email-radhey.shyam.pandey@xilinx.com>
From:   Denis Kirjanov <kda@linux-powerpc.org>
Date:   Tue, 17 Nov 2020 16:13:12 +0300
Message-ID: <CAOJe8K3-x36TU2kuW-uR8eqkNyoPsLWZYvD53MPcWxA6i5g72g@mail.gmail.com>
Subject: Re: [PATCH net v2] net: emaclite: Add error handling for of_address_
 and _mdio_setup functions
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
        michal.simek@xilinx.com, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, Shravya Kumbham <shravya.kumbham@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/20, Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com> wrote:
> From: Shravya Kumbham <shravya.kumbham@xilinx.com>
>
> Add ret variable, condition to check the return value and error
> path for the of_address_to_resource() function. It also adds error
> handling for mdio setup and decrement refcount of phy node.
>
> Addresses-Coverity: Event check_return value.
> Signed-off-by: Shravya Kumbham <shravya.kumbham@xilinx.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
> Changes for v2:
>
> - Change subject_prefix to target net tree.
> - Add error handling for mdio_setup and remove phy_read changes.
>   Error checking of phy_read will be added along with phy_write
>   in a followup patch. Document the changes in commit description.
> ---
>  drivers/net/ethernet/xilinx/xilinx_emaclite.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> index 0c26f5bcc523..4e0005164785 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> @@ -820,7 +820,7 @@ static int xemaclite_mdio_write(struct mii_bus *bus, int
> phy_id, int reg,
>  static int xemaclite_mdio_setup(struct net_local *lp, struct device *dev)
>  {
>  	struct mii_bus *bus;
> -	int rc;
> +	int rc, ret;
>  	struct resource res;
>  	struct device_node *np = of_get_parent(lp->phy_node);
>  	struct device_node *npp;
> @@ -834,7 +834,12 @@ static int xemaclite_mdio_setup(struct net_local *lp,
> struct device *dev)
>  	}
>  	npp = of_get_parent(np);
>
> -	of_address_to_resource(npp, 0, &res);
> +	ret = of_address_to_resource(npp, 0, &res);
> +	if (ret) {
> +		dev_err(dev, "%s resource error!\n",
> +			dev->of_node->full_name);
> +		return ret;
> +	}

npp is not returned to of_node_put() in the error case below

>  	if (lp->ndev->mem_start != res.start) {
>  		struct phy_device *phydev;
>  		phydev = of_phy_find_device(lp->phy_node);
> @@ -1173,7 +1178,11 @@ static int xemaclite_of_probe(struct platform_device
> *ofdev)
>  	xemaclite_update_address(lp, ndev->dev_addr);
>
>  	lp->phy_node = of_parse_phandle(ofdev->dev.of_node, "phy-handle", 0);
> -	xemaclite_mdio_setup(lp, &ofdev->dev);
> +	rc = xemaclite_mdio_setup(lp, &ofdev->dev);
> +	if (rc) {
> +		dev_warn(dev, "error registering MDIO bus: %d\n", rc);
> +		goto error;
> +	}
>
>  	dev_info(dev, "MAC address is now %pM\n", ndev->dev_addr);
>
> @@ -1197,6 +1206,7 @@ static int xemaclite_of_probe(struct platform_device
> *ofdev)
>  	return 0;
>
>  error:
> +	of_node_put(lp->phy_node);
>  	free_netdev(ndev);
>  	return rc;
>  }
> --
> 2.7.4
>
>
