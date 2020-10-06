Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491B028541C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 23:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbgJFVvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 17:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgJFVvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 17:51:46 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2D6C061755;
        Tue,  6 Oct 2020 14:51:46 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id f37so258577otf.12;
        Tue, 06 Oct 2020 14:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5L+gLeTbCB4MFIuoEXCXhV99qSHj08vZ9RH6pYhyr8M=;
        b=HBjMjiII9lPdYlDVdBNEud8p77zdAFiv/3lSAMvGsKHH8RxZ851bVT+7zmPkYmMS2l
         fewmYccfP2ZhoOxwaVG7lLDyI2z6KM/03zhWgyjJ3Pu/pyV6HOFvWh9WYup8JaARohio
         CpHyXet1TwUUzG7YNO5tTRfaitnkfSAyN/wPQlJEzSKaFjHfocAr2BfSvUamkOvV1xKb
         FNFfyRoIDe5NC8hT4MA+Q7T/KLM/Im4XRS1ZG/Jh12fmPKWBaKtZRvhnMA4eDVVrFkIg
         CiTtEqyxM2p8nndiHiWCyqVjJPXrU7TFW+7rMWnXxzfY0QEU5zMAlPxKTFAHz4ig6NHd
         +JUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5L+gLeTbCB4MFIuoEXCXhV99qSHj08vZ9RH6pYhyr8M=;
        b=GsqtiaQ7Cnb2Ydn7GKwcKdlVobvxv5qdgNvcdT63jZ+mOec+fMie7BE8AH3fbLtFvu
         Y2XTipZV2RHOybI6UpjNTl+xrghCIfu06/k5UAd0YTxfr/ELJ1H+OSkqVj+c7fYwzdLJ
         LA23Fil8l8XR68hNDppauhKwoZhFprryF1LUWKZft1D3wa3juxv2TzyB3blniZXeE9bE
         Np+wYHOvHZvcoFglwmkUhoZqXeM4VK94D+G77dmWG9Yc8ZMswajmmdpX4LgbulCVP+nH
         cb8Nf7QD5DQPQviW5K5u1smXzJ77J3uABcW4b07x5VNyCOPWJjCcf1hPFX+CYfInq1qd
         ofJQ==
X-Gm-Message-State: AOAM5325j3MdfeyD64F+HswWOIdMrOk72nOuF9gIFI1L1RrjCbzPEBAn
        GEsVln64vCc4ZGfuJk8lpe0=
X-Google-Smtp-Source: ABdhPJzysNBDu1Mx2hKoxCqoj/cHnY41oZNrQ3PVb0m9YiWNB33Qf6b9ti/s+dhXSJsty2t0rZ2T7Q==
X-Received: by 2002:a9d:241:: with SMTP id 59mr1589otb.151.1602021105475;
        Tue, 06 Oct 2020 14:51:45 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g26sm6554otn.77.2020.10.06.14.51.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Oct 2020 14:51:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 6 Oct 2020 14:51:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     jdelvare@suse.com, p.zabel@pengutronix.de,
        linux-hwmon@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v5 1/2] Add DT bindings schema for PVT controller
Message-ID: <20201006215144.GA96365@roeck-us.net>
References: <cover.1601889876.git.rahul.tanwar@linux.intel.com>
 <b540b49ca47d75c5f716f8a4e4eed0664a1116bf.1601889876.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b540b49ca47d75c5f716f8a4e4eed0664a1116bf.1601889876.git.rahul.tanwar@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 05:27:45PM +0800, Rahul Tanwar wrote:
> PVT controller (MR75203) is used to configure & control
> Moortec embedded analog IP which contains temprature sensor(TS),
> voltage monitor(VM) & process detector(PD) modules.
> 
> Add DT bindings schema for PVT controller.
> 
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  .../devicetree/bindings/hwmon/moortec,mr75203.yaml | 71 ++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> new file mode 100644
> index 000000000000..6f3e3c01f717
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/moortec,mr75203.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Moortec Semiconductor MR75203 PVT Controller bindings
> +
> +maintainers:
> +  - Rahul Tanwar <rtanwar@maxlinear.com>
> +
> +properties:
> +  compatible:
> +    const: moortec,mr75203
> +
> +  reg:
> +    items:
> +      - description: PVT common registers
> +      - description: PVT temprature sensor registers
> +      - description: PVT process detector registers
> +      - description: PVT voltage monitor registers
> +
> +  reg-names:
> +    items:
> +      - const: common
> +      - const: ts
> +      - const: pd
> +      - const: vm
> +
> +  intel,vm-map:
> +    description:
> +      PVT controller has 5 VM (voltage monitor) sensors.
> +      vm-map defines CPU core to VM instance mapping. A
> +      value of 0xff means that VM sensor is unused.
> +    $ref: /schemas/types.yaml#definitions/uint8-array
> +    maxItems: 5
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  "#thermal-sensor-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - intel,vm-map
> +  - clocks
> +  - resets
> +  - "#thermal-sensor-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pvt: pvt@e0680000 {
> +        compatible = "moortec,mr75203";
> +        reg = <0xe0680000 0x80>,
> +              <0xe0680080 0x180>,
> +              <0xe0680200 0x200>,
> +              <0xe0680400 0xc00>;
> +        reg-names = "common", "ts", "pd", "vm";
> +        intel,vm-map = [03 01 04 ff ff];
> +        clocks = <&osc0>;
> +        resets = <&rcu0 0x40 7>;
> +        #thermal-sensor-cells = <1>;
> +    };
