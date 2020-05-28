Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2D41E5CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 12:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387767AbgE1KOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 06:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387746AbgE1KOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 06:14:42 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB736C08C5C8
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 03:14:41 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id l15so15460517vsr.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 03:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TY9Fq3LC1xXg14hd0WuKsgTduh/q3AHtb5rRCMjqthI=;
        b=oju0zui0cmPviPwNVqYCcbRzOnIlDnD2z/Ec7qSBE11ITW0arlTs0rfOYMvIeQ9wfx
         /4yWDLNn5L7oK7nTxhx+JKY0U0oQ+33Fpes4gNQiQIwbcu+tiBzxyJqW1zOVQAT2t3O9
         ORDGfYB9mcEyABJO8mdBkkCId6+gCFiYf3CwT+u32T7jVpY9JODfw+B7YfY23icsTcay
         gq0SH2+cp0IRpnzkPfiW/rSYlmRsfNcdwoUbRd64xyIaGa8WMq4a/M+ZHaD2Cwt/ooCO
         wA603COlUc7IAHkuKE2rTU5/aIZ4N6njxoQoLrqcLKeQO700kbw8VDYs+wwRYfsYtKE6
         e3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TY9Fq3LC1xXg14hd0WuKsgTduh/q3AHtb5rRCMjqthI=;
        b=QFo7XEir7+TAawzICJ0l6K2G0ylBexhGEGC1SwhZUZ9/ozE9AcOBC/J9urAHuod1oj
         ymUISd2G4BTYZNJiBnZkSHhc+utlpPeewz30CCNaUBBlVC3zADqgOHfUNj36yYyhqTsf
         KrkAfvSJoP9coc4qgyTfnose7oja/Uw8C5+C1N4icBsTQ8U08QE+7YKhScy+guFUNAFu
         PRkP6eafPG1Vx8aRfIp8zLuQyyUTut4SvlG7YFbYRSFhamt0uLOAu9nwMeDxfwAOR19C
         OA7jcGz/6AoKqlnYh63VCsKCqWJ3C670s0Il86XKzeSrzrgAx7kPClU5J4FfKEer70Sz
         Ysxg==
X-Gm-Message-State: AOAM530i+EJZnKw4MXxuU+v0Fx5Xq9QjKMMX9FaijGyte8R6nhTPP1oo
        jClIG0EnHTDxNXv4TFUIu5FEsyXOaFLBSov+Bq9bsQ==
X-Google-Smtp-Source: ABdhPJxaSx0GrfVYgNa6ttgTTx9DNETbX+EjiCtMH3XnmOpimLE18atcCkh+HHZjk+14Uco80rFogu5VL03hl/Tqrpw=
X-Received: by 2002:a67:690e:: with SMTP id e14mr1364771vsc.34.1590660880942;
 Thu, 28 May 2020 03:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200525074053.7309-1-vladimir.kondratiev@intel.com>
In-Reply-To: <20200525074053.7309-1-vladimir.kondratiev@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 28 May 2020 12:14:04 +0200
Message-ID: <CAPDyKFqOMyXwqjPm8BoPqUEDeo9nmJ3TBryZd7-Gf76POxKjPg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-cadence: fix PHY write
To:     Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 May 2020 at 09:41, Vladimir Kondratiev
<vladimir.kondratiev@intel.com> wrote:
>
> Accordingly to Cadence documentation, PHY write procedure is:
>
> 1. Software sets the PHY Register Address (HRS04[5:0]) and the
>    PHY Write Data (HRS04[15:8]) fields.
> 2. Software sets the PHY Write Transaction Request (HRS04[24]) field to 1.
> 3. Software waits as the PHY Write Transaction Acknowledge (HRS04[26])
>    field is equal to 0.
> 4. Hardware performs the write transaction to PHY register where
>    HRS04[15:8] is a data written to register under HRS04[5:0] address.
> 5. Hardware sets the PHY Transaction Acknowledge (HRS04[26]) to 1 when
>    transaction is completed.
> 6. Software clears the PHY Write Transaction Request (HRS04[24]) to 1
>    after noticing that the PHY Write Transaction Acknowledge (HRS04[26])
>    field is equal to 1.
> 7. Software waits for the PHY Acknowledge Register (HRS04[26]) field is
>    equal to 0.
>
> Add missing steps 3 and 7. Lack of these steps causes
> integrity errors detested by hardware.
>
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-cadence.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index e474d3fa099e..6b2e7c43cbc1 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -114,6 +114,11 @@ static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
>         u32 tmp;
>         int ret;
>
> +       ret = readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_HRS04_ACK),
> +                                0, 10);
> +       if (ret)
> +               return ret;
> +
>         tmp = FIELD_PREP(SDHCI_CDNS_HRS04_WDATA, data) |
>               FIELD_PREP(SDHCI_CDNS_HRS04_ADDR, addr);
>         writel(tmp, reg);
> @@ -128,7 +133,10 @@ static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
>         tmp &= ~SDHCI_CDNS_HRS04_WR;
>         writel(tmp, reg);
>
> -       return 0;
> +       ret = readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_HRS04_ACK),
> +                                0, 10);
> +
> +       return ret;
>  }
>
>  static unsigned int sdhci_cdns_phy_param_count(struct device_node *np)
> --
> 2.20.1
>
> ---------------------------------------------------------------------
> Intel Israel (74) Limited
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>
