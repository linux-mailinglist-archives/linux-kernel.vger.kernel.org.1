Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5660C25BC69
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 10:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgICILO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 04:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728223AbgICIKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:10:40 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A909C061246
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 01:10:40 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id b16so1246701vsl.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 01:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9LSujuKc0BRpFIUlAoG3t4WRDvr3ggsu3MS/qx+gqZg=;
        b=F8cahaKlXlYymZy1vM9/LjOB55QfYqrKFz+jtu996q05elSZiM4NT/N2FUhqENkdDS
         p/z6Naq+t4p4sOjc9rOWCu2u1NigD8yO+JXlMBuBZtyBCdEfDOOMwtk9YeAi0BiRMh37
         0cNizsSvb4/1gqjnVsWXsFsjVuFrCowgJeOMM9oaX3pnRyKPZ4Pw2wqwbzAEAQEBr3aZ
         YzFzqehpPSEHkPysCEhZXHec2zTgFZjTY7WcaPzMmME8TmM85odYmBTJfYnaQ0Y8Scg9
         2dCn4+yr0AdNuw9EU4HFZWjjYLsm5OwcnOMYXb2MfuQcwzW0b4yz0P2Hx8XlmGPD+8UG
         kp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9LSujuKc0BRpFIUlAoG3t4WRDvr3ggsu3MS/qx+gqZg=;
        b=IB0H0A5wbvyt6cOBhmiswHGU0bIpa0R927NYOAL4xmCnSfcBTsiB+p3BRwxJ9etdpr
         NiKXQkyxdntLviwfLBcoe+3/VtY9N3ektql0ZrajtLpIQ/7yz/7C6p6/Hi53yrN39Pc9
         TnwyGnGLEoJ3MMdDJw2VvqKHegtN54QFECixtSzZ8Y9HwStTn9IUxwn0ZzzG74RzugYL
         /l1vEYVPGJLfgc4ReUOqKW27VZIzZJlVMiospQOlWODDhGoZRc2AN7GIPC/3aML3Z6Vv
         43qdlsdIEFqCKAKQLypAgYJfdkj75ndNWFRQzWz0Ez9PBvzI2SJOGYs402p/evdunh8q
         y9CA==
X-Gm-Message-State: AOAM532+qS25yNda2VMtHOacx+49vNzUbEs+7X7XOlR70T5KiPnN9Fl5
        LZUUhbjCWcmyqAZlT4uRdv+SzjKj3mL4j9cC+9eW0w==
X-Google-Smtp-Source: ABdhPJyI6yM9cYgRxLstCkc5xLwEf5PvN5GPJ1sq3T0dsqBj666zrIWnBAGaIL6c1jHKd+VdnV6KQIQh4y5v/9ZPk8s=
X-Received: by 2002:a67:8b47:: with SMTP id n68mr837341vsd.50.1599120638807;
 Thu, 03 Sep 2020 01:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200902204847.2764-1-krzk@kernel.org> <20200902204847.2764-2-krzk@kernel.org>
In-Reply-To: <20200902204847.2764-2-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Sep 2020 10:10:02 +0200
Message-ID: <CAPDyKFpQxJ29Rhv=LNzJf8LkpV01EY2Z5-wLPs2fTsraUM=XWQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: s3cmci: Use proper printk format for iomem pointer
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Ben Dooks <ben-linux@fluff.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Sep 2020 at 22:49, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> iomem pointers should be printed with pointer format to hide the
> actual value and fix warnings when compile testing for 64-bit
> architecture:
>
>   drivers/mmc/host/s3cmci.c:1355:46: warning:
>     cast from pointer to integer of different size [-Wpointer-to-int-cast]
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/s3cmci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
> index dcd458649338..3fb597095079 100644
> --- a/drivers/mmc/host/s3cmci.c
> +++ b/drivers/mmc/host/s3cmci.c
> @@ -1352,7 +1352,7 @@ static int s3cmci_state_show(struct seq_file *seq, void *v)
>  {
>         struct s3cmci_host *host = seq->private;
>
> -       seq_printf(seq, "Register base = 0x%08x\n", (u32)host->base);
> +       seq_printf(seq, "Register base = 0x%p\n", host->base);
>         seq_printf(seq, "Clock rate = %ld\n", host->clk_rate);
>         seq_printf(seq, "Prescale = %d\n", host->prescaler);
>         seq_printf(seq, "is2440 = %d\n", host->is2440);
> --
> 2.17.1
>
