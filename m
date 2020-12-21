Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00072DFC5C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 14:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgLUNnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 08:43:04 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:41128 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgLUNnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 08:43:04 -0500
Received: by mail-wr1-f45.google.com with SMTP id a12so11097951wrv.8;
        Mon, 21 Dec 2020 05:42:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q7UNQoTHgmNv0BAESI8aO2Rq115t5X5vM58d1YEnIy0=;
        b=r6oFLA78mM/UDqhypsChyL6b65YKvPiujs65jrnlPv6BuGHpNXvDq2F9llT25xQQRr
         kbhDoC4KXvnWWsT63+fxJ2pk18w9TPuTJkpNIXD/QuC+jOcF5iWJb+rdqqyPMB66bzvk
         UZJ/0Lqb8Px2Sl4uro6HFS8YbuvLhdUgEZM3vX2kyDegWZI96X6a6NIM5eNzDaST3wjT
         KC02FFffqCrPToifjB3spioUkaZOteZd0C6n1yNpNhdP+U4n6Uw1v3izZITJ3Dz39MhZ
         X6FFbcx5La2Ltc4NuHkKXPs2lkFHojegSz2TRFOI8WYMDzkYLMPkAJV5p2CDFpbttlVS
         ZEow==
X-Gm-Message-State: AOAM530x1V08FUBbjl5f7xUx2WmGLbg+vSSMPccfM1NsTauALimW531p
        YBdstVxgE0Nn2X2sMOBwZbg=
X-Google-Smtp-Source: ABdhPJymVDA0bI+881pIn4JFoYBD9LMIxTN50zgdnPwGpdqqCeBJDIVJe6Tpq4ndw22Vkn+wRg8jjQ==
X-Received: by 2002:adf:bc87:: with SMTP id g7mr18642151wrh.147.1608558141976;
        Mon, 21 Dec 2020 05:42:21 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id n11sm8360854wra.9.2020.12.21.05.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 05:42:20 -0800 (PST)
Date:   Mon, 21 Dec 2020 14:42:19 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/6] arm64: defconfig: Enable REGULATOR_PF8X00
Message-ID: <20201221134219.GA31176@kozik-lap>
References: <20201221113151.94515-1-jagan@amarulasolutions.com>
 <20201221113151.94515-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201221113151.94515-2-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 05:01:46PM +0530, Jagan Teki wrote:
> Enable PF8X00 regulator driver by default as it used in
> some of i.MX8MM hardware platforms.
> 
> Engicam i.Core MX8M Mini SoM is using the PF8121A family PMIC. 
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - updated commit message
> 
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
