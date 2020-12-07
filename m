Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED032D1709
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 18:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgLGRA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 12:00:29 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43792 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgLGRA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 12:00:29 -0500
Received: by mail-oi1-f196.google.com with SMTP id q25so8028131oij.10;
        Mon, 07 Dec 2020 09:00:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/SkJ+y4JbdE9Xwej35tShvVwA0lpKmxCFraHeH0nWHU=;
        b=gm58I5AL9EvwinzQATnkjF5PfTQzYZ90Q0MMaJwgiCeoT4d9wPjvKwzdNbiaX8HLyz
         TYPnQRy2FdGfYuxfskio672z0u4NplQCF8VJFDnzjRIprHRhyByEVZrgzjyYzlaHOYpi
         xbQ94ACc1VZ3OFOV5X1H3GVhWC7JyspQdFM1y+ZayiyEXVAgx9AFMdNJt20VtOnqRa3n
         F9Rptpycwvl7nlQWgjj8nui08NdjBrBv3W7NRApW1CWotwlw+YFir5X2eikeT05zfi0q
         Sq0/Fp6pbAPNPzp8viMDqPlZMjJCKtv0Jae52NmgzEFJenN6uuhGQPDgtkaleyyztOs2
         hKuQ==
X-Gm-Message-State: AOAM5336ItB7zIepYtb7b08PHD1OCRGfneDVHS285LXBFZCQ3jU7cO/1
        VgBSMBJ4VnnbFt/kmna5YA==
X-Google-Smtp-Source: ABdhPJw/vjdojTgl/o7v8d/67obyPy8N0PY1fH5WpiG2P28+XiZRLIfp/vBt4qFEzO6Ba3m9FScZNg==
X-Received: by 2002:aca:6087:: with SMTP id u129mr13372577oib.173.1607360387662;
        Mon, 07 Dec 2020 08:59:47 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s9sm2749031otb.6.2020.12.07.08.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:59:46 -0800 (PST)
Received: (nullmailer pid 434629 invoked by uid 1000);
        Mon, 07 Dec 2020 16:59:45 -0000
Date:   Mon, 7 Dec 2020 10:59:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        airlied@linux.ie, daniel@ffwll.ch, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de,
        laurentiu.palcu@oss.nxp.com
Subject: Re: [PATCH v3 2/6] dt-bindings: display: imx: Add i.MX8qxp/qm PRG
 binding
Message-ID: <20201207165945.GA430214@robh.at.kernel.org>
References: <1607311260-13983-1-git-send-email-victor.liu@nxp.com>
 <1607311260-13983-3-git-send-email-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607311260-13983-3-git-send-email-victor.liu@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 11:20:56AM +0800, Liu Ying wrote:
> This patch adds bindings for i.MX8qxp/qm Display Prefetch Resolve Gasket.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> Note that this depends on the 'two cell binding' clock patch set which has
> already landed in Shawn's i.MX clk/imx git branch.  Otherwise, imx8-lpcg.h
> won't be found.
> 
> v2->v3:
> * No change.
> 
> v1->v2:
> * Use new dt binding way to add clocks in the example.
> 
>  .../bindings/display/imx/fsl,imx8qxp-prg.yaml      | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-prg.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-prg.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-prg.yaml
> new file mode 100644
> index 00000000..d59e2db
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-prg.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/imx/fsl,imx8qxp-prg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX8qm/qxp Display Prefetch Resolve Gasket
> +
> +maintainers:
> +  - Liu Ying <victor.liu@nxp.com>
> +
> +description: |
> +  The i.MX8qm/qxp Prefetch Resolve Gasket (PRG) is a gasket interface between
> +  RTRAM controller and Display Controller.  The main function is to convert
> +  the AXI interface to the RTRAM interface, which includes re-mapping the
> +  ARADDR to a RTRAM address.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: fsl,imx8qxp-prg
> +      - const: fsl,imx8qm-prg

Use enum instead of oneOf+const.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: rtram clock
> +      - description: apb clock
> +
> +  clock-names:
> +    items:
> +      - const: rtram
> +      - const: apb
> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - power-domains
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8-lpcg.h>
> +    #include <dt-bindings/firmware/imx/rsrc.h>
> +    prg@56040000 {
> +        compatible = "fsl,imx8qxp-prg";
> +        reg = <0x56040000 0x10000>;
> +        clocks = <&dc0_prg0_lpcg IMX_LPCG_CLK_0>,
> +                 <&dc0_prg0_lpcg IMX_LPCG_CLK_4>;
> +        clock-names = "rtram", "apb";
> +        power-domains = <&pd IMX_SC_R_DC_0>;
> +    };
> -- 
> 2.7.4
> 
