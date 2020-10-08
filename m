Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFBC286EAF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 08:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgJHG1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 02:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgJHG1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 02:27:41 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB3FC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 23:27:41 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a200so3129306pfa.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 23:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OuiV3wgIXzx63LT1TbLoPQXYUsCqxPmc9QmQdBF6e0Q=;
        b=sww4vSn5OMQQCrwnqJj4MAQAvSUpidVprLLOy0kYqttVgs4lPWZiqzUsQx/c5IzxIT
         IpupasF0e2eexeziCwtyVrKpn5YhPhJb87TltlPGZYSkkw7dakRGEiiWy/S4X3BI4MmA
         754K3bCKmGICAq4fgneEShxlCQD1uvHatp2Djwgva0jztTtJPiovyvg8Ia9ruyF//a7x
         yg6AGHwZLHC2j/q/P+lufm76ab4lbwf1WmfWiW5oPAe0zFsWeG1HrlwG9bz//8UI+3Hh
         fazjlGWV8aissdY/VJGqpV7CISTb9DU1gRiMe3qfJHIenrcRNqJMBNDbIbJrrH+Ey7zr
         lobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OuiV3wgIXzx63LT1TbLoPQXYUsCqxPmc9QmQdBF6e0Q=;
        b=m2kQFhbRb5/G3gGwpkWQ3FCrWhCunasJmtDXae5414ivsqWqjcGztXfe09K2ZcN65N
         L1b/uBOh5jFORXoFh97JT6oQ2wAXjfVtOx3XllwitOhhF7xgxqhNmHblQ3h6IIMs1Fks
         c2qNHKznMjqwl/0962HJ9zjRcweYmYQC2QzAT1fyRHQh3keab8iPtkgjYYASR+za3rlR
         Kf8Fe1ED6m6Zzk8ihOGxC8wBEf2hsoomWulQ2JusOXqb/Cy6cGql8AVpDvwAL5XIoZBy
         dmgnyw/3tfDJBCQWfTpeQYPvwNvx7G0FAB1jq6KgJtvuaGyCwJ622L4KoY1sVqVb5e3n
         zXrg==
X-Gm-Message-State: AOAM531PumTRG//JE1/iGKXhhmc/0psuWCeIbWF7IdjBfiBr0uqXkfp1
        oxx2xcWsVCsEGnpPZKMn0f0=
X-Google-Smtp-Source: ABdhPJxVuw+wVuHhBAsK0ABqPS1NWt/41nr77Mi0Hcl6k6L/orjE9bKH7eCUrX5THXB4G0OMjJkmaA==
X-Received: by 2002:a63:d216:: with SMTP id a22mr6136135pgg.339.1602138460324;
        Wed, 07 Oct 2020 23:27:40 -0700 (PDT)
Received: from ubuntu-m3-large-x86 ([2604:1380:45e1:2200::1])
        by smtp.gmail.com with ESMTPSA id q8sm452845pfg.118.2020.10.07.23.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 23:27:39 -0700 (PDT)
Date:   Wed, 7 Oct 2020 23:27:37 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: Kconfig: fix a HISI_HIKEY_USB dependency
Message-ID: <20201008062737.GA309212@ubuntu-m3-large-x86>
References: <0b6dff854c4bb412c2c11f17803e84d61385415f.1602138248.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b6dff854c4bb412c2c11f17803e84d61385415f.1602138248.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 08:24:53AM +0200, Mauro Carvalho Chehab wrote:
> The dependency should be just USB_ROLE_SWITCH, instead
> of CONFIG_USB_ROLE_SWITCH.
> 
> Fixes: 2827d98bc5d6 ("misc: Kconfig: add a new dependency for HISI_HIKEY_USB")
> 
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  drivers/misc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 7cee2b72c09e..d5ce8082b0a0 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -459,7 +459,7 @@ config PVPANIC
>  config HISI_HIKEY_USB
>  	tristate "USB GPIO Hub on HiSilicon Hikey 960/970 Platform"
>  	depends on (OF && GPIOLIB) || COMPILE_TEST
> -	depends on CONFIG_USB_ROLE_SWITCH
> +	depends on USB_ROLE_SWITCH
>  	help
>  	  If you say yes here this adds support for the on-board USB GPIO hub
>  	  found on HiKey 960/970 boards, which is necessary to support
> -- 
> 2.26.2
> 
