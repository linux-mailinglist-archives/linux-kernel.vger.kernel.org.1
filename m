Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E86426BB83
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 06:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgIPE3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 00:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgIPE3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 00:29:44 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4C5C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 21:29:43 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id c10so5414346otm.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 21:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CbpPK/Siu+d9dTl8nIly6n0m2jPY9tJNIXsIgkbDIw4=;
        b=PHMmuZn8tH1B1bgMVfEoXDoPiabkrcZ6bbZGs9xDoF0tLy2NlnrQkkqBE8HK17mmkY
         EAVs1/DLqAl0Vy0+xa40q0htbrPg3qvNcw7g1ijYV6d9IaA8QKZmCPaipsta3RP4X+xy
         gp8P37uvp7V0sWhUIrdnx7UHVa8wzWnnaU6Ocm6ZflBzlG+4UDKykJHP2eXH0QVsjIjC
         S0j6gFks8JwCKAnYzdySzaIgCsnEIkl4oSnRg9/p1PrjTySy5rC0+x5NQwI1PCZjW/lC
         +rUhUDub8AJwUFWeg8KI2UK+VSoLECoyaRP/BLIcLHPWHsUR7K/s1hI1+L4m03EN1wwG
         yPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CbpPK/Siu+d9dTl8nIly6n0m2jPY9tJNIXsIgkbDIw4=;
        b=gFe/kWomfcqINzP30q3UQTxVE7X4n5ufcvooZR7kotbKEUbZb9l2FuP7SajC+w+/M/
         h8jKz7M9Y6e+FMUooH84s8UYzzvJHWiaK/FsGUFARC9APxcwPm50sPgb8CZmn3A4sNtG
         OwGZfbGSyMTipeq1ZT4+ABvnKroSwJObR3VHZjgwcYuIz62Py1+ilv7dB/P+B1RRJKic
         vPsOJ0nOLztnrvDYsIFwCWfKhKW+6DlLU2K6VSyGCQyKYiwRe6danB16rU8kOO69jOp1
         xQyTUyR2S/0ZYfV1o2kvZor8nTLPIa7LL3YQPVflx4+5mIaRiAEZCaVRIyxQwoCpN0tJ
         Ou1Q==
X-Gm-Message-State: AOAM532o0cU0Ta/45sPn/Pfamybum41FiQ2CzJiwhDL6OpK5EFTU1nCR
        XreFjUK9Fp9qjv1RvzgGLO/y9Q==
X-Google-Smtp-Source: ABdhPJzRiqydG/HYSbv1upl3PnSI4mgAlWvKqm4Ls2OyNROQKt+mgWEtMm3v8Ebm1p+C9lhBgSlkTA==
X-Received: by 2002:a05:6830:1ac8:: with SMTP id r8mr14353983otc.70.1600230582598;
        Tue, 15 Sep 2020 21:29:42 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:7cad:6eff:fec8:37e4])
        by smtp.gmail.com with ESMTPSA id c124sm8557751oib.22.2020.09.15.21.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 21:29:41 -0700 (PDT)
Date:   Tue, 15 Sep 2020 23:29:39 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sumit Semwal <sumit.semwal@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/2] dt-bindings: display: panel: Add bindings for
 Novatek nt36672a
Message-ID: <20200916042939.GC1893@yoga>
References: <20200902064407.30712-1-sumit.semwal@linaro.org>
 <20200902064407.30712-2-sumit.semwal@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902064407.30712-2-sumit.semwal@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02 Sep 01:44 CDT 2020, Sumit Semwal wrote:

> Novatek nt36672a is a display driver IC that can drive DSI panel. It
> is also present in the Tianma video mode panel, which is a FHD+ panel
> with a resolution of 1080x2246 and 6.18 inches size. It is found in
> some of the Poco F1 phones.
> 
> This patch adds the display driver for the IC, with support added for
> this tianma fhd video mode panel.
> 
> Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> 
> ---
> v2: remove ports node, making port@0 directly under panel@0 node.
> v3: updated to replace port@0 to just 'port'.
> v5: renamed to novatek,nt36672a, since the binding is for the IC and not
>       the panel.
> v6: v5 review comments incorporated.
>     - added enum for the compatible part, since it can be extended in
>       future.
>     - few cosmetic updates.
> ---
>  .../display/panel/novatek,nt36672a.yaml       | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
> new file mode 100644
> index 000000000000..d2170de6b723
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/novatek,nt36672a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Novatek NT36672A based DSI display Panels
> +
> +maintainers:
> +  - Sumit Semwal <sumit.semwal@linaro.org>
> +
> +description: |
> +  The nt36672a IC from Novatek is a generic DSI Panel IC used to drive dsi
> +  panels.
> +  Right now, support is added only for a Tianma FHD+ LCD display panel with a
> +  resolution of 1080x2246. It is a video mode DSI panel.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +         - tianma,fhd-video
> +      - const: novatek,nt36672a
> +    description: This indicates the panel manufacturer of the panel that is
> +      in turn using the NT36672A panel driver. This compatible string
> +      determines how the NT36672A panel driver is configured for the indicated
> +      panel. The novatek,nt36672a compatible shall always be provided as a fallback.
> +
> +  reset-gpios:
> +    description: phandle of gpio for reset line - This should be 8mA, gpio
> +      can be configured using mux, pinctrl, pinctrl-names (active high)
> +
> +  vddio-supply:
> +    description: phandle of the regulator that provides the supply voltage
> +      Power IC supply
> +
> +  vddpos-supply:
> +    description: phandle of the positive boost supply regulator
> +
> +  vddneg-supply:
> +    description: phandle of the negative boost supply regulator
> +
> +  reg: true
> +  port: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - vddi0-supply
> +  - vddpos-supply
> +  - vddneg-supply
> +  - reset-gpios
> +  - port
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |+
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        panel@0 {
> +            compatible = "tianma,fhd-video", "novatek,nt36672a";
> +            reg = <0>;
> +            vddi0-supply = <&vreg_l14a_1p88>;
> +            vddpos-supply = <&lab>;
> +            vddneg-supply = <&ibb>;
> +
> +            reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            port {
> +                tianma_nt36672a_in_0: endpoint {
> +                    remote-endpoint = <&dsi0_out>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> -- 
> 2.28.0
> 
