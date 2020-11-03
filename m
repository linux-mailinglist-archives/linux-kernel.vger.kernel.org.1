Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87DD72A4BC2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 17:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgKCQkR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Nov 2020 11:40:17 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52402 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgKCQkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 11:40:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id c18so13387822wme.2;
        Tue, 03 Nov 2020 08:40:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5VqbnNEsISzTx1+2zCjn0IZi1oNIpk688VcKl8HpDLI=;
        b=hTLh+TaGcZ/cL5FpLGpfQYkIYFmluvt11cuki2h5VO28K+N56Na0EF27MmEFlg7iDD
         shckgZAfiHc8bAiJAeOVu4kujoOeaxHD9f/SPbCYUuG3p1B043+Rwr2o2xi54t7tD3BH
         YTVbuku03fCRG4TivDt8ukZmkX/vtPER4BIK+mIyLUiSc4DhrQzQEjXWrD9XIiFs9WsK
         Ji9inBnxCriWvcty6JabHUw6XhXLKZpWt9YG2J4Oq5yYx6hG7+L05eUWaNUiqAJNpBJ5
         kXtXo0dXnBtQIWH9QtrKAd/gS/kHD/vtImGZhqItM3q7IdNp/jF8X2IXi/B6h6nGLTtX
         l60w==
X-Gm-Message-State: AOAM530VO4NnJ/WBcM+AK2Ic655G3ViL4UFVrAVmUYa/HMzmDdvwHltv
        QdCVW+2U9PVxIR6MmL5xBC8=
X-Google-Smtp-Source: ABdhPJxHA9TXX2ewYjGAO6mdcEx5JBCuiEyhaA6ckxhF7acHpUaj+iPlTPCc70w028VEW+8eqfRE+A==
X-Received: by 2002:a1c:7301:: with SMTP id d1mr615443wmb.141.1604421615281;
        Tue, 03 Nov 2020 08:40:15 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id b136sm3328206wmb.21.2020.11.03.08.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 08:40:14 -0800 (PST)
Date:   Tue, 3 Nov 2020 17:40:12 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Anand Moon <linux.amoon@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?Q?Bart=C5=82omiej_=C5=BBolnierkiewicz?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 3/5] ARM: dts: exynos: Add Ethernet interface description
 for Odroid XU
Message-ID: <20201103164012.GD14739@kozik-lap>
References: <20201103124618.21358-1-l.stelmach@samsung.com>
 <CGME20201103124621eucas1p23bae6351a79c0e271b68223a35dbd7f7@eucas1p2.samsung.com>
 <20201103124618.21358-4-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201103124618.21358-4-l.stelmach@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 01:46:16PM +0100, Łukasz Stelmach wrote:
> Add Ethernet interface description for Odroid XU.
> 
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5410-odroidxu.dts | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
> index 75b4150c26d7..882d9296fa5d 100644
> --- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
> +++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
> @@ -19,6 +19,10 @@ / {
>  	model = "Hardkernel Odroid XU";
>  	compatible = "hardkernel,odroid-xu", "samsung,exynos5410", "samsung,exynos5";
>  
> +	aliases {
> +		ethernet = &ethernet;

Just like with patch 1/5 - please explain in commit msg why do you need
this.

Best regards,
Krzysztof
