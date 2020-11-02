Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4AF2A3167
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgKBRXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgKBRXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:23:33 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B414C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 09:23:33 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id j5so7147369plk.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 09:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ATZTaWKB7FLAcEtv7JwaiUAx+9bWAX/DQcn3u1wg8I8=;
        b=mXsQpv/AF/HFFU1B5YrdH/Fh702XYsDb6sDBm8SI+HXlcUIhRuahhb4vQwJF7prFqH
         XRBXcEPlFrYrxTvaWP7mzHDnTzxOVtplmMopT+QJbEYDjXwZiPi2L/SbdYElDs78QriR
         BnezgALmcqxzV0opn59fIYU0TuTinuRDTjE7q7xzpIJsVyi7HVMOxFMcnkJ+VqOhTv+x
         QLs8qpd9WkQa6lodiVaoNaO/qe59XNT9XQ7X3saHywnBzes0V9WiyhLrSViTx/LuC9KE
         ZKfUKoS8830r7MqJj4EUGxVZrJuYsaLXqwych3K14iBDdEK8Et1zLpdk9jQ53g/ea4FK
         VMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ATZTaWKB7FLAcEtv7JwaiUAx+9bWAX/DQcn3u1wg8I8=;
        b=fazy2L5OmF1U7kh0jooHVnnf7jIZKppRMqHkxHjQNP4RmbQyYoiLFYLMR2Ym0sSIkk
         S+Rg011eXytcwiu3YbyEh1IWPQErP9nU/PazVnTUZQdOXECsDidv93mPAJczvPlwESpD
         Wz7iJTvHv9BKxj7fRWW0O4rfgH/fImBzlGKG1UwYbCRxQzwUTFXTXNIs9cXYWqmZW9H1
         enYad8+y+TtzXhbz2TSMvSWLh/n7QhThbFeDoFQWfWDD1uiJ3mwxaGmjg7614pZJJg/P
         G2wW5cTbIgOcR0mzy1sOcoONL1Jp8t37LdL53fPiLCNe1Es+xzLUK2r7TUL4bgjVyo4o
         gK/g==
X-Gm-Message-State: AOAM533egswPAZttAi2tjKYxnqntv2DFohpHctZzOX4TOa2RQWwXVyeH
        OpjrfNheDuPn1PG/AJOB3Lz01w==
X-Google-Smtp-Source: ABdhPJyjDCbGH+Kdv6bAKAIDQ7KElZ+TVN8Kdmk5KprdCDWo2WIIlqle/ccjedkmKtbr39jIL2Gskg==
X-Received: by 2002:a17:902:8c8a:b029:d6:d1e7:e78e with SMTP id t10-20020a1709028c8ab02900d6d1e7e78emr4187252plo.39.1604337812915;
        Mon, 02 Nov 2020 09:23:32 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m23sm13407953pgk.84.2020.11.02.09.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 09:23:32 -0800 (PST)
Date:   Mon, 2 Nov 2020 10:23:30 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     suzuki.poulose@arm.com, Al.Grant@arm.com, mike.leach@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxarm@huawei.com
Subject: Re: [PATCH] coresight: funnel: Remove unnecessary .owner of static
 funnel driver
Message-ID: <20201102172330.GB2749502@xps15>
References: <1604139150-18659-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604139150-18659-1-git-send-email-liuqi115@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liu,

On Sat, Oct 31, 2020 at 06:12:30PM +0800, Qi Liu wrote:
> As driver.owner has been set in platform_driver_register(), it is
> unnecessary to set it in static funnel driver, so remove it from
> struct static_funnel_driver.
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> ---
>  drivers/hwtracing/coresight/coresight-funnel.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> index af40814..07bc203 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -356,7 +356,6 @@ static struct platform_driver static_funnel_driver = {
>  	.remove          = static_funnel_remove,
>  	.driver         = {
>  		.name   = "coresight-static-funnel",
> -		.owner	= THIS_MODULE,

I received two identical patches (with a different title) from you.  Since there
was no explanation I will discard the first one and work with this one.

You are correct, platform_driver_register() does take care of THIS_MODULE.
Please send another revision where you will do three things:

1) CC the coresight mailing list, as instructed by get_maintainer.pl
1) Also fix the replicator driver.
2) Add a comment that clearly mentions THIS_MODULE doesn't need to be set:

                .name   = "coresight-static-funnel",
                /* THIS_MODULE is taken care of by platform_driver_register() */
                .of_match_table = static_funnel_match,
                .acpi_match_table = ACPI_PTR(static_funnel_ids),
                .pm	= &funnel_dev_pm_ops,

Thanks,
Mathieu

> --
> 2.8.1
> 
