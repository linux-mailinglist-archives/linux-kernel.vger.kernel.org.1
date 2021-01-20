Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C307C2FCC9A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 09:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbhATITr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 03:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730356AbhATIJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 03:09:22 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9675CC0617A4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 00:08:36 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id my11so2756184pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 00:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RnZy7v3JI4lJcRmer2QxQXUef8c3KbxByhUTj8LliLo=;
        b=fMQzFky/yOWQ0MNa0KsnwgXS6vJwOqAPrBZlXEu+svpMUgKAFO+eKD2kA4fD53ZY6F
         3sLRIcV9aFEAQpUW01+sd03fFJocK841pp2D/qKTrM3hJdmqlEFFZ/njI5CLV5XCv2d1
         BmVE8MN7NfK7jfdHxcfWxPldjXj/SdSOqi+Ei3qtePLj1CS6v1AJj/vYmhpxs8iNzD4+
         ch535TY1pjQwq9iWUp+E+HaHRZycUdGW8EFbcp6TMrQciOD8WjAnfsSsVIbtX/j0R2OP
         wsKofaKtnxiQir3hrcYQzZS2wW9TSZ5HoCYHUm0EQnJp6rj6D6verhq+V0O9nWKfSSPL
         VNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RnZy7v3JI4lJcRmer2QxQXUef8c3KbxByhUTj8LliLo=;
        b=cI0RmYCXACg9m/pl1ztvpxaIl1FjM/r0Ihj754FjyRRSK8rfyhytY2wybNur2n401M
         3wW9mm2GbfhyCdhq0RT+nak7BDdA90lQFG6GwvvKsFLGcYYDXl4A8CSMJ/WvwACOrRAi
         VzhJXZG4XFUBXIz3RLSRhipTJF+V/LumcB1oUhhdHnzaRZLYMc6KUcQVNIr8kbBVfPbj
         vzJv+tnY6jXKM/v9TJl+xS+Z/1jh0yCNkIv3itDAa2ZZ3L5mpBnicHMfQBl8/naXhccS
         RPDcQtIISRnqTtruDxmXKedtTokZ+3TIgI7CiBA355qwG+h6a2q+4Fj6fpoeWtac2ZdT
         gyMA==
X-Gm-Message-State: AOAM531o+FzFG1D8UmTbj1ZpRB2298QfIg0HrmzlHTt9CGZ6mRe/hgf4
        9dUvASEsUAueJGEsm+XI2A8e+g==
X-Google-Smtp-Source: ABdhPJzRCn24hYJvClTc57jLHkYZPTxm7lYoC/7vAB1PI/XIeRDKykjSHXAbVph8+64/j7TiMCdk7Q==
X-Received: by 2002:a17:902:b213:b029:db:3a3e:d8ad with SMTP id t19-20020a170902b213b02900db3a3ed8admr8742980plr.73.1611130116141;
        Wed, 20 Jan 2021 00:08:36 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id 123sm1396576pgf.38.2021.01.20.00.08.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2021 00:08:35 -0800 (PST)
Date:   Wed, 20 Jan 2021 13:38:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Prepare for ->set_opp() helper to work without
 regulators
Message-ID: <20210120080833.bw4c5bh2wntmiaqi@vireshk-i7>
References: <fb69353c-a35b-9b7c-46bc-d464c6dab6f5@gmail.com>
 <302c014726dbd9fcde852985528c139d2214a1f2.1611038066.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <302c014726dbd9fcde852985528c139d2214a1f2.1611038066.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-01-21, 12:05, Viresh Kumar wrote:
> Until now the ->set_opp() helper (i.e. special implementation for
> setting the OPPs for platforms) was implemented only to take care of
> multiple regulators case, but going forward we would need that for other
> use cases as well.
> 
> This patch prepares for that by allocating the regulator specific part
> from dev_pm_opp_set_regulators() and the opp helper part from
> dev_pm_opp_register_set_opp_helper().
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Dmitry,
> 
> I haven't tested this patch, can you please help with that ?
> 
>  drivers/opp/core.c | 81 ++++++++++++++++++++++++----------------------
>  drivers/opp/opp.h  |  2 ++
>  2 files changed, 45 insertions(+), 38 deletions(-)

Pushed with this diff.

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 1ed673334565..1dc5ca3f6d26 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1939,7 +1939,6 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
                                            unsigned int count)
 {
        struct dev_pm_opp_supply *supplies;
-       struct dev_pm_set_opp_data *data;
        struct opp_table *opp_table;
        struct regulator *reg;
        int ret, i;
@@ -1990,9 +1989,8 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
        mutex_lock(&opp_table->lock);
        opp_table->sod_supplies = supplies;
        if (opp_table->set_opp_data) {
-               data = opp_table->set_opp_data;
-               data->old_opp.supplies = supplies;
-               data->new_opp.supplies = supplies + count;
+               opp_table->set_opp_data->old_opp.supplies = supplies;
+               opp_table->set_opp_data->new_opp.supplies = supplies + count;
        }
        mutex_unlock(&opp_table->lock);
 
@@ -2038,7 +2036,7 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
                regulator_put(opp_table->regulators[i]);
 
        mutex_lock(&opp_table->lock);
-       if (opp_table->sod_supplies) {
+       if (opp_table->set_opp_data) {
                opp_table->set_opp_data->old_opp.supplies = NULL;
                opp_table->set_opp_data->new_opp.supplies = NULL;
        }

-- 
viresh
