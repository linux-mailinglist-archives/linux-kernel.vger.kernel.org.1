Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041072426FB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 10:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgHLIyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 04:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgHLIyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 04:54:24 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CECDC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 01:54:22 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so1286289wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 01:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nDDmL3/ds8QQCHr7yYQlwt5HIoUGQcvll/5Jm4Nj/NU=;
        b=eZV8SOfT++JcZDWbZGOFPKgBc8EnckFjLKn0Viw6/71x8cx9KnAkUpyX/V2nx8COkQ
         zQlB/OB1wRP6pMrRE9yJN+Smhb4ZY7oNjWxYK+841LJxbAsQ+hbwU+EnDxuG7nllptBh
         kTFBJaY0ELC5hFKngUr4N7e64e5LHsz+8RTyapmjBNLyVhbCYlRTj8K3gPyBcNQqu/56
         A0sA6RI/7uLTydnKJViPe7ScJUB7FlL5/noJyDh/QYsEOBf72693tlJmhwdtjEDYxUjI
         FQm/Z/ep1iEMfNkmGmphrWOr8IeSQc8GBFMv5yh3ThO3kbJ9lv0IV6Pc5iwVfr61pd5A
         qavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nDDmL3/ds8QQCHr7yYQlwt5HIoUGQcvll/5Jm4Nj/NU=;
        b=gZRxwsfcp94F8rkoN705hW+8zdK1cY66rY3bkMbhroxUWyCheLFen3uw0xIIv8Xphn
         6nGFJpJTgATyZZ7isNq042bmtekyNRV/HrPEn+Bv5SMnUVeCZYWF7Jr3HV+Jxzo7Ssz3
         1xTZB4fsJwK0h1Y3AqKL6ZT/tofjj0Zzk1MxNa79BMT5HiynapvF1PHDLtj8YtPxFizM
         clDfrjePAQp0cTvUy2Kz4tvTaYY4C81r8PKkibM7flWSaloqhoARZzRW5a/td7TJmFJ8
         TKDODrUxX6KrVKJt81CJtqWsBd7urGBeAVi8u9TBWYFtzs5fzSgDjJZfCNxQmVhg2qND
         3whw==
X-Gm-Message-State: AOAM533d2WNK7j/OInKndAdQAkXqPV3jAdG/ONP29sPYtTrnwOQe8BSb
        47cEFZeTienuNUpwau9YKdDEXpxVteRa5W/10aik3A==
X-Google-Smtp-Source: ABdhPJxgHkQRilAAOvDxUOE0ttC56I2wbbW0+aBiE/cDA/sPn42xpkcsDJURVoApPB+Kh0XCHSsmcVBjkOhxDPs0fKk=
X-Received: by 2002:adf:bc45:: with SMTP id a5mr32002929wrh.215.1597222460695;
 Wed, 12 Aug 2020 01:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200730080146.25185-1-stephan@gerhold.net>
In-Reply-To: <20200730080146.25185-1-stephan@gerhold.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 12 Aug 2020 10:53:44 +0200
Message-ID: <CAPDyKFqy5-qtfKy=8iyR+LZNUTVi8namLGk_juq4a9YZH8DVqg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] opp: required_opps: Power on genpd, scale down in
 reverse order
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Niklas Cassel <nks@flawful.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jul 2020 at 10:02, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> I'm trying to get CPR (Core Power Reduction, AVS) working for MSM8916 on mainline.
> Shortly said there are two power domains that must be scaled with the CPU OPP table:
>
>   - (VDD)MX
>   - CPR
>
> My idea for this was to add both as "required-opps" to the CPR OPP table
> and let the OPP core take care of all the scaling.
>
> There are two remaining problems that need to be addressed for that to work:
>
>   1. The power domains should be scaled down in reverse order
>      (MX, CPR when scaling up, CPR, MX when scaling down).
>   2. Something has to enable the virtual genpd devices to make the rpmpd driver
>      actually respect the performance states we vote for.
>
> Both issues were briefly discussed before (see links in the patches),
> but I think we did not agree on an exact solution yet. After some consideration,
> I thought it would be best to address these directly in the OPP core.
>
> However, note that this patch is RFC because it is just supposed to initiate
> discussion if alternative solutions would be better. :)

Ramping up since the holidays, so I might overlook something - but I
think your suggestion solution makes perfect sense to me.

>
> Stephan Gerhold (3):
>   opp: Reduce code duplication in _set_required_opps()
>   opp: Set required OPPs in reverse order when scaling down
>   opp: Power on (virtual) power domains managed by the OPP core
>
>  drivers/opp/core.c | 115 ++++++++++++++++++++++++++++++++++++---------
>  drivers/opp/opp.h  |   1 +
>  2 files changed, 93 insertions(+), 23 deletions(-)
>
> --
> 2.27.0

So, for the series:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
