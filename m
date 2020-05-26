Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CC81B8194
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 23:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgDXVSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 17:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgDXVSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 17:18:54 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63741C09B04A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 14:18:54 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id c3so14946727otp.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 14:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JH4b2yUgrRfNHWgcGuHimY3HuUAtZbHhYYgcbbN+n7w=;
        b=mwHsCg60VWO11eWQt/hJEUGF5Xp645z/jo0zwnavgwRPqatslMnx6qZ2kCxzXmPbCv
         mYYvK6kIhQHF94oCzIbl3vtdmsKBNlehlwowsOzDsPcLP5bhH6TZEIHgjcHyn0l9kSZi
         OM9PPDJeTrO2h7DfVpH3Z8SI+AfJNy+z7plWwpPs5mUbxW0nnqp6yZ6nwFb6GAUJsxdY
         egaeDfTbWlW5vSqNTS1JOjtz5Ao/BsnxtzpK3T4zYuTcLK3hfphYs5hbdpGasPIjNrZJ
         0nnct1jkEy26bE47J1Nw26p8Hj5OsXzMgiD3Fqmd9vBffR7DHCdUQ72jKcX3egKfnl1v
         kQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JH4b2yUgrRfNHWgcGuHimY3HuUAtZbHhYYgcbbN+n7w=;
        b=ULKRqIYCnI/0Z8R819bpFabCRAJwO5hyV9OYdXDx7Uc2BV97WX8GIshFJaDW7teXU5
         hFoTX5NuPO09LqPMvJI8m569T3Ho8m7t0vYKohHznhVXWtk+tfvMczjFbuBCOI7omMpa
         VrU8KJ1EeqBd3K/iLzqcZlJgn8y/Pt1lli+kslRm5b/OFp73iAZoGjfgcQhmiHf1w+lD
         pqzvf8TTzSwiWU32K3vcoMUepet+8IBQ0YPqkCPK944zBe7YJinAKzqq9y3ZlpBg4olX
         lLPnsraI6a3DT8xrLX2fzCHZSL/dA8Ht69JCfNyopRwsUhhQAFM1QEq+/JJzWgubEjnX
         /6ZQ==
X-Gm-Message-State: AGi0PuaEUnYTXKJ4mDGIyS5lVWkwHhg2VlfagfKuzkByEIEjiWnCcpTE
        4JpdZ9CRQhHveeX/hEWjLzOnalVBdPWBY4G+9zFqwQ==
X-Google-Smtp-Source: APiQypIGeacaBHNTvM766dTzv4dPNygP9HlkNLpttNTbMpzV41oh77j62R8ZTlR1RzHISXuwWyhoFgUUG5AfVD2+FyU=
X-Received: by 2002:a9d:2622:: with SMTP id a31mr10002145otb.231.1587763133240;
 Fri, 24 Apr 2020 14:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200424155404.10746-1-georgi.djakov@linaro.org> <20200424155404.10746-7-georgi.djakov@linaro.org>
In-Reply-To: <20200424155404.10746-7-georgi.djakov@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 24 Apr 2020 14:18:17 -0700
Message-ID: <CAGETcx9iAJRW9Y9orHNF-fC53nNob_vZKYUNEpwf_AeAdWCOjw@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] OPP: Update the bandwidth on OPP frequency changes
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 8:54 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> If the OPP bandwidth values are populated, we want to switch also the
> interconnect bandwidth in addition to frequency and voltage.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> v7:
> * Addressed review comments from Viresh.
>
> v2: https://lore.kernel.org/r/20190423132823.7915-5-georgi.djakov@linaro.org
>
>  drivers/opp/core.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 8e86811eb7b2..66a8ea10f3de 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -808,7 +808,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>         unsigned long freq, old_freq, temp_freq;
>         struct dev_pm_opp *old_opp, *opp;
>         struct clk *clk;
> -       int ret;
> +       int ret, i;
>
>         opp_table = _find_opp_table(dev);
>         if (IS_ERR(opp_table)) {
> @@ -895,6 +895,17 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>                         dev_err(dev, "Failed to set required opps: %d\n", ret);
>         }
>
> +       if (!ret && opp_table->paths) {
> +               for (i = 0; i < opp_table->path_count; i++) {
> +                       ret = icc_set_bw(opp_table->paths[i],
> +                                        opp->bandwidth[i].avg,
> +                                        opp->bandwidth[i].peak);
> +                       if (ret)
> +                               dev_err(dev, "Failed to set bandwidth[%d]: %d\n",
> +                                       i, ret);
> +               }
> +       }
> +

Hey Georgi,

Thanks for getting this series going again and converging on the DT
bindings! Will be nice to see this land finally.

I skimmed through all the patches in the series and they mostly look
good (if you address some of Matthias's comments).

My only comment is -- can we drop this patch please? I'd like to use
devfreq governors for voting on bandwidth and this will effectively
override whatever bandwidth decisions are made by the devfreq
governor.

If you really want to keep this, then maybe don't "get" the icc path
by default in patch 4/7 and then let the device driver set the icc
path if it wants the opp framework to manage the bandwidth too?

-Saravana
