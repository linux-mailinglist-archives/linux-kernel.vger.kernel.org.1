Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6682527645B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 01:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgIWXLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 19:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgIWXLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 19:11:19 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6DCC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 16:11:19 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y17so555546plb.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 16:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2C2k3bgm/wJgHGoPq3RjqjO7qGsk8WgF9RAs+eFblaY=;
        b=LiswQhMejoVglYkrxG9w0XpsBon11s3vESoHybcFToEdc5v2+NWsS8qqK5KwzJ/AsD
         d17on9QRv/S/TyDlJsRNEOvGZ6UpT+LdvtburVCLnEgzWB0oIEd8fi5ehdVx0RJRsupQ
         xmspR5jK/Y+6o6D0HKN7vH4QrmrUnFp3kw2e76h+331JCqdxZzZc6VgTIcVCPZZfj717
         ncaxK3US42BrvAlPy6qWLMc6FPyIfkadKdRoo0kO3u/BM2o+FFxNkVHEkvslRD9xT7A7
         OUTzgcYRNF5zXEihYdZntXS33ZP0+5CMSsynjHG0JtYipj1yIDWes8af7HqwLJy2eokG
         vnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2C2k3bgm/wJgHGoPq3RjqjO7qGsk8WgF9RAs+eFblaY=;
        b=HlpAm0f44NwJ5Pr6E3oZL8w7cykGX5Og3Bfe5Hm5bj0behkVgwodg+SRFjh8Wpnbqf
         LtIwlmKI3bAYMXeoVnVlzGQ1YD8+jymv8E4na8s7DK96UMPf4cdKOFTtGKGenzaaGn9/
         QWv2UgP4gLDj8GoihzDe5maP6hnGkhCxp34NWq5W/5PCFLCj/VxqFsMTkgGls+WBrmLB
         2V4g40ulj0KtNswpQnJijO/0kDckpvOQAl18413n24uRP3sNN6PA9zDCP5Ffy174mR2q
         w7pzocXq7Dbb+x6tc9n1Fbo7e9ggsLxYbMb9DF5YtvK6REEOxpdgUy9Zxiv/iFsWtXEl
         NzOg==
X-Gm-Message-State: AOAM532DeHy2fngqeQ+3p18InjirfbGCL/nk5lxMG5uuiPzzHOzprU/I
        qpROz64ZNm2ZElRrTuemYApb/A==
X-Google-Smtp-Source: ABdhPJxqk2zGhDGZJVw4sdmPM+ciEWAW24BXvgeiu5oFPiHXm3UbUZEWegPSBDlvL8N/12l5EIu9eg==
X-Received: by 2002:a17:902:7fca:b029:d2:439c:3e97 with SMTP id t10-20020a1709027fcab02900d2439c3e97mr1917445plb.22.1600902678777;
        Wed, 23 Sep 2020 16:11:18 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id j19sm668468pfe.108.2020.09.23.16.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 16:11:18 -0700 (PDT)
Date:   Wed, 23 Sep 2020 17:11:16 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Alexandre Bailon <abailon@baylibre.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        stephane.leprovost@mediatek.com, gpain@baylibre.com
Subject: Re: [PATCH v2 0/4] Add support of mt8183 APU
Message-ID: <20200923231116.GA1154153@xps15>
References: <20200910130148.8734-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910130148.8734-1-abailon@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

Things have been quite busy over the last 3 weeks, preventing me from
giving your work the attention it deserves.  It is on my radar and will get to
it in the next two weeks.

Thanks,
Mathieu
 
On Thu, Sep 10, 2020 at 03:01:44PM +0200, Alexandre Bailon wrote:
> Some Mediatek's SoC have an Accelerated Processing Unit.
> This adds support of the one available in the mt8183
> (aswell some derivative SoC).
> 
> This series depends on two other series:
> - Mediatek MT8183 scpsys support  
> - arm64: dts: Add m4u and smi-larbs nodes for mt8183
> 
> Changes in v2:
> - Drop the workarounds needed to load bad firmwares
> - There are many name for the APU (most common one is VPU).
>   Rename many functions and dts nodes to be more consistent.
> - Use the bulk clock API, and enable / disable clock at a better place
> - add few comments explaining how to start the APU
> - update the way to use pinctl for JTAG
> - fix some minors issues
> - fix device tree bindings
> 
> Alexandre Bailon (4):
>   dt bindings: remoteproc: Add bindings for MT8183 APU
>   remoteproc: Add a remoteproc driver for the MT8183's APU
>   remoteproc: mtk_vpu_rproc: Add support of JTAG
>   ARM64: mt8183: Add support of APU to mt8183
> 
>  .../bindings/remoteproc/mtk,apu.yaml          | 107 +++++
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  39 ++
>  drivers/remoteproc/Kconfig                    |  19 +
>  drivers/remoteproc/Makefile                   |   1 +
>  drivers/remoteproc/mtk_apu.c                  | 437 ++++++++++++++++++
>  5 files changed, 603 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml
>  create mode 100644 drivers/remoteproc/mtk_apu.c
> 
> -- 
> 2.26.2
> 
