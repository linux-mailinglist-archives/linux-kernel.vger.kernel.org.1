Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66E72CEFD0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 15:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbgLDOjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 09:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730320AbgLDOjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 09:39:23 -0500
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833F4C061A53
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 06:38:43 -0800 (PST)
Received: by mail-ua1-x943.google.com with SMTP id x13so1911174uar.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 06:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vwpuxaaZbL1aUgf+1bfZQEaatrFcmPToO36aqopJneA=;
        b=V0/ZJW1pimWXHb5XHK92onAUgt5du6OUKqfD2kvZ4I6vLZAh/oD4cWmR2aQUdUozGm
         BFw4K0Jr/Dte3vzRwP0a+qYRGbHGniiTs0I7D0ZV3wwG0nmizWRi6ps/ghOXAQzVbdmp
         +q3fWU+OtVKd4IS92/mn4mZmZDLJ2WQhSlnkF/YowL6HNPY4C7a+3ZgF1V894wRjKGWg
         OH4FllR62z/9BRG6zmmLWRycDiXFQtvUApmWBask4Kt6gb6BkMIp6OjDEb9+BKUX7yve
         dUi/mscp6gKqu6JrDggWFjrlY3n1vkXGZ/MaK7Se9PWoDUS6O+TEh0y+U+XNoDwl1yWN
         a+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vwpuxaaZbL1aUgf+1bfZQEaatrFcmPToO36aqopJneA=;
        b=U7Njh73HK5E18PpydbxWw0LMrPsmfGn5/oT8uyRxc6nFuv1moodHnxn6dKRimtILRs
         zg0iKQJpJ7CSaXL/6V4EPnWQkRL+jQ7E+PdH+xCBOd25sQ8fr/pTxGwNzzlwpGzUwh1U
         Vdltvx/FljtZNlAsLP8XZ5cc0BXIICWWEH72y7/nb8J7fLPjXVmY4hxFdQpaGOLQoocC
         ooA8eDh26mj1PG5kcQmkGawf8BGNWmh8BOZ1Xj1ynTuyriDbA8yOKJHhLVvKl394rzdz
         ADLhX4H2u10IrvzsUzFmxLiTrUxgDS4YIWoK3c6iUeQ1dPe9Go3VKr8l2qc4wUkGyOUd
         r5FA==
X-Gm-Message-State: AOAM532gaT380Fm2jxN6U/o51dFrRAnDbPJGfLBOigynLnMZzyLGI762
        CM7ItZBfgtXi/rxvXdrvPWKAiKA60Dztscbd6oJHvA==
X-Google-Smtp-Source: ABdhPJzRn9F4pmIEZTb+X83QUxDi1ljME12Y/RmmipMsNVsDfDtmIvA4x3ulGS73cdI+/Aq6lQmwjmX/e6zQsbxPgno=
X-Received: by 2002:a9f:3e4b:: with SMTP id c11mr3325774uaj.19.1607092722711;
 Fri, 04 Dec 2020 06:38:42 -0800 (PST)
MIME-Version: 1.0
References: <20201125110145.2824-1-benchuanggli@gmail.com>
In-Reply-To: <20201125110145.2824-1-benchuanggli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Dec 2020 15:38:06 +0100
Message-ID: <CAPDyKFpCJrHpb0gzDY5Tpg=7YnKpYr80q7m3KaQqBLnNgRPLmw@mail.gmail.com>
Subject: Re: [PATCH,v2] mmc: sdhci-pci-gli: Disable slow mode in HS400 mode
 for GL9763E
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Nov 2020 at 12:01, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> The GL9763E uses 150Mhz (slow mode) by default in HS400 mode. In order
> to make HS400 mode run at 200Mhz, the slow mode needs to be turned off.
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 9887485a4134..d45d7e529150 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -87,6 +87,9 @@
>  #define PCIE_GLI_9763E_SCR      0x8E0
>  #define   GLI_9763E_SCR_AXI_REQ           BIT(9)
>
> +#define PCIE_GLI_9763E_MMC_CTRL  0x960
> +#define   GLI_9763E_HS400_SLOW     BIT(3)
> +
>  #define SDHCI_GLI_9763E_CQE_BASE_ADDR   0x200
>  #define GLI_9763E_CQE_TRNS_MODE           (SDHCI_TRNS_MULTI | \
>                                     SDHCI_TRNS_BLK_CNT_EN | \
> @@ -764,6 +767,10 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>         value |= GLI_9763E_SCR_AXI_REQ;
>         pci_write_config_dword(pdev, PCIE_GLI_9763E_SCR, value);
>
> +       pci_read_config_dword(pdev, PCIE_GLI_9763E_MMC_CTRL, &value);
> +       value &= ~GLI_9763E_HS400_SLOW;
> +       pci_write_config_dword(pdev, PCIE_GLI_9763E_MMC_CTRL, value);
> +
>         pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
>         value &= ~GLI_9763E_VHS_REV;
>         value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
> --
> 2.29.2
>
