Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D16027AD5B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 13:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgI1L5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 07:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgI1L5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 07:57:11 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993D7C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 04:57:11 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id z19so2088305uap.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 04:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m6BlvVj0EVBywT2cgsOvKNryF2Rcqd3HsW1lXVo1/GQ=;
        b=pEn/6/8w3Oy5g1bbm39JWitdVAV22PJrmkH7b+G99ss/wCBD0qrKg18W5H/i5c1rWc
         y9uKCA8zaRWqRn28zrPEPT659GmhDg5KCB9mbEL4GMFnpc9/9H+rrgIcUkNjvEhd+uBd
         ryIAmPJ3xMFMyQr6lpwMCgvAMmMnlYl8UBqkq00fWI1N8wzGC/QxFaQRRATkGavKZqK2
         blW91iQHF78F47AHuqcbpfmobaffGRoEjozN7WFmmV8yxcG/nGa/F3XuglPgmnKiNCP1
         AIA11sjlfh/yWiEdY6Np6R/RGrmPTNdAwIV+CYy7sah+p9EilfEOEV/bvtxG74V++jAi
         ER0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m6BlvVj0EVBywT2cgsOvKNryF2Rcqd3HsW1lXVo1/GQ=;
        b=JzG3gV95w8fZIlHWk7Iv4YGhGp/u/j88znfhw3euYqDlIOySFWPmpoGTrgF+Sq5OsM
         GK4b/66DZAgzigPpzclfoTMkWxC91IMxMke5xoycOCLjC6qEnN6pIN+LR3YtbnvGS0F4
         uHMcNMYncPoHDybuSUaV1QjlSP/JdCLpSGmOWu2cyq4wtwMEUhyOiGAJWdaV84wtcXI+
         Pa/paChH2RocjuxSj00O/jJsPlcgA6UPXbppNVnadB3nYBzDXQrGZ31kiacRiNO6kyro
         FMkF6k94o+jyMkEMlIZvxyhkGbaHsruMQX6VG0cdQnhXOQUOfaEMI1lWCE/hzeHdHpps
         ROLA==
X-Gm-Message-State: AOAM5311BunfAJvhQL1wCm/zA08YirNRyrqzUx+9l5NvgiKrIZDM+eXI
        1Qv5K61XdGNlLSpzgL4pPCVFYp9v11uK0ObNAzlCKw==
X-Google-Smtp-Source: ABdhPJy2xwpA03LkomFwJX+og3ha8axdK0DMS/pf4Ie0JmuKCaW5PwxmHaD/vPRC+Y16/8q34eWNEpKcCm82OEYTvPo=
X-Received: by 2002:ab0:130a:: with SMTP id g10mr375063uae.100.1601294230739;
 Mon, 28 Sep 2020 04:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200924110449.329523-1-ulf.hansson@linaro.org>
In-Reply-To: <20200924110449.329523-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Sep 2020 13:56:34 +0200
Message-ID: <CAPDyKFo0Tw0K_i4QjqN_CzHt_d=HCOeudmTBsSrf1-4maD_jog@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] PM / Domains: Add power on/off notifiers for genpd
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael,

On Thu, 24 Sep 2020 at 13:06, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Changes in v2:
>         - Improved error handling in patch3.
>
> A device may have specific HW constraints that must be obeyed to, before its
> corresponding PM domain (genpd) can be powered off - and vice verse at power
> on. These constraints can't be managed through the regular runtime PM based
> deployment for a device, because the access pattern for it, isn't always
> request based. In other words, using the runtime PM callbacks to deal with the
> constraints doesn't work for these cases.
>
> For these reasons, this series introduces a power on/off notification mechanism
> to genpd. To add/remove a notifier for a device, the device must already have
> been attached to the genpd, which also means that it needs to be a part of the
> PM domain topology.
>
> The intent is to allow these genpd power on/off notifiers to replace the need
> for the existing CPU_CLUSTER_PM_ENTER|EXIT notifiers. For example, those would
> otherwise be needed in psci_pd_power_off() in cpuidle-psci-domain.c, when
> powering off the CPU cluster.
>
> Another series that enables drivers/soc/qcom/rpmh-rsc.c to make use of the new
> genpd on/off notifiers, are soon to be posted. However, I would appreciate any
> feedback on the approach taken, even before that series hits LKML.
>
> Kind regards
> Ulf Hansson
>
>
> Ulf Hansson (3):
>   PM / Domains: Rename power state enums for genpd
>   PM / Domains: Allow to abort power off when no ->power_off() callback
>   PM / Domains: Add support for PM domain on/off notifiers for genpd
>
>  drivers/base/power/domain.c | 187 +++++++++++++++++++++++++++++-------
>  include/linux/pm_domain.h   |  19 +++-
>  2 files changed, 171 insertions(+), 35 deletions(-)
>
> --
> 2.25.1
>

I will need to iterate patch 3, potentially even a couple of more times.

As I expect patch 1 and patch2 to not get changed, may I suggest that
you pick up those so we can move focus to patch3?

Kind regards
Uffe
