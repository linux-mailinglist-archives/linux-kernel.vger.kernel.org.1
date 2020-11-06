Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73AF02A9DF8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 20:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgKFTZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 14:25:50 -0500
Received: from mail-ej1-f66.google.com ([209.85.218.66]:40600 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbgKFTZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 14:25:50 -0500
Received: by mail-ej1-f66.google.com with SMTP id oq3so3446450ejb.7;
        Fri, 06 Nov 2020 11:25:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MkMvO/fVRYJ0hwCb4YApCHFWfZiXPjKI+TWhUu7OZR8=;
        b=L3Jxp66LRDhQDLGOuqu/TPP61U+MU7zfbUjmADkeDRcs2z313NkVidnw5VroBVt7th
         +KzrnOs1UYNox2JnNId8/yfwNb+M6+vDdU4VOdQdShzE084UMdcRAtHDHqlL3+GLN6g0
         sgckaCNKiOTVF2Do41z05jcIsbDpTmRh0etUfkjiNg/XS8hfh619ZWEqvUFUbbAW7pkz
         R0R8yWmd32vEx69PhMldvmY1qIozGnBo8OKhvgM/9dytd7gJ6X0W2wE/VSmFx9ZrJSvk
         gcObIdR8fxN8kfmB+LHo4zkGFuqKSxrC7RTUHdmQ++V0L7ta8Vpru8AKViAL1tFaGsAV
         cYmA==
X-Gm-Message-State: AOAM530hBnKW3LYMI/CedRcOjRY5QxpXhlcXRBIneDuWuNppE7FRsqXi
        xZyaEi1YvRKnv5p8n1pIWeI=
X-Google-Smtp-Source: ABdhPJx4RaCkZ86rfx8Y1o2dN7HaNlaMQle4aKgb+itcSlgSCADS4Avz1UbnGkpB6HVi7vVOYuXVcw==
X-Received: by 2002:a17:906:748b:: with SMTP id e11mr3412873ejl.513.1604690748007;
        Fri, 06 Nov 2020 11:25:48 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id j4sm1620376ejs.8.2020.11.06.11.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 11:25:46 -0800 (PST)
Date:   Fri, 6 Nov 2020 20:25:45 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/3] dt-bindings: arm: fsl: Add
 beacon,imx8mn-beacon-kit
Message-ID: <20201106192545.GA328543@kozik-lap>
References: <20201106121238.1814427-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201106121238.1814427-1-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 06:12:35AM -0600, Adam Ford wrote:
> Add beacon,imx8mn-beacon-kit to list of compatible options.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V2:  New to series
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 85fb24da4a02..808e001aa81a 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -659,6 +659,7 @@ properties:
>          items:
>            - enum:
>                - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
> +              - beacon,imx8mn-beacon-kit  # i.MX8MM Beacon Development Kit

Hi Adam,

Wrong place. You need to add it under "i.MX8MN based Boards"

Comment has a typo - MM.

Best regards,
Krzysztof
