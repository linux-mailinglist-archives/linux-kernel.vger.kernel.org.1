Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC3F2E7226
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 17:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgL2QNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 11:13:44 -0500
Received: from mail-ej1-f54.google.com ([209.85.218.54]:39631 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgL2QNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 11:13:43 -0500
Received: by mail-ej1-f54.google.com with SMTP id n26so18713419eju.6;
        Tue, 29 Dec 2020 08:13:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jvaxF2qqbNWuMGJFsY0/jXt/I0/AEmLETs3GwqJSk18=;
        b=CWXeNbNeemL3dAhN7TEgbiNrxr0B1bBdiuC6qZ670+8/th9NGyhqZP6F1Qm5TG6d2K
         hhBeRqsTKPlcNvf9xjVGtujjmD3UnZ6cVO+Rt0e/1tNrKSFtonF81AKcZ6yy37eKSRQq
         oGC9KLKOVlpNlAqJ0eDeRrxOFNNHv9R7FMAyJH/i1/lX2Kh/gpJopPZdaW6PLilmmGn0
         wC0TfayszGIyd7j+vxs0EBlWezZxKMWhm7nMNimywfZWpbS5gq1Sq8QU4nVuuDVxjwc5
         upXEN3URtkvSvZK5MEzimKtgshuJ8VqgyeRWHFgNOrf5LX2WYrkkcHAadR510RBgipop
         eQXg==
X-Gm-Message-State: AOAM530pdSw7JidExp+wCl/wKnLnXlVghmOTJWpBeD9ZZXNS63DNiwCS
        iG32JnueTmDd5JrmHL+9JRg=
X-Google-Smtp-Source: ABdhPJyj5hB3vZjTglhIpQkZ3IbFk6ReoXXtsOqKHwm2zdExL3ET4aBoUub9886coqnCotYL91TShQ==
X-Received: by 2002:a17:906:d8a3:: with SMTP id qc3mr46409002ejb.443.1609258382297;
        Tue, 29 Dec 2020 08:13:02 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id dk16sm18309258ejb.85.2020.12.29.08.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 08:13:01 -0800 (PST)
Date:   Tue, 29 Dec 2020 17:13:00 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     peng.fan@nxp.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        robh+dt@kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: imx8mn: add spba bus node
Message-ID: <20201229161300.GB17229@kozik-lap>
References: <1609243245-9671-1-git-send-email-peng.fan@nxp.com>
 <1609243245-9671-4-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1609243245-9671-4-git-send-email-peng.fan@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 08:00:44PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> According to RM, there is a spba bus inside aips3 and aips1, add it.

This does not look like matching contents of commit.

Best regards,
Krzysztof


> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> index 73602832ccaa..033fa90570ff 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -749,7 +749,7 @@ uart2: serial@30890000 {
>  					clock-names = "ipg", "per";
>  					status = "disabled";
>  				};
> -			}
> +			};
>  
>  			crypto: crypto@30900000 {
>  				compatible = "fsl,sec-v4.0";
> -- 
> 2.28.0
> 
