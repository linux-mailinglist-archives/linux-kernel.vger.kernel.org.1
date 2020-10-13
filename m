Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8324A28DD6E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbgJNJY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730816AbgJNJUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:20:11 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA81BC0613BE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 15:27:08 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id u7so938403vsq.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 15:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nEh8aWSBzrx6UT31IWc0LsTnrFS8ZDfHAx42jaS0Cjs=;
        b=jvDdn/lroKNiUWKl5bN/qT1jMxMbc7sZcDAu3vbzKBJYEOQM00+YdWsySveShwX1qr
         LTiDPBQG5xOZ/wML9iM6nzFQgC76cHZwJpg9OoaMQN3FhlVSj/quqpW7HMh0VMVa8ILu
         VS8aq2hPsvuME+fGU5NMgPErb9Z5OJzMtD+Lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nEh8aWSBzrx6UT31IWc0LsTnrFS8ZDfHAx42jaS0Cjs=;
        b=qgppI25yC4Q3orjgXSa8kB16opyHHZwkVSXXNv6aPjDTTV+zSsNeOnb9GPc0C2EtPU
         3VBgmMVhdcUDRfasjQUg37kPnAX6bpRa4bM4dw+3bM9AqloRdyMA7qnpXclxyHGXPdjg
         FgYNLR7lF1XY3zL57q98JqC+1/Y5DD4wl03iBk0orE/4iF1UwF+a7TlA45DaTnVAfukA
         g9kxAxDnRrDet9XxqAC6ShV1j4DKv2ozTjGkZIldeQ+D2XDb0dmgbv9lR15b4P4KayTU
         O2I2nuWKwKH/ItYgoQYr828ErTyq61Va+3n9HV21hTmNiIz0AjpPHrYfsXG66v4NjH/T
         14+Q==
X-Gm-Message-State: AOAM533IWrxeqQM4suw7R+C2Y+8Hkm5B3SjuJ5UPgDuW9+w+mVMm2qoa
        9T4gv1nwlGqcl3gFdAt1OmxfPt5mT/4mew==
X-Google-Smtp-Source: ABdhPJyIS7Ele430vhCqezHi3WvNeMEB+kKb1sZQWh68CaXc4lkJwQPXIUD0NSauNyBKL/Z4jr2yEQ==
X-Received: by 2002:a67:f716:: with SMTP id m22mr1756931vso.12.1602628027612;
        Tue, 13 Oct 2020 15:27:07 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id o145sm197459vkd.13.2020.10.13.15.27.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 15:27:06 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id q20so488264uar.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 15:27:06 -0700 (PDT)
X-Received: by 2002:a9f:31ce:: with SMTP id w14mr1804071uad.104.1602628026293;
 Tue, 13 Oct 2020 15:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <1602614008-2421-1-git-send-email-tdas@codeaurora.org> <1602614008-2421-2-git-send-email-tdas@codeaurora.org>
In-Reply-To: <1602614008-2421-2-git-send-email-tdas@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 13 Oct 2020 15:26:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XOj-Vg36v8GtE1sjay0jCdCLgRMJtyN9ZYyZhsNkdVfg@mail.gmail.com>
Message-ID: <CAD=FV=XOj-Vg36v8GtE1sjay0jCdCLgRMJtyN9ZYyZhsNkdVfg@mail.gmail.com>
Subject: Re: [PATCH v0] clk: qcom: lpasscc: Re-configure the PLL in case lost
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 13, 2020 at 11:33 AM Taniya Das <tdas@codeaurora.org> wrote:
>
> In the case where the PLL configuration is lost, then the pm runtime
> resume will reconfigure before usage.
>
> Fixes: edab812d802d ("clk: qcom: lpass: Add support for LPASS clock controller for SC7180")
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  drivers/clk/qcom/lpasscorecc-sc7180.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/clk/qcom/lpasscorecc-sc7180.c b/drivers/clk/qcom/lpasscorecc-sc7180.c
> index 228d08f..5804a93 100644
> --- a/drivers/clk/qcom/lpasscorecc-sc7180.c
> +++ b/drivers/clk/qcom/lpasscorecc-sc7180.c
> @@ -356,6 +356,25 @@ static const struct qcom_cc_desc lpass_audio_hm_sc7180_desc = {
>         .num_gdscs = ARRAY_SIZE(lpass_audio_hm_sc7180_gdscs),
>  };
>
> +static int lpass_core_cc_pm_clk_resume(struct device *dev)
> +{
> +       struct regmap *regmap = dev_get_drvdata(dev);
> +       int l_val;

nit: technically "unsigned int" to match what regmap_read takes.

> +
> +       pm_clk_resume(dev);

Even though pm_clk_resume() doesn't currently return any errors, it
would be good form to check.  AKA:

ret = pm_clk_resume(dev);
if (ret)
  return ret;


> +       /* Read PLL_L_VAL */
> +       regmap_read(regmap, 0x1004, &l_val);
> +       if (!l_val)
> +               clk_fabia_pll_configure(&lpass_lpaaudio_dig_pll, regmap,
> +                               &lpass_lpaaudio_dig_pll_config);
> +       return 0;
> +}
> +
> +static const struct dev_pm_ops lpass_core_pm_ops = {
> +       SET_RUNTIME_PM_OPS(pm_clk_suspend, lpass_core_cc_pm_clk_resume, NULL)
> +};
> +
>  static int lpass_core_cc_sc7180_probe(struct platform_device *pdev)
>  {
>         const struct qcom_cc_desc *desc;
> @@ -386,6 +405,9 @@ static int lpass_core_cc_sc7180_probe(struct platform_device *pdev)
>         clk_fabia_pll_configure(&lpass_lpaaudio_dig_pll, regmap,
>                                 &lpass_lpaaudio_dig_pll_config);
>
> +       pdev->dev.driver->pm = &lpass_core_pm_ops;
> +       dev_set_drvdata(&pdev->dev, regmap);

I'm kinda confused.  Why not just change "lpass_core_cc_pm_ops"?  Then
you can get rid of the above two lines of code and get rid of the
whole "lpass_core_pm_ops" structure?


-Doug
