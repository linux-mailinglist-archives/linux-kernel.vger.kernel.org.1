Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5C72A792D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 09:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbgKEIZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 03:25:48 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43561 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgKEIZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 03:25:48 -0500
Received: by mail-ed1-f67.google.com with SMTP id b9so598123edu.10;
        Thu, 05 Nov 2020 00:25:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BynuZQ4IcnE7iQujs9AoYeaOaUtAjpLHhcdFHAx92NU=;
        b=KsfvtKhUqlHfJKdbL+R7bwLAvlK/PVwicE7CoswcKOw8v4F50c5EPseD1C9Gk4wk16
         9nF8VUbtKuzu0O+yTY6eKZsDPY7odm0vgoRkgXxe24VkzgtWEczNzm3VHtgrR9eQ8XRI
         RIKUr7MYlxrms4wDtGkSD8sILgtkhOjokStvRKiM2oiOAFBfAY431uFaSol1xWl+culx
         MdvSooGSe+Hse0EBOi+G2m9P3Anc9aXSWIk3QmB7VbREPH7OX1uexhqcsP7Gbz/cDkA7
         iaMIL/T5KjW0DeIYZ9gN20lheYgMShBMo71qWG8xLqk3QBEF2suzG0hViRzRUZqZ+SE9
         uOPg==
X-Gm-Message-State: AOAM530pc+ZgsxRLrXAFzrIdIID1IlWtjhwUU2Pp7BSM9sryusfQKF82
        izipVNPmMJOST6G/nOlSR18=
X-Google-Smtp-Source: ABdhPJxkpUg1Mul8x6cVLkyTVYz10e4c3t5chhkLiHgDZkp8bbZfVtyDie7JQU7x4d52LbYCid3dFg==
X-Received: by 2002:aa7:cdd3:: with SMTP id h19mr1411156edw.330.1604564746185;
        Thu, 05 Nov 2020 00:25:46 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id k26sm447082edf.85.2020.11.05.00.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 00:25:45 -0800 (PST)
Date:   Thu, 5 Nov 2020 09:25:43 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alice Guo <alice.guo@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Message-ID: <20201105082543.GA17569@kozik-lap>
References: <20201105072629.24175-1-alice.guo@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201105072629.24175-1-alice.guo@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 03:26:26PM +0800, Alice Guo wrote:
> Add DT Binding doc for the Unique ID of i.MX 8M series.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>  .../devicetree/bindings/arm/fsl.yaml          | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index e4db0f9ed664..0419f078502b 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -901,6 +901,39 @@ properties:
>                - fsl,s32v234-evb           # S32V234-EVB2 Customer Evaluation Board
>            - const: fsl,s32v234
> 
> +  soc:
> +    description:
> +      i.MX8M Family SoC must provide a soc node in the root of the device tree,
> +      representing the System-on-Chip since these test chips are rather complex.
> +    type: object
> +    properties:
> +      compatible:
> +        oneOf:
> +          - items:
> +              - const: fsl,imx8mm-soc
> +              - const: simple-bus
> +          - items:
> +              - const: fsl,imx8mn-soc
> +              - const: simple-bus
> +          - items:
> +              - const: fsl,imx8mp-soc
> +              - const: simple-bus
> +          - items:
> +              - const: fsl,imx8mq-soc
> +              - const: simple-bus
> +
> +      nvmem-cells:
> +        maxItems: 1
> +        description: Phandle to the SOC Unique ID provided by a nvmem node
> +
> +      nvmem-cells-names:
> +        const: soc_unique_id
> +
> +    required:
> +      - compatible
> +      - nvmem-cells
> +      - nvmem-cell-names
> +

Did you actually test it? I see multiple errors with this patch.
fsl-ls1012a-frdm.dt.yaml: /: soc:compatible: ['simple-bus'] is not valid under any of the given schemas

Best regards,
Krzysztof

