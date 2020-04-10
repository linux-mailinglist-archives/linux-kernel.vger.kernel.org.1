Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 454621A3DB5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 03:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgDJBWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 21:22:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33669 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDJBWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 21:22:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id c138so408162pfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 18:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3Q2KcR5vivg2vLIlkBGPIg0aMjasX9J0lCrxGu0EU40=;
        b=Q4QXqN8ObBhFo5YYd5MXFVPJmG6I8IpB8kCIEceSLNZEiohuJ1hYR1jU1OcFgHcgKQ
         NCzttmwJPGmGfkCMah1sHDOmdzepxCuLdX99/aWpWxiIoZOD7WM8w9+f6zXK+/Vuq9fl
         qnyw8+a+JSXDKZxg1FzlzhDpB8coXYjo9SJJiY1lyE04ppVt/tedfkdEJV9jwb7Hkw0B
         t0KEPJ2x3CRfar+D730Z3uT0m4LB3ADMTvFPduqnJttjbV8BYJD6UIEb2S77OLOq2D4e
         gXbG8UsCNFKtcqanJZV2VWqAa5c/gNuD63Bf0c9q97MTkHEgzy6RB97N9RHa7i676ygs
         0/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Q2KcR5vivg2vLIlkBGPIg0aMjasX9J0lCrxGu0EU40=;
        b=U773RzntuO9B3LGRMbEPhBicWrGgPxMtevu0U+tIy2NUOlXLnGw9ib5JhqfWHydTjv
         RGJWe4JV8fNVl/eqlyS4GlnessuUyD2qONBbQK4pZzTuj9uCvrBOjrlQ6kK1S74bNvlv
         GkdIktp54DJlz5J/eMcjTmes9LN3wkaWOJuTVUXpqK8P3uZt8zp5S81W6oPU66WiSsWJ
         pjzYqvCjHtCGH6Dj053C0UvCWVLwlg19385h/opx+v5kRh6rWVaErQn0P79AP5kd+UiM
         59UVvWr8UpwJxq33UKMvz00TdbfUzVLK6eN0SDWLzNEVsf/BPsl7WpT1rTynnMg7rIds
         7vzQ==
X-Gm-Message-State: AGi0PuamdAsvX7Nv+5BV2laXoaw6j1DLIPeVEOAQy8C0VWeyriPZJV7o
        /LlLAF2FBY5hRE0UxWJz8zu50A==
X-Google-Smtp-Source: APiQypLpOQFFR0tNf0woJcisRcnRh6SPZmJIFjx7rMqYqS9XD1Mx0/cSXdRJSatERIidaB8va0hhwg==
X-Received: by 2002:aa7:86cf:: with SMTP id h15mr2628240pfo.263.1586481737786;
        Thu, 09 Apr 2020 18:22:17 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u3sm337755pfb.36.2020.04.09.18.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 18:22:17 -0700 (PDT)
Date:   Thu, 9 Apr 2020 18:22:26 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH 2/2] remoteproc: use filesz as backup when translate
 memsz fail
Message-ID: <20200410012226.GV20625@builder.lan>
References: <1586420572-28353-1-git-send-email-peng.fan@nxp.com>
 <1586420572-28353-2-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586420572-28353-2-git-send-email-peng.fan@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09 Apr 01:22 PDT 2020, Peng Fan wrote:

> Since we no need memset if memsz is larger than filesz, we could
> use filesz for the da to va translation when memsz translation fail.
> 

To me this implies that the firmware has a segment that's larger than
the memory that it's going to run in. I think even if we're not writing
to the entire memsz, asking da_to_va for the entire memsz provides a
valuable sanity check.

Regards,
Bjorn

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/remoteproc_elf_loader.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
> index cc50fe70d50c..74d425a4b34c 100644
> --- a/drivers/remoteproc/remoteproc_elf_loader.c
> +++ b/drivers/remoteproc/remoteproc_elf_loader.c
> @@ -229,8 +229,16 @@ int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
>  		if (!ptr) {
>  			dev_err(dev, "bad phdr da 0x%llx mem 0x%llx\n", da,
>  				memsz);
> -			ret = -EINVAL;
> -			break;
> +
> +			ptr = rproc_da_to_va(rproc, da, filesz);
> +			if (!ptr) {
> +				dev_err(dev,
> +					"bad phdr da 0x%llx mem 0x%llx\n",
> +					da, filesz);
> +				ret = -EINVAL;
> +				break;
> +			}
> +
>  		}
>  
>  		/* put the segment where the remote processor expects it */
> -- 
> 2.16.4
> 
