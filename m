Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A577527E8BB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbgI3Mmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 08:42:51 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:44043 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgI3Mmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:42:50 -0400
Received: by mail-ej1-f65.google.com with SMTP id a3so1798646ejy.11;
        Wed, 30 Sep 2020 05:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lXsyiu5/sLG7JXskdJ38fspCNifimKQZmoKWxZ1qnuw=;
        b=pNllAKcpflsPi8k/vGqlQ9RXtT/HpOLlP8mdCBdm2eKDAmoLS7CdUJ2rfQQ/ywa34Y
         F6JJuqmzUVMXyAayYC/LdQQT9TVqqhhJUkLSEG0RKlS3FTlTfstEHJWXWHlQZVoDKhxq
         RTPmRKKC0gIyldZNISx8iwTaAXSyIk3bzYiz5L3jovIWx4aixQ37zHFdgqQ/TVt+hiGe
         b2RDQl4ciiOVmroenKzSvQ+Vtw8D7lkU4D6Viwbm4QbhRWPR6ZxdZIgQlfd/iSZlDWkA
         m93I5KphYQvavtUJInTGbu6Fpsp6/aD58nx/b4ImHA8zerg2o8TKjEQEBAbLww81//mw
         ecOQ==
X-Gm-Message-State: AOAM531LHglU7bZKhcWUxKcLx/MfijQENVPxxSBkm3KE+zzWP2k55tuw
        3rRd5pLxYEbp/xBSqscSPoU=
X-Google-Smtp-Source: ABdhPJzJOzFFrUR1a7sbFdr75NzgGkj5H6cDwfEkAhRjB+75W0ZpuTwCzZMwjpjVa1dgIQ4A8go1JA==
X-Received: by 2002:a17:906:1e51:: with SMTP id i17mr2690939ejj.103.1601469768395;
        Wed, 30 Sep 2020 05:42:48 -0700 (PDT)
Received: from pi3 ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id e9sm1386972edu.49.2020.09.30.05.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 05:42:47 -0700 (PDT)
Date:   Wed, 30 Sep 2020 14:42:44 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Robert Jones <rjones@gateworks.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 09/14] dt-bindings: arm: fsl: document VF boards
Message-ID: <20200930124244.GA1368@pi3>
References: <20200926162811.5335-1-krzk@kernel.org>
 <20200926162811.5335-9-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200926162811.5335-9-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 26, 2020 at 06:28:06PM +0200, Krzysztof Kozlowski wrote:
> Document and adjust the compatibles for VF500 and VF600 based boards.
> The Toradex Colibri Evaluation Boards use multiple compatibles.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/arm/fsl.yaml          | 24 +++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 812e8d8babd8..d9c430bfe37e 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -559,10 +559,26 @@ properties:
>                - fsl,vf600
>                - fsl,vf610
>                - fsl,vf610m4
> -              - toradex,vf500-colibri_vf50              # Colibri VF50 Module
> -              - toradex,vf500-colibri_vf50-on-eval      # Colibri VF50 Module on Colibri Evaluation Board
> -              - toradex,vf610-colibri_vf61              # Colibri VF61 Module
> -              - toradex,vf610-colibri_vf61-on-eval      # Colibri VF61 Module on Colibri Evaluation Board
> +
> +      - description: Toradex Colibri VF50 Module on Colibri Evaluation Board
> +        items:
> +          - const: toradex,vf500-colibri_vf50-on-eval
> +          - const: toradex,vf500-colibri_vf50
> +          - const: fsl,vf500
> +
> +      - description: VF610 based Boards
> +        items:
> +          - enum:
> +              - lwn,bk4                   # Liebherr BK4 controller
> +              - phytec,vf610-cosmic       # PHYTEC Cosmic/Cosmic+ Board
> +              - fsl,vf610-twr             # VF610 Tower Board
> +          - const: fsl,vf610
> +
> +      - description: Toradex Colibri VF61 Module on Colibri Evaluation Board
> +        items:
> +          - const: toradex,vf600-colibri_vf61-on-eval
> +          - const: toradex,vf600-colibri_vf61

I made typos here so please do not apply this one. I'll send a v2.

Best regards,
Krzysztof


