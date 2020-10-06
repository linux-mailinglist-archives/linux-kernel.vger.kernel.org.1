Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53673285433
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 23:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgJFVzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 17:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgJFVza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 17:55:30 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDD6C061755;
        Tue,  6 Oct 2020 14:55:30 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id o8so330158otl.4;
        Tue, 06 Oct 2020 14:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fw9scDYwnYqh9lbjj7y9Lc0xhOLikf4SJcoavRTek4Q=;
        b=gMqlMI06RHSy3yXaV56ZpYv8TOaGKyxn2nNGzbYeV55t3749MjsHL3BImSZOd+hYu3
         +Fz9h3vOOCsZq4DGMKDhYEorZRd80LGZN7xMgvxqb2Q7P6sg8nh13SJ1sppuS+8lAPs3
         HZ3BIj/eUNfwPJod2LDfCbACzKOK2bh6FwGgaKclpqyY4VHp8PwQaNxaG179UJKb3X2f
         /851F+n4f40dkONdHT20xbb5kxIxt0UDyYNSTZmQyTOv9+KFxSNDxjLfJ7g9U9UJ/ZKf
         WrxsqBG+MRcK0z2lpKhbqdbKbAZGVKMEN6EDlv6H6SbJU7h9PaM6Jmk6+uXSRO2ecaUW
         A1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fw9scDYwnYqh9lbjj7y9Lc0xhOLikf4SJcoavRTek4Q=;
        b=D7btILMnyf4D4uQ5RIBsU2z2W/usMQa7wlRZ/vkT6iwyBOSvStsXPCoY8scn3YDoIh
         tDuu76wf2hi+3e+3S7MW7HwOu5dhIrO/cbC3hpe+CmJbS45Fk9IvBTLlb3j+TWMyH45y
         /uZ74bmM6iOmw004QDTb0gQ5x8RkzoSyd4JqZPeuYDuG5qVMJ1jtV+1eH11miV50r6ND
         S1U2cabcxrwsOCa5OsPMNETJ3h469LN7sXdHoa8C/269GHN6aM4qg6JgYsKLekT2yIqk
         0w+0k3VzgzTB8HNN48g9UxRRspH2oMXuutUTx2JAxoACDGErmSs5ZHB1HkD6InHUA9n6
         01bg==
X-Gm-Message-State: AOAM531hRmBnGvJmzr4APS7ZX3uyt27Wa5mly5MUY/S4eykTC9BbL+n5
        rLNpcsAIiJxaKjtxyhr/TZo=
X-Google-Smtp-Source: ABdhPJzSq3b2SMqKWooMwB5wh0tPNLsf3olhKGtTimJFE/AkqNsaNGf+lwbYNpUMO4bsqq10sXqNEw==
X-Received: by 2002:a05:6830:14cb:: with SMTP id t11mr33379otq.74.1602021330242;
        Tue, 06 Oct 2020 14:55:30 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b17sm201482oog.25.2020.10.06.14.55.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Oct 2020 14:55:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 6 Oct 2020 14:55:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chu Lin <linchuyuan@google.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: hwmon: max20730: adding device tree
 doc for max20730
Message-ID: <20201006215528.GA96892@roeck-us.net>
References: <20201004031445.2321090-1-linchuyuan@google.com>
 <20201004031445.2321090-2-linchuyuan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201004031445.2321090-2-linchuyuan@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 04, 2020 at 03:14:44AM +0000, Chu Lin wrote:
> max20730 Integrated, Step-Down Switching Regulator with PMBus
> 
> Signed-off-by: Chu Lin <linchuyuan@google.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> ChangeLog v1 -> v2
>   hwmon: pmbus: max20730:
>   - Don't do anything to the ret if an error is returned from pmbus_read_word
>   - avoid overflow when doing multiplication
> 
> ChangeLog v2 -> v3
>   dt-bindings: hwmon: max20730:
>   - Provide the binding documentation in yaml format
>   hwmon: pmbus: max20730:
>   - No change
> 
> ChangeLog v3 -> v4
>   dt-bindings: hwmon: max20730:
>   - Fix highefficiency to high efficiency in description
>   - Fix presents to present in vout-voltage-divider
>   - Add additionalProperties: false
>   hwmon: pmbus: max20730:
>   - No change
> 
>  .../bindings/hwmon/maxim,max20730.yaml        | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max20730.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max20730.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max20730.yaml
> new file mode 100644
> index 000000000000..93e86e3b4602
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max20730.yaml
> @@ -0,0 +1,65 @@
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
> +  compact, high efficiency power-delivery solutions with high-precision
> +  output voltages and excellent transient response.
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
> +      If voltage divider present at vout, the voltage at voltage sensor pin
> +      will be scaled. The properties will convert the raw reading to a more
> +      meaningful number if voltage divider present. It has two numbers,
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
> +
> +additionalProperties: false
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
