Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274F82B1BF9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgKMNhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgKMNhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:37:07 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2968FC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:37:07 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id s8so9923872wrw.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZXNcKWQV/iEYRYgtaXItr/T7NMzdHwiOF6B3gBdjlXs=;
        b=iEzsfCk1zLQ2MDNk/U8uXqwMw6R8CD2OZcMKYDv9aRltDGLn4y0PDZ9o2zaiCHNXyG
         v2FpDwIpb7Yphd1RxG19LrMGWFChFd7HLfeYB6paIaqzOZ6m5SwW9zv34Dx/Pee8DRee
         B5wVBCcYuwO7gZroB/h5ZZF87gYv+tspvDp6z7ZhbpMwafNnad7Ti/PpVAv11YAKQPNA
         Nc2BVAgQWmAR2kRq416gSnf1Tkng5kY7GLHbtPC2fxXRSDbmEo0pc50hNCXf/zc2gLhh
         sBkNfNNw60BfZIGAK3xN4tsBtf5WiNe2DMlTZRdjnrNYfeaNC1jHf+Bje7bmpzvTsxLK
         0v8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZXNcKWQV/iEYRYgtaXItr/T7NMzdHwiOF6B3gBdjlXs=;
        b=OxQPhSvyAt2MOVGNaU6hTj4R0Nu8GztYZ45OR0GW2OOIg0NfPBfv5bhJA2QVxB1KAh
         QDWR6dR/nehmeLK8OMPmUNRwApfrVaZgZtUlRlobuOMaVSbDZZP1lsJ+ggZTsaJ+1iNG
         PDqhlRrLKoQLNBnnTCwf4Qr2IKtLQV8pHzfbDcRfyZ+9h9lh1IIsdQqfyDZvBiMfMHjs
         I9GVFv7F11gIYNstF1UB66TQoaSB1bRxoTUwq5r3IaYS7XX7WzVYIZsHdAFfm8qS7ONt
         +k4KZrJyqe2kTlhGgHwWffe6lvcNcYelOsDTBiQscMonKRQjIMyEGAwL79hR6SZ8YGl1
         Cm4w==
X-Gm-Message-State: AOAM531+/h0z7YKu7FJv79/qVlM03WeA1PdNc4AjjP4YsvhsoM9ctzdM
        91e/314tX1wMNnJIl1CVj+WE2w==
X-Google-Smtp-Source: ABdhPJwrsEOkezQK2FB3H3FkJIqCrtELMW+h2nOu6rx156SZy+MuKs9Kw+gq+hQzvwLWmxsMPLt8oA==
X-Received: by 2002:adf:84a5:: with SMTP id 34mr3501915wrg.8.1605274625927;
        Fri, 13 Nov 2020 05:37:05 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id c2sm10395014wmf.47.2020.11.13.05.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:37:05 -0800 (PST)
Date:   Fri, 13 Nov 2020 13:37:01 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mfd: stmfx: fix dev_err_probe call in
 stmfx_chip_init
Message-ID: <20201113133701.GJ3718728@dell>
References: <20201113122725.12971-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201113122725.12971-1-amelie.delaunay@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Nov 2020, Amelie Delaunay wrote:

> ret may be 0 so, dev_err_probe should be called only when ret is an error
> code.
> 
> Fixes: 41c9c06c491a ("mfd: stmfx: Simplify with dev_err_probe()")
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
> v2: address Lee's comment about error handling area
> ---
>  drivers/mfd/stmfx.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
