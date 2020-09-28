Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF8527ABDA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgI1KeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgI1KeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:34:23 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436A9C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 03:34:23 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id w25so440368vsk.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 03:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xjY5fl6HDUc2l2AlN3kkW97cFvPBmXB5YCuUUeD53nc=;
        b=dwxgsAPacWj3Zit0Jujndz7E4Df0ipLAkZz/tcbg9k5eGQTht5hufz6yk0diRTvxvb
         lZ8KElcdi6kMTNq0CjpUnjaq4PhxXJr/9OTAFbwTrVjJ5ALLe2q5DybPo0EKN4JZzY3o
         H3qdGoIxtuLpyHrZ7/b/mgL79+jtxo4t2UjEzLwK5S7Dcnb2npoKHR5D/hkRyEMzpnNC
         IqUiW4KTf5mxsScegxgKFyUPFkA/VI1BLgsR7sZURdfySkLe1e4O9E9FXcpW3PZd3Ldy
         TcoIlzVUhm58zR8KJ0O8bp5i/vinc1kA/o1YGBXZ5gduFfRFCDQlKnpEXdhedTW3RXOY
         Dl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xjY5fl6HDUc2l2AlN3kkW97cFvPBmXB5YCuUUeD53nc=;
        b=iQjgArbniVj7ZUmC6So49LEri0cBoWQSuNHvn9VvQFSeSML43eeXlsCmaZdHPfTZah
         R3TB6dLONeKR9zcsMH5vU5kIEWn72V+846463tScmuHfBfLk+zkRQ1nbtoYfcqJTNXpf
         3aGzgl64B26k8YmKL9rO0lMl9da1SoHReCFEiqeWSKtEazrP6plDmj3ZNHgR59jlk0Ss
         3fHcSm3080mzR5p7tsrCehQfhsuU/PsYh1YHZLGhAfa24scmM0r865C0k3ytlliyk7Vi
         L1oSLTywPSZS8/FdmAIOso2wJRAtMKsuxV7BfSHxH/clFavzlzMZxikTbZpABqTUkBud
         3+CQ==
X-Gm-Message-State: AOAM5337OOiOF1vtapDF7bBjdr6DiMb1a+DOOUKo2RrBH3psGpfE54RI
        t9lIv2Q/JNNO5PjkJxHQS7javhI/xuzXUuqcMIJL4w==
X-Google-Smtp-Source: ABdhPJwgHSw05IQH/Ec+pjLgUHnUYITQ5+QWCFsMcaLoHkMxNOjsErxsHQw3gDiApRWk/zhYp3IVUl4BPWGQM7owzww=
X-Received: by 2002:a67:ec9a:: with SMTP id h26mr5011637vsp.34.1601289262461;
 Mon, 28 Sep 2020 03:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200925084952.13220-1-kai.heng.feng@canonical.com>
In-Reply-To: <20200925084952.13220-1-kai.heng.feng@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Sep 2020 12:33:45 +0200
Message-ID: <CAPDyKFpRs1xSMj5UmV1PW_9sQBVNUABySxg-e4y+m7Sn4fYsPQ@mail.gmail.com>
Subject: Re: [PATCH] memstick: Skip allocating card when removing host
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        "open list:SONY MEMORYSTICK SUBSYSTEM" <linux-mmc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Sep 2020 at 10:49, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>
> After commit 6827ca573c03 ("memstick: rtsx_usb_ms: Support runtime power
> management"), removing module rtsx_usb_ms will be stuck.
>
> The deadlock is caused by powering on and powering off at the same time,
> the former one is when memstick_check() is flushed, and the later is called
> by memstick_remove_host().
>
> Soe let's skip allocating card to prevent this issue.
>
> Fixes: 6827ca573c03 ("memstick: rtsx_usb_ms: Support runtime power management")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/memstick.c | 4 ++++
>  include/linux/memstick.h         | 1 +
>  2 files changed, 5 insertions(+)
>
> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
> index 693ee73eb291..ef03d6fafc5c 100644
> --- a/drivers/memstick/core/memstick.c
> +++ b/drivers/memstick/core/memstick.c
> @@ -441,6 +441,9 @@ static void memstick_check(struct work_struct *work)
>         } else if (host->card->stop)
>                 host->card->stop(host->card);
>
> +       if (host->removing)
> +               goto out_power_off;
> +
>         card = memstick_alloc_card(host);
>
>         if (!card) {
> @@ -545,6 +548,7 @@ EXPORT_SYMBOL(memstick_add_host);
>   */
>  void memstick_remove_host(struct memstick_host *host)
>  {
> +       host->removing = 1;
>         flush_workqueue(workqueue);
>         mutex_lock(&host->lock);
>         if (host->card)
> diff --git a/include/linux/memstick.h b/include/linux/memstick.h
> index da4c65f9435f..ebf73d4ee969 100644
> --- a/include/linux/memstick.h
> +++ b/include/linux/memstick.h
> @@ -281,6 +281,7 @@ struct memstick_host {
>
>         struct memstick_dev *card;
>         unsigned int        retries;
> +       bool removing;
>
>         /* Notify the host that some requests are pending. */
>         void                (*request)(struct memstick_host *host);
> --
> 2.17.1
>
