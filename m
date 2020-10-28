Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460F829D3A6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgJ1Vpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:45:52 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43410 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgJ1Vns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:43:48 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09SLhaTJ058741;
        Wed, 28 Oct 2020 16:43:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603921416;
        bh=rKwBi6lLjjepnpsz5X/9dYoEl9YGuELhyvzjY0sjk3A=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=JWaTF6lbh5Hbhj2kf+cJjx+NqhzDgW+wiExZ4GuLHyty737HA+E8aV8S8F1YJ3ys+
         L50g/rUn1E1RKmq8tNSsM0Wxt3yNWYLV+TYXCcfZXz3TP2qEF8n3GY616NGFoYRqf7
         bH+qsLjiB82/mXnO6+UgMvsHUXWaQuslSGn962C8=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09SLhaO8122339
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 16:43:36 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 28
 Oct 2020 16:43:36 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 28 Oct 2020 16:43:36 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09SLha4b108673;
        Wed, 28 Oct 2020 16:43:36 -0500
Date:   Wed, 28 Oct 2020 16:43:36 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Tero Kristo <t-kristo@ti.com>
CC:     <ssantosh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] soc: ti: ti_sci_pm_domains: check for proper args count
 in xlate
Message-ID: <20201028214336.qfwbs46j5x6cpjhr@award>
References: <20201028141700.10510-1-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201028141700.10510-1-t-kristo@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:17-20201028, Tero Kristo wrote:
> K2G devices still only use single parameter for power-domains property,
> so check for this properly in the driver. Without this, every peripheral
> fails to probe resulting in boot failure.
> 
> Fixes: efa5c01cd7ee ("soc: ti: ti_sci_pm_domains: switch to use multiple genpds instead of one")
> Reported-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  drivers/soc/ti/ti_sci_pm_domains.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/ti/ti_sci_pm_domains.c b/drivers/soc/ti/ti_sci_pm_domains.c
> index af2126d2b2ff..8afb3f45d263 100644
> --- a/drivers/soc/ti/ti_sci_pm_domains.c
> +++ b/drivers/soc/ti/ti_sci_pm_domains.c
> @@ -91,7 +91,7 @@ static struct generic_pm_domain *ti_sci_pd_xlate(
>  	struct genpd_onecell_data *genpd_data = data;
>  	unsigned int idx = genpdspec->args[0];
>  
> -	if (genpdspec->args_count < 2)
> +	if (genpdspec->args_count != 1 && genpdspec->args_count != 2)
>  		return ERR_PTR(-EINVAL);
>  
>  	if (idx >= genpd_data->num_domains) {


Thanks Tero.

Acked-by: Nishanth Menon <nm@ti.com>

Santosh: can we queue this one for 5.10? - I am trying to track and get
all platforms booting and functional in 5.10

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
