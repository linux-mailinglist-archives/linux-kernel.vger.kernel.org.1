Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4802B810F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 16:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbgKRPoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 10:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgKRPoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:44:12 -0500
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E32DC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 07:44:12 -0800 (PST)
Received: by mail-vk1-xa41.google.com with SMTP id b190so572510vka.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 07:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ydW4yk3TuZeSZNEMd5axHSNJoQSvtmifCt5BdKRg16c=;
        b=tA/bE1TZGsTU92aTpRhEFvcyxzto5ecR9XJkFucrG8nxq2ihWvjgHGw1iuywYvzipU
         6YvjThzK2uomYFlRwGZs/4slkWzQdwdqkQ/fN+8XFkyQ+cz+tp+9wEkcr5dFRe/tQ4in
         Uvds9pYH9IgCzN5SL4vuds34h/D/zNQ1GBT1cdh/d2Bpr8x2VTgxY/zv0SXrVf/smnvD
         uI5XcI1AwNVbcIb3asABOyPIgdngYu+zSx9+KxprHaC43jdC5ckL3YhQQ2wL/qzJgtxh
         OKPN5HKu9JAlBeZ5nTxF7HklNo8p7oPUJ/EdAELw+CYnW2layqGwmSrDFOv23hUeRfl/
         wDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ydW4yk3TuZeSZNEMd5axHSNJoQSvtmifCt5BdKRg16c=;
        b=sMZoaA56IJqmYc+K0g8ouJIFt2nACySkTWfEXi/brpTGttriSVPegSZkjvHHmWm6S1
         yciFgHPjlAOaAMXkCLRk8ccaJrugK5xZDdiaO+dhQ7X4zHb+ZKbMVyy4IG4ad8IB2hhH
         uSpu7IpQYgHKnN2IuWwZ3zgHL46KeDROUBob/VVIR1oAL2AxoYGhDmybJAqfv+/rtWDE
         l+0IcKysKaE12OTqQUAkdfOtHOKHqO2EH+rZ3ldgpx++fMV53PAuSV0nymDKys6HHuOJ
         hGjYMgmtLq+4zqbz+ewdIAHFDQzExiJjc42iHbot73tfHidCyAaBVKf9B61t3LHTOX3p
         Xyng==
X-Gm-Message-State: AOAM533omf5Ri515bDszZKgPvdzBuVVHoX7sTXfSQe8usRB1GR1GKhiW
        ddS1Gc2NqfuT4/8FhxhudP+S5ACl0gq/wUFEao6qmw==
X-Google-Smtp-Source: ABdhPJyclpsoyMGwEp4eAi3irUnBeWNOvcROuZtu5a/eHfn8VDPqkTkMqfp76L/7oEhiRZt1qoUuCvCNowDqVMNb2pU=
X-Received: by 2002:a1f:41cc:: with SMTP id o195mr3817836vka.15.1605714251540;
 Wed, 18 Nov 2020 07:44:11 -0800 (PST)
MIME-Version: 1.0
References: <1605680495-37483-1-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1605680495-37483-1-git-send-email-manish.narani@xilinx.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 18 Nov 2020 16:43:35 +0100
Message-ID: <CAPDyKFr7KTf7jUAuPj=0NZ1sty+y7ySV8PkdrKFXPVthJ=VJVQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add pinctrl support to the driver
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        git@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Nov 2020 at 07:22, Manish Narani <manish.narani@xilinx.com> wrote:
>
> Driver should be able to handle optional pinctrl setting.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 829ccef87426..f788cc9d5914 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -23,6 +23,7 @@
>  #include <linux/regmap.h>
>  #include <linux/of.h>
>  #include <linux/firmware/xlnx-zynqmp.h>
> +#include <linux/pinctrl/consumer.h>
>
>  #include "cqhci.h"
>  #include "sdhci-pltfm.h"
> @@ -135,6 +136,8 @@ struct sdhci_arasan_clk_data {
>   * @clk_ops:           Struct for the Arasan Controller Clock Operations.
>   * @soc_ctl_base:      Pointer to regmap for syscon for soc_ctl registers.
>   * @soc_ctl_map:       Map to get offsets into soc_ctl registers.
> + * @pinctrl:           Per-device pin control state holder.
> + * @pins_default:      Pinctrl state for a device.
>   * @quirks:            Arasan deviations from spec.
>   */
>  struct sdhci_arasan_data {
> @@ -149,6 +152,8 @@ struct sdhci_arasan_data {
>
>         struct regmap   *soc_ctl_base;
>         const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
> +       struct pinctrl  *pinctrl;
> +       struct pinctrl_state *pins_default;
>         unsigned int    quirks;
>
>  /* Controller does not have CD wired and will not function normally without */
> @@ -1619,6 +1624,25 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>                 goto unreg_clk;
>         }
>
> +       sdhci_arasan->pinctrl = devm_pinctrl_get(&pdev->dev);
> +       if (!IS_ERR(sdhci_arasan->pinctrl)) {
> +               sdhci_arasan->pins_default =
> +                       pinctrl_lookup_state(sdhci_arasan->pinctrl,
> +                                            PINCTRL_STATE_DEFAULT);
> +               if (IS_ERR(sdhci_arasan->pins_default)) {
> +                       dev_err(&pdev->dev, "Missing default pinctrl config\n");
> +                       ret = PTR_ERR(sdhci_arasan->pins_default);
> +                       goto unreg_clk;
> +               }
> +
> +               ret = pinctrl_select_state(sdhci_arasan->pinctrl,
> +                                          sdhci_arasan->pins_default);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "could not select default state\n");
> +                       goto unreg_clk;
> +               }
> +       }

Isn't all this already taken care of via pinctrl_bind_pins() called by
driver core during probe?

[...]

Kind regards
Uffe
