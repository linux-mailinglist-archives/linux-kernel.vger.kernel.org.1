Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F6D2E0627
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 07:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgLVGmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 01:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgLVGmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 01:42:10 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005B5C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 22:41:29 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id j1so6932582pld.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 22:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qCUDEuOxwnC1AGuwl6fnluLE3mg41lKSQCQsRBnikAE=;
        b=SLqK80aWe80/oOFjlKAkk5jqsLmB6RoEBWiQMpcRzPAse5ZgDQA6H/f2QcYQaYX+Sk
         j72VoUeumbbh4H7SoJchN3WQ4I8yPJLZcR2WOnDQDMCzorCW4hJclXsTQgFoRz22RdKG
         b36kXTEMnqcyvZ4P8k2BHIQ3OnbkH5vPepxZyzfdedwjW/vFkSQupF0OBKJtYCIUOXd+
         tnsNf4Jyrnc5hEpCgs3Ty8sMXZ+Y1xPDWrfNT0FgbK/gljhOZLN19WV5tE5Pm7gIZMx/
         BqJRbe7G+WxvEmQbKhOkP8Fkwv3F+QpBIqDZjzxrC/La6nliwsr0G5LVDTCHzO75q9IH
         T1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qCUDEuOxwnC1AGuwl6fnluLE3mg41lKSQCQsRBnikAE=;
        b=I0Qb1ciYCfwaz580mMIABWv3adhIbNwwlWKOkYePlSSvZWXyOY8QkfYeHrNJRdjI2q
         m/ZyQtJjCqlcWD3jIhlPJH2SjINmDsJt6t2NBrsHlzGC2M/dqDMBPTslttoiSFb5r98K
         QgH85PduAxlbHlJvTjXaGZgUAFg6pml1iwYbx0EmjO7MEu5ix/Kcmli5/qoFajNQRtGy
         ht4kpT77ICnxM0mjmlEiYDxkG5b97CTfEbRtWyARYmqfUY+LNWN7WqqTzFJn9BZWYhum
         UIJsQy4Zjs6Lk+C3PnVPiPrkHYfncY6tD9ZI1Qh3Zyioi0mWLBkkpsByYqtwFAUHh9U9
         pqig==
X-Gm-Message-State: AOAM530ccRRsU1A1H/M3+r3RIj8FOR2pQlNgspd4gLsj9UyYmru0uO86
        uNXc1Xan6+W/5e7fVRPzR2Y0Nw==
X-Google-Smtp-Source: ABdhPJxN42pTclkBGDeXVc+JmlXJ2Zqv4ydgjwhoQWE66qXHkx0fFIYjfke1IlzZt4m8tXjIu/60fA==
X-Received: by 2002:a17:902:b94a:b029:dc:18f2:8063 with SMTP id h10-20020a170902b94ab02900dc18f28063mr20113799pls.8.1608619289583;
        Mon, 21 Dec 2020 22:41:29 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id z2sm7851394pgl.49.2020.12.21.22.41.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Dec 2020 22:41:28 -0800 (PST)
Date:   Tue, 22 Dec 2020 12:11:27 +0530
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
Subject: Re: [PATCH v2 09/48] opp: Add dev_pm_opp_sync_regulators()
Message-ID: <20201222064127.cn7tagfwpi5tu4zk@vireshk-i7>
References: <20201217180638.22748-1-digetx@gmail.com>
 <20201217180638.22748-10-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217180638.22748-10-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-12-20, 21:05, Dmitry Osipenko wrote:
> Extend OPP API with dev_pm_opp_sync_regulators() function, which syncs
> voltage state of regulators.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

We shouldn't be doing this, details in patch 28.

-- 
viresh
