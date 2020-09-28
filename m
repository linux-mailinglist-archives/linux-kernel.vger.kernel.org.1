Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A220327B6A4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 22:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgI1Urx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 16:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgI1Urx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 16:47:53 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC75C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 13:47:52 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id n61so2313124ota.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 13:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qfHHuJyhHYYGK0U8SAtvUd7mSQGe+e2IQIFpamJOBYA=;
        b=dnjGDFtDbEElPt+bmnS52yBRq2dw6IuySw9sMyYFj/X6VF0s0eULAeUcD1m4ccIn/W
         WbpZMrr4hJLiiTeakXmMSQ6U4Wdh4e4bSS/igWFe//UVlNpYsg99EQ/sl3+KLeqCt+cP
         Z7KHIahp5janRPuFnuYdVV2+Fn08tQDbGPGmzvFtw+ju0F0xPVD1DFD9a3vnExrkMc6Q
         +NRzPu++swARiV6QciIXl2JtpZUBTP0+H8Rs8HlmCxWaPbDWAnWdJtrEif4r4b/5kRcb
         y2jd8Hv2d9w+1WdP8gD4EuClJBkptO+UQV4hRGwYU30t0DriLpopZHSjVvwILL8nVj8v
         pfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qfHHuJyhHYYGK0U8SAtvUd7mSQGe+e2IQIFpamJOBYA=;
        b=STUenXnS+R9eKwvC/N62ra7wBY3Vc0Pk5bH25ve6eNuzbpwDrdb5KoN30aBJN0+Pgo
         Fq/Q/B7vUt0bQY6uxGTMSVzEqGYtiBCDrAy+v8o/EaSY+FuVR1mtgbR8Cd2BXjCHeJtE
         1pUiEV1pSxwouJ9nVINCbEWqgZHT46XpqDcZFP3myelo7pM0UQIL0w3W5JMANWDAiS+i
         T9XvYKsLpTNFGZ6CiYJVfK4zXE6SbWVdwXnvyYGF53vXeBZxbOHkjAZwAlZztPGgtPuE
         ukG+mdT3+qjJM6q++MsKwUNOHo3WJcxZgNo23fo9oNsq9btK+WFDNEDn+oyhj88oltLp
         FLxw==
X-Gm-Message-State: AOAM533LfEatZ0di3To+Q7v9MCIcN79WCIAbRX5v4EW9bWzlxgr2r0KG
        1vjSp2+hJNeLJBmzv2WizsBWkoDcqwMt+Ja7uCsORQ==
X-Google-Smtp-Source: ABdhPJx1A6nsTbMAwIBn601XHNVGqA8Ik//44vQQoCehlVJyYQa+KwuudA+qmLUWAAx/4GwAkkNW3ByI7/QBuGdhpSk=
X-Received: by 2002:a05:6830:196:: with SMTP id q22mr521334ota.221.1601326071554;
 Mon, 28 Sep 2020 13:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <1598354482-15491-1-git-send-email-mkshah@codeaurora.org> <1598354482-15491-2-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1598354482-15491-2-git-send-email-mkshah@codeaurora.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 28 Sep 2020 13:47:40 -0700
Message-ID: <CALAqxLVam5bs8riyVG-L4sA8bYze6R19-DawHo4O_s3hx-5Myw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Revert "drivers: qcom: rpmh-rsc: Use rcuidle
 tracepoints for rpmh"
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 4:22 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Commit efde2659b0fe ("drivers: qcom: rpmh-rsc: Use rcuidle tracepoints
> for rpmh") was written to fix a bug seen in an unmerged series that
> implemented a struct generic_pm_domain::power_off() callback calling
> rpmh_flush(). See stack trace below.
>
>      Call trace:
>       dump_backtrace+0x0/0x174
>       show_stack+0x20/0x2c
>       dump_stack+0xc8/0x124
>       lockdep_rcu_suspicious+0xe4/0x104
>       __tcs_buffer_write+0x230/0x2d0
>       rpmh_rsc_write_ctrl_data+0x210/0x270
>       rpmh_flush+0x84/0x24c
>       rpmh_domain_power_off+0x78/0x98
>       _genpd_power_off+0x40/0xc0
>       genpd_power_off+0x168/0x208
>
> Later the final merged solution is to use CPU PM notification to invoke
> rpmh_flush() and power_off() callback of genpd is not implemented in the
> driver.
>
> CPU PM notifiers are run with RCU enabled/watching (see cpu_pm_notify()
> and how it calls rcu_irq_enter_irqson() before calling the notifiers).
>
> Remove this change since RCU will not be idle during CPU PM notifications
> hence not required to use _rcuidle tracepoint. Using _rcuidle tracepoint
> prevented rpmh driver to be loadable module as these are not exported
> symbols.
>
> This reverts commit efde2659b0fe835732047357b2902cca14f054d9.
>
> Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>

Hey Maulik!
  Thanks so much for sending out this series!  I noticed this hasn't
made it to -next yet, so would it be good to resubmit it?

thanks
-john
