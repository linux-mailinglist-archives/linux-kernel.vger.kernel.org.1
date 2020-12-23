Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440A02E1C02
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 12:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgLWLsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 06:48:09 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:33405 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgLWLsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 06:48:08 -0500
Received: by mail-wr1-f44.google.com with SMTP id t30so18380900wrb.0;
        Wed, 23 Dec 2020 03:47:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9PVUTbFRR1JynPbfBxdIGB2FDbBUwVcKx9vabgDVC9s=;
        b=XumOr65hOHD+BwT9sfnYxTQOAiBCDU/itIGY2aFT8T8fXD0g3qLAWkERCT4qrlaEi/
         ks5OKZcjhxNn7e6PlM1gE+YhmvM7ghwouo6EDaWKS3Rd9rF7jYS9oWYMeaxXI9C/Zohj
         zAAVzxxiYO08l/R3mCOtRWamoQZCaPuc7VpCyiAWtcrLZe4G3XxGFgZopWzypYNvLkX+
         ffxWPkSnHJkG68UOZV36Y8gDuFrxEZVByt0uAoyhD/Lu+8DuIueZnuhU1TLJf7dW+uK3
         svINCEKgRUE0FDN1mcbl6dK8dFMr+8NPg7+okjhauRQRixD0KsHXAV79cjp2zlGOvR+r
         ky+Q==
X-Gm-Message-State: AOAM533Y31IVCOtY6J6WT/TJu+9yCeuUVA+DfXUxxLdA2cOGrnvyULp1
        dZ3h6IwjgSTIXwyzNGgdLc8=
X-Google-Smtp-Source: ABdhPJwMJqHGt4IFm68GdFF5nZDTTZDOmWIT//j4L81Mhkcq+FKyCVAac9Si77CalKv+xR+ZWowiew==
X-Received: by 2002:a05:6000:1152:: with SMTP id d18mr29257735wrx.6.1608724046353;
        Wed, 23 Dec 2020 03:47:26 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id b19sm29595439wmj.37.2020.12.23.03.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 03:47:25 -0800 (PST)
Date:   Wed, 23 Dec 2020 12:47:23 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matteo Lisi <matteo.lisi@engicam.com>
Subject: Re: [PATCH v3 3/6] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini
 SoM
Message-ID: <20201223114723.GB21091@kozik-lap>
References: <20201223110343.126638-1-jagan@amarulasolutions.com>
 <20201223110343.126638-4-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201223110343.126638-4-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 04:33:40PM +0530, Jagan Teki wrote:
> i.Core MX8M Mini is an EDIMM SoM based on NXP i.MX8M Mini
> from Engicam.
> 
> General features:
> - NXP i.MX8M Mini
> - Up to 2GB LDDR4
> - 8/16GB eMMC
> - Gigabit Ethernet
> - USB 2.0 Host/OTG
> - PCIe Gen2 interface
> - I2S
> - MIPI DSI to LVDS
> - rest of i.MX8M Mini features
> 
> i.Core MX8M Mini needs to mount on top of Engicam baseboards
> for creating complete platform solutions.
> 
> Add support for it.
> 
> Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - keep regulator min/max hoping
> Changes for v2:
> - updated commit message
> - add cpu nodes
> - add fec1 node
> - fixed pmic tree comments
> - dropped engicam from filename since it aligned with imx6 engicam
>   dts files naming conventions.
> 
>  .../dts/freescale/imx8mm-icore-mx8mm.dtsi     | 232 ++++++++++++++++++
>  1 file changed, 232 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm.dtsi

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

