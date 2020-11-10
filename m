Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C2E2AE14B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 22:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbgKJVDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 16:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgKJVDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 16:03:00 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36075C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:03:00 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 33so14249539wrl.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cl7mu1oJmxHryxTnp1BFFDbppYfx4b3GmLjMWirrXpA=;
        b=t0KEjfmxLppQcRxfnYEcNWIZBmLHP7HXMRFKhC00W8Hp2KWhozDeUsxelrXqVMzcQj
         KXlmUYDPtPDEwdE3/ExohP+t2Xww0n4xcP+FBpqavG04n6y5GiytgkVIG4n/EqJSONvf
         +m4TuIGfaeOetLwKfABy+Qp7zMYmclssGNjqBVoh+AsCJ2Dd4LnEe4EnARmZPrLESRds
         ZBTP2N7MC236DxwF6/J2KrS4Pr+VX8ALzm+efyx22XsYuS91JDGoRtTkwVrpLKd+C1MK
         ED4EYR5QKYe3n6p3p8i7rLWBGr4YqxonTyfAqxCtiQrBByo0eM9c4xp/kjNYVpX7x8tQ
         J0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cl7mu1oJmxHryxTnp1BFFDbppYfx4b3GmLjMWirrXpA=;
        b=MUvdKGpUu2VOMRjjJ6+Cpt/LVQlAZ/s22/Qgwb/CNe5dC+R1q4QqfwCZ/zgWzPzsn/
         Pz98QsE/UOhdL92LrFoJw5yg4BglC2TJzDk2WNjwlwL7gPWdMFqWiqeW47W9ROnYDtpA
         gi7MDHv66SH3ADClKe29oGsuZxfeRaMjrK4s9HNK4fB6CLtZhQuAT1jW9sdcEUL0OZXu
         Ikv3q3IEFnDnSF64KXwrxbp+AE33i5PY4dnp0ILp1/s8E+s6hhy9dwtqbBTMMluxY1Gc
         7U70wmfs8oykO9Wd+U3TVRnkGTU3Mqkj3tAPht6QAMPzCYTbFfL3WgL31d/yavPvw2YS
         QoOQ==
X-Gm-Message-State: AOAM533mvIQ0PnGC9Wdujwyk6Jp86F0OwYQkmE3CeOsm9l8SAo3IOzRj
        LrEcKDj6UMhOYYnSQrKzMnIUvkPB1oxavLUw
X-Google-Smtp-Source: ABdhPJwIsCLVZUJBtrdWyW3Ob7YqHeqsWN46NIYBEC8Ip4Zj9vK+XjNlJtGBKT0A6Vdthxqmn7lVPQ==
X-Received: by 2002:adf:db4a:: with SMTP id f10mr11091524wrj.420.1605042178875;
        Tue, 10 Nov 2020 13:02:58 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id p13sm18415385wrt.73.2020.11.10.13.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:02:58 -0800 (PST)
Date:   Tue, 10 Nov 2020 21:02:56 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 24/25] soc: tegra: fuse: speedo-tegra210: Remove a group
 of set but unused variables
Message-ID: <20201110210256.GK2063125@dell>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
 <20201103152838.1290217-25-lee.jones@linaro.org>
 <20201110194134.GB2375022@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201110194134.GB2375022@ulmo>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020, Thierry Reding wrote:

> On Tue, Nov 03, 2020 at 03:28:37PM +0000, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/soc/tegra/fuse/speedo-tegra210.c: In function ‘tegra210_init_speedo_data’:
> >  drivers/soc/tegra/fuse/speedo-tegra210.c:105:56: warning: variable ‘soc_iddq’ set but not used [-Wunused-but-set-variable]
> >  drivers/soc/tegra/fuse/speedo-tegra210.c:105:46: warning: variable ‘gpu_iddq’ set but not used [-Wunused-but-set-variable]
> >  drivers/soc/tegra/fuse/speedo-tegra210.c:105:36: warning: variable ‘cpu_iddq’ set but not used [-Wunused-but-set-variable]
> > 
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Jonathan Hunter <jonathanh@nvidia.com>
> > Cc: linux-tegra@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/soc/tegra/fuse/speedo-tegra210.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Sam as for the previous patch, I applied this and removed the register
> reads altogether, since there aren't any side-effects.

Perfect.  Thanks Thierry.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
