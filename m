Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344562FB850
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392556AbhASMQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 07:16:58 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35244 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732409AbhASMIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 07:08:50 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10JC6QJi052188;
        Tue, 19 Jan 2021 06:06:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611057986;
        bh=gx/uox2HkSxRJWIW+/oeYtSkbyPUTy3/ZXHFNZSNNKw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=DqftxCR6hZnMQ2Pl+ozI5bfYcVORgcjHQWaL7RoxBpG/AG/4RkUO8dF3Wlqnb+udT
         FNVp/XOrgjtuy0Dt39XYMAKzlBCZAMyST52hPhZ9RmlkGT1GeD2zHBlfF/GsqpJuhy
         h5bPSGoThLJ640BbX43rNuKeyp6I274Juof8lfyc=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10JC6Qsm034414
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Jan 2021 06:06:26 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 19
 Jan 2021 06:06:25 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 19 Jan 2021 06:06:25 -0600
Received: from [10.250.232.169] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10JC6MRl004593;
        Tue, 19 Jan 2021 06:06:23 -0600
Subject: Re: [PATCH] dt-bindings: usb: j721e: add ranges and dma-coherent
 props
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-usb@vger.kernel.org>
References: <20210115193124.5706-1-grygorii.strashko@ti.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <a9a36b3e-d93e-5e23-d040-22da1d65f991@ti.com>
Date:   Tue, 19 Jan 2021 17:36:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210115193124.5706-1-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/21 1:01 am, Grygorii Strashko wrote:
> Add missed 'ranges' and 'dma-coherent' properties as cdns-usb DT nodes has
> child node and DMA IO is coherent on TI K3 J721E/J7200 SoCs.
> 
> This also fixes dtbs_check warning:
>  cdns-usb@4104000: 'dma-coherent', 'ranges' do not match any of the regexes: '^usb@', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> index 4423f0a29f54..7ec87a783c5c 100644
> --- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> +++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> @@ -21,6 +21,8 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  ranges: true
> +
>    power-domains:
>      description:
>        PM domain provider node and an args specifier containing
> @@ -63,6 +65,8 @@ properties:
>    '#size-cells':
>      const: 2
>  
> +  dma-coherent: true
> +
>  patternProperties:
>    "^usb@":
>      type: object
> 

Acked-by: Aswath Govindraju <a-govindraju@ti.com>
Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>
