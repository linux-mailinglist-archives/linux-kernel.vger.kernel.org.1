Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2310B2D1EDB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 01:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgLHAQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 19:16:15 -0500
Received: from gproxy1-pub.mail.unifiedlayer.com ([69.89.25.95]:58098 "EHLO
        gproxy1-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728020AbgLHAQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 19:16:15 -0500
Received: from cmgw14.unifiedlayer.com (unknown [10.9.0.14])
        by gproxy1.mail.unifiedlayer.com (Postfix) with ESMTP id 64576C10DAD3D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 17:15:34 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id mQfFkMNrjwNNlmQfGkXXr9; Mon, 07 Dec 2020 17:15:34 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=Hac6sBM8 c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=zTNgK-yGK50A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=VwQbUJbxAAAA:8
 a=gEfo2CItAAAA:8 a=sozttTNsAAAA:8 a=_jlGtV7tAAAA:8 a=wkPXI5Rq_EWXVTfHbnkA:9
 a=CjuIK1q_8ugA:10:nop_charset_2 a=AjGcO6oz07-iQ99wixmX:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=aeg5Gbbo78KNqacMgKqU:22 a=nlm17XC03S6CtCLSeiRr:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ncp9CpIxDmtSPeBusVYnYvkP37GO1Y0RnBZMGD5zCRU=; b=ABEQCIcaebv5FWBrXLeGAaii/A
        5+zy3psNbMCq88Iu1L95JjnRyr5Rqo8YwNegpYiSaCHwg73xSfba9n/aztUIRseAPoYTocHCYTuU+
        SRZgapo63xacABwuFNb37Tq6Yp4th5BUBsKZ5m8k/Pkh2lxeIVH5kxyNScUAolvJRuyuBkrGVtVrc
        ms1uuAUW2wrGhhX4m02X0ZhTJ+u53svMW1fflKOC0CouXGI5ElONFeP920qLPWq6yFFKlEPl5jbtW
        fN3jDuLy8255w467B7PkZI0vLqQpX/se3uHI7p0Jb5nhF1CXn4hIuEUybxWLP2KtM6ncvSZTg8F7S
        2I95eVXg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:33510 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kmQfF-001tGq-6q; Tue, 08 Dec 2020 00:15:33 +0000
Date:   Mon, 7 Dec 2020 16:15:32 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Kun Yi <kunyi@google.com>
Subject: Re: [PATCH 1/4] dt-bindings: hwmon: convert TI INA2xx bindings to
 dt-schema
Message-ID: <20201208001532.GA59098@roeck-us.net>
References: <20201117220807.208747-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117220807.208747-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kmQfF-001tGq-6q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:33510
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 4
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 11:08:04PM +0100, Krzysztof Kozlowski wrote:
> Convert the TI INA2xx bindings to dt-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied.

Thanks,
Guenter

> ---
>  .../devicetree/bindings/hwmon/ina2xx.txt      | 24 --------
>  .../devicetree/bindings/hwmon/ti,ina2xx.yaml  | 55 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 56 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/ina2xx.txt
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ina2xx.txt b/Documentation/devicetree/bindings/hwmon/ina2xx.txt
> deleted file mode 100644
> index 02af0d94e921..000000000000
> --- a/Documentation/devicetree/bindings/hwmon/ina2xx.txt
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -ina2xx properties
> -
> -Required properties:
> -- compatible: Must be one of the following:
> -	- "ti,ina209" for ina209
> -	- "ti,ina219" for ina219
> -	- "ti,ina220" for ina220
> -	- "ti,ina226" for ina226
> -	- "ti,ina230" for ina230
> -	- "ti,ina231" for ina231
> -- reg: I2C address
> -
> -Optional properties:
> -
> -- shunt-resistor
> -	Shunt resistor value in micro-Ohm
> -
> -Example:
> -
> -ina220@44 {
> -	compatible = "ti,ina220";
> -	reg = <0x44>;
> -	shunt-resistor = <1000>;
> -};
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
> new file mode 100644
> index 000000000000..6f0443322a36
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/ti,ina2xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments INA209 family of power/voltage monitors
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +
> +description: |
> +  The INA209 is a high-side current shunt and power monitor with
> +  an I2C interface.
> +
> +  Datasheets:
> +    https://www.ti.com/product/INA209
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,ina209
> +      - ti,ina219
> +      - ti,ina220
> +      - ti,ina226
> +      - ti,ina230
> +      - ti,ina231
> +
> +  reg:
> +    maxItems: 1
> +
> +  shunt-resistor:
> +    description:
> +      Shunt resistor value in micro-Ohm.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        power-sensor@44 {
> +            compatible = "ti,ina220";
> +            reg = <0x44>;
> +            shunt-resistor = <1000>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0818a5b03832..e9ba2e555679 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8669,7 +8669,7 @@ INA209 HARDWARE MONITOR DRIVER
>  M:	Guenter Roeck <linux@roeck-us.net>
>  L:	linux-hwmon@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/hwmon/ina2xx.txt
> +F:	Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
>  F:	Documentation/hwmon/ina209.rst
>  F:	drivers/hwmon/ina209.c
>  
