Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820442FB857
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392663AbhASMSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 07:18:16 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43410 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390327AbhASMJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 07:09:10 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10JC8RPG128742;
        Tue, 19 Jan 2021 06:08:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611058107;
        bh=kvrZYowJSqX9MDzYtcglFyrE+Ao3yGQ51T2K6DtJl7g=;
        h=Subject:CC:References:From:Date:In-Reply-To;
        b=G15EauPYYp8ADI+Vpd5im6/M+waSJu5IR/7+LH+CT+sNLQMF7JOW7pQ0iDX1wxfJN
         W3Li6pA/huxdVlg0jeEUFTI3ZIjBcGckPCtv+whgjQ9L+LHTR6oQvlZt+AZ+Hxysti
         TMfvOJkRyrr7jmRmI1QfHUGIAUOMIrz/cT5cEMo4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10JC8Rqh095248
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Jan 2021 06:08:27 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 19
 Jan 2021 06:08:27 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 19 Jan 2021 06:08:26 -0600
Received: from [10.250.232.169] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10JC8Ml8007480;
        Tue, 19 Jan 2021 06:08:23 -0600
Subject: Re: [PATCH] dt-bindings: usb: Add ranges and dma-coherent property
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20210119064224.6946-1-a-govindraju@ti.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <d5c8b823-9751-dffb-4bdf-e1d1029735e0@ti.com>
Date:   Tue, 19 Jan 2021 17:38:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210119064224.6946-1-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/21 12:12 pm, Aswath Govindraju wrote:
> Add ranges and dma-coherent property in ti,j721e-usb dt-binding.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---

I am very sorry this patch is a duplicate of the patch,
https://lore.kernel.org/patchwork/patch/1366215/

Kindly ignore.

Thanks,
Aswath

>  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> index 4423f0a29f54..0c553e72d2ff 100644
> --- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> +++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> @@ -38,6 +38,8 @@ properties:
>        - const: ref
>        - const: lpm
>  
> +  ranges: true
> +
>    ti,usb2-only:
>      description:
>        If present, it restricts the controller to USB2.0 mode of
> @@ -63,6 +65,8 @@ properties:
>    '#size-cells':
>      const: 2
>  
> +  dma-coherent: true
> +
>  patternProperties:
>    "^usb@":
>      type: object
> @@ -73,6 +77,7 @@ required:
>    - power-domains
>    - clocks
>    - clock-names
> +  - ranges
>  
>  additionalProperties: false
>  
> @@ -95,6 +100,7 @@ examples:
>              assigned-clock-parents = <&k3_clks 288 16>; /* HFOSC0 */
>              #address-cells = <2>;
>              #size-cells = <2>;
> +            ranges;
>  
>              usb@6000000 {
>                    compatible = "cdns,usb3";
> 

