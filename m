Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45A92D886F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 18:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407677AbgLLQrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 11:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392549AbgLLQrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 11:47:05 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F668C0613CF;
        Sat, 12 Dec 2020 08:46:25 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id d27so13859911oic.0;
        Sat, 12 Dec 2020 08:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ymG4jEHUUvXvwINChPOK8vrT9NJD/wpkg/b1KPrA2ME=;
        b=NB6hS8ZrMm+6EUZA2VCLg1RxPrmeSFn05858jt6Ge8cD/q02rHb9SfK91iBUEiFAhU
         hCkmWNd5TR3PSC8J7jCfQrFIxssdMx9D2jJQKPjyoyyEMRaNMMZ7L1nJ8ewqp88ft+1d
         MoPtPW3sdk2NDI5z0HmeGgwTkMRog76ZlFkn6RObH4NUZTHQo2x1TA4l2U+sbISsGOCB
         Ho5ySzekxPBPqsiORJFyVFF3yk7rkO2N3z4k+2ObW48YbXwldmkcOlewxWddadXZZL1+
         eBhFtnxZbxr/NBorMXaUhgvOKEQhE06Q3Kv2W4FEY0dq9l75MVOJHxSD1UgtGW16j4IP
         gF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ymG4jEHUUvXvwINChPOK8vrT9NJD/wpkg/b1KPrA2ME=;
        b=kiFtapksqO1Tqf26LxX/dTd0FjdjUUQcSrxvYy4H1XgcdBuy+v+sG0BBR+kGT6Dz9L
         jLp7oXJ48zR/P4uV4DyjGz810FySdSqTVkwZr8EUniX+miM90Ylv4eGxhE2eA1sbVJ1P
         L5yEamIz3TuiSS2zfTjhgomuV+JE38/VZuSWImCXbA+aNTY+bWSmNS/+7lsfZdJ9tWXD
         1GFLAkIDsZ9ztRwMWu+RgCPVB1b5DN4lt51Zt54LHN4J+EaatGC5RFDcUorRhfPY/Dj1
         vZK5OFAul9njk92BbEKBqrhDA98oPRN5yIDQLzxlphNZt4mIu6zEgvM69Pf2Gct48fc3
         INjw==
X-Gm-Message-State: AOAM532PDO4Npf871hI3nFFpLFCeTXWai3J0AKUL9UoN1i8tv0r7mNFL
        NTzTNlW9Gwr3eNIqgdZ/Qc4=
X-Google-Smtp-Source: ABdhPJzY4CcqiSHA/j8rLYR6wVjUUREvl9Yx2emWlvX3UmOLenWAz5r/ylh7hyu/TImUaFeCCcAaPg==
X-Received: by 2002:a05:6808:6c2:: with SMTP id m2mr13131024oih.123.1607791584720;
        Sat, 12 Dec 2020 08:46:24 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c18sm2733642oib.31.2020.12.12.08.46.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 Dec 2020 08:46:24 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 12 Dec 2020 08:46:23 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kun Yi <kunyi@google.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        supreeth.venkatesh@amd.com, openbmc@lists.ozlabs.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux hwmon-next v5 3/3] dt-bindings: (hwmon/sbtsi_tmep)
 Add SB-TSI hwmon driver bindings
Message-ID: <20201212164623.GA29335@roeck-us.net>
References: <20201211215427.3281681-1-kunyi@google.com>
 <20201211215427.3281681-4-kunyi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211215427.3281681-4-kunyi@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 01:54:27PM -0800, Kun Yi wrote:
> Document device tree bindings for AMD SB-TSI emulated temperature
> sensor.
> 
> Signed-off-by: Kun Yi <kunyi@google.com>

Applied, after fixing the subject line.
I also added Rob's Reviewed-by: tag from v2.

Guenter

> ---
>  .../devicetree/bindings/hwmon/amd,sbtsi.yaml  | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/amd,sbtsi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/amd,sbtsi.yaml b/Documentation/devicetree/bindings/hwmon/amd,sbtsi.yaml
> new file mode 100644
> index 000000000000..446b09f1ce94
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/amd,sbtsi.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/amd,sbtsi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: >
> +  Sideband interface Temperature Sensor Interface (SB-TSI) compliant
> +  AMD SoC temperature device
> +
> +maintainers:
> +  - Kun Yi <kunyi@google.com>
> +  - Supreeth Venkatesh <supreeth.venkatesh@amd.com>
> +
> +description: |
> +  SB Temperature Sensor Interface (SB-TSI) is an SMBus compatible
> +  interface that reports AMD SoC's Ttcl (normalized temperature),
> +  and resembles a typical 8-pin remote temperature sensor's I2C interface
> +  to BMC. The emulated thermal sensor can report temperatures in increments
> +  of 0.125 degrees, ranging from 0 to 255.875.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - amd,sbtsi
> +
> +  reg:
> +    maxItems: 1
> +    description: |
> +      I2C bus address of the device as specified in Section 6.3.1 of the
> +      SoC register reference. The SB-TSI address is normally 98h for socket
> +      0 and 90h for socket 1, but it could vary based on hardware address
> +      select pins.
> +      \[open source SoC register reference\]
> +        https://www.amd.com/system/files/TechDocs/56255_OSRR.pdf
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        sbtsi@4c {
> +                compatible = "amd,sbtsi";
> +                reg = <0x4c>;
> +        };
> +    };
> +...
