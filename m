Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D459D27D63B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 20:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgI2S4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 14:56:33 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35744 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgI2S4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 14:56:32 -0400
Received: by mail-ot1-f68.google.com with SMTP id s66so5530450otb.2;
        Tue, 29 Sep 2020 11:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yQ/KrzK4yfoKUdCLw0ghQcxTiUteDo9PVTHtCn34YjM=;
        b=Z1RrHA9hpvkE0JAp4qQ/RJZIlH2aCPAx+sB0K4vF8XYbGRCBz8WsqIFPO3YJzEMikB
         dey3DpSDMfs9yMqtFo/e0bppD6lSzK/Pj1m7sm+OERErbMlv0m0jevvseTsseOXK3fL8
         p7tJeynK+phBk+NUHBTHxlMkAhVeIlAWF20q9A6dZSwp1Fsk6fR3K5Qxdj3/1R2pz2lQ
         P4BRd81xgduMkP0HVU/a/QjyPY0RAnsdx9tazoJfQqry7kGde73xi0yAozO5OwDm4SuL
         M8iXBM0l6q1lhwhEQgd/KJh5CiGONbgpF2/8bfuX4VK10TBcoOuW1O4hG5yNfjqzsIen
         3hxQ==
X-Gm-Message-State: AOAM530klJZu8H1sG+7yhR+xfX0JVLimuiMS62LTJhz+iICbW5nBsSEY
        xgW54vRufvnPaoo/oJsh/cuqlI9RUyCP
X-Google-Smtp-Source: ABdhPJzkDOAfc+rv8g28EWOFXY2tIHwtG3dR5Toa04aCVd7WmrKVl84iCy093Kdia2S/C/B2j9xQUQ==
X-Received: by 2002:a9d:5550:: with SMTP id h16mr3851712oti.157.1601405791567;
        Tue, 29 Sep 2020 11:56:31 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z20sm3131969oor.3.2020.09.29.11.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 11:56:30 -0700 (PDT)
Received: (nullmailer pid 961198 invoked by uid 1000);
        Tue, 29 Sep 2020 18:56:30 -0000
Date:   Tue, 29 Sep 2020 13:56:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chu Lin <linchuyuan@google.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        qiongwang@google.com, zhongqil@google.com, jasonling@google.com,
        belgaied@google.com
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: max20730: adding device tree
 doc for max20730
Message-ID: <20200929185630.GA955932@bogus>
References: <20200924215444.2865885-1-linchuyuan@google.com>
 <20200924215444.2865885-2-linchuyuan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924215444.2865885-2-linchuyuan@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 09:54:43PM +0000, Chu Lin wrote:
> max20730 Integrated, Step-Down Switching Regulator with PMBus
> 
> Signed-off-by: Chu Lin <linchuyuan@google.com>
> ---
>  .../bindings/hwmon/maxim,max20730.yaml        | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max20730.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max20730.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max20730.yaml
> new file mode 100644
> index 000000000000..7372b27334c3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max20730.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/maxim,max20730.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim max20730
> +
> +maintainers:
> +  - Jean Delvare <jdelvare@suse.com>
> +  - Guenter Roeck <linux@roeck-us.net>
> +
> +description: |
> +  The MAX20730 is a fully integrated, highly efficient switching regulator
> +  with PMBus for applications operating from 4.5V to 16V and requiring
> +  up to 25A (max) load. This single-chip regulator provides extremely
> +  compact, highefficiency power-delivery solutions with high-precision

space             ^

> +  output voltages and excellent transient response

period needed

> +
> +  Datasheets:
> +    https://datasheets.maximintegrated.com/en/ds/MAX20730.pdf
> +    https://datasheets.maximintegrated.com/en/ds/MAX20734.pdf
> +    https://datasheets.maximintegrated.com/en/ds/MAX20743.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max20730
> +      - maxim,max20734
> +      - maxim,max20743
> +
> +  reg:
> +    maxItems: 1
> +
> +  vout-voltage-divider:
> +    description: |
> +      If voltage divider presents at vout, the voltage at voltage sensor pin
> +      will be scaled. The properties will convert the raw reading to a more
> +      meaningful number if voltage divider presents. It has two numbers,

s/presents/present/

> +      the first number is the output resistor, the second number is the total
> +      resistance. Therefore, the adjusted vout is equal to
> +      Vout = Vout * output_resistance / total resistance.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 2
> +    maxItems: 2
> +
> +required:
> +  - compatible
> +  - reg

additionalProperties: false

> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      max20730@10 {
> +        compatible = "maxim,max20730";
> +        reg = <0x10>;
> +        vout-voltage-divider = <1000 2000>; // vout would be scaled to 0.5
> +      };
> +    };
> -- 
> 2.28.0.681.g6f77f65b4e-goog
> 
