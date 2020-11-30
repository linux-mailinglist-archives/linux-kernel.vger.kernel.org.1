Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965102C83DD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 13:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbgK3MHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 07:07:02 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52867 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729181AbgK3MHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 07:07:01 -0500
Received: by mail-wm1-f65.google.com with SMTP id a6so4720758wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 04:06:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cNHSrOxsS84508OIwZveVw9CPTkCJYCdpB9zIaiTW4o=;
        b=JA0uHRkwuycny2V3RVzwRurqO+Cpv14oJtJKBx/4/CH0rwo19LVYPc/RtFWXIuv4D/
         Y+CgfAR3JgnwbJj59Z/03gEAxGkIJJ2MAns+87+5lU84kzi3QnizZnBKrop9I4Gmie0V
         lM6DUys7DT5OFg80tTSiWJsWUpG6z5TvTwud69lyOSdgZm5YRezM0K9l8bWqaoFByfrf
         VznQxy6ldDG1q7Tmp5HW2vVMQBxTQiNFw3UnI7M/E0Vd5pHph6cJnhN47O2grEt3Hawx
         rmJF/4DX4fv2uN/aSRxCHd0gBxsyfOurGsbEYJbsk8DcJ7z48OHX28uXKZ9D80gGwTns
         z4Mw==
X-Gm-Message-State: AOAM532VjZeRkgjfkVfc878JllxP625jZtJWWN2qGk6/fM+byCbdxLZM
        iBbffmeqYQWmOvltOPQItfo=
X-Google-Smtp-Source: ABdhPJyBghtEj9ZxN/Xq4Z+GkPldfRQWLY6nBtgi4RYrvd/oboLDWw6fovEvLqHz2oCfQP4FsvKh+g==
X-Received: by 2002:a7b:c154:: with SMTP id z20mr22667715wmi.160.1606737980523;
        Mon, 30 Nov 2020 04:06:20 -0800 (PST)
Received: from pi3 (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id a1sm28195060wrv.61.2020.11.30.04.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 04:06:19 -0800 (PST)
Date:   Mon, 30 Nov 2020 13:06:17 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, shawnguo@kernel.org,
        leoyang.li@nxp.com, vkoul@kernel.org, geert+renesas@glider.be,
        Anson.Huang@nxp.com, michael@walle.cc, olof@lixom.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nishanth Menon <nm@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] arm64: defconfig: drop unused POWER_AVS option
Message-ID: <20201130120617.GA22590@pi3>
References: <20201130112731.30599-1-andrey.zhizhikin@leica-geosystems.com>
 <20201130112731.30599-2-andrey.zhizhikin@leica-geosystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201130112731.30599-2-andrey.zhizhikin@leica-geosystems.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 11:27:30AM +0000, Andrey Zhizhikin wrote:
> Commit 785b5bb41b0a ("PM: AVS: Drop the avs directory and the
> corresponding Kconfig") moved AVS code to SOC-specific folders, and
> removed corresponding Kconfig from drivers/power, leaving original
> POWER_AVS config option enabled in defconfig file.
> 
> Remove the option, which has no references in the tree anymore.
> 
> Fixes: 785b5bb41b0a ("PM: AVS: Drop the avs directory and the corresponding Kconfig")
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
> ---
>  arch/arm64/configs/defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
