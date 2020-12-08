Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3E32D1EE4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 01:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgLHARU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 19:17:20 -0500
Received: from gproxy3-pub.mail.unifiedlayer.com ([69.89.30.42]:55989 "EHLO
        gproxy3-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728627AbgLHARU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 19:17:20 -0500
Received: from cmgw15.unifiedlayer.com (unknown [10.9.0.15])
        by gproxy3.mail.unifiedlayer.com (Postfix) with ESMTP id 98B544008A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 17:16:39 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id mQgJk6k7Mh41lmQgJk8kyD; Mon, 07 Dec 2020 17:16:39 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=O5cXQi1W c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=zTNgK-yGK50A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=VwQbUJbxAAAA:8
 a=gEfo2CItAAAA:8 a=sozttTNsAAAA:8 a=i0lMqlOU_K7d7D0v5JsA:9
 a=CjuIK1q_8ugA:10:nop_charset_2 a=AjGcO6oz07-iQ99wixmX:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=aeg5Gbbo78KNqacMgKqU:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kkEkNJy0lO/e3fz/CxQHPrgbGis0YmD6vhn7gvjMzc8=; b=fACOFhCqe0XmXYFD/l6XWRrmr7
        lmYxQBhLjG9PbkgMX+wKgmvnMzavn5PYrHDlBlsVxHZL4KZsM8tXiyAlbfRWfftFsy7JEMiH1gaxb
        vR4iY66ic0VHnASanGYA5E5SetM3gksc4OtX9bGiA6S/s10RnbVdpyWWLOJJrIFsMogj4ZN38TVWl
        fH9Ew4uHZ492RSTwE/s2mUEZZ6YOdaoAV9y8aqGLerOeEhIAVJsyuFF4eNQQVgpNh1Sa7BpRZ9LDt
        CL4Q5szOE7kbm4anxSHN5uTbJfOqXeBdx6dAPfs916ou94Eyq9uzrYt/AkbTLXQQGSIkfn8SnEe8a
        f738K18w==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:33518 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kmQgI-001u2N-Fd; Tue, 08 Dec 2020 00:16:38 +0000
Date:   Mon, 7 Dec 2020 16:16:37 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Kun Yi <kunyi@google.com>
Subject: Re: [PATCH 3/4] dt-bindings: hwmon: convert TI ADS7828 bindings to
 dt-schema
Message-ID: <20201208001637.GA59306@roeck-us.net>
References: <20201117220807.208747-1-krzk@kernel.org>
 <20201117220807.208747-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117220807.208747-3-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kmQgI-001u2N-Fd
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:33518
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 24
X-Org:  HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 11:08:06PM +0100, Krzysztof Kozlowski wrote:
> Convert the TI ADS7828 bindings to dt-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied.

Thanks,
Guenter

> ---
>  .../devicetree/bindings/hwmon/ads7828.txt     | 25 --------
>  .../devicetree/bindings/hwmon/ti,ads7828.yaml | 57 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  4 --
>  3 files changed, 57 insertions(+), 29 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/ads7828.txt
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ti,ads7828.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ads7828.txt b/Documentation/devicetree/bindings/hwmon/ads7828.txt
> deleted file mode 100644
> index fe0cc4ad7ea9..000000000000
> --- a/Documentation/devicetree/bindings/hwmon/ads7828.txt
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -ads7828 properties
> -
> -Required properties:
> -- compatible: Should be one of
> -	       ti,ads7828
> -	       ti,ads7830
> -- reg: I2C address
> -
> -Optional properties:
> -
> -- ti,differential-input
> -  Set to use the device in differential mode.
> -- vref-supply
> -  The external reference on the device is set to this regulators output. If it
> -  does not exists the internal reference will be used and output by the ads78xx
> -  on the "external vref" pin.
> -
> -  Example ADS7828 node:
> -
> -  ads7828: ads@48 {
> -	   comatible = "ti,ads7828";
> -	   reg = <0x48>;
> -	   vref-supply = <&vref>;
> -	   ti,differential-input;
> -  };
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,ads7828.yaml b/Documentation/devicetree/bindings/hwmon/ti,ads7828.yaml
> new file mode 100644
> index 000000000000..33ee575bb09d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ti,ads7828.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/ti,ads7828.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments ADS7828/ADS7830 Analog to Digital Converter (ADC)
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +
> +description: |
> +  The ADS7828 is 12-Bit, 8-Channel Sampling Analog to Digital Converter (ADC)
> +  with an I2C interface.
> +
> +  Datasheets:
> +    https://www.ti.com/product/ADS7828
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,ads7828
> +      - ti,ads7830
> +
> +  reg:
> +    maxItems: 1
> +
> +  ti,differential-input:
> +    description:
> +      Set to use the device in differential mode.
> +    type: boolean
> +
> +  vref-supply:
> +    description:
> +      The regulator to use as an external reference. If it does not exists the
> +      internal reference will be used.
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
> +        adc@48 {
> +            comatible = "ti,ads7828";
> +            reg = <0x48>;
> +            vref-supply = <&vref>;
> +            ti,differential-input;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index ab623ba930d5..1b1fa0424539 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -350,10 +350,6 @@ properties:
>            - st,24c256
>              # Ambient Light Sensor with SMBUS/Two Wire Serial Interface
>            - taos,tsl2550
> -            # 8-Channels, 12-bit ADC
> -          - ti,ads7828
> -            # 8-Channels, 8-bit ADC
> -          - ti,ads7830
>              # Temperature Monitoring and Fan Control
>            - ti,amc6821
>              # Temperature sensor with 2-wire interface
