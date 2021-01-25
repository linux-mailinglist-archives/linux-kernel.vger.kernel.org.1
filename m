Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F9B30288A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 18:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbhAYRNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 12:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730159AbhAYRLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 12:11:41 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DF4C061794
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 09:10:31 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id p5so15480914oif.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 09:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CiQwU0uQMl0x2LLoEUfiYuSqNBnhBy8hs2yd2mhpH0A=;
        b=cDbyQlsCCe8Cot3vrfN5F/iXSU/8y9dODtuV7WZ2sjlCDEP7cN9foP1BzFPJc6SFlW
         Vdy0MGAths5Uo9w3678VYa+qxbIBd4ZkSsa2iPexeQDp+4AZQjhJVIhsh4/xdQCaTt+6
         u7VN2XBVyIthAijZX2yYZqwQkrvvXs2NcCcU7a6Fcs0+kDIBw5c9QJlVD3OCbNVeUny/
         jenR4l1nMdwRbj2J5Ts38jT2O5iESUd9xyqMUXZOIsjOVmx1wSaH/rrSloptYzGamNTW
         uaoPSPdKqwD3PW3HzZJ2V+5bSksP6P1TwRE1o97fANuVx1pPQET0HopxxUkWcXBqNL25
         09MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CiQwU0uQMl0x2LLoEUfiYuSqNBnhBy8hs2yd2mhpH0A=;
        b=UjTy9iuK2XI3iiMaIX2N2PThT06vW/ZSUfQFC59FMwCIC+6NgX6Pv0/l+qt0TiyfmC
         I2AYpdfpDGZ3vWd4cSW4qDzvLGwvOXqmjYolkhCxjQHob2+Mfa9zTX2Eyr/j5vPpz6zT
         wvnxZ25u6dIDzmUSb1pitRBnPSpaGXZ4uoAxZ3XdL/iJVcQfj25cozzhRAQ122OvRTVL
         QRM53PDEpiWntgd5Q9RVkUR4dZMDFyBh+vKCkc3Iam6r573L3AL2sW542LRhD1rGtCt/
         SMBbxalwbvN4C14sMFlVYyCHxE6nmd8QwKDwt0+uw0Q4ulDuxFVspexeC/yfajPvC+Z4
         vKng==
X-Gm-Message-State: AOAM5307nVDnM22Jfv6wEXvgk28szxtac39i0li4Kxy30Ykv3ZE4/SQr
        LeQOhPHFSyGkltch1/JgYkHHgw==
X-Google-Smtp-Source: ABdhPJwvzgGBdYbZSP0vhyScwPdNWTzVfw20HDZVrDrLYGkEsg2A9FYv4lzLJATK9Kj9OG46uvpb+A==
X-Received: by 2002:aca:f551:: with SMTP id t78mr721431oih.34.1611594631387;
        Mon, 25 Jan 2021 09:10:31 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n18sm702450oov.4.2021.01.25.09.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 09:10:30 -0800 (PST)
Date:   Mon, 25 Jan 2021 11:10:29 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: phy: qcom,qmp: Add SM8350 UFS PHY
 bindings
Message-ID: <YA77hbH6aOW7mzbF@builder.lan>
References: <20210125100906.4004908-1-vkoul@kernel.org>
 <20210125100906.4004908-3-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125100906.4004908-3-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 25 Jan 04:09 CST 2021, Vinod Koul wrote:

> Add the compatible strings for the UFS PHY found on SM8350 SoC.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> index 62c4f2ba5b9f..bf804c12fa5f 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> @@ -38,6 +38,7 @@ properties:
>        - qcom,sm8250-qmp-modem-pcie-phy
>        - qcom,sm8250-qmp-usb3-phy
>        - qcom,sm8250-qmp-usb3-uni-phy
> +      - qcom,sm8350-qmp-ufs-phy
>        - qcom,sm8350-qmp-usb3-phy
>        - qcom,sm8350-qmp-usb3-uni-phy
>        - qcom,sdx55-qmp-usb3-uni-phy
> -- 
> 2.26.2
> 
