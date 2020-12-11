Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADF72D7547
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 13:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391304AbgLKMG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 07:06:59 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57538 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729717AbgLKMGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 07:06:32 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BBC4sEE031693;
        Fri, 11 Dec 2020 06:04:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607688294;
        bh=Tu59/3Cv9BBH4Oz+YHX6+4aqIBoWj0gUR86vdaBThG0=;
        h=Subject:CC:References:From:Date:In-Reply-To;
        b=pQQTe8/9P79ImNwSWY8bwsYjm4sipUW8iJ/sWpK5M9ADk0fdkkfPoRQz69+iHWVTG
         GJsd9jvzJptbSuNCxAN/Yw3d6VFu1O4tlnvalFbJYuDipLXQJnyZyvVqSBGhE0TnfX
         tZ5BWAAI/9tkxtWF8rU6f5dlL3Q1j2o/RdiG/3vw=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BBC4sle110761
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Dec 2020 06:04:54 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 11
 Dec 2020 06:00:44 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 11 Dec 2020 06:00:44 -0600
Received: from [10.250.232.169] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BBC0fj9060784;
        Fri, 11 Dec 2020 06:00:41 -0600
Subject: Re: [PATCH v4] dt-bindings: usb: Add new compatible string for AM64
 SoC
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Roger Quadros <rogerq@ti.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20201211060429.20027-1-a-govindraju@ti.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <062c861a-b35e-06cd-2bda-a2d3f5034290@ti.com>
Date:   Fri, 11 Dec 2020 17:30:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201211060429.20027-1-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 11/12/20 11:34 am, Aswath Govindraju wrote:
> Add compatible string in j721e-usb binding file as the same USB subsystem
> is present in AM64.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
> 
> Changes since v3:
> - used enum instead of anyOf.
> 
> Changes since v2:
> - added changes done over the versions.
> 
> Changes since v1:
> - replaced the '\t' at the beginning of the lines with spaces as it was
>   causing the dt_binding_check to fail.
> 
>  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> index 388245b91a55..1a5c7bbb40d1 100644
> --- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> +++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> @@ -11,8 +11,9 @@ maintainers:
>  
>  properties:
>    compatible:
> -    items:
> -      - const: ti,j721e-usb
> +    enum:
> +      - ti,j721e-usb
> +      - ti,am64-usb
> 

I am trying to use the compatible strings in the following manner

```
compatible = "ti,am64-usb", "ti,j721e-usb";

```
If I use above patch I am getting an error while doing a dtbs check.

```
/home/gsaswath/src/ti-linux-kernel/arch/arm64/boot/dts/ti/k3-am642-evm.dt.yaml:
cdns-usb@f900000: compatible: Additional items are not allowed
('ti,j721e-usb' was unexpected)
	From schema:
/home/gsaswath/src/ti-linux-kernel/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
/home/gsaswath/src/ti-linux-kernel/arch/arm64/boot/dts/ti/k3-am642-evm.dt.yaml:
cdns-usb@f900000: compatible: ['ti,am64-usb', 'ti,j721e-usb'] is too long
	From schema:
/home/gsaswath/src/ti-linux-kernel/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml

```


I have looked around for examples but I am unable to find a similar
case. I tried using anyOf in the following manner

```
compatible:
     anyOf:
        - const: ti,am64-usb
        - const: ti,j721e-usb
```

But I am getting an error

```
/home/gsaswath/src/ti-linux-kernel/Documentation/devicetree/bindings/usb/ti,j721e-usb.example.dt.yaml:
cdns_usb@4104000: compatible: 'anyOf' conditional failed, one must be fixed:
	Additional items are not allowed ('ti,j721e-usb' was unexpected)
	['ti,am64-usb', 'ti,j721e-usb'] is too long
	'ti,j721e-usb' was expected
```

Doesn't anyof mean that the compatible strings can be used in any
combination ??

Thanks,
Aswath

>    reg:
>      description: module registers
> 

