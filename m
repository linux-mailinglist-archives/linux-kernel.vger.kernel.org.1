Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0C32E0366
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 01:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgLVA0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 19:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgLVA0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 19:26:50 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A203C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 16:26:10 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id w3so10440274otp.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 16:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JkT2GoAgaDCIg6JP1BBV4nUDnDd5UxbXfE+0ky9BWws=;
        b=mVcxaYyxooCgxbJpCm1rd54CEfXZq0eH3JT8VYFsjVoz8RAaKAR5FrrKRHZ1Beefgf
         NIvfhHmCaF70c67max9e9NFoT3oBGCDFnZ98Cspcp74LMJ7Qq8kHIOQ+6FOXbU+LJCX1
         ug9U7LJmxQoRS1pNV/RRe8XvU+zplfJxoiH80s2+iVQbxJzoQkqdhTaTepjEdXa6C5if
         qsMeqUe4nC0ygvtnwFrnt9w2cXbPL477zOueDblm5vZJcbE2eKLGmfCCUg/wh/RGOspP
         b1EzJnCSNavPb/10WYeERP1UJb36Vg+8iGTgE82cr0QDIwITkjJ9yWvMcwi1Jn8MqpuD
         iC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JkT2GoAgaDCIg6JP1BBV4nUDnDd5UxbXfE+0ky9BWws=;
        b=kWZCzKsp7V1uUBBoRu0a+FTvNaVWLXTPpGlwfu3dH5rfO8OIs/fHVkLw2Ez5s8/r6K
         VjLfy5wEgi1vM592kN+bRHDOFnzo52CJihNxKbyr5YQo9S0yas1lrrYcB0aVojZ92Kq7
         JIuRJdk5eJDgJY83kTsdvpmjC7GnwX0aNAuGB0fS0s4xmZ1HmKDzPCnyeY2FUAErJP/g
         /oXUuRVQEzKAhLG+w1x8rnohTSSwOqabN1WyXMfj28CVfglonQtq39a7VG3RKPqO3Hg5
         0R6M7BK8/+UigOJlAs+MS+Lzj5xsNq0BY6MyUWSSgr7UH3Hhb0xNxd1Cl2khQGIunUSC
         63JQ==
X-Gm-Message-State: AOAM532a5uRfAtGlQevwZLfLe9YhswOQyJPkF9flTQLNgDozrkSL3ogS
        wYMIibcAe4nKjebQ3SloHRKMVQ==
X-Google-Smtp-Source: ABdhPJzQZF8CgUO1+SF5WMwEL99ZiQpdPW5XrIXz4b28AIUk8f48EZoGy4LQ2q1+iKfX44jX3IVIWg==
X-Received: by 2002:a05:6830:110b:: with SMTP id w11mr13916917otq.285.1608596769655;
        Mon, 21 Dec 2020 16:26:09 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m7sm4066357oou.11.2020.12.21.16.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 16:26:09 -0800 (PST)
Date:   Mon, 21 Dec 2020 18:26:07 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     ohad@wizery.com, mathieu.poirier@linaro.org,
        o.rempel@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, matthias.bgg@gmail.com, agross@kernel.org,
        patrice.chotard@st.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/8] remoteproc: introduce is_iomem to rproc_mem_entry
Message-ID: <X+E9H1WBtK/xkjUs@builder.lan>
References: <20201221100632.7197-1-peng.fan@oss.nxp.com>
 <20201221100632.7197-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221100632.7197-2-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21 Dec 04:06 CST 2020, Peng Fan (OSS) wrote:

> From: Peng Fan <peng.fan@nxp.com>
> 
> Introduce is_iomem to indicate this piece memory is iomem or not.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V4:
>  New patch
> 
>  include/linux/remoteproc.h | 2 ++
>  1 file changed, 2 insertions(+)
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
