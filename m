Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E1E28A7AE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 16:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387961AbgJKOG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 10:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387885AbgJKOG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 10:06:57 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA843C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 07:06:55 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u24so11512893pgi.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 07:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4+10aIg0LY5QAFNAEfhIEK2HTC8CvBMQh8TDi3Ta15g=;
        b=U4k1uUk58Z1nR8RuU6oY/B6VajK+wYVdouZOe90lFioapLR8w2XhFo9kvBOEB81su/
         uRMhMtUzQ7Dv/kTEnTR3Vne5ivWTGVDNAs+m7YO1v0HrdLHhR9/46xjmBQv6EqaDKsWM
         EojcvA5wi0FyFvP8gOlgxK/um+xMfsdoB8A1ppoKmIu7oN/+NONFV1j11/rvpcaWBWhS
         E+nI0GctxBRFPmYUstGrZi+LryM1CziGe81PiDyo6eIwomotyl9VFRiyKYYPhVx9zBgN
         fzRUySBVEtF9gbMLCR2Men6iBa45e9ZKoXL87Q9CbF7lNqP72mUfL9Cl435ChTBMA70j
         MuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4+10aIg0LY5QAFNAEfhIEK2HTC8CvBMQh8TDi3Ta15g=;
        b=mVlOz/4+AnIX4cdtu8RxlkGQl8Mrz4VjNAC+6cJcBAmxLp1IBHM9+n3WPi/sfRMuvL
         rE26WMUaSvp+7m4nlnIOx04O3ASw8C4v1Ch35MIXqxYT/1cZ34Cah3ysQiQG+WiC/+uq
         mOFEew/TJhy6sG6YF7QpIE931YcAV54VosG4I8MPo1VV1NbxYdaS5PONelmbKktBM1A0
         hyGp4myBMlfTmXyI62f5LjMZ7hKG++O0uTSZ4hrCXWBVKjhqFlmrvgkix1g7reSPscS8
         J5kzA1lPnnNN3/eHkAvChzBdikk6pOon5OEw6x2Se7X4hF7rP4xQna1ejDOpWYJh/I6Q
         9s8Q==
X-Gm-Message-State: AOAM530b6i90Nb5Ed0oYCeMvGqGwS6K+7TOBW8GxJvBkz9z3zKV+aGCq
        3KQW0p0/BKsoACRCpVgWekVE
X-Google-Smtp-Source: ABdhPJzUC2gi2ueJb96QvQxo1BNhkGYEBWHO1rWrZi4GSflNVuTbwnyy0DIufn3AcEOSjc0OPHHNGQ==
X-Received: by 2002:a62:ed11:0:b029:155:4bd9:6ade with SMTP id u17-20020a62ed110000b02901554bd96ademr15393025pfh.6.1602425214953;
        Sun, 11 Oct 2020 07:06:54 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:28d:c562:841e:ecfd:8468:c018])
        by smtp.gmail.com with ESMTPSA id b21sm9403865pfb.97.2020.10.11.07.06.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Oct 2020 07:06:54 -0700 (PDT)
Date:   Sun, 11 Oct 2020 19:36:45 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Wolfram Sang <wsa@kernel.org>, Peter Rosin <peda@axentia.se>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
Subject: Re: [PATCH 3/3] i2c: owl: Enable asynchronous probing
Message-ID: <20201011140645.GA4971@Mani-XPS-13-9360>
References: <cover.1602190168.git.cristian.ciocaltea@gmail.com>
 <f343802a4b1a8ab6fc78e5db6d24a350b2319495.1602190168.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f343802a4b1a8ab6fc78e5db6d24a350b2319495.1602190168.git.cristian.ciocaltea@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 12:44:41AM +0300, Cristian Ciocaltea wrote:
> Speed up the boot process by using the asynchronous probing feature
> supported by the recent kernels.
> 
> For SBCs based on the Actions Semi S500 SoC, the overall boot time is
> expected to be reduced by 200-300 ms.
> 
> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/i2c/busses/i2c-owl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/busses/i2c-owl.c b/drivers/i2c/busses/i2c-owl.c
> index 547132768119..ed3942051845 100644
> --- a/drivers/i2c/busses/i2c-owl.c
> +++ b/drivers/i2c/busses/i2c-owl.c
> @@ -521,6 +521,7 @@ static struct platform_driver owl_i2c_driver = {
>  	.driver		= {
>  		.name	= "owl-i2c",
>  		.of_match_table = of_match_ptr(owl_i2c_of_match),
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  	},
>  };
>  module_platform_driver(owl_i2c_driver);
> -- 
> 2.28.0
> 
