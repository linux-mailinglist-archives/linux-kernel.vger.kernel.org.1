Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000252C0FCB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 17:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389897AbgKWQHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 11:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389888AbgKWQHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 11:07:38 -0500
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4A5C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 08:07:38 -0800 (PST)
Received: by mail-vk1-xa43.google.com with SMTP id a4so572342vko.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 08:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O/ItqqpCB3WwrW1C+GCf4NN2Kjg8Qry/xoQUCv8LM1Y=;
        b=Vu16UjmbO6sNa5108slHIduaE+yjbGtAc5ye7fxBJdvq7YygR0atRT57IkCM1X31+W
         UUgiwq2aSFoFNzraUyzdqbwX8hu/fONCC6hXIeUo2tKabgHbyllDl5GZCKAda3EDH79N
         Sxz/RslEJC7ZoEx5jpq1sTKXMJqn+pP2LeEKE4aZpdh5WE1o9n4Ju7m/Zpxuhjlqmpz6
         sjeKBWZaKjxfh6ogWeSrHa+0N/ex2uJMz4wwi6UIzBlwI46NpSZgzY4PwGa8Vh5cz7ue
         hnVoluFIbrAf2b0aY3dn74xoWNW4TFSK6ZHnThlMJuxyA1ynf97QfEm/rQ+ExtTj6/3n
         HYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O/ItqqpCB3WwrW1C+GCf4NN2Kjg8Qry/xoQUCv8LM1Y=;
        b=Ng4RrXDF44LfT8xXCp1c93h2+VNv6o1GKGYkbDOX2lQeK094VXbfBXHE2hyA+Y4f10
         Orj9rCDj4pSOsDt2vc/pfZ+M92JMZIc5qFmqdhbiVaZ+Gd7N6Irohcek8xmmUuRQ4kuL
         vgGg9gkoFb2fa0H51mdfCR5b3J7XuRL5BAGeVKeXw2iKbZ00RQdJHspFCvoXub2HhU45
         wz7UEvSn04f5DFoaBUwgj7zPwx1VLHfRIzSBqvl2LWurdX+M5NsJemLWuBz1QU5kfyYX
         WZT3hiedIAAig6EjXQ9mAbt5avWn1EhPbW3krRY65I4lByyhru8u9SloDovtrAG09mCz
         SdrA==
X-Gm-Message-State: AOAM530j3EDLrmW0oUmLiMYYdcl7DK7bFFkAi9SO/HA2GPHw+5lXz2Og
        uAbCGWXPiWSyD4epL+V7zIhITDsPtpzIdjABZbVs6Q==
X-Google-Smtp-Source: ABdhPJyWnEErE/SiDA8LVPRNMejQR2+57MiKFEIdwOr/gU4OcMsQt0L5pBWLI+QK+wC55RYqTPUdmE3EersH0WdAUv4=
X-Received: by 2002:a1f:2cd4:: with SMTP id s203mr524230vks.6.1606147657783;
 Mon, 23 Nov 2020 08:07:37 -0800 (PST)
MIME-Version: 1.0
References: <20201118120120.24908-1-muhammad.husaini.zulkifli@intel.com> <20201118120120.24908-2-muhammad.husaini.zulkifli@intel.com>
In-Reply-To: <20201118120120.24908-2-muhammad.husaini.zulkifli@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 23 Nov 2020 17:07:01 +0100
Message-ID: <CAPDyKFp6ws4SKwBXF36CQ2-PiaJtETXupqRsPMCLyUvc9Ho7Kg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mmc: sdhci-of-arasan: Fix clock registration fail
 for Keem Bay SOC
To:     "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Nov 2020 at 05:01, <muhammad.husaini.zulkifli@intel.com> wrote:
>
> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
>
> Commit 16ada730a759 ("mmc: sdhci-of-arasan: Modify clock operations handling")
> introduces platform specific SDHCI clock operation. Each platform should
> specify clock operations handlers.
>
> Commit 16ada730a759 ("mmc: sdhci-of-arasan: Modify clock operations handling")
> and Commit 36c6aadaae86 ("mmc: sdhci-of-arasan: Add support for Intel Keem Bay")
> are merged about the same time. When doing rebasing during the upstream process,
> Commit 16ada730a759 ("mmc: sdhci-of-arasan: Modify clock operations handling")
> was not included. This will result in sd clock registration failure for
> Keem Bay SOC Devices as clock operations handlers are not defined.
>
> This patch declares the clock operation for Keem Bay SOC Devices.
> Add clk_ops for SD, EMMC and SDIO operations.
>
> Fixes: 36c6aadaae86 ("mmc: sdhci-of-arasan: Add support for Intel Keem Bay")
>
> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 829ccef87426..012d52e1abee 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -1199,16 +1199,19 @@ static struct sdhci_arasan_of_data sdhci_arasan_versal_data = {
>  static struct sdhci_arasan_of_data intel_keembay_emmc_data = {
>         .soc_ctl_map = &intel_keembay_soc_ctl_map,
>         .pdata = &sdhci_keembay_emmc_pdata,
> +       .clk_ops = &arasan_clk_ops,
>  };
>
>  static struct sdhci_arasan_of_data intel_keembay_sd_data = {
>         .soc_ctl_map = &intel_keembay_soc_ctl_map,
>         .pdata = &sdhci_keembay_sd_pdata,
> +       .clk_ops = &arasan_clk_ops,
>  };
>
>  static struct sdhci_arasan_of_data intel_keembay_sdio_data = {
>         .soc_ctl_map = &intel_keembay_soc_ctl_map,
>         .pdata = &sdhci_keembay_sdio_pdata,
> +       .clk_ops = &arasan_clk_ops,
>  };
>
>  static const struct of_device_id sdhci_arasan_of_match[] = {
> --
> 2.17.1
>
