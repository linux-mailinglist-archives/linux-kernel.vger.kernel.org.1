Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919632D176B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 18:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgLGRVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 12:21:54 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44491 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgLGRVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 12:21:54 -0500
Received: by mail-ot1-f67.google.com with SMTP id f16so13146652otl.11;
        Mon, 07 Dec 2020 09:21:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=itlqPicSMRd57nRY/PX69XHL3uisVndeLcgR+EO03z4=;
        b=mbvqKxDGbBhv+7vVRklEWVJc0/MEjniQLTVFMV/+TFtv1CZke5yEP9a8BjP81LBamG
         LYtJ0Y+GexfcKwZX1kLRJO0EsWRfjaOtom5WA5cEo1dy1FAwB+TTd+4RjLmhkPwf6fxn
         ZpC6yhQInj7Abhzc88lw4B9BfIeDcfZb6ffg6lDuay05UqbvMGO31XNa4N/nQ1jeZzFP
         vr0rsr+RsyVmMuarAWehQyXHqqlNlM57f8SIFNLl0Sayt3UvYUvgejDXQPFHsOOPLLwN
         +6ZYiqOH1+Fn2oI1X3GctpNAdq9s5Hx8dRlsy4n9U8eejw3QFPc6psHbkh1/EEnxr1ps
         MfgA==
X-Gm-Message-State: AOAM533Y9ht3CN+XRiFUBMpKQrLBoIpFQUb5FQzjYnN7+K+PJ39tAZ3T
        8O4F3R6iSgY5nH85qHDOMg==
X-Google-Smtp-Source: ABdhPJxN3RwybzAnbl8yifcm/Ew7Kpeu2mQ+OZpWky+VxeYPzAn337QI8AxN98X31l6hvUYFcHYR4A==
X-Received: by 2002:a05:6830:1349:: with SMTP id r9mr6019026otq.256.1607361673016;
        Mon, 07 Dec 2020 09:21:13 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t13sm3050904oic.4.2020.12.07.09.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 09:21:12 -0800 (PST)
Received: (nullmailer pid 465658 invoked by uid 1000);
        Mon, 07 Dec 2020 17:21:11 -0000
Date:   Mon, 7 Dec 2020 11:21:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/2] devicetree: phy: rockchip-emmc add
 output-tapdelay-select
Message-ID: <20201207172039.GA463809@robh.at.kernel.org>
References: <20201202082507.3536-1-chris.ruehl@gtsys.com.hk>
 <20201202082507.3536-3-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202082507.3536-3-chris.ruehl@gtsys.com.hk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 04:25:07PM +0800, Chris Ruehl wrote:
> Update the rockchip-emmc-phy.txt and add the u32 property
> 'output-tapdelay-select'. This allow to set the otapdlysec register.
> 
> Tested with our customized rk3399 board to tune eMMC.
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
>  Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
> index 3e4d2d79a65d..00aa2d349e55 100644
> --- a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
> @@ -18,6 +18,9 @@ Optional properties:
>                          If not set, the default value of 50 will be applied.
>   - enable-strobe-pulldown: Enable internal pull-down for the strobe line.
>                             If not set, pull-down is not used.
> + - output-tapdelay-select: Specifies the phyctrl_otapdlysec register.
> +                           If not set, the register defaults to 0x4.
> +                           Maximum value 0xf.

Needs a vendor prefix.

>  
>  Example:
>  
> -- 
> 2.20.1
> 
