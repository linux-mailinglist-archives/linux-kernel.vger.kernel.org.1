Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0619B2A62D9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 12:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbgKDLFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 06:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbgKDLFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 06:05:02 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDC4C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 03:05:01 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 33so10770816wrl.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 03:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uGpMj3h6QmyluEWK+senKwfVoJtwj/Kz3PcPUWSG8IE=;
        b=P9dFybcJibfBDmQi5sdHXLOHo3j4v7Ku7M/zi6ZXNrg33f7xEJwjHgeSSiRIO06RLI
         TagOY+zOnwHGMxG8TAlEUMZxxA23SghjQRUy1SWjgkGoPPXYbpSHkck3UDYTZtj16NQM
         N5VSRSe7DMIlfsEPnM054+heTcwJfy5uu3EUGFgIVWBeZVKSX1hWs5UaAcjzRT7W7VwM
         maDFEwWVqyEaHxqxasPSXVbJMZiZvv8YcpWTKCDiZEka5Z+Ag7K0BnCc+PDnK+dETxld
         lsQ1CmmtoJwMHoTDcjRVuqUl/PUfFPWwXC/t1yR0l937P4lJshDfIwBEbupsP1oto8bL
         Bn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uGpMj3h6QmyluEWK+senKwfVoJtwj/Kz3PcPUWSG8IE=;
        b=lSDTKqWQIayy/K6gn5w5yzAG2/RsGIk8Cd3WtjbgyuNszn3TvXT0fIxjbHDpq3ivUe
         JITZaj6rI/x//31hqjryhYQMVLwIY4Do4gs+yfRaksxYXJGJv6LCskDOXfz+g2OAdEA5
         iJ6PdqtxsaZouImW5d8obAkEkHasJLaomCeluHps14Nvm1P3w73S4/sUGUq690SRgrzS
         uaYgC7TeNI7ZXbXx5yLVdtJTnjVc4NdpwOMY2ZjUmWqZDlR9kvDq656JtBWQEYKBEVoR
         u0J6YMEc3fvZtABXrxecuAzFlpAGPNOulZuLRBwVF36r/KWSQETrmfH29h1/dm1L2g5n
         SLjQ==
X-Gm-Message-State: AOAM533AwYsIAEUPzSuTjD7xjWu+w94J4cU9dG1fSg8ObfL4sJigWz7e
        Jn6CPaHKYwPXRw99CcRJMlnWkkDm9MMWJkne
X-Google-Smtp-Source: ABdhPJzL5PqiyhpAF9ZSPqLoerHA1chzXdZ2P8S+5sBCkqBJX16Uu0diQU9MJvJOsCDk1ZQc4TzDng==
X-Received: by 2002:a5d:4d0d:: with SMTP id z13mr30172100wrt.23.1604487900539;
        Wed, 04 Nov 2020 03:05:00 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id c185sm1713709wma.44.2020.11.04.03.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 03:04:59 -0800 (PST)
Date:   Wed, 4 Nov 2020 11:04:58 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] mfd: Constify static struct resource
Message-ID: <20201104110458.GZ4488@dell>
References: <20200922192659.14535-1-rikard.falkeborn@gmail.com>
 <20200922192659.14535-9-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200922192659.14535-9-rikard.falkeborn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Sep 2020, Rikard Falkeborn wrote:

> Constify a number of static struct resource. The only usage of the
> structs are to assign their address to the resources field in the
> mfd_cell struct. This allows the compiler to put them in read-only
> memory. Done with the help of Coccinelle.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
>  drivers/mfd/88pm800.c              |  2 +-
>  drivers/mfd/88pm860x-core.c        | 50 +++++++++++++-------------
>  drivers/mfd/hi655x-pmic.c          |  2 +-
>  drivers/mfd/intel_quark_i2c_gpio.c |  4 +--
>  drivers/mfd/ioc3.c                 | 16 ++++-----
>  drivers/mfd/max8925-core.c         | 56 +++++++++++++++---------------
>  drivers/mfd/rdc321x-southbridge.c  |  4 +--
>  drivers/mfd/retu-mfd.c             |  4 +--
>  drivers/mfd/rk808.c                |  8 ++---
>  drivers/mfd/tc3589x.c              |  4 +--
>  drivers/mfd/tc6387xb.c             |  2 +-
>  drivers/mfd/tc6393xb.c             |  6 ++--
>  drivers/mfd/tps65090.c             |  2 +-
>  drivers/mfd/tps6586x.c             |  2 +-
>  drivers/mfd/tps80031.c             |  2 +-
>  15 files changed, 82 insertions(+), 82 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
