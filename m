Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EBF288324
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 09:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731733AbgJIHAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 03:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731044AbgJIHAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 03:00:42 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B222BC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 00:00:42 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id j20so1020879uaq.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 00:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6LxvX5EGSR5dzBeJZ4icU2Yz0a2U6qxuATeWZPemrZs=;
        b=HlG3sqIPhShbJ5Cx3vwfnebC0xgxM/SxHaKUwe8bETaqPD5Z/NXCAWb89YCDemgs/R
         ZBujRadVWfw/hFjUNCeWgO569J8i4SyBb+ukBZzrjCIAwUBEQ38OY5gjZGokBdt127oF
         T0XuYvwEfXOprlg4MpgFi1yUMGp77gF8oIg2qe7UdMuUACeFH+aGe5Gmyu66slvG9bHH
         EgnEa1K3sRE8xzC+f6wMrajp2abARwCz0rJzUaDG2wL6RfOVLQ4bf04Yyz/P8OaTVNT9
         98UC0K1rY3tkH2qF5zbCvDPB4/4yzdI9qgRipqm5A70MBFy8hu7Dmq8CTs/ncYiFQd1J
         wXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6LxvX5EGSR5dzBeJZ4icU2Yz0a2U6qxuATeWZPemrZs=;
        b=cqQHo5HigwVApCCuSxO3tXRCizAW9oA+RlT8xb6P2tAHy5QR5AJRKRrhn5cQtypxWu
         QCYXE58Yxv4cE2cIogBTqNACiz8D82iTPBYq2hjZr6eYhiqjHy8glC0p4OKB4c+zIN0r
         /YOewKd2MdBdccHmmPNCxk4VdwuxnPsNYuk7yqcN79m/UyVVrTxXAYB+EwTgsoCKcE/R
         OKHkFQYCOtSPLARhqfXX/DdW6tvLL3EYBH4q1y9/F9u/iIA9SBvnNaexWTijBzczOoBr
         fw/VuwWbuc8TebokMeCuWK/3CNnfA35xcFDAESY8ZO6hnqgUkizDSu8ogJ0keVwd2B6f
         1Q6g==
X-Gm-Message-State: AOAM530G+WVvtXFyY+OGDKdhctqVzPoJLeom59u8vQSDOmn7jQsX4AgK
        8QhocHl7X2vrbimBTDbV29IbrImS8D44TdEIXZu6Qg==
X-Google-Smtp-Source: ABdhPJxP48s9Fi3PvzMHTIKhwWE5xo6W5AMzluAvP/iw7yZfHQsSa0wuItjNoe6316/TEnRWyUg3tzmN+NBKagVDQq0=
X-Received: by 2002:a9f:31ce:: with SMTP id w14mr7428678uad.104.1602226841942;
 Fri, 09 Oct 2020 00:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201008100129.13917-1-faiz_abbas@ti.com>
In-Reply-To: <20201008100129.13917-1-faiz_abbas@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 9 Oct 2020 09:00:05 +0200
Message-ID: <CAPDyKFpixCO35ARA9QBfhcdkhFpiqqWCxDrJnOF7g+AiY_P9Kg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci_am654: Fix module autoload
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Oct 2020 at 12:01, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Add a MODULE_DEVICE_TABLE() entry so that the driver is autoloaded
> when built as a module.
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci_am654.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 2bce962bf7e4..a64ea143d185 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -739,6 +739,7 @@ static const struct of_device_id sdhci_am654_of_match[] = {
>         },
>         { /* sentinel */ }
>  };
> +MODULE_DEVICE_TABLE(of, sdhci_am654_of_match);
>
>  static int sdhci_am654_probe(struct platform_device *pdev)
>  {
> --
> 2.17.1
>
