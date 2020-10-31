Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0972A1739
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 13:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgJaMNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 08:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgJaMND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 08:13:03 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687A3C0613D5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 05:13:03 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id f37so8079467otf.12
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 05:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OJnBN88M+BlFSOlt8QGTKwLwqQoCIrUkzepgf9Q0TBU=;
        b=pwNwtn8hzJqmy4ovTfgp+b9xQU0d3N7a4+9JjCBXoZyL1e+C60v6cZwIHT9Co9EktW
         leVrLES3lNC1lA73J0lc9tPz9GOTDIjoXisVqTDbp+4W4beDzFl+md+cUWH6e65dxU/o
         BWmL6MqkyKTDW+j+nUrz8BUFcWQtYOSiTJXt6xsiqNkwCMkxdAXvDh7C6i0F4u8nq9gM
         R0CGYAr3pH1eGV+eYn0gF5WLQtT7C/pII4Jhilmi2zCSYBDR1YYYkyfOqWFIOHBZ6emU
         7tJg4h43ZV4ad/jVBNelzfvvv5SOzFrFm4UUshjR0uX7duCQLDQFsYb6Js35w92LiVlW
         uPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJnBN88M+BlFSOlt8QGTKwLwqQoCIrUkzepgf9Q0TBU=;
        b=cd3wUBkxHeFHJE/bLyyqePKtbFeeSk/iWFxcpfvym4PseAMBCWm4RdKiebsakiUWny
         TT3WpbG76olP35hO97sXhMmWoE73sS9G8AFV+/CtvYjo56FFduhmDz4VUbHqDSOTrHkV
         Kqt9Ri/7V4mRpOG/9C1nNyehRyknGvfRIS6zKeCoDmbkA7W5PLOdU/QzaNoZ1Gs1yDoo
         CgdA3LLhMtd6d4KTTdayartQigNG8Ofp81GSwe2JbqdjnFnckJLDM2oCzpGgUd6aIzTe
         PuYx1MlJgErcMhBDeY3ubSNBGWwFH+fMpiI8e/CDGBeSDvEoC8Y/bl6J3cqaz7c4fU90
         1LDA==
X-Gm-Message-State: AOAM530Xgcs7io72IiP6pxhnkQ6b/b4us1h8+At8v5Uq3FQFQFOExp+a
        76+gZXpuvnBQKK/i559yvzeE0/T3g/EMnVnwJVeSkA==
X-Google-Smtp-Source: ABdhPJxdEcH+KjsMqyTGbY1i1CZ42RiVG1YOCVBbGk18uLqBbkGoU8Ym0A8YyqxteNkC5P0vB765E9ShdESnE21YH98=
X-Received: by 2002:a05:6830:3104:: with SMTP id b4mr5147702ots.66.1604146382129;
 Sat, 31 Oct 2020 05:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201028114635.7570-1-robert.marko@sartura.hr> <2f0653b7d05d1ef26f6624b38d1d7b2d@codeaurora.org>
In-Reply-To: <2f0653b7d05d1ef26f6624b38d1d7b2d@codeaurora.org>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Sat, 31 Oct 2020 13:12:51 +0100
Message-ID: <CA+HBbNGWX7msHgurh+7yzMO7upiGnvSfT=jBy41Xu7Mp6GXE9w@mail.gmail.com>
Subject: Re: [PATCH v2] watchdog: qcom_wdt: set WDOG_HW_RUNNING bit when appropriate
To:     kathirav@codeaurora.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        wim@linux-watchdog.org, linux@roeck-us.net,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 6:21 AM <kathirav@codeaurora.org> wrote:
>
> On 2020-10-28 17:16, Robert Marko wrote:
> > If the watchdog hardware is enabled/running during boot, e.g.
> > due to a boot loader configuring it, we must tell the
> > watchdog framework about this fact so that it can ping the
> > watchdog until userspace opens the device and takes over
> > control.
> >
> > Do so using the WDOG_HW_RUNNING flag that exists for exactly
> > that use-case.
> >
> > Given the watchdog driver core doesn't know what timeout was
> > originally set by whoever started the watchdog (boot loader),
> > we make sure to update the timeout in the hardware according
> > to what the watchdog core thinks it is.
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > Cc: Luka Perkov <luka.perkov@sartura.hr>
> > ---
> > Changes in v2:
> > * Correct authorship
> >
> >  drivers/watchdog/qcom-wdt.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> > index ab7465d186fd..28c93a918e38 100644
> > --- a/drivers/watchdog/qcom-wdt.c
> > +++ b/drivers/watchdog/qcom-wdt.c
> > @@ -152,6 +152,13 @@ static int qcom_wdt_restart(struct
> > watchdog_device *wdd, unsigned long action,
> >       return 0;
> >  }
> >
> > +static int qcom_wdt_is_running(struct watchdog_device *wdd)
> > +{
> > +     struct qcom_wdt *wdt = to_qcom_wdt(wdd);
> > +
> > +     return (readl(wdt_addr(wdt, WDT_EN)) & 1);
>
> QCOM_WDT_ENABLE macro can be used instead of 1?
Yes, pushed this in v4(Forgot to do it in v3).
Thanks
>
> > +}
> > +
> >  static const struct watchdog_ops qcom_wdt_ops = {
> >       .start          = qcom_wdt_start,
> >       .stop           = qcom_wdt_stop,
> > @@ -294,6 +301,21 @@ static int qcom_wdt_probe(struct platform_device
> > *pdev)
> >       wdt->wdd.timeout = min(wdt->wdd.max_timeout, 30U);
> >       watchdog_init_timeout(&wdt->wdd, 0, dev);
> >
> > +     if (qcom_wdt_is_running(&wdt->wdd)) {
> > +             /*
> > +              * Make sure to apply timeout from watchdog core, taking
> > +              * the prescaler of this driver here into account (the
> > +              * boot loader might be using a different prescaler).
> > +              *
> > +              * To avoid spurious resets because of different scaling,
> > +              * we first disable the watchdog, set the new prescaler
> > +              * and timeout, and then re-enable the watchdog.
> > +              */
> > +             qcom_wdt_stop(&wdt->wdd);
>
> qcom_wdt_start disables the WDT, configure the timeout values and
> enables it. Do we still need to call qcom_wdt_stop?
No, as the start will actually stop the WDT and then set everything up.
Pushed in v3.
>
> > +             qcom_wdt_start(&wdt->wdd);
> > +             set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
> > +     }
> > +
> >       ret = devm_watchdog_register_device(dev, &wdt->wdd);
> >       if (ret)
> >               return ret;
