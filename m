Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B12828BE93
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 19:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403883AbgJLRAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 13:00:24 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35931 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390541AbgJLRAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 13:00:24 -0400
Received: by mail-ed1-f65.google.com with SMTP id l16so17768505eds.3;
        Mon, 12 Oct 2020 10:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wn7EpXqZqHIQ3MMILy5MY7724GoBcJYnMWBYl3sWpNQ=;
        b=c6BRUtKbt48ex6W2OcK2c55VMoeHQtTiYRsaOSnnzpPbSV0l4Ben0J27sbQerE7ogw
         Pjv2FEs4VZ0LTjA/QvUV2QYU/y5Ro5fWElXp9BkGOctwcteeO3N6Hq/VFb0VGSWFslvh
         2fQmaQHUPg+B5CS3LdZo8f0WfL7BrTEODX4sJSzlt73ByzwQcv54B6u+EyGPsaQWuuEu
         T6sJAIyoVpOgMwjaa3xKOsh14aFajPl0tQEmg8z7OgjOBbgBEWtSIIhbgBS2EwIA439x
         WZR47X54Ukwetf45HZ5LAzgtDaj1KgV4MXsKtQFQjj9/MGRenn0da+ZnQr/6pmQXbmnV
         mpng==
X-Gm-Message-State: AOAM532L4FV1iIx4/YO00hu7EMDRmZMUAcBWmHzAoRP1HVoNtrkYBXjN
        vJFT3bb0m24VMZbUjeEcgjU=
X-Google-Smtp-Source: ABdhPJzISm+wRVoKC+DT01Byee1lSD1AYIeK5EIK2LTNhM9yT1Jeqg3TetDh7RaddD0Dz4nvuuZ2+g==
X-Received: by 2002:aa7:cd4f:: with SMTP id v15mr14664030edw.243.1602522020943;
        Mon, 12 Oct 2020 10:00:20 -0700 (PDT)
Received: from kozik-lap ([194.230.155.215])
        by smtp.googlemail.com with ESMTPSA id o3sm10895646edv.63.2020.10.12.10.00.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Oct 2020 10:00:19 -0700 (PDT)
Date:   Mon, 12 Oct 2020 19:00:16 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: imx8mm: Add node for SPDIF
Message-ID: <20201012170016.GA5369@kozik-lap>
References: <20201008212706.870115-1-aford173@gmail.com>
 <20201008212706.870115-2-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201008212706.870115-2-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 04:27:05PM -0500, Adam Ford wrote:
> The i.MX8M Mini can support SPIDF which is very similar to the

SPIDF -> SPDIF

> IP used on the i.MX35.
> 
> This patch adds the SPIF node.

Just "Add the SPDIF node", avoid "this patch". And SPIF->SPDIF.

> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index fad1f9cdb241..44a59f59f65a 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -358,6 +358,30 @@ micfil: audio-controller@30080000 {
>  				status = "disabled";
>  			};
>  
> +			spdif1: spdif@30090000 {
> +				compatible = "fsl,imx8mm-spdif", "fsl,imx35-spdif";

This does not pass the dtschema validation, so only "fsl,imx35-spdif".

Best regards,
Krzysztof
