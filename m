Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2F72CC408
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 18:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbgLBRlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 12:41:23 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44436 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbgLBRlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 12:41:23 -0500
Received: by mail-ed1-f67.google.com with SMTP id l5so4839634edq.11;
        Wed, 02 Dec 2020 09:41:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KfQDuc8JDGaeOFT/J+juY74FnBzeM7oQNchYmasmgIE=;
        b=CbrLrsdQjmkBhaSc7eb8IHHZbKZPHwkDDm2MIvB+ooNjcqPDjvmQo4kx/TZooV/HuZ
         Xg8TFCys0XuWHRFk8llQUqXAG8l3G+iSjB6S49LLP4jLf7SE7y7fe3wShrRvbnvUcYnh
         Jjjz4V1pwNOX4yn5S5ieZ03J2lm4eOMfJpvYP3hOzoDO5ei/6YUHRySEVsaP/ajSEBQR
         Dj4q5PE8MJ7ajd7BVgew0k+yLUmgAnaroOkhr/YaihMmORVIKxGSf95eNPMWu1XQAd4R
         OtTpZ411/D2YlqNBQrnZTzLOI+YclSamRcc6XcvRHXz88RGQETBdHbJ4k2pbdrZMAYs+
         NcJw==
X-Gm-Message-State: AOAM532myMoxrYdzwnW9mRiGm/3u48rGPClCkuB/6uQtB1BkcYODuRq6
        DWxqNaAA5ICTrqsuUdbq0Ew=
X-Google-Smtp-Source: ABdhPJyc3MIxUudzkpaxEzu2a0RIqr8H32057Ls1p2FLivkBO22bDn6oASQbAfcIMcGPSKkGontmUA==
X-Received: by 2002:a50:9ea3:: with SMTP id a32mr1122544edf.40.1606930841062;
        Wed, 02 Dec 2020 09:40:41 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id b14sm428500edx.0.2020.12.02.09.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 09:40:39 -0800 (PST)
Date:   Wed, 2 Dec 2020 19:40:38 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH 09/10] dt-bindings: arm: fsl: Add Engicam i.Core MX8M
 Mini C.TOUCH 2.0 10.1" OF
Message-ID: <20201202174038.GG3490@kozik-lap>
References: <20201202121241.109952-1-jagan@amarulasolutions.com>
 <20201202121241.109952-10-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201202121241.109952-10-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 05:42:40PM +0530, Jagan Teki wrote:
> i.Core MX8M Mini is an EDIMM SOM based on NXP i.MX8MM from Engicam.
> 
> C.TOUCH 2.0 is a general purpose carrier board with capacitive
> touch interface support.
> 
> 10.1" OF is a capacitive touch 10.1" Open Frame panel solutions.
> 
> i.Core MX8M Mini needs to mount on top of C.TOUCH 2.0 carrier with
> pluged 10.1" OF for creating complete i.Core MX8M Mini C.TOUCH 2.0
> 10.1" Open Frame solution board.
> 
> Add bindings for it.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Please run the checkpatch - it should complain about order of patches.

> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 8c8f7728788d..9e275921112d 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -669,6 +669,7 @@ properties:
>                - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
>                - engicam,icore-mx8mm               # i.MX8MM Engicam i.Core MX8M Mini SOM
>                - engicam,icore-mx8mm-ctouch2       # i.MX8MM Engicam i.Core MX8M Mini C.TOUCH 2.0
> +              - engicam,icore-mx8mm-ctouch2-of10  # i.MX8MM Engicam i.Core MX8M Mini C.TOUCH 2.0 10.1" Open Frame

Run dtbs_check before posting.

Best regards,
Krzysztof
