Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D6E2F811A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 17:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbhAOQrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 11:47:22 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53720 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbhAOQrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 11:47:21 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10FGjtRF008746;
        Fri, 15 Jan 2021 10:45:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610729155;
        bh=zchShokG7/uvqn5K80CFp02tXojD8KiM9r/o+giCB4E=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=iYbhCDhPcH8tQ2LYnMwQ2jmrKD0AM4eBLOG26lC09fDbeRNNeyB1bIVixWK2WdKG4
         EQY1lTzpOcXaPmT7WOx0WpavlwtVrP6wzy+BpcOnq+SlLhGQHTVxKsRkZivIUEkdSI
         Oe9M7uaR50SnGVEhh4jmrunP9FiX8biOpKcxZPB0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10FGjtxI100716
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Jan 2021 10:45:55 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 15
 Jan 2021 10:45:54 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 15 Jan 2021 10:45:54 -0600
Received: from [10.250.34.42] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10FGjsS7087268;
        Fri, 15 Jan 2021 10:45:54 -0600
Subject: Re: [PATCH 1/2] dt-bindings: soc: ti: ti,pruss: add ti,am1806-pruss
To:     David Lechner <david@lechnology.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20210104183021.330112-1-david@lechnology.com>
 <20210104183021.330112-2-david@lechnology.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <f03b9e77-510a-2ad4-4cb8-4aa3919abeb5@ti.com>
Date:   Fri, 15 Jan 2021 10:45:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210104183021.330112-2-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Sekhar and Bartosz

Hi David,

On 1/4/21 12:30 PM, David Lechner wrote:
> This adds a "ti,am1806-pruss" compatible type for the PRUSS found in
> TI AM18xx/OMAP-L138 SoCs.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> index 037c51b2f972..a6ed23fdbc00 100644
> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> @@ -61,6 +61,7 @@ properties:
>  
>    compatible:
>      enum:
> +      - ti,am1806-pruss  # for AM18xx/OMAP-L138 SoC family

Almost all the drivers for these SoCs use the prefix "ti,da850-xxx" for the
compatibles. Can we switch to using those instead of ti,am1806?

regards
Suman

>        - ti,am3356-pruss  # for AM335x SoC family
>        - ti,am4376-pruss0 # for AM437x SoC family and PRUSS unit 0
>        - ti,am4376-pruss1 # for AM437x SoC family and PRUSS unit 1
> @@ -321,6 +322,7 @@ if:
>      compatible:
>        contains:
>          enum:
> +          - ti,am1806-pruss
>            - ti,k2g-pruss
>            - ti,am654-icssg
>            - ti,j721e-icssg
> 

