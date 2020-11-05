Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDE82A8300
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbgKEQGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgKEQGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:06:05 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76319C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 08:06:05 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c20so1740118pfr.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 08:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tcIkgTJPLpkhdZacr76tfOm6rgrkfw7s2ZkhH1Tbzc8=;
        b=W9VHwEqFaK+4slIwWgFXll7jB05SQCRdmvTbzySiv1j6aI0MybAxZDNAil2cFMVBEI
         7aijcZncXdxSbatagESRThbtqIy7l7WIe1Rj5uh+zzUsCHrMujQtzNL9QzpAEGb9s2uZ
         MDhCe7EDPjwGlOlFPq+FPkdh+olRsVw8CykcOjv/RnBx+taTHNUaSgD28y1LFOTyUabY
         AJDoB63n8++vbe+2cSA0nuwdlx01ibBXDIqGKu60dk6tJu8Ee+c30Dt4ZpDFv6nhgyeY
         D8RzHlcUj+IocM7NN9yOt+InHbH85NJYk0Jm6TZTq3DrZ/ctfHQOa1SMmw9+F7EsJF8T
         Sp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tcIkgTJPLpkhdZacr76tfOm6rgrkfw7s2ZkhH1Tbzc8=;
        b=PokHnp8qe7zamR62nY3Ihc8po4BMspluEPjUsOpN0fegeK7TeRZWe5owpIpIO75Y8r
         v8/bognKx06l9sVCjYhM8ETaeYhS0nvJXGwAUCJNDISBMldOnqLzZ5UYywv2j/+AUv4g
         RPxrWq7PTU8HUpDsslpVqNZjLnYDTlKtKgvJZWLrDeofVzl6+acu4pdIdzTkYw+cIEQ0
         3FZflh7MXycTJbuzCf+ngIaGGX0kqbSxzoIKq8cakX57sXIYj5bokXY7zb9gfELjVPwo
         gtJZy8eJgN1wNl6cujAYqHBM5ResnzJABEc8ioNHG7gQKZJSa4WyZsO14P+5WfPPXL93
         4+xQ==
X-Gm-Message-State: AOAM533mvs+PJG1DFXrj5IC8Lm+qwgpGhE1ERAp3yzpsP3EiXPmfX+Ej
        M3b0+wgrBETSZ8bBVh7se2uA
X-Google-Smtp-Source: ABdhPJyRTLxTPLx6zU9LgPxazZRz9dkRYeXzbkVOT1LqB4A3lkF93+NNb7+yx75OIzFaD9qlaBbyIw==
X-Received: by 2002:a62:19c8:0:b029:18a:ec5e:e68e with SMTP id 191-20020a6219c80000b029018aec5ee68emr2830119pfz.9.1604592364817;
        Thu, 05 Nov 2020 08:06:04 -0800 (PST)
Received: from work ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id v12sm2842394pfu.193.2020.11.05.08.06.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 08:06:03 -0800 (PST)
Date:   Thu, 5 Nov 2020 21:35:58 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     carl.yin@quectel.com
Cc:     hemantk@codeaurora.org, sfr@canb.auug.org.au,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        naveen.kumar@quectel.com
Subject: Re: [PATCH v2] bus: mhi: core: Fix null pointer access when parsing
 MHI configuration
Message-ID: <20201105160558.GG7308@work>
References: <20201102122710.23406-1-carl.yin@quectel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102122710.23406-1-carl.yin@quectel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 08:27:10PM +0800, carl.yin@quectel.com wrote:
> From: "carl.yin" <carl.yin@quectel.com>
> 
> Functions parse_ev_cfg() and parse_ch_cfg() access mhi_cntrl->mhi_dev
> before it is set in function mhi_register_controller(),
> use cntrl_dev instead of mhi_dev.
> 
> Fixes: 0cbf260820fa ("bus: mhi: core: Add support for registering MHI controllers")
> Signed-off-by: carl.yin <carl.yin@quectel.com>
> Reviewed-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Nit: Your name in the Signed-off-by tag should be in a proper format
like "Carl Yin". I'll fix it up while applying. But please fix it in
future patches.

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> index 0ffdebd..c6b43e9 100644
> --- a/drivers/bus/mhi/core/init.c
> +++ b/drivers/bus/mhi/core/init.c
> @@ -610,7 +610,7 @@ static int parse_ev_cfg(struct mhi_controller *mhi_cntrl,
>  {
>  	struct mhi_event *mhi_event;
>  	const struct mhi_event_config *event_cfg;
> -	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	struct device *dev = mhi_cntrl->cntrl_dev;
>  	int i, num;
>  
>  	num = config->num_events;
> @@ -692,7 +692,7 @@ static int parse_ch_cfg(struct mhi_controller *mhi_cntrl,
>  			const struct mhi_controller_config *config)
>  {
>  	const struct mhi_channel_config *ch_cfg;
> -	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	struct device *dev = mhi_cntrl->cntrl_dev;
>  	int i;
>  	u32 chan;
>  
> -- 
> 2.25.1
> 
