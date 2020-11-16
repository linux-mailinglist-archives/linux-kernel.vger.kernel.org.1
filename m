Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1351B2B430E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 12:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbgKPLlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 06:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728662AbgKPLlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 06:41:47 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC86C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 03:41:45 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id s135so3635465vkh.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 03:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2lOdbwlpCkQ/U9b3AI8byk39FYQ+zSfYd4xMBl2NASE=;
        b=jVRee76xd/vj7nXCbI+BMQETz21ek9rOn5KYwlEgY8rR7BwA15GOWS/WjjTQdHOr/L
         jUFPM9gMGsb2ja5/vP0MD6Cu1HL8aBPFeE7/sEEB1TBN94P7zs6yMRe8yAz5WYI32eT/
         mxfxhgJHsKXS37zoW9tG03L2y8KDDQYANGkj4ipDQhWvU1IPXyPK2rwBrgc15JQFTYZm
         yEdQYbWcEdXbTVZ0upCd/wRj1ZmWWlPZcBLfx1Pt6kfV+iwitXgSftXc4VS8TwUV/yNf
         AEUNT12cbenYntn9bjKSjVCVwFHH7wS6NVXt0cx+djYtAjiu4PPC3oc1TAWMOzcVOGCe
         gjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2lOdbwlpCkQ/U9b3AI8byk39FYQ+zSfYd4xMBl2NASE=;
        b=Lpv25oZ2AuWvo3CnXsoC+aj2sDBIZ79mclC9Doa4BskUuHqnjZkw3RcGLTgtiIYNrK
         14qb/z0yQQiDW4sAk1HwhOWplD3MScMOvdQjhD3EX7fFSJK8kSqplShTnfrbjt0/C5Mv
         qXxtLKvNUggjG5o7zXlfaUHpEFCJ3KGX+TkUdM+LVTpcABExoCxYD8JYvDhPu5g44YEe
         ORiPz6PqinYOVTN6EgURspyPlO+0YMLIXzfMKXPLje7ZQiuGv2pv/mo+VEd2MTRynt2C
         QxzE/Ht07PVgJuMnt0cGmR9z2KIt/pNCS7ECs4935KFnFqr6Ykf9GGAHsi2l6Dse6jPk
         O6bA==
X-Gm-Message-State: AOAM532i0Y2hlhHu0qqEBmy1T1zAM+CHw1IFJXhoTqK8oEiMEySRfkX3
        ABKT0YTEtMynAsdf69BfjOsTeSyzLzzVcTweLi1Sbg==
X-Google-Smtp-Source: ABdhPJyF+H/3JuvG1rFtW0kdG+BQsvxK9WRDn/noF2Wj5TJ7U/U1fEbxZ4IGsVFZ+argIC1nTyuv7vbjE+bp1pyH1+Q=
X-Received: by 2002:a1f:41cc:: with SMTP id o195mr6992899vka.15.1605526904953;
 Mon, 16 Nov 2020 03:41:44 -0800 (PST)
MIME-Version: 1.0
References: <20201106120933.7190-1-muhammad.husaini.zulkifli@intel.com> <20201106120933.7190-2-muhammad.husaini.zulkifli@intel.com>
In-Reply-To: <20201106120933.7190-2-muhammad.husaini.zulkifli@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Nov 2020 12:41:08 +0100
Message-ID: <CAPDyKFrq0Wsc7bNS0QPMitNqpkzK87VAuTnjDqrqTrVDGCwxgg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: sdhci-of-arasan: Specify .clk_ops for Keem
 Bay SOC
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

On Fri, 6 Nov 2020 at 05:10, <muhammad.husaini.zulkifli@intel.com> wrote:
>
> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
>
> Commit 16ada730a759 ("mmc: sdhci-of-arasan: Modify clock operations handling")
> introduces platform specific SDHCI clock operation.
>
> This patch declares the clock operation for Keem Bay.
> Add clk_ops for SD, EMMC and SDIO operations.

The above commit message doesn't really tell why or what goes on here.
Can please try to clarify that.

>
> Fixes: 36c6aadaae86 ("mmc: sdhci-of-arasan: Add support for Intel Keem Bay")

Is $subject patch fixing a bug/regression?

Kind regards
Uffe

>
> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
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
