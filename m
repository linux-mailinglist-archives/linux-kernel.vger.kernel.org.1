Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF6B2F4A11
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbhAML0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbhAML0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:26:52 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1D1C0617A6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:25:44 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id k30so909221vsp.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+6c0jaVgiPZUTWx3FWeCKRMV7GRdUXOup2JSIVMvzG8=;
        b=gNXTPYsFPMysLFn3dCllIUoARg68sve0A5NvDm0LecEB74K0w3aX0o3Oy8RftNHLmM
         0UHhr2JZv1DbNSXaaFzvQchVhJZ+PU7RnaDayZiD0UTU05stT6yagTaGsCprysBvazRt
         PuZFGBKck3t/OL500aa3m+GgiD84sDgRi4I9wDnmGo93HA8W01dE5Qbg8B6hDWkpCjU7
         hDBKO9XW6xxvcQdQoNjZ4T4H/fV0j0TXXOjJLPvWM7uq6CJ9SU2bnyzw1oQSrR3GyeTD
         EWIFnQGAWZIrYQRt9NCWN/sOSLoaIFhLsHba1ehQPuHjSBRLZT+pSzfdqpTEe079ZS/d
         UYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+6c0jaVgiPZUTWx3FWeCKRMV7GRdUXOup2JSIVMvzG8=;
        b=NeC3jA/7ZCJO9xPt6u5ehNXx/6ofnJWEp7mwEaed3XoPdzJhOsH1rudUvXvdjJXCRo
         OJ+WdNzby3xTOuf5MJFixA1CLfLekuc7ZakxHOuk511WERukitjly3IQ5Zg6WCcg5HI+
         w6n1gtoDl1H4q3j5WKXTf78SGVMldn7QefU0fg0Ipe2IipCxWUvzI6mQyTwboV+pfPbf
         02tbRpx36izglq5WAGkBxoqQbzfH/dDJ4MUYS5/ejW7VO9s3i+zxTHnPl3hbSo+x5oYn
         6IOsvQIsOvB+2DyI+hYC1YZZWCfelj60jMKGlVTyAHtScpwz2Uzmwx93RLxBNcntk0KQ
         3Giw==
X-Gm-Message-State: AOAM530iioQxKBulVDQUatp6Q9MmSi4G519tyT/god0+kspz5ggmldfF
        TEEAQ7Y5Fit/CakrjIufprNa4/jd6U9RmH1UGWVWOg==
X-Google-Smtp-Source: ABdhPJzBZUATGCHxXNENn1oOCawpmSFAUuZxF8+zv4IBBiT0lha9aGQM7yiT0C4pte1egzsVpJXEtDvM8ee8/7wmcJE=
X-Received: by 2002:a05:6102:2127:: with SMTP id f7mr1456131vsg.48.1610537143857;
 Wed, 13 Jan 2021 03:25:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1608714110.git.hns@goldelico.com> <415ea1cb85eedc12f0c2f70da9a1ae3885bdd091.1608714110.git.hns@goldelico.com>
In-Reply-To: <415ea1cb85eedc12f0c2f70da9a1ae3885bdd091.1608714110.git.hns@goldelico.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 12:25:07 +0100
Message-ID: <CAPDyKFqfUrOy7dKTHE7O4RFpJa9OsPh2XTb3c7b_ukbN55e3cQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: jz4740: remove unused struct component card_detect_irq
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Lee Jones <lee.jones@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Dec 2020 at 10:05, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> I have not found any user for this struct component.
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/jz4740_mmc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index a1f92fed2a55b7..b3c636edbb4610 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -152,7 +152,6 @@ struct jz4740_mmc_host {
>         enum jz4740_mmc_version version;
>
>         int irq;
> -       int card_detect_irq;
>
>         void __iomem *base;
>         struct resource *mem_res;
> --
> 2.26.2
>
