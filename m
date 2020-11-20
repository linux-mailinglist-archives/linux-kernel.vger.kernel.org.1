Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8565F2BB917
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 23:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgKTWhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 17:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbgKTWhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 17:37:04 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D3FC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 14:37:04 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id w4so8515234pgg.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 14:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4zBsSClJxK/oRC1/vhFa/cwjuf3LYCK8JJOKPWg9iec=;
        b=IiJvOOQfoY3zYljz6wJd/z8j1MJMr60n656zy9wu42s1EcN4zs31x16q0hrbj9o0Qt
         grw3V1YyAqeMtmk1aKaFCOkNpInUU1/IXMXxXYbW0f65LcRN9XjvZcJwPTgPsPTQCUMe
         4d9EcZ8CJrlNBwmzXR8wa+xIxkkpeDch0xSDStaKjYrLhq5guO6H5r3AiLPGdrSxGqA0
         aKinU4UUF47pI/TV1+IYMYLeEEOlVpAkYE0L4/mZ+WsyXUjZH+hueca0wYUdYe+c+RyI
         FXwqGMNwZ76rgC+kuSYkCw0A9uiPbSVF7xhw/JsCv4VzbqGzoqwM8T/A/uxK5Z6lK68Z
         yVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4zBsSClJxK/oRC1/vhFa/cwjuf3LYCK8JJOKPWg9iec=;
        b=gmlKyAS7wOoB8QKPp+hH/L95+3o58eZCiyj3IkEIVKCpNvmr1Z/DlAS2HWfnrriynP
         FW4QboYYyShkbtYaB8FaMtepoLFZcc1HomcEfrkTI7Cm6dNVsgf0kYm2rb28ex8RsHN2
         mSvq6zMQaDaTwHKGVPb0Z9ugDQr1Fv8UbHtE1QJxGtcH6JhgOEjezk+Oqc6wt8TL9qDI
         5+hisMiwcVNZdBIYgB9/DNJnlTDPensB+Ti1AtO/ZMDQdj3G8N9neTjmGOgFhHjnmKeE
         bBdC/zmnXOPduXx/ngA9dUjbXpRZ1gg3D8YcOLspt8ntPV4OT032rvZKQuGJtdtROlf/
         hn3Q==
X-Gm-Message-State: AOAM531Xq3P2XOGDvOWwOM8bW9jqVlS8z0j3nHG0C3BeF5cUlhHq1CX7
        ZtCpTloq6JCytD3kT2pK7KmA7A==
X-Google-Smtp-Source: ABdhPJz9vh7QXNVSMeNOljxwXcEdKLKPOsBMHRM83Y5rYhvQAkwQSFFkDuQ+ybVfYd+6FX1n+Y6vZA==
X-Received: by 2002:a62:2a8c:0:b029:197:a56b:8e79 with SMTP id q134-20020a622a8c0000b0290197a56b8e79mr11024847pfq.51.1605911824277;
        Fri, 20 Nov 2020 14:37:04 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id u197sm5089110pfc.127.2020.11.20.14.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 14:37:03 -0800 (PST)
Date:   Fri, 20 Nov 2020 15:37:01 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>, od@zcrc.me,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: Add module parameter 'auto_boot'
Message-ID: <20201120223701.GF4137289@xps15>
References: <20201115115056.83225-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201115115056.83225-1-paul@crapouillou.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Sun, Nov 15, 2020 at 11:50:56AM +0000, Paul Cercueil wrote:
> Until now the remoteproc core would always default to trying to boot the
> remote processor at startup. The various remoteproc drivers could
> however override that setting.
> 
> Whether or not we want the remote processor to boot, really depends on
> the nature of the processor itself - a processor built into a WiFi chip
> will need to be booted for the WiFi hardware to be usable, for instance,
> but a general-purpose co-processor does not have any predeterminated
> function, and as such we cannot assume that the OS will want the
> processor to be booted - yet alone that we have a single do-it-all
> firmware to load.
>

If I understand correctly you have various remote processors that use the same firmware
but are serving different purposes - is this correct?
 
> Add a 'auto_boot' module parameter that instructs the remoteproc whether
> or not it should auto-boot the remote processor, which will default to
> "true" to respect the previous behaviour.
>

Given that the core can't be a module I wonder if this isn't something that
would be better off in the specific platform driver or the device tree...  Other
people might have an opinion as well.

Thanks,
Mathieu

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/remoteproc/remoteproc_core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index dab2c0f5caf0..687b1bfd49db 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -44,6 +44,11 @@
>  
>  #define HIGH_BITS_MASK 0xFFFFFFFF00000000ULL
>  
> +static bool auto_boot = true;
> +module_param(auto_boot, bool, 0400);
> +MODULE_PARM_DESC(auto_boot,
> +		 "Auto-boot the remote processor [default=true]");
> +
>  static DEFINE_MUTEX(rproc_list_mutex);
>  static LIST_HEAD(rproc_list);
>  static struct notifier_block rproc_panic_nb;
> @@ -2176,7 +2181,7 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>  		return NULL;
>  
>  	rproc->priv = &rproc[1];
> -	rproc->auto_boot = true;
> +	rproc->auto_boot = auto_boot;
>  	rproc->elf_class = ELFCLASSNONE;
>  	rproc->elf_machine = EM_NONE;
>  
> -- 
> 2.29.2
> 
