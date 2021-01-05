Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871692EA91C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 11:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbhAEKpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 05:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbhAEKpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 05:45:09 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E8DC061794
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 02:44:29 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id b5so1473637pjl.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 02:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BwSbyQm79HhY13p/o1BQvjNVGauzp0nHoLkaQ4+ZdHg=;
        b=ja6fAvIj+76NbGkR+F/kvrIPBBW5nYDAeAnrguXjrrrcNrRf5Rku9S4gCvv04L4Ere
         1VPYkkBDH8YwBOd3FMIFqwd86/AGzGse02dCPp6JYkTH11ZepeuRAzEDn5bLXlCL1ycf
         270I0GKzrNEvoCoXNWr4jL4CbYcUT+O4SCH6E5pzvtdJCMObYo2nKuahOwUn0/AGdnkQ
         CnaJd34ZA8Q3D9ennAWg2P9e+M+J/YVxHqlWXnvZ2hvxOCiFqmQutraWPxL7/atQGqYG
         gGpJTW3I3MrjpEPERkGhRX3onufur5N3TquSvHBms62cvos5G6FNdojAd+aSQedToB0t
         DffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BwSbyQm79HhY13p/o1BQvjNVGauzp0nHoLkaQ4+ZdHg=;
        b=S+f7BAdNWVcvY+yjALXHuFDFNkxiKwJu6nqC5BG2HdMF4NvxhI3e+GGx7LAubsrPhl
         5Y+0l+sqCUmiOZBAgVfQ4lOq2Jg2t1FMdbzABIRZuaSbtZ906Er1ojhLy37EgznzrbsV
         PYkTRCgcKk4ykAFQuxDuEhTDb6zsPuFmiYBAYwbd8iAutr0NYoDA+MJ6doarlsGaHQiF
         JlNsmF8/7Gd8OtmzwLcI1yOI565aXN6L5aq9nPFo1/PW7J+glx46s53QCv9a6pTrB9Lx
         OF9MrV86ljClNhSPgUNzHBeFVPHBy8NP0yhV2Zr2twFX9sIreujbFLUrG1wNzfZy4qtR
         gNbg==
X-Gm-Message-State: AOAM533K9/jQ76/Dt2O/gst1ygzEuiTBQ5kVczb+r9+IgUSFY7Xegg7d
        9Z8dyfk5LL8oBjPqnHnHgUKpVw==
X-Google-Smtp-Source: ABdhPJxE5ryz7tO+u7OHjKIxWIWZ9lt7SQVbebjpyThfUiSI2FFOBGIV4tZUJjkh1yyR78nqEQkKAg==
X-Received: by 2002:a17:902:9681:b029:db:fd65:d10e with SMTP id n1-20020a1709029681b02900dbfd65d10emr77236181plp.6.1609843469119;
        Tue, 05 Jan 2021 02:44:29 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id w200sm60641821pfc.14.2021.01.05.02.44.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 02:44:28 -0800 (PST)
Date:   Tue, 5 Jan 2021 16:14:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] cpufreq: sama7g5: add cpufreq driver
Message-ID: <20210105104426.4tmgc2l3vyicwedd@vireshk-i7>
References: <1609842147-8161-1-git-send-email-claudiu.beznea@microchip.com>
 <1609842147-8161-3-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609842147-8161-3-git-send-email-claudiu.beznea@microchip.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-01-21, 12:22, Claudiu Beznea wrote:
> Microchip SAMA7G5 devices supports runtime changes of CPU frequency.
> This is doable by changing CPUPLL frequency along with MCK0 frequency.
> Along with this CPU's regulator must be changed to accommodate new
> frequencies.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/cpufreq/Kconfig.arm          |   9 +
>  drivers/cpufreq/Makefile             |   1 +
>  drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
>  drivers/cpufreq/sama7g5-cpufreq.c    | 371 +++++++++++++++++++++++++++++++++++
>  4 files changed, 383 insertions(+)
>  create mode 100644 drivers/cpufreq/sama7g5-cpufreq.c

Did you try to reuse cpufreq-dt driver? It already handles most of
this stuff, the only thing you need to do is to make sure
clk_set_rate() for a CPU needs to handle all the clk stuff behind the
scene.

We haven't been accepting new implementations of the drivers which can
work just fine with cpufreq-dt, please try to adapt to it.

Thanks.

-- 
viresh
