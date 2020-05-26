Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17931C5474
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 13:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbgEELdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 07:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728866AbgEELdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 07:33:39 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E73C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 04:33:39 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id u12so273420uau.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 04:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=166ZI2PQYttk8mUuPjh9fJHZKXnQuSqSXt1RrZvFtpA=;
        b=SbmAUPviBr80iF1qScxhl5zJVFA3V7xs4iTOq1msRXtlVS5Z9A1FelEaA5QOQUWqSn
         Gciu/AaBzFBmE9zsnvklJwgF+se1u3nj/rAckeZ5e5cdWv6G/dnbkbVhbAILnHgR8ESS
         0RJNI/xujs7FxJsLMC8nNRkZLo0PDbWYVPfHWPg2m1CApz8MmMYfQf4zmiPiVH+2qRQS
         KpJhx0xg/64TubUQdiVtwLaCC/RxcIr8uKxVm8m4N4Lz4ee+Ce2Si7BmBh+ccTDUf2Ok
         cWulD+4LSCa2nf0nb8Ruoidn+kZRLzCVPbwfVcgMFxE3RM0EQsHaWeDgVB2/Rns/tTD9
         Y36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=166ZI2PQYttk8mUuPjh9fJHZKXnQuSqSXt1RrZvFtpA=;
        b=YjVA/hq+qyiSQQF0HlN6OMRxL0p0NDZ1FKIVa3rtf6ztt90uJoY3i6h0fmm2EpNQ1U
         L6AimlKIhNqgSCGXZKV31Dv1msLsdRvTe8I4m6q0F4ojmM3TXY3qfVrSmePp+2l8xXJi
         Lh1YAl9rrpf6qQg/vmvOYHKA4n51TgN0P1s+yzMhxa2JDVXbwk3dBGerqjdAamfkrxgs
         Kdv+GWUm48Hde9AYaeyYYxuVNCgq6j3Oy6yX6vasrnzxp52jxrMa4E9V9cwkx2fPi45w
         BEfiLpxeGtH21BKlP6i8Q9PAMt1vj/8tPqHyRZ9ZIO+t+Mh4QZOK2awcyCEZkiHs4g1s
         F9VA==
X-Gm-Message-State: AGi0PubzpvzSPqDQiAlXbPgiWEvqjqe63iCBSfTzOLmRKAQI7uJHXOyz
        0tjcT81bABLRgocqXBnAe+3J2fA8IUDte4qs3MInHA==
X-Google-Smtp-Source: APiQypIVXSv4Xz1Q8pgiALwOrIbs+TbqKGJBWZAvFSYtSethZHtLnwLnQoOS0qNKX6URobh8SNfeXpV8uZemzz1NRmg=
X-Received: by 2002:ab0:3343:: with SMTP id h3mr1749214uap.19.1588678418386;
 Tue, 05 May 2020 04:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <1588080785-6812-1-git-send-email-rnayak@codeaurora.org>
 <1588080785-6812-10-git-send-email-rnayak@codeaurora.org> <CAPDyKFrGQvcCB1wfv=iqk66uja3faMRF1gGMSE2VhB8gJcO=sg@mail.gmail.com>
 <15efa375-cf1e-b793-1d3e-29ca0a547522@codeaurora.org>
In-Reply-To: <15efa375-cf1e-b793-1d3e-29ca0a547522@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 5 May 2020 13:33:01 +0200
Message-ID: <CAPDyKFoaJTXq2qN+HXoSUovun9+4gzLeVJ-88FKbZCSCKjByLw@mail.gmail.com>
Subject: Re: [PATCH v3 09/17] mmc: sdhci-msm: Fix error handling for dev_pm_opp_of_add_table()
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Pradeep P V K <ppvk@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Apr 2020 at 16:09, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
>
> On 4/28/2020 11:59 PM, Ulf Hansson wrote:
> > On Tue, 28 Apr 2020 at 15:39, Rajendra Nayak <rnayak@codeaurora.org> wrote:
> >>
> >> Even though specifying OPP's in device tree is optional, ignoring all errors
> >> reported by dev_pm_opp_of_add_table() means we can't distinguish between a
> >> missing OPP table and a wrong/buggy OPP table. While missing OPP table
> >> (dev_pm_opp_of_add_table() returns a -ENODEV in such case) can be ignored,
> >> a wrong/buggy OPP table in device tree should make the driver error out.
> >>
> >> while we fix that, lets also fix the variable names for opp/opp_table to
> >> avoid confusion and name them opp_table/has_opp_table instead.
> >>
> >> Suggested-by: Matthias Kaehlcke <matthias@chromium.org>
> >> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> >> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> >> Cc: Pradeep P V K <ppvk@codeaurora.org>
> >> Cc: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> >> Cc: linux-mmc@vger.kernel.org
> >
> > Is this a standalone patch that I queue up via my mmc tree?
>
> Hi Ulf, yes, its a standalone patch which applies on top of the one
> you already have in your tree. No other dependencies.

Thanks for confirming! Perhaps next time you could add this
information as part of a description to the patch (where we usually
add patch version information).

Anyway, applied for next!

[...]

Kind regards
Uffe
