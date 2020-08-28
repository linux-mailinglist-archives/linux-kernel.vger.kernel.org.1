Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696922562AD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 23:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgH1V43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 17:56:29 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34590 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgH1V40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 17:56:26 -0400
Received: by mail-io1-f66.google.com with SMTP id w20so574013iom.1;
        Fri, 28 Aug 2020 14:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bnuQFFeQy61Sm8kS2vhKjdCEzpmvVQn8pWWRcCfWkZQ=;
        b=DIfRvtgnrXixIrO4jOaDCV1J3x7HpNuJTRnjKsdkI7gpbGoyvkO8to8VYxk4lZOFzC
         +NW794eSK+0txberQMubVCzuUjUZUcDM/SDsdcuwei6QP/zskGmDoIdDJARIuxciREBh
         /ucx43gPwQrZC/CIQ93cy7IkkqwiudmzTGOSWcMKIBaUn0c5HOYVQiHkBm98+xeczJRt
         giELZxL3mk0Cjlpohl7XmfeXZLuOuyL99psVMdOImLyPr25/X/IZPzvz0gD0+jEtSqkv
         av+J/kKwee8/sEelz9pOqJ4WX39M4zEUO0DPEa0k92VljRoMj8dK7BnZEe95T09mM2jB
         nGHw==
X-Gm-Message-State: AOAM532HaDgpndYCPBkSzs//4invq9BtYs3fRou4CEWXjfz1fIW58qpE
        LSYAGKxh/0dlPvvhOomLMxTTM4davd/d
X-Google-Smtp-Source: ABdhPJxAo0CwfDWujxgV01Kcz5GmAk8vpvEoBxI69Bslbj8QJirVXxKSjpE8Ok5gcXfKWgKIkT6gaw==
X-Received: by 2002:a5d:871a:: with SMTP id u26mr623569iom.92.1598651785621;
        Fri, 28 Aug 2020 14:56:25 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id h18sm230268iow.16.2020.08.28.14.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 14:56:24 -0700 (PDT)
Received: (nullmailer pid 3474171 invoked by uid 1000);
        Fri, 28 Aug 2020 21:56:22 -0000
Date:   Fri, 28 Aug 2020 15:56:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        sboyd@kernel.org, gregkh@linuxfoundation.org,
        mturquette@baylibre.com
Subject: Re: [PATCH v6 1/8] dt-bindings: add documentation of xilinx clocking
 wizard
Message-ID: <20200828215622.GA3469481@bogus>
References: <1598621996-31040-1-git-send-email-shubhrajyoti.datta@xilinx.com>
 <1598621996-31040-2-git-send-email-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598621996-31040-2-git-send-email-shubhrajyoti.datta@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 07:09:49PM +0530, Shubhrajyoti Datta wrote:
> Add the devicetree binding for the xilinx clocking wizard.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
> v6:
> Fix a yaml warning
> 
>  .../bindings/clock/xlnx,clocking-wizard.yaml       | 71 ++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
> new file mode 100644
> index 0000000..ca63593
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/xlnx,clocking-wizard.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx clocking wizard
> +
> +maintainers:
> +  - Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> +
> +description: |
> +  The clocking wizard is a soft ip clocking block of Xilinx versal. It
> +  reads required input clock frequencies from the devicetree and acts as clock
> +  clock output.
> +
> +select: false
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:

You can drop 'items' since there is only 1.

> +          - xlnx,clocking-wizard
> +          - xlnx,clocking-wizard-6.0
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  clocks:
> +    description: List of clock specifiers which are external input
> +      clocks to the given clock controller.

Drop this. That's every 'clocks' property.

> +    items:
> +      - description: clock input
> +      - description: axi clock
> +
> +  clock-names:
> +    items:
> +      - const: clk_in1
> +      - const: s_axi_aclk
> +
> +  speed-grade:

Needs a vendor prefix.

> +    allOf:

You can remove the 'allOf'.

> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [1, 2, 3]
> +    description:
> +      Speed grade of the device.
> +    maxItems: 1

Drop this. A 'uint32' is always 1 item.

> +
> +required:
> +  - compatible
> +  - "#clock-cells"
> +  - clocks
> +  - clock-names
> +  - speed-grade
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-generator@40040000 {
> +        #clock-cells = <1>;
> +        reg = <0x40040000 0x1000>;
> +        compatible = "xlnx,clk-wizard-1.0";

Doesn't match the schema.

> +        speed-grade = <1>;
> +        clock-names = "clk_in1", "s_axi_aclk";
> +        clocks = <&clkc 15>, <&clkc 15>;
> +        clock-output-names = "clk_out1", "clk_out2",
> +        "clk_out3", "clk_out4", "clk_out5",
> +        "clk_out6", "clk_out7";
> +    };
> +...
> -- 
> 2.1.1
> 
