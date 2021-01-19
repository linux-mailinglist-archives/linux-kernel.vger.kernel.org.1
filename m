Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98782FB1A9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 07:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbhASGiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 01:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730110AbhASGgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 01:36:49 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E75DC061575
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 22:36:07 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id i63so4558658pfg.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 22:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=X5IMzCSjw6hdE0XYKTmPpUTu7Rrf+T8M0wW3hZeEQ+w=;
        b=TVyBVn2kvggDDFt8zMQcx6cZ4HsYmqisKNtFOLIQgEofRxA6SO6mEMqGRUdgiKuZoj
         ILjwcx6zf18jHqTs9k5RmDCBtBgjPVy8q+mPq5ItW5yGwPDePuAa6Qg8dh9GvG0HR+Pz
         3LcumwwsPip9Zwsz9JgGVt32Jh2sUE05gEvRMd/yZTB/ao0cQ0baj/5UL/VVK4qLfzLv
         RuOHq+YV3bEtbYfDhdQ9B0UgRCPE+NgQXsADKgswcFJqqYmR5Sj55lYKeo6dHgFP/2GC
         +Sx5o5iU60KxODan/z0YsJ3rYPSAqblz2sFcOfGtthbLxBzygSPIO9vQY8cGj7NC/90c
         VlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=X5IMzCSjw6hdE0XYKTmPpUTu7Rrf+T8M0wW3hZeEQ+w=;
        b=K3o8Pl7bUVHMQWWGJojGUiPR/0IoHoXP3E7e/RLXqsqWdyLg/lJuUTIDOV28MGCfnP
         G9BleiFd7QvNfJ6MvHWKmdi3INBkFJeJh6Fcth0pXxQSE+qTcYHIQgVL88P30joZM857
         hFaebL0zMwQnsNBdpdzPzfBp++npAOK/lnqrwrnIiFvaqyPdiJ/NXVZVQQTGpflpl+DO
         Z2vROEDtH+bBTLtuy2IMiG4eyeq8l4VRKgkTskUxU9GcrZEk0kiTbeq5d+OMSg3r6Cjz
         O7ENrKmxJB6I316AglbOpW6/YGZ0uKcf3mpUUDRjGBgMCSoShoVIqWQT+v74p/GvULjw
         +ASg==
X-Gm-Message-State: AOAM531OrYwaGtpvbypiCasW/9rBdivo6hhZoVySjHgWLKgUds+X9PY2
        5rm83wZ/t4ieNiBYe0PsKwex+g==
X-Google-Smtp-Source: ABdhPJwemrAik0aboHC/87dKaQTGExZ9AwAfw7s+kZOyu9xR1AM7abKX1vES1VKZTcBV7T3k+afM6A==
X-Received: by 2002:a62:8414:0:b029:1ae:6a9a:48c7 with SMTP id k20-20020a6284140000b02901ae6a9a48c7mr3059280pfd.52.1611038166710;
        Mon, 18 Jan 2021 22:36:06 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id h11sm1509164pjg.46.2021.01.18.22.36.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 22:36:05 -0800 (PST)
Date:   Tue, 19 Jan 2021 12:06:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 10/12] opp: Support set_opp() customization without
 requiring to use regulators
Message-ID: <20210119063603.oqbpndniizfifp4t@vireshk-i7>
References: <20210118005524.27787-1-digetx@gmail.com>
 <20210118005524.27787-11-digetx@gmail.com>
 <20210118114451.5mpuvgnhhajx4b3y@vireshk-i7>
 <fb69353c-a35b-9b7c-46bc-d464c6dab6f5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb69353c-a35b-9b7c-46bc-d464c6dab6f5@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-01-21, 21:48, Dmitry Osipenko wrote:
> 18.01.2021 14:44, Viresh Kumar пишет:
> > On 18-01-21, 03:55, Dmitry Osipenko wrote:
> >> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> >> index eefd0b15890c..c98fd2add563 100644
> >> --- a/include/linux/pm_opp.h
> >> +++ b/include/linux/pm_opp.h
> >> @@ -13,6 +13,7 @@
> >>  
> >>  #include <linux/energy_model.h>
> >>  #include <linux/err.h>
> >> +#include <linux/kref.h>
> >>  #include <linux/notifier.h>
> >>  
> >>  struct clk;
> >> @@ -74,6 +75,7 @@ struct dev_pm_opp_info {
> >>   * @regulator_count: Number of regulators
> >>   * @clk:	Pointer to clk
> >>   * @dev:	Pointer to the struct device
> >> + * @kref:	Reference counter
> >>   *
> >>   * This structure contains all information required for setting an OPP.
> >>   */
> >> @@ -85,6 +87,7 @@ struct dev_pm_set_opp_data {
> >>  	unsigned int regulator_count;
> >>  	struct clk *clk;
> >>  	struct device *dev;
> >> +	struct kref kref;
> >>  };
> > 
> > Instead of kref thing, allocate the memory for supplies from
> > dev_pm_opp_set_regulators() and store it in new entries in opp-table
> > and for rest of the data from dev_pm_opp_register_set_opp_helper(), to
> > which you can copy supplies pointers then.
> > 
> 
> Could you please show a code sample?

Sent a patch to you.

-- 
viresh
