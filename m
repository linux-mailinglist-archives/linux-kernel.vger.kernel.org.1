Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4982427B6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 11:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgHLJhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 05:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgHLJhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 05:37:41 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45AEC06178A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 02:37:40 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f7so1403618wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 02:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xUJA54KTzQJyhxDXIqR9ReX2WN+bK5CjNuAWDhsdb8w=;
        b=crr6oK1RJrz1nT63FwEgbS3gquu/Ncq38lBd42GrnhhkTBXb4cMsIlG2foOG5WIA8O
         WkSv44SczGIHDr0xQlOkRWLczZs2351YnlOSc/9gsjx0xFZJRC7wcaB7NoFJsWsGG+SN
         SmsMBj7Jo5Dj4AXLZjJeu86fS842ynrwKjltjgDHVc97wIM0xMlbrGgFu23CA43WZEqK
         JluWeEigpXi6/Zq/Dk5dOHooEgLZQJFZYbRixqFTNYsugm2NhqJb7gSCxy2lM10cX9e1
         mT9KIr53nqS+l1kKtdPhUZ2wzeIcpbb64uuZIZ0X9Ks7YmGuJOwkG3Tl09d+rKzm2r/a
         m42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xUJA54KTzQJyhxDXIqR9ReX2WN+bK5CjNuAWDhsdb8w=;
        b=DI5RErcAtTUejOkTvEWnYSUb4SgAXjHoSup0VZQ1swhOAPnVQCm4wbnR93ewu4oB+k
         t6gW3vGM47Ed4DChhVHClsikvV0XAu2b/GsIiO9o2o3mmpLBG0QVUvAQv1cc2emugELB
         Y7Qi7wRoW+9UqDlP2h/BXj82G5Bc9EkHOrxwVAoyligH9whmRpkYxf5TIcbdPSECwbJa
         62D4EOE/ij+w2uTLUzISIG20xux7U1/UXCbAfzCM51RE4KqFCQBy9tg7dCbmi+hKILUB
         GoP3DHW3eontM4vaCrTlGj1qH56tLpAr1zJNgIc1NHt+xvEsO2zYLqff7sm7oBENDoSp
         Pq2A==
X-Gm-Message-State: AOAM530mUk+Sjz17fZhiUczu7BUtdcXCqnJwHhmO2W2+4FfZgRdMadkZ
        v1SugRwskA44KfXMT3URfzhvKYTOdW82vKPx+1zgCw==
X-Google-Smtp-Source: ABdhPJzyVACqW0P5GX9T7WEr0tB2SFQ6077mmdaufTh9FO15OFL7AzToRKYCZQO33CyJbC41uGaJ5fCGYkTuz7UxjFw=
X-Received: by 2002:a5d:43c4:: with SMTP id v4mr34386550wrr.426.1597225059226;
 Wed, 12 Aug 2020 02:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <1596541616-27688-1-git-send-email-rnayak@codeaurora.org> <1596541616-27688-3-git-send-email-rnayak@codeaurora.org>
In-Reply-To: <1596541616-27688-3-git-send-email-rnayak@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 12 Aug 2020 11:37:03 +0200
Message-ID: <CAPDyKFoRv49jKi-4UW6EVyAzo1emb=rs2h7CWavON+JoXXh1kA@mail.gmail.com>
Subject: Re: [PATCH 2/3] PM / Domains: Add support for 'assigned-performance-states'
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Aug 2020 at 13:47, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> For devices which have 'assigned-performance-states' specified in DT,
> set the specified performance state during attach and drop it on detach.
> Also drop/set as part of runtime suspend/resume callbacks.

To allow flexibility, I would prefer to keep the performance state
being orthogonal to the power on/off state for a genpd.

Therefore, I am wondering if this is better handled by the consumer
driver instead?

Kind regards
Uffe

>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/base/power/domain.c | 27 +++++++++++++++++++++++++++
>  include/linux/pm_domain.h   |  1 +
>  2 files changed, 28 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 0a01df60..8704823 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -810,6 +810,10 @@ static int genpd_runtime_suspend(struct device *dev)
>         if (irq_safe_dev_in_no_sleep_domain(dev, genpd))
>                 return 0;
>
> +       /* Drop the assigned performance state */
> +       if (dev_gpd_data(dev)->assigned_pstate)
> +               dev_pm_genpd_set_performance_state(dev, 0);
> +
>         genpd_lock(genpd);
>         genpd_power_off(genpd, true, 0);
>         genpd_unlock(genpd);
> @@ -829,6 +833,7 @@ static int genpd_runtime_resume(struct device *dev)
>  {
>         struct generic_pm_domain *genpd;
>         struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
> +       unsigned int assigned_pstate = dev_gpd_data(dev)->assigned_pstate;
>         bool runtime_pm = pm_runtime_enabled(dev);
>         ktime_t time_start;
>         s64 elapsed_ns;
> @@ -857,6 +862,9 @@ static int genpd_runtime_resume(struct device *dev)
>         if (ret)
>                 return ret;
>
> +       /* Set the assigned performance state */
> +       if (assigned_pstate)
> +               dev_pm_genpd_set_performance_state(dev, assigned_pstate);
>   out:
>         /* Measure resume latency. */
>         time_start = 0;
> @@ -890,6 +898,8 @@ static int genpd_runtime_resume(struct device *dev)
>  err_poweroff:
>         if (!pm_runtime_is_irq_safe(dev) ||
>                 (pm_runtime_is_irq_safe(dev) && genpd_is_irq_safe(genpd))) {
> +               if (assigned_pstate)
> +                       dev_pm_genpd_set_performance_state(dev, 0);
>                 genpd_lock(genpd);
>                 genpd_power_off(genpd, true, 0);
>                 genpd_unlock(genpd);
> @@ -2405,6 +2415,12 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
>
>         dev_dbg(dev, "removing from PM domain %s\n", pd->name);
>
> +       /* Drop the assigned performance state */
> +       if (dev_gpd_data(dev)->assigned_pstate) {
> +               dev_pm_genpd_set_performance_state(dev, 0);
> +               dev_gpd_data(dev)->assigned_pstate = 0;
> +       }
> +
>         for (i = 1; i < GENPD_RETRY_MAX_MS; i <<= 1) {
>                 ret = genpd_remove_device(pd, dev);
>                 if (ret != -EAGAIN)
> @@ -2442,6 +2458,7 @@ static void genpd_dev_pm_sync(struct device *dev)
>  static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>                                  unsigned int index, bool power_on)
>  {
> +       unsigned int assigned_pstate;
>         struct of_phandle_args pd_args;
>         struct generic_pm_domain *pd;
>         int ret;
> @@ -2485,6 +2502,16 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>         if (ret)
>                 genpd_remove_device(pd, dev);
>
> +       /* Set the assigned performance state */
> +       if (!of_property_read_u32_index(base_dev->of_node,
> +                                       "assigned-performance-states",
> +                                       index, &assigned_pstate)) {
> +               if (assigned_pstate) {
> +                       dev_pm_genpd_set_performance_state(dev, assigned_pstate);
> +                       dev_gpd_data(dev)->assigned_pstate = assigned_pstate;
> +               }
> +       }
> +
>         return ret ? -EPROBE_DEFER : 1;
>  }
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 9ec78ee..4a415ee 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -180,6 +180,7 @@ struct generic_pm_domain_data {
>         struct notifier_block nb;
>         int cpu;
>         unsigned int performance_state;
> +       unsigned int assigned_pstate;
>         void *data;
>  };
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
