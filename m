Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A962E0747
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 09:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgLVIhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 03:37:33 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:37136 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgLVIhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 03:37:32 -0500
Received: by mail-wr1-f50.google.com with SMTP id i9so13680430wrc.4;
        Tue, 22 Dec 2020 00:37:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Iuqy0VCH+AsaSuCDDBZWazEL0zg6PF7/PlUnAAAlyQ=;
        b=IhSPzjC0qJp3VKjU4BBBaRgk8//dZcdhEP2/Tg5rpdPZUmT1cUldfyU6twJUhkjMFl
         BiO4qc2nojMh+sAS320Ri1K2gQsumrgq8B+yprKszcz6Y+HWERWJ3DV9djnUjrWAo5WK
         fG+XV6xVO3t/7eqSorCFrk5C0bh6wPtrJfq4ZKXcm7ZUiaL5+/ZxJ2LcJMojfDxO9rmb
         UKVm6AEhdOc3tmY5wEZl1QxYSmUuOgl82q3b7km6f3r6SqZjrF3uQ82HbomeGnBolxQ1
         W9uYt2aHGtc8GlckeyVmDgmAKtFZ+GIO090b3Bd+YBCK37jMqCZLuCog91pV/z72E4zh
         NBWA==
X-Gm-Message-State: AOAM533tFMDCWQ3z6XXXnnVgq4UJmGPv4+AHuOP5pKQELtQcZ/a2n037
        uCA16xO8vh+TgDCLU7E9faQ=
X-Google-Smtp-Source: ABdhPJw2xw0PzVZBjVPxmyzAxXmwvBSVW86NtCqzTRelHjaoNYs0z3j2VwGIY6q4Lsi/87Z2abY8CA==
X-Received: by 2002:adf:f681:: with SMTP id v1mr22573210wrp.133.1608626210378;
        Tue, 22 Dec 2020 00:36:50 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id j13sm25494948wmi.36.2020.12.22.00.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 00:36:49 -0800 (PST)
Date:   Tue, 22 Dec 2020 09:36:47 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH v9 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Message-ID: <20201222083647.GA5026@kozik-lap>
References: <20201222081057.26401-1-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201222081057.26401-1-alice.guo@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 04:10:54PM +0800, Alice Guo (OSS) wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> Add DT Binding doc for the Unique ID of i.MX 8M series.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
> 
> Changes for v9:
>  - add additionalProperties for "^soc@[0-9a-f]+$"
>  - add examples
> Changes for v8:
>  - match soc node with regular expression
> Changes for v7:
>  - change to a separate schema file
> Changes for v6:
>  - none
> Changes for v5:
>  - correct the error of using allOf
> Changes for v4:
>  - use allOf to limit new version DTS files for i.MX8M to include
>    "fsl,imx8m*-soc", nvmem-cells and nvmem-cells-names
> Changes for v3:
>  - put it into Documentation/devicetree/bindings/arm/fsl.yaml
>  - modify the description of nvmem-cells
>  - use "make ARCH=arm64 dtbs_check" to make sure it is right
> Changes for v2:
>  - remove the subject prefix "LF-2571-1"
> 
>  .../bindings/soc/imx/imx8m-soc.yaml           | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/imx/imx8m-soc.yaml
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
