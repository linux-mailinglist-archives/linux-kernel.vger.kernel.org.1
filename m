Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158992A62C0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 11:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgKDK6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 05:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgKDK6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 05:58:20 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C5BC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 02:58:19 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id b8so21573925wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 02:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mAxpfkmWK7mTrDjujUo24hBISOqTOpXD97ns8sDmboQ=;
        b=lg8znmyuN2O7BnstGmjleCOUa05z+WLRvSvhF+trmv2phSNyMAdxu7WePvU199TIuS
         T/TgK++WwTqWaegj9cTPUo/t8jDIae+N3HRsY2jfYaSAN3J4waWtYB0HDxpDnvgCWccW
         PT46vuDvgwrZhUkjdmzLRSEnsjLxgbtwQrotvi9eFw3SjWC+ax76cT5zSmPM7wmxXs6x
         1xE77LiQ/fHoaYi+cuD2I2ydbnbkElEEhxVlWVm8aaYj9j6bF4163v0O2qGse7QazHEv
         65JK3ZsSCvQessncWWuRdvQ9Y03+R2ZkpjddsIQ7fmEIXkdwGp3g2s/cTI9EWrs5tNwH
         mB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mAxpfkmWK7mTrDjujUo24hBISOqTOpXD97ns8sDmboQ=;
        b=X+PZBDxLBDX9eTGZcy9/Nhw4t4pkVmjXS8kLp6uHtYmZp2AfrDZFT08Sk1JYUMlgTa
         MaovQyZEHlcPaqf8J4teJghuE76pXzzobH4s6fBADvfdWY4+k/jboM25rS/kEdje2oVq
         VAm+TYNifKeqDjMeQ5kGHysA1Zb5THKKIMC9yBYEyN8eKhJXHC1KGNe+jCSVdAWEfDIo
         aQOkJKMF9JrUaz7bAFyvTTEfRQJHlpKanckWmQoJNuqINufEYJ1BtFjCKefxURidhUAL
         VdNNHfvhJZjcE1zLJ+UnGH+9pQhN1HAQZH674s3nLsD5uZRGRaLFHkNtvd2hVwMr61UG
         m2Uw==
X-Gm-Message-State: AOAM532Xqrc9fpCj/M9ySicYW9c1MX2VxBdVc2qVt49cHCf7HvMjl2kd
        XKm6IB0vKlLFO+LIEWGmet3XyNeEGyT4BRZm
X-Google-Smtp-Source: ABdhPJxCzd+sYnpJed5EuV6o15LCLm9OzRMtWCknhMkZPUNafnLabpjREYUm4d2vZKMWlX/ACF3Muw==
X-Received: by 2002:adf:c14c:: with SMTP id w12mr27224106wre.40.1604487497921;
        Wed, 04 Nov 2020 02:58:17 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id b7sm1902180wrp.16.2020.11.04.02.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 02:58:17 -0800 (PST)
Date:   Wed, 4 Nov 2020 10:58:15 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Milo Kim <milo.kim@ti.com>
Subject: Re: [PATCH 5/8] mfd: lp8788: Constify static struct resource
Message-ID: <20201104105815.GW4488@dell>
References: <20200922192659.14535-1-rikard.falkeborn@gmail.com>
 <20200922192659.14535-6-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200922192659.14535-6-rikard.falkeborn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Sep 2020, Rikard Falkeborn wrote:

> Constify a couple of static struct resource. The only usage of the
> structs is to assign their address to the resources field in the
> mfd_cell struct. This allows the compiler to put them in read-only
> memory. Done with the help of Coccinelle.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
>  drivers/mfd/lp8788.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
