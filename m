Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72CF91E4D42
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 20:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgE0Srj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 14:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgE0Srg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 14:47:36 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36CDC008635;
        Wed, 27 May 2020 11:41:12 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id r2so16902995ioo.4;
        Wed, 27 May 2020 11:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SZIP9gMLgQ3EMwU5hsVyfxacis5ozsWVrpZIFpNFZGc=;
        b=G+4gJintsKdfnw7fRfaD8JBiK50z0248dtdyAiUCtgFne2vvp2IawDUNvMBn3A9gvs
         mzywz4NvWqJDFSJ3+CHTEO5Al5lzUJf1cbR/czx2LwMpjGCTPeMKryhIqHI3mxE5i+uJ
         Sjs0+Jnap5wVAZ+SXCyQ4ucCJdHQu0dSAWpRBXpjYbWamZ4oMKHGY1m6VKF0RM7rqyH9
         YTCLP4GK3iyaRZm+KDUAkxI4kwaoZkbpKzgEqp7mtjn3t8NJTz2VG7QivKdnyO/i2msJ
         c77ee5aWqlLxSQaoO2iZOL6ItyLLNhZNrpLtFlR1DNKgDUQkxRXGELllQ4cArbmdA5jc
         g+rA==
X-Gm-Message-State: AOAM533obs/Ln8JBjkH09fwceSH2cfUR4o9pXlmJVvzwFQwNFvJ85HD5
        zaA6FsZof5iU6oTW7622YQ==
X-Google-Smtp-Source: ABdhPJy9b/AK7GxNKc/ofJ9HvLdVBBl8IZ9/rlzqGnAPgtRfy+4FSAq2XENSvm4Jrr7coT1f/mQx8w==
X-Received: by 2002:a02:90cd:: with SMTP id c13mr6859068jag.83.1590604872125;
        Wed, 27 May 2020 11:41:12 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id g19sm1552123iom.21.2020.05.27.11.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 11:41:11 -0700 (PDT)
Received: (nullmailer pid 2530396 invoked by uid 1000);
        Wed, 27 May 2020 18:41:10 -0000
Date:   Wed, 27 May 2020 12:41:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Qi Zheng <arch0.zheng@gmail.com>
Cc:     devicetree@vger.kernel.org, frowand.list@gmail.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt/platform: Fix comment in of_dev_lookup()
Message-ID: <20200527184110.GA2530290@bogus>
References: <20200524152614.69393-1-arch0.zheng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524152614.69393-1-arch0.zheng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 May 2020 23:26:14 +0800, Qi Zheng wrote:
> The code is using of_dev_lookup() rather than of_devname_lookup().
> 
> Signed-off-by: Qi Zheng <arch0.zheng@gmail.com>
> ---
>  drivers/of/platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
