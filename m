Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABC92478A2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 23:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgHQVRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 17:17:31 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:38999 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgHQVRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 17:17:30 -0400
Received: by mail-il1-f193.google.com with SMTP id f12so8217079ils.6;
        Mon, 17 Aug 2020 14:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fEJijV8ieRhM9pU0b66oFoC8+BxQVxgYtUFe2JVtLRU=;
        b=CTf/tcODswCqSLG6GjgmEp2sbGLssI3uOSSuRaojrDkDMzDInG6PYCZ6JYFczIYxRy
         FKRfvzPqGqobq/L3CHRb48ejnVyd7iMpMhw7agZdu5kse7GeIv3v5+Lao5WkIRIc8tiW
         LYT6pe7Lz6rhgCZMi3lgyp1I69eKCfl2toMIo7Ry5DLqUUpfpDVJHh7K+XVTwlYCBmAF
         +NjXywHORVevdtQE+4MJQj4EKJI/c5FzkzMo8nNEyIiWE2058FV4wa1QZ5pGm+FzTqtl
         Pv+jJpaa5B0Zvg76o+4nAK5GBDDk8nb4OBjyKiNAFV6k0nFY45S2brHyq7HLBdCpd+lq
         6yWw==
X-Gm-Message-State: AOAM530OovrOatYF0g9HfjsFugcggL9YoPwOLPbncqZZ9uStguSlYpSb
        /vDC5EvmHyR7TIjWbmeb4Q==
X-Google-Smtp-Source: ABdhPJwVXeCNY/DOviWn1/mTBa45rCMz6NgTmoKRifw6gM2z4bS2UuDgsKsYwaUFwiOQGRYCgy9uWw==
X-Received: by 2002:a92:5ad8:: with SMTP id b85mr14803799ilg.304.1597699049780;
        Mon, 17 Aug 2020 14:17:29 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id v84sm6494214ilk.4.2020.08.17.14.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 14:17:29 -0700 (PDT)
Received: (nullmailer pid 1578739 invoked by uid 1000);
        Mon, 17 Aug 2020 21:17:27 -0000
Date:   Mon, 17 Aug 2020 15:17:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     ulf.hansson@linaro.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-am654: Document bindings for the
 host controllers on TI's J7200 devices
Message-ID: <20200817211727.GA1578682@bogus>
References: <20200802070114.9624-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200802070114.9624-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Aug 2020 12:31:14 +0530, Faiz Abbas wrote:
> Add binding documentation for mmc host controllers present on
> TI's J7200 SOC
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-am654.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
