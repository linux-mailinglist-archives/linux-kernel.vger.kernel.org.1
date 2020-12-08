Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17332D1EE1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 01:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgLHAQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 19:16:50 -0500
Received: from gproxy3-pub.mail.unifiedlayer.com ([69.89.30.42]:57857 "EHLO
        gproxy3-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728607AbgLHAQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 19:16:49 -0500
Received: from CMGW (unknown [10.9.0.13])
        by gproxy3.mail.unifiedlayer.com (Postfix) with ESMTP id 1058140338
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 17:16:05 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id mQfkkuxWti1lMmQfkks5YC; Mon, 07 Dec 2020 17:16:05 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.2 cv=KcKiiUQD c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10
 a=evQFzbml-YQA:10 a=VwQbUJbxAAAA:8 a=gEfo2CItAAAA:8 a=Pq8ssVdbdvpq67fBYTkA:9
 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=sptkURWiP4Gy88Gu7hUp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=htbOW0a+Pf/IYLgvmjEO/OkDkvAbUSp4e0JlCKo5s9E=; b=HRZ1yMOAixpF8qH9FyXVuMsBd9
        0zlIMO+yv723icmuVlQ94VDWTzBlNxcEulBqpxvImt+D9L66MXAIzbYIB9NxgQSZLH48qfKhOhuGC
        1oow0Qc9SpJaoGeLHgbkBiBXkHJphkQqycAe+P/OFggbhubRvLu8heySktk8wG4Z++P5kFSjKjsyi
        gaKcFDLeALl3EU8ZZeW30eHdJfxo7WUzYG/B703n2TdVHExe5FDphbzL/MCxJsVZJ0KF+LOmTb47q
        kjBt0xe5/VHUx4yH2absqLYrVcMH32PSdSwnv4p1axCM/2RE1SJtfHI3bY2sAKRHy7Kzwiwo/5roF
        pwiRzCdQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:33514 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kmQfj-001te4-Sx; Tue, 08 Dec 2020 00:16:04 +0000
Date:   Mon, 7 Dec 2020 16:16:03 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Kun Yi <kunyi@google.com>
Subject: Re: [PATCH 2/4] dt-bindings: hwmon: convert AD AD741x bindings to
 dt-schema
Message-ID: <20201208001603.GA59202@roeck-us.net>
References: <20201117220807.208747-1-krzk@kernel.org>
 <20201117220807.208747-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117220807.208747-2-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kmQfj-001te4-Sx
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:33514
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 14
X-Org:  HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 11:08:05PM +0100, Krzysztof Kozlowski wrote:
> Convert the Analog Devices AD741x bindings to dt-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied.

Thanks,
Guenter

> ---
>  .../devicetree/bindings/hwmon/ad741x.txt      | 15 -------
>  .../devicetree/bindings/hwmon/adi,ad741x.yaml | 39 +++++++++++++++++++
>  2 files changed, 39 insertions(+), 15 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/ad741x.txt
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ad741x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ad741x.txt b/Documentation/devicetree/bindings/hwmon/ad741x.txt
> deleted file mode 100644
> index 9102152c8410..000000000000
> --- a/Documentation/devicetree/bindings/hwmon/ad741x.txt
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -* AD7416/AD7417/AD7418 Temperature Sensor Device Tree Bindings
> -
> -Required properties:
> -- compatible: one of
> -		"adi,ad7416"
> -		"adi,ad7417"
> -		"adi,ad7418"
> -- reg: I2C address
> -
> -Example:
> -
> -hwmon@28 {
> -	compatible = "adi,ad7418";
> -	reg = <0x28>;
> -};
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,ad741x.yaml b/Documentation/devicetree/bindings/hwmon/adi,ad741x.yaml
> new file mode 100644
> index 000000000000..ce7f8ce9da0a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/adi,ad741x.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/adi,ad741x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7416/AD7417/AD7418 temperature sensors
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7416
> +      - adi,ad7417
> +      - adi,ad7418
> +
> +  reg:
> +    maxItems: 1
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
> +        temperature-sensor@28 {
> +            compatible = "adi,ad7418";
> +            reg = <0x28>;
> +        };
> +    };
