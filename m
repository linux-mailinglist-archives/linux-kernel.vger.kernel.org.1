Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF55255751
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 11:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgH1JPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 05:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgH1JPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 05:15:34 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FEFC061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 02:15:33 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id o184so240434vsc.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 02:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zi8nSPHMdjjrzjQ95uIpbJn6FzlNcwjQhcXkzfbqLfM=;
        b=ARMU3Sm1HfR4wX1HJxIZnHKc/bbvOhVrX9LVg6THxme0OoKcI6xmfOkKHnjYpbteCJ
         VV1vimGJX0cqcH1aC9HPCwBN15ob8K/0SGVqqHmyitfUWuS7psXryKzORuPO1Smy7lvw
         9HkaLdtakfX2KQt/oN4ePv3vSaRCZ2khzWeB+//oPpndINVRlK7rfd76r1ArDlVIbScf
         DXrPfgo4r4UQWymB/8otAlH9gstuPpeB4VGamPFYq6kL6FwO+F8J4bczClot5TDZaZXA
         nYvKm+4/wt3p4bQlQrZtheVKR5Zdm3utMCRueQ/QGk1uzppqHCqs09NbvNR6Bohm5Ekz
         /KoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zi8nSPHMdjjrzjQ95uIpbJn6FzlNcwjQhcXkzfbqLfM=;
        b=eVFxzXyeFsiJbiiIPRsTyHIdPDlI5AtTKst7jkxu/ZKsOyP+hTNmY7IpsGvpQYc3t+
         abMwQK1B3Aqf4tXBsM4MGaXGu2TAwqulRK4XTxkQdDaq5iD/XrAffTVifs7fbVOp9nI1
         szIr/RkYMZBMoGVm2OJv/lyRWexYoJs13y5O01MiiHYKfKU1UXQ+dti0EPtuznP682Cs
         RY1qu6tqevqNPsTngpm469YORmYhD1JTtg5JiHanAIR1RPopepTxcFs3c4bomMcwaNcQ
         c9A17Ho6P8fOzHFUp+hjb6wbVABdkT7xfPr3YmVIR6+o9UnRjpujh1RHR6frHbm0VsMk
         Y6OA==
X-Gm-Message-State: AOAM530wcGgzzVFLLNJSFJd2fhZIvdP8RpzGG7PEIOHCjwdJ3jAd8hLY
        2LSIXy5Glb3RM5pM+X0xiT7kDUEzxsBL124+/e5C9A==
X-Google-Smtp-Source: ABdhPJyIDuUnOpmtIaCu/f8jrHWtD3Gs+OyjgcG3Z1bCdQZadwCfr0m7nO46s64/KtzS83TI683giQyQ5NxFVTcNIP4=
X-Received: by 2002:a67:e218:: with SMTP id g24mr227520vsa.167.1598606133029;
 Fri, 28 Aug 2020 02:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200827083330.1.I669bb4dc3d92bd04e9a695f97904797dc8241b79@changeid>
 <CA+G9fYtWpBQb8Ew_G=bjcR7wBHMgKm=EXV7vuk6FE9m0-4Ef3A@mail.gmail.com>
In-Reply-To: <CA+G9fYtWpBQb8Ew_G=bjcR7wBHMgKm=EXV7vuk6FE9m0-4Ef3A@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 28 Aug 2020 14:45:21 +0530
Message-ID: <CA+G9fYt-k9FMq0HcRN5iQyvt7yaz8YMpENcUktm7yQ1y+zgd1A@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-msm: When dev_pm_opp_of_add_table() returns 0
 it's not an error
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, vbadigan@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Aug 2020 at 01:57, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Thu, 27 Aug 2020 at 21:03, Douglas Anderson <dianders@chromium.org> wrote:
> >
> > The commit d05a7238fe1c ("mmc: sdhci-msm: Unconditionally call
> > dev_pm_opp_of_remove_table()") works fine in the case where there is
> > no OPP table.  However, if there is an OPP table then
> > dev_pm_opp_of_add_table() will return 0.  Since 0 != -ENODEV then the
> > "if (ret != -ENODEV)" will evaluate to true and we'll fall into the
> > error case.  Oops.
> >
> > Let's fix this.
> >
> > Fixes: d05a7238fe1c ("mmc: sdhci-msm: Unconditionally call dev_pm_opp_of_remove_table()")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>
> I will test this patch and report again on this email thread.

Sorry this patch did not solve the reported problem.
However, I would be testing the V2 set from Viresh Kumar.

and report the test results on the other patch set [1].
[1] https://lore.kernel.org/linux-pm/cover.1598594714.git.viresh.kumar@linaro.org
