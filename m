Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804922C8482
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 13:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgK3M5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 07:57:21 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35803 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgK3M5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 07:57:21 -0500
Received: by mail-wr1-f68.google.com with SMTP id r3so16092428wrt.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 04:56:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2H34qoEVgIGqf2cF7TNTCGJPSbpkA6tOSSc6mx/D3Lo=;
        b=ki1YchwxbJbaXF1ibAElLsfLorHV99FGH129vEbs+ZoNNkJySorMolzmljdZOpdHBi
         5gosGhe5f/+Ac48Hb/+t4P34fTMwk6Urglm1VwZ5ERtLxGK4zqPwBM+1/6LL5/msdAxd
         ke/O13dPeAepPoYmfJ4TWbxP9gzVRMP0d6P+KAdoymHTM+q4Wi8Qy+PR70RRheUE1r2a
         OCj7BNc59uOuPNSDKOBihj399YbRWhbGddwiKfdXo6WSwF7oXUEXkgRqlOPdyUwlimnk
         7P1m0PTfsAfhI1EU2sotkjC3dGxlYxb/cnt9w96T/WsRVEW38tcVc5qLTzSJi4SbRWIJ
         8VzQ==
X-Gm-Message-State: AOAM531MXzXZ4GKWbuPhTYEiO2k1Kibxzkd80pUM8pPO1+vxwwAkMriD
        vvgie5XXIgFxJ5hseO8kvKA=
X-Google-Smtp-Source: ABdhPJy5XJUmZ4VXhJcCxZ+GiZJmD6iH2yFPSRHNhx4XZLsUsua7+61xdLEoTONoMJqbviks+PeY9A==
X-Received: by 2002:adf:dc83:: with SMTP id r3mr27322406wrj.223.1606740993285;
        Mon, 30 Nov 2020 04:56:33 -0800 (PST)
Received: from pi3 (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id r13sm21717923wrm.25.2020.11.30.04.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 04:56:32 -0800 (PST)
Date:   Mon, 30 Nov 2020 13:56:30 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, shawnguo@kernel.org,
        leoyang.li@nxp.com, vkoul@kernel.org, geert+renesas@glider.be,
        Anson.Huang@nxp.com, michael@walle.cc, olof@lixom.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nishanth Menon <nm@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] ARM: multi_v7_defconfig: drop unused POWER_AVS option
Message-ID: <20201130125630.GB22699@pi3>
References: <20201130112731.30599-1-andrey.zhizhikin@leica-geosystems.com>
 <20201130112731.30599-3-andrey.zhizhikin@leica-geosystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201130112731.30599-3-andrey.zhizhikin@leica-geosystems.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 11:27:31AM +0000, Andrey Zhizhikin wrote:
> Commit 785b5bb41b0a ("PM: AVS: Drop the avs directory and the
> corresponding Kconfig") moved AVS code to SOC-specific folders, and
> removed corresponding Kconfig from drivers/power, leaving original
> POWER_AVS config option enabled in multi_v7_defconfig file.
> 
> Remove the option, which has no references in the tree anymore.
> 
> Fixes: 785b5bb41b0a ("PM: AVS: Drop the avs directory and the corresponding Kconfig")
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
