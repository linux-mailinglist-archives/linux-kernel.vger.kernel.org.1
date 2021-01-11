Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26512F1E4E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 19:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390538AbhAKSyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 13:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbhAKSyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:54:21 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4AFC061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 10:53:41 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id a188so468054pfa.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 10:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jSERQ+46dpd0R1Tdu0kDaiLVRoNkNJzqJu2xIoZLDwc=;
        b=HQU12V6IQwHtU+MAo57BdWUwiuR2P3Qx5SBmBR3VmTsefNj4XuV/6tdcIuOxlzV4S4
         G3w9GECjcEIej/Fb3h6YQN67qMoTermjimXuPqMVJ0XJfVXK3uvxC75FQ8fE2n8uNzwP
         y9vPYamS5tuwrRYF89xpvF6ocoscB4gTFjQ5PCtBuL5AJRROdzernNepyHp4agcAE+9w
         kF4ZRZCIiSfhseiJlNQCTA1OQMwymbmkYfuWJV3z19tsfUXzuOousnP4CPpsNBoz8+2b
         Za5uvLhhXM/5StEAyCzaN8GY21Y+06Oj6CzY1wR7SXZ6SD3y2cqZhv42ovEsGz1h/mt3
         sb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jSERQ+46dpd0R1Tdu0kDaiLVRoNkNJzqJu2xIoZLDwc=;
        b=iWaYuwTGsKuf4I2bNagYK3N28bapjU5MKTpv/cIr/OoXiSOO+0xTIjlQOguO/e3X3z
         aBsrPixElS7j7jK+XDfJodNN5qiQOsaR+wl7DLde3zfFsxcdH6eYRUUNFgfyuOkSb1q0
         GDCidKVeiFBs3kYje5oskqcbGzxZ1Ab4la0iU0OA9clvIcFmBrY0DA7q2mOiVDiupTv/
         ZrBW0cyDhzrTMpJDbnhFW1fJWNfYAHXiaFnA2Z5AVp2DdZlxuVtQ7gj/kRaWN7yqrgdq
         lLzvIDcLrec/Qejz2RTkahzzFguMJ5IaKTlIAw4vkSpU8YdehU9y/eg7jYa87txooGEt
         m1Rw==
X-Gm-Message-State: AOAM533JVM7tvrSWOzWCyDhyAZR9UiN235jaB2n5TDjHjJOPklX3nMxu
        jwPRP324dRO05TKby3WccmYYySVEjgkpvQ==
X-Google-Smtp-Source: ABdhPJyJxqnV8GtIbQSTPtRVjQC4HTgiloJsRJrImG/IokTvyHb/RJ0KxJoVO/40sN1d4VXLj4opTA==
X-Received: by 2002:a62:384b:0:b029:19d:a5c6:d76 with SMTP id f72-20020a62384b0000b029019da5c60d76mr804697pfa.16.1610391220801;
        Mon, 11 Jan 2021 10:53:40 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id n195sm339537pfd.169.2021.01.11.10.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 10:53:40 -0800 (PST)
Date:   Mon, 11 Jan 2021 11:53:38 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     peng.fan@nxp.com
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        o.rempel@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, matthias.bgg@gmail.com, agross@kernel.org,
        patrice.chotard@st.com
Subject: Re: [PATCH V5 1/8] remoteproc: introduce is_iomem to rproc_mem_entry
Message-ID: <20210111185338.GD144935@xps15>
References: <20201229033019.25899-1-peng.fan@nxp.com>
 <20201229033019.25899-2-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229033019.25899-2-peng.fan@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 11:30:12AM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Introduce is_iomem to indicate this piece memory is iomem or not.
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  include/linux/remoteproc.h | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index f28ee75d1005..a5f6d2d9cde2 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -315,6 +315,7 @@ struct rproc;
>  /**
>   * struct rproc_mem_entry - memory entry descriptor
>   * @va:	virtual address
> + * @is_iomem: io memory
>   * @dma: dma address
>   * @len: length, in bytes
>   * @da: device address
> @@ -329,6 +330,7 @@ struct rproc;
>   */
>  struct rproc_mem_entry {
>  	void *va;
> +	bool is_iomem;
>  	dma_addr_t dma;
>  	size_t len;
>  	u32 da;
> -- 
> 2.28.0
> 
