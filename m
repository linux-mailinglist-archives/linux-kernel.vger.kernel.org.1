Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFBD27D57C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 20:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgI2SJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 14:09:43 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43169 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgI2SJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 14:09:42 -0400
Received: by mail-oi1-f194.google.com with SMTP id i17so6447896oig.10;
        Tue, 29 Sep 2020 11:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UmEX7aRyUiIvvUwVS7hih2bLYD2+vWnKr3oUOONb9+w=;
        b=UMVTwJGKIhdiKI2P0y9zNe7TQce59ixN8s0XUpwZTsmE/UhTdgwJnArlZchSDxg7oN
         QpHn370SiZQIAzEJesfTVBgGdfLu/4dVbi2pga4Roc4gGwSjy7vbERg634c3MMYPie3U
         3KOFF0HKMz3zOUR7FUEf8ovsDrsEkFXFb/bhKqYo/X676SFisD9Sqj4MOqVEuV7g5Km3
         +NG5P8S47RleqsqrphvwYNapC8FZumHUpO4xpV/2Oe3IfsjpRiWYHej7iM8djfwhrOOt
         KU21NQa24Lw/KnBhhi684/tLcZO514ZStvzhTow1afHPHLYCQ3K3sDtk1MsXfYjPz3fH
         RoNw==
X-Gm-Message-State: AOAM532RRVoHY0UoNM0InJe//b+PZSteckWhBloxj6vgHmYqLFbAUL4P
        oJLPf0tuXzband8q+Eqwdg==
X-Google-Smtp-Source: ABdhPJz+WWxtld/0/zsMzKVVpMtXvQOq50LlLu+mJKPkxvkEcsbCgmr7/K+m1N6Bmk4hCyu2MiY6iw==
X-Received: by 2002:aca:538f:: with SMTP id h137mr3449806oib.103.1601402981749;
        Tue, 29 Sep 2020 11:09:41 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f1sm3046487ooq.12.2020.09.29.11.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 11:09:41 -0700 (PDT)
Received: (nullmailer pid 885000 invoked by uid 1000);
        Tue, 29 Sep 2020 18:09:40 -0000
Date:   Tue, 29 Sep 2020 13:09:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Piyush Mehta <piyush.mehta@xilinx.com>
Cc:     axboe@kernel.dk, p.zabel@pengutronix.de, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, sgoud@xilinx.com, michal.simek@xilinx.com
Subject: Re: [PATCH V2 1/2] dt-bindings: ata: ahci: ceva: Update
 documentation for CEVA Controller
Message-ID: <20200929180940.GA882918@bogus>
References: <1600769713-944-1-git-send-email-piyush.mehta@xilinx.com>
 <1600769713-944-2-git-send-email-piyush.mehta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600769713-944-2-git-send-email-piyush.mehta@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 03:45:12PM +0530, Piyush Mehta wrote:
> This patch updates the documentation for the CEVA controller for adding
> the optional properties for 'phys' and 'resets'.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> ---
>  Documentation/devicetree/bindings/ata/ahci-ceva.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-ceva.txt b/Documentation/devicetree/bindings/ata/ahci-ceva.txt
> index 7561cc4..da423eb 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-ceva.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-ceva.txt
> @@ -38,6 +38,9 @@ Required properties:
>  
>  Optional properties:
>    - ceva,broken-gen2: limit to gen1 speed instead of gen2.
> +  - phys: phandle for the PHY device
> +  - phy-names: Should be "sata-phy"

Not really a useful name. There's not much point to *-names when only 1.

> +  - resets: phandle to the reset controller for the SATA IP
>  
>  Examples:
>  	ahci@fd0c0000 {
> @@ -56,4 +59,7 @@ Examples:
>  		ceva,p1-burst-params = /bits/ 8 <0x0A 0x08 0x4A 0x06>;
>  		ceva,p1-retry-params = /bits/ 16 <0x0216 0x7F06>;
>  		ceva,broken-gen2;
> +		phy-names = "sata-phy";
> +		phys = <&psgtr 1 PHY_TYPE_SATA 1 1>;
> +		resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
>  	};
> -- 
> 2.7.4
> 
