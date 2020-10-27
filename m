Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63E729AA4D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 12:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899007AbgJ0LIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 07:08:46 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:46208 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2898999AbgJ0LIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 07:08:46 -0400
Received: by mail-ej1-f67.google.com with SMTP id t25so1576607ejd.13;
        Tue, 27 Oct 2020 04:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vkB99++sVe3+tJ+75rrN7FpuFdKJPJ67yYVUAZtO1SM=;
        b=KTgKTF0uQoBs13jprnqzdBSC20GLW1pe5sPPCTZz3K9ePc10K5AqVBuiRbGqvBCNec
         jHrv+dusqkeMWGf56Vn2D6Dz52EnJeMoOfcPnerH8k9vb8k+OzWpItIJJKCsBYLjVnC3
         Y88kf1c0YmrXt/dHqtQDmEHNBnVz6VTUFjr8BGH2YyXVgggZ4dJsNtp5RVkyLX2t+Aqn
         hFGT3FrE+nt0FedVzTxvB1wzW7lpx0bTqjrRpkSgXo2VA5HpZZkLTfMHMmvsQ5ARFDAO
         cToFSoPdnqcT70IRQqk/skr+gF60yNksEyIbB2blJKdw0XDGrjWpVXwrkALnKp/zDv7u
         gL8w==
X-Gm-Message-State: AOAM531xvOwPa/uSrpzQUvf4/SOtyyIYySr9Aog0B19Bw7v4k2iWb3QU
        fiy7OwQ81hPzUIQRoVG7z9o=
X-Google-Smtp-Source: ABdhPJytrKpdjS5v/Ce2FRPg9aihFnc0X6Ds/w6A+BnKzkrLi9eW/adZBK1qCEgBBJ9aE/G7Cactyg==
X-Received: by 2002:a17:906:3acd:: with SMTP id z13mr1900626ejd.118.1603796923984;
        Tue, 27 Oct 2020 04:08:43 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id j22sm737816edp.77.2020.10.27.04.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 04:08:42 -0700 (PDT)
Date:   Tue, 27 Oct 2020 12:08:40 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: fsl_aud2htx: Add binding doc for
 aud2htx module
Message-ID: <20201027110840.GA23076@kozik-lap>
References: <1603708855-2663-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1603708855-2663-1-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 06:40:54PM +0800, Shengjiu Wang wrote:
> AUD2HTX (Audio Subsystem TO HDMI TX Subsystem) is a new
> IP module found on i.MX8MP.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../bindings/sound/fsl,aud2htx.yaml           | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml b/Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml
> new file mode 100644
> index 000000000000..18548d0889a8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/fsl,aud2htx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP Audio Subsystem to HDMI RTX Subsystem Controller
> +
> +maintainers:
> +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> +
> +properties:
> +  $nodename:
> +    pattern: "^aud2htx@.*"

aud2htx is not a generic class of a device so it should not be enforced.

> +
> +  compatible:
> +    const: fsl,imx8mp-aud2htx
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Peripheral clock
> +
> +  clock-names:
> +    items:
> +      - const: bus
> +
> +  dmas:
> +    items:
> +      - description: DMA controller phandle and request line for TX
> +
> +  dma-names:
> +    items:
> +      - const: tx
> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - dmas
> +  - dma-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/imx8mp-clock.h>
> +
> +    aud2htx: aud2htx@30cb0000 {
> +             compatible = "fsl,imx8mp-aud2htx";

Wrong indentation. Most of examples are indented with 4 spaces.

Best regards,
Krzysztof
