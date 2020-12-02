Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B782CC377
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 18:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388871AbgLBRWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 12:22:45 -0500
Received: from mail-ej1-f66.google.com ([209.85.218.66]:46281 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387580AbgLBRWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 12:22:45 -0500
Received: by mail-ej1-f66.google.com with SMTP id bo9so5471242ejb.13;
        Wed, 02 Dec 2020 09:22:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vxdi5t3aRqbauZYdW0k+eTugsOvVm5z/0z7wI7PLSG8=;
        b=b+AFVRETr4cIJSoc7CbexbljVJaDCk0lly95KLcJhsN4O83sYKUI18+DBgnlNf0cXc
         OLJ7WCF+2O19FA3WHEMa2yK/pBFrgq8kLSKziu0rX10UL4UZrVYMQDSOXANLsGvS2tvO
         JwdBRSiDvSrNkDhDn8lpnstd7GMAf3n3SqWz1Dpi02OcYTW6eVMebMpbHZJG5MQpKszm
         HmJbVGvsUwOiuYOOTduM5Rxhccj+8N3/EeN/2lz1sgBzGLRpvDGgrAwbMSUestV9m3Pi
         bEBWwyQQU9055XJeCTe9N0Br4XK1oD009mI5Ud444FY5l+H/L8UAGJZv00VHxVrmjlYY
         ddpw==
X-Gm-Message-State: AOAM531eBvy0W3gJfW5d+QqWjzYfHODGzxiYtAbPhW9DfCLl+Vneuevq
        9YOa3YHAwXF+BJrWad7jK0H3vdM4ryw=
X-Google-Smtp-Source: ABdhPJwMnHiab0zi4zzhNdZiqlRAy8dx1lDMxaZ38uua7ZXbCox6L1iG6ArIb7XciLNpMekHF+Aq5A==
X-Received: by 2002:a17:906:6606:: with SMTP id b6mr762218ejp.151.1606929722914;
        Wed, 02 Dec 2020 09:22:02 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id t11sm299077ejx.68.2020.12.02.09.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 09:22:01 -0800 (PST)
Date:   Wed, 2 Dec 2020 19:22:00 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 01/10] arm64: defconfig: Enable REGULATOR_PF8X00
Message-ID: <20201202172200.GA3490@kozik-lap>
References: <20201202121241.109952-1-jagan@amarulasolutions.com>
 <20201202121241.109952-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201202121241.109952-2-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 05:42:32PM +0530, Jagan Teki wrote:
> Enable PF8X00 regulator driver by default as it used in
> some of i.MX8MM hardware platforms.

Could you mention names (one is enough) of platforms this could be found
on? This would be more detailed reason why the option should be enabled.

Best regards,
Krzysztof

> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
