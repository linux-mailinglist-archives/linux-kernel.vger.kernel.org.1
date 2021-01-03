Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53E62E8E20
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 21:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbhACUjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 15:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbhACUjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 15:39:04 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA20C061573
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 12:38:24 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id b8so13333191plx.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 12:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XvrKssYYT7cwZM69/vVSJ9MvxCCu5oos/HuxgCZEtxI=;
        b=E7LjxrLe33RpLpApT8KK9xNFa8cVaYMgQHfpHxtmt6PElVaHXO6DWqHsgMWuVnYPNV
         5a6g4DnOH1ctQRTKKNe9XE5MVPqqNijBUzdX2v8rdagJ0Ve3hMhIiHt1U/qjGHGlQUFv
         2OM/kGkNkVayWYtveeKiOIMZJBbVKGqQk9qZDF16LENqqmRSYXl+h1fJe7rAkdXil1zH
         vcYSfi4vVLwzOhqWKHH4/HsUCV327e0kp27mB/bWEiCsQCWr92NlwOp2+q3m6cpe6MtQ
         68A/nCSiSTngUiu8PQnKyize9l8ROScwH7l05xrU383+qUrAqIpkhvGtF9Vb3tvA+baA
         bnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XvrKssYYT7cwZM69/vVSJ9MvxCCu5oos/HuxgCZEtxI=;
        b=szJFOpytcOWBSmn5pNeQWk9hrXFDAyHZsRh+P+W7WH/0bSLO9Dv0+u2F9mF6kUC4vZ
         89J4RsRhKOw8r9mS9joSmBsKfOk1mGdhJYFaUW8n/OViRjNTlMk8Gj3BpEerlKzmT5ou
         FCtJQX9CPSnE9a4wT7KGi5IIyGdMdt+vBu/OAA9+Y1VLpWcz5mcM62rYMSwR5BKlH4O7
         NHDDy9DGzEUY85FDaq1R3Ko1f6jcnaxuQ7Yac1GT3Omdb2vOCmLWx27fZuibxp3bHZO5
         lV1LB7YLiM0pq2aQYWKe4OA8LmJtjU4u9VS5HJBCEEn1tP1gzEDyp7//PGJ2Y3NbsEzo
         S0eA==
X-Gm-Message-State: AOAM532hA+GTf/IT1OUyWD/YsCFKtDZbA0/x9dde9U/yh+qxkfmTjjex
        MxbQrh5jfGCePLd5ax4ffqDfcAVjJxVyGA==
X-Google-Smtp-Source: ABdhPJzOUTk7776jpYnKQuUkjnwafBFh9qgvVIzYW4BMsTa/mkli9DsBJKj+ahbJMUTsppa2z5EJlw==
X-Received: by 2002:a17:90b:68e:: with SMTP id m14mr26573593pjz.228.1609706303729;
        Sun, 03 Jan 2021 12:38:23 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id d4sm18477198pjz.28.2021.01.03.12.38.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Jan 2021 12:38:23 -0800 (PST)
Date:   Sun, 3 Jan 2021 12:38:38 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_aud2htx: select SND_SOC_IMX_PCM_DMA
Message-ID: <20210103203837.GA2020@Asurada-Nvidia>
References: <20210103135327.3630973-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210103135327.3630973-1-arnd@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 03, 2021 at 02:53:17PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added driver requires DMA support and fails to build
> when that is disabled:
> 
> aarch64-linux-ld: sound/soc/fsl/fsl_aud2htx.o: in function `fsl_aud2htx_probe':
> fsl_aud2htx.c:(.text+0x3e0): undefined reference to `imx_pcm_dma_init'
> 
> Fixes: 8a24c834c053 ("ASoC: fsl_aud2htx: Add aud2htx module driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
