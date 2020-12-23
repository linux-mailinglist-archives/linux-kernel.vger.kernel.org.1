Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701E42E1818
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 05:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgLWEWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 23:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgLWEWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 23:22:47 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F33C061793
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 20:22:06 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id n3so515847pjm.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 20:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vFPBACuSZLmFwKfzTZBK29MSltq37ELB0qaT/YRoFRY=;
        b=IpGc94bYryxmTwQjxV0XiBy+F4O5lVtghSrxEz/IB5lG/bE1epAtZMErAAzi3cYsf3
         VvGlaBeqLlBLA4p3RCHh8GUg0YUIbEBfJJpYVXlBHEE0jAMFJRa95EKnwi2RqZ615dWN
         YevqvsZaZWfs9EV1uQe8PwIvpJwXm6R19TuPZ8v8f7Rhw9+Hv9ETOM7t122FAz4tdO2c
         L8avA55nUCv9EIjhwz3mGd07csNFfkX0fEz/ixCBF7Sz3iIDU5AY+DIld6fxQJefByQZ
         KcwESs6ZbcAlvTm6yHttIP4VkC+QBk0ZbsUCyLUgLvc09112Gj99IpGEq533s7VebyPB
         VOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vFPBACuSZLmFwKfzTZBK29MSltq37ELB0qaT/YRoFRY=;
        b=uUhF34DpO/ZgMDxfCm3ef59YnuVQ5BNTTMkbNQcbKbW2DNya0wfxopF6lF9VK4hAec
         JSbgBHk6XOAtukJ3Xnoc3mHE1D+OICTwiCY3ByJ0eSRGY47F2U8SDQR3Ib/z6r5IAIGH
         8WaFiSWG3A5dmUXUW08lhvgFgh+37Nlq65h5HkRcuhISP9zv2W4ZtXz4fozf876YK3Od
         fTMntKX1jz2IMJkth1tuWJre7aYCG1nwrSbdCt8pRaO2MGq2XwC5Q1fs7GYEpXUmGLfi
         NzPFadtGW0xp5zP3KSJhuFgtXGE3XOOdG8YDdWoijj4KJR3DSHIzRgxnOGucXnq6hhsI
         NMfQ==
X-Gm-Message-State: AOAM533HWyN2RzHvkD15UvLftIps9NYvjUKUDz7x2+sJVmpPTaJXM9fi
        tLbomlMSLiwqfi13ZtdwbQybeg==
X-Google-Smtp-Source: ABdhPJxgtdKyvR1thUteXsp8n8u1tUpiDzW8vaTCpk7yHVskegF0VKZCmCi8HGyvB/579lHHSRqmQA==
X-Received: by 2002:a17:90a:67ce:: with SMTP id g14mr25301218pjm.33.1608697326249;
        Tue, 22 Dec 2020 20:22:06 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id x23sm8679028pgk.14.2020.12.22.20.22.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Dec 2020 20:22:05 -0800 (PST)
Date:   Wed, 23 Dec 2020 09:52:00 +0530
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
Subject: Re: [PATCH v2 14/48] opp: Filter out OPPs based on availability of a
 required-OPP
Message-ID: <20201223042200.ey2azaqizazrz6bp@vireshk-i7>
References: <20201217180638.22748-1-digetx@gmail.com>
 <20201217180638.22748-15-digetx@gmail.com>
 <20201222085940.y625zxee4tevbqm5@vireshk-i7>
 <9ed8bde3-f7b5-025c-c038-87f35ea39e5f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ed8bde3-f7b5-025c-c038-87f35ea39e5f@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-12-20, 22:17, Dmitry Osipenko wrote:
> 22.12.2020 11:59, Viresh Kumar пишет:
> > On 17-12-20, 21:06, Dmitry Osipenko wrote:
> >> A required OPP may not be available, and thus, all OPPs which are using
> >> this required OPP should be unavailable too.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  drivers/opp/core.c | 11 ++++++++++-
> >>  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > Please send a separate patchset for fixes, as these can also go to 5.11 itself.
> 
> Alright, although I don't think that this patch fixes any problems for
> existing OPP users.

Because nobody is using this feature, but otherwise this is a fix for me.

> >> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> >> index d9feb7639598..3d02fe33630b 100644
> >> --- a/drivers/opp/core.c
> >> +++ b/drivers/opp/core.c
> >> @@ -1588,7 +1588,7 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
> >>  	     struct opp_table *opp_table, bool rate_not_available)
> >>  {
> >>  	struct list_head *head;
> >> -	int ret;
> >> +	int i, ret;
> >>  
> >>  	mutex_lock(&opp_table->lock);
> >>  	head = &opp_table->opp_list;
> >> @@ -1615,6 +1615,15 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
> >>  			 __func__, new_opp->rate);
> >>  	}
> >>  
> >> +	for (i = 0; i < opp_table->required_opp_count && new_opp->available; i++) {
> >> +		if (new_opp->required_opps[i]->available)
> >> +			continue;
> >> +
> >> +		new_opp->available = false;
> >> +		dev_warn(dev, "%s: OPP not supported by required OPP %pOF (%lu)\n",
> >> +			 __func__, new_opp->required_opps[i]->np, new_opp->rate);
> > 
> > Why not just break from here ?
> 
> The new_opp could be already marked as unavailable by a previous voltage
> check, hence this loop should be skipped entirely in that case.

Then add a separate check for that before the loop as we don't need that check
on every iteration here.

-- 
viresh
