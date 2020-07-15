Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46192220304
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 05:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgGODoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 23:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbgGODoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 23:44:21 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB617C061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 20:44:20 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s189so1879836pgc.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 20:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4/SBrzVijxleaEq8AAptBYjj9dMKnx46mBawTUAgxao=;
        b=BUM59QPFrAAvEdO1KQBDTmXPxgly1HWMoYdopTs9/nR/7mhpWAPtG95gopY8lQ73PG
         qLNRL1tht9UVjGra/Wmw4f3oOdeoccToTV8nzNXF3SiWZSsiPibGcI/LCroI4q8lSM5T
         a8UTRzXKlOAvnYumNrG1uhcS3uAzLeU4bu6Qa1rZXOaQDIWfa1M7V5zVG6NI4TCyiaWI
         a5Yjr/rV850NCmtLEbDkQ1pPOuK0rjf+oneIp522YxsRbmr8rHWpEdAg+ni9uuQjZiSF
         OnrUg5Un+oUU0gw+5LdqJHrQNUo7/asY4ax5wsUx9r0CWBTWa8zc2Gi5kiW4/pltLgb+
         SUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4/SBrzVijxleaEq8AAptBYjj9dMKnx46mBawTUAgxao=;
        b=q2Q2SyF5gBf3tUNSNNqJQRr4o43KlshR/vTmHAqtpKaWwoYv9t8z/Lsper0ln/Bzro
         +VbjIgyVUOHpAzTvkjbRIhCOF5e4NPvg4HHTGA3inVREo+kg4ukrCxbX5wPPbjPsBtjD
         IxdibIt7irEcKnm3AsdZlFxyPRF/lIYgrdCvO9QwgD2IDUZhS3C+f3TCTddZZ4KpvJoz
         SvpmQ7fh7VVDzNpCfq+7iQA8Zhvquy7m4YwHjs3hprvAKgtS48IyFXa15w447buCnqoW
         n0BU8DxIe/im9FD6XgY3llNHEaybcWaA3AnMdAMncQRrhUwG2QQFr/SgXasEyi0h/bs1
         pxWA==
X-Gm-Message-State: AOAM5328WGGF7xrpka13Jz6pfs/ix0bMFis5iI8BSP1k2AJ4kUhvaADN
        /WmX0bV1huvxTKv38ehbZUIu5w==
X-Google-Smtp-Source: ABdhPJxc0bksLr171Wya+nxw6hqk8SsGcHJa3FowE638dwgY1ToULq8ink4AN2Ndk8zhudgjTw6k0g==
X-Received: by 2002:a63:4b1d:: with SMTP id y29mr6308025pga.264.1594784660501;
        Tue, 14 Jul 2020 20:44:20 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id v28sm530817pgc.44.2020.07.14.20.44.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2020 20:44:19 -0700 (PDT)
Date:   Wed, 15 Jul 2020 09:14:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Walter Lozano <walter.lozano@collabora.com>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH] cpufreq: imx: Select NVMEM_IMX_OCOTP
Message-ID: <20200715034418.fnpoaqynvxlkcype@vireshk-i7>
References: <20200714184356.32749-1-walter.lozano@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714184356.32749-1-walter.lozano@collabora.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-07-20, 15:43, Walter Lozano wrote:
> When probing cpufreq for iMX6 the values in the efuse needs to be
> read which requires NVMEM_IMX_OCOTP. If this option is not enabled,
> the probe will be deferred forever and cpufreq won't be available.
> 
> This patch forces the selection of the required configuration option.
> 
> Signed-off-by: Walter Lozano <walter.lozano@collabora.com>
> ---
>  drivers/cpufreq/Kconfig.arm | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index c6cbfc8baf72..ce0227c429cf 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -93,6 +93,7 @@ config ARM_IMX6Q_CPUFREQ
>  	tristate "Freescale i.MX6 cpufreq support"
>  	depends on ARCH_MXC
>  	depends on REGULATOR_ANATOP
> +	select NVMEM_IMX_OCOTP
>  	select PM_OPP
>  	help
>  	  This adds cpufreq driver support for Freescale i.MX6 series SoCs.

Applied. Thanks.

-- 
viresh
