Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8CD2DE3B6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 15:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgLROJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 09:09:51 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34364 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbgLROJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 09:09:50 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BIE901h089178;
        Fri, 18 Dec 2020 08:09:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608300540;
        bh=MP/aflp2kqPzZRgdYXg9m6RlHVOpsuvLhLq090MhZCI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=DX2nq+GxbLDSzpLg38r1TBqCBOax+DnNY31pAoP3+mf+ueMDk7eNGm1CXeA3y+s9T
         3r1akq/U1axTTJqJtxucDM9B5YJUAQUqMXY1Z62eT0NZTHbhGcAdyaG5YLGCZzSIHG
         Wg/AS2TsjlVzbGzVOANRCqouSejVQceiT7ldAnwU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BIE90q6078843
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Dec 2020 08:09:00 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 18
 Dec 2020 08:09:00 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 18 Dec 2020 08:09:00 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BIE90on036430;
        Fri, 18 Dec 2020 08:09:00 -0600
Date:   Fri, 18 Dec 2020 08:09:00 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Tero Kristo <t-kristo@ti.com>
CC:     <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Update my email address and maintainer
 level status
Message-ID: <20201218140900.5ys46co2bshgwmuc@monotype>
References: <20201217130721.23555-1-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201217130721.23555-1-t-kristo@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:07-20201217, Tero Kristo wrote:
> My employment with TI is ending tomorrow, so update the email address
> entry in the maintainers file. Also, I don't expect to spend that much
> time with maintaining TI code anymore, so downgrade the status level to
> odd fixes only on areas where I remain as the main contact point for
> now, and move myself as secondary contact point where someone else has
> taken over the maintainership.
> 
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tero Kristo <kristo@kernel.org>

Thanks Tero. Much appreciate your help and continued support..

Acked-by: Nishanth Menon <nm@ti.com>

> ---
>  MAINTAINERS | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f59ebd1eda3d..c362d8d9d316 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2615,8 +2615,8 @@ S:	Maintained
>  F:	drivers/power/reset/keystone-reset.c
>  
>  ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE
> -M:	Tero Kristo <t-kristo@ti.com>
>  M:	Nishanth Menon <nm@ti.com>
> +M:	Tero Kristo <kristo@kernel.org>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Supported
>  F:	Documentation/devicetree/bindings/arm/ti/k3.yaml
> @@ -6465,9 +6465,9 @@ S:	Maintained
>  F:	drivers/edac/skx_*.[ch]
>  
>  EDAC-TI
> -M:	Tero Kristo <t-kristo@ti.com>
> +M:	Tero Kristo <kristo@kernel.org>
>  L:	linux-edac@vger.kernel.org
> -S:	Maintained
> +S:	Odd Fixes
>  F:	drivers/edac/ti_edac.c
>  
>  EDIROL UA-101/UA-1000 DRIVER
> @@ -17503,7 +17503,7 @@ F:	drivers/iio/dac/ti-dac7612.c
>  
>  TEXAS INSTRUMENTS' SYSTEM CONTROL INTERFACE (TISCI) PROTOCOL DRIVER
>  M:	Nishanth Menon <nm@ti.com>
> -M:	Tero Kristo <t-kristo@ti.com>
> +M:	Tero Kristo <kristo@kernel.org>
>  M:	Santosh Shilimkar <ssantosh@kernel.org>
>  L:	linux-arm-kernel@lists.infradead.org
>  S:	Maintained
> @@ -17647,9 +17647,9 @@ S:	Maintained
>  F:	drivers/clk/clk-cdce706.c
>  
>  TI CLOCK DRIVER
> -M:	Tero Kristo <t-kristo@ti.com>
> +M:	Tero Kristo <kristo@kernel.org>
>  L:	linux-omap@vger.kernel.org
> -S:	Maintained
> +S:	Odd Fixes
>  F:	drivers/clk/ti/
>  F:	include/linux/clk/ti.h
>  
> -- 
> 2.17.1
> 
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
