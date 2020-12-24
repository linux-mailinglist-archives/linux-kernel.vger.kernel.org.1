Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5AE2E24E5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 07:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgLXGoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 01:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgLXGoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 01:44:23 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1C2C0617A6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 22:43:43 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id x12so855827plr.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 22:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=EggZlPNaFVNouUQNpMn4xGppTh9DzckHE4NrKj3sjKU=;
        b=Oh3/knrLmICSN2Z3rwKTSyV0rZAdC95C5D83OrFtERU6Bx2ojcAX/s8nBJJNKbvkSv
         BfQYGy1zC8m1ZuYadonmShwKsEssyRaQOZBAyphCdJD8hE380Ft5/TXEmY6MO3GlJasq
         RrkhWNQEmgh/GsGttqWcNfZ71NVDkNEYwWsjuqkP8VdwJTCX2vdDpxVwsnQ5HNEweh0M
         An3fXfg9/d0G0+FuPk0ByAahetYKeSmx82mAoRUPnE+BrNipzngY1IzLAgLZrzjOCrN5
         irhxwHDc5mBc6s5RnM5iXO8Nlvm9QXzBmJqpuOPmEAQFWdjKY9j2t4sfjZzWKZOQDh3R
         twCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EggZlPNaFVNouUQNpMn4xGppTh9DzckHE4NrKj3sjKU=;
        b=T/Z9SubWEI08uVAqcF5euE+lYXBAl1GBTlsU/soUmPv+R2keWhwgwdPx92Gw3HMJ/A
         KgUlbRv1jRcxgwoXtFN8c4H/c2Jtindo0mYNRfkex/Sbg0hV4oxOSgqCXv7GrLeMf83J
         QCBc3y2VjRAPvxbRwCEG6pkXjSHZd0F8E+HEiikBEzxdOwYZSX4xWCr+2y5NmoLBEpne
         fF9iTLQjBKUDFVArjZZr3guRMRYmO2v8YwwaUH2rep/TBNfQwohPuwhD470aoML1D6IL
         lOT6syrBEgKd5WgJw7JPbjAQVNVK6S2egk7aM3hq0K6W7MLSUdIIEpMc1oe5K6PTI8Xh
         zg5Q==
X-Gm-Message-State: AOAM533cs4iWXZVmrYo2J3ingAmy8XnffbeHorD9FhIPNGPiWBFfjqJA
        1Fg7rseIl4QfnUMPunYu8qV7Ng==
X-Google-Smtp-Source: ABdhPJzvXFDg0AOs/T4jYpQbUFp8mqlvGxAfA/7keO1x94rQjdeak+7MJF5KZ9Mxu1T0gEblsk2C9g==
X-Received: by 2002:a17:90b:60b:: with SMTP id gb11mr3193035pjb.122.1608792222393;
        Wed, 23 Dec 2020 22:43:42 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id c14sm24658375pfd.37.2020.12.23.22.43.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Dec 2020 22:43:41 -0800 (PST)
Date:   Thu, 24 Dec 2020 12:13:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 11/48] opp: Add dev_pm_opp_find_level_ceil()
Message-ID: <20201224064339.zngidobhstnlu2a3@vireshk-i7>
References: <20201217180638.22748-1-digetx@gmail.com>
 <20201217180638.22748-12-digetx@gmail.com>
 <20201222064253.x7vsurh7q5k7qzb5@vireshk-i7>
 <fd7b9f42-d0a7-45eb-2a17-d46779011c58@gmail.com>
 <20201223041931.klnppy4fu3sdgtsz@vireshk-i7>
 <f00e0c74-8d9a-d3d3-81bb-3ac25a74175d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f00e0c74-8d9a-d3d3-81bb-3ac25a74175d@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-12-20, 23:37, Dmitry Osipenko wrote:
> 23.12.2020 07:19, Viresh Kumar пишет:
> > On 22-12-20, 22:15, Dmitry Osipenko wrote:
> >> 22.12.2020 09:42, Viresh Kumar пишет:
> >>> On 17-12-20, 21:06, Dmitry Osipenko wrote:
> >>>> Add a ceil version of the dev_pm_opp_find_level(). It's handy to have if
> >>>> levels don't start from 0 in OPP table and zero usually means a minimal
> >>>> level.
> >>>>
> >>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >>>
> >>> Why doesn't the exact version work for you here ?
> >>>
> >>
> >> The exact version won't find OPP for level=0 if levels don't start with
> >> 0, where 0 means that minimal level is desired.
> > 
> > Right, but why do you need to send 0 for your platform ?
> > 
> 
> To put power domain into the lowest performance state when device is idling.

I see. So you really want to set it to the lowest state or just take the vote
out ? Which may end up powering off the domain in the worst case ?

-- 
viresh
