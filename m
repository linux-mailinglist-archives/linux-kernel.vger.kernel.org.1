Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF821AA2AA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 15:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505668AbgDOM7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 08:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2505617AbgDOM54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 08:57:56 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552E3C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 05:57:56 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id g10so1264755uae.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 05:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r5sKn1JJVgm/fgQdr3rP8MdzsVK7nHhD8/ZfpnREROo=;
        b=G5O0ZNtI/lhvh2YbkeigqevONdPcJNyW36RJu6DaCTNULDY22D+wXKMjJdQd7KvBlv
         oTfthgAY1md6uAa3CEIDnutbFslq3+BYX7QggVz2V1zExH2exyxZetM5k1rTefLCgxtV
         iEpyKNYDo1nRA4Kq2/WKGKWa+NsM6AH3OujDgWXJRfQ0THNzaeyfZm9/dmFGqES1rja2
         m3zdbshttS6S6hL/oRkv/+nmnvpjca3VwFla3S0Tdd9HW7J9kmiObkbehxG3ekM93FcZ
         TUuwjMSuHc2pY+a8zt7Vfd5qR/ryC85oOzXRlBbFLTsUE6VyIrnCLTKqW55P49wf09wY
         8Iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r5sKn1JJVgm/fgQdr3rP8MdzsVK7nHhD8/ZfpnREROo=;
        b=FPtyoWZQ/ko2zMfpA02hP8pFSdxh2b7TWgMqfdXBiAx9psG+AmIfUqTzLHWi4vu3wm
         5no8NgcK7otPk1whdLxWS0ldwK9bRXUszCQ/mHBNqs45VU2f3YU9Ja2z/Fpw/usHpWXI
         IUiBP7RKKJF2Nu0jOZHp/MoVlXdbJY1Rg1t+EY3DuBhHc4TFL6UHoS6N20tCboJsIvT5
         qR9689Ms2MOyxNqk6S3sY3ABczZooVwznsQixLs/KeaAP2ShAG6Ri7DgtYQ3Yy0yBsht
         x00NtQpeirkD1CCfYcA0/fKCJnwB/9v40XXV5iTGqa2+H5ofVHUvJpIq2w5oIwr3rxyf
         Il9A==
X-Gm-Message-State: AGi0PuZAHDLfCiJB0arlJSpZf2jrgn/KzNpXOHUWPV2LRP3+EkxRanwu
        OXAyf62IBwl92DKOETLI4tR6dZCi1DJ50pYQWcEOOg==
X-Google-Smtp-Source: APiQypJI7c0NMJgUbFRtW4uPDq40cfg0SP5CzG4iio6GHzdHCd5X+k9Oy9LawY1QGN7bl3rJK38vw1RGEuY06aeP87Q=
X-Received: by 2002:ab0:6449:: with SMTP id j9mr4172749uap.19.1586955475320;
 Wed, 15 Apr 2020 05:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200410213043.1091851-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20200410213043.1091851-1-martin.blumenstingl@googlemail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Apr 2020 14:57:19 +0200
Message-ID: <CAPDyKFpsTTUaTLy--DvOr0oAB71cTBdH1pfTV63LtcKOKOsnDw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: meson-mx-sdio: Set MMC_CAP_WAIT_WHILE_BUSY
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Apr 2020 at 23:30, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> The Meson SDIO controller uses the DAT0 lane for hardware busy
> detection. Set MMC_CAP_WAIT_WHILE_BUSY accordingly. This fixes
> the following error observed with Linux 5.7 (pre-rc-1):
>   mmc1: Card stuck being busy! __mmc_poll_for_busy
>   blk_update_request: I/O error, dev mmcblk1, sector 17111080 op
>    0x3:(DISCARD) flags 0x0 phys_seg 1 prio class 0
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> I'm sending this as RFC because I'm not sure if this is a proper fix.
> It "fixes" the issue for me but I want the MMC maintainers to double-
> check this.

Thanks for sending this! I assume it's a regression and caused by one
of my patches that went in for 5.7. Probably this one:
0d84c3e6a5b2 mmc: core: Convert to mmc_poll_for_busy() for erase/trim/discard

Now, even if enabling MMC_CAP_WAIT_WHILE_BUSY seems like the correct
thing to do, I suggest we really try understand why it works, so we
don't overlook some other issue that needs to be fixed.

Would you be willing to try a few debug patches, according to the below?

First, can you double check so the original polling with CMD13 is
still okay, by trying the below minor change. The intent is to force
polling with CMD13 for the erase/discard operation.

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index baa6314f69b4..bbf1dff0ae2a 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -452,7 +452,7 @@ static int mmc_busy_status(struct mmc_card *card,
bool retry_crc_err,
        u32 status = 0;
        int err;

-       if (host->ops->card_busy) {
+       if (host->ops->card_busy && busy_cmd != MMC_BUSY_ERASE) {
                *busy = host->ops->card_busy(host);
                return 0;
        }
-- 

Second, if the above works, it looks like the polling with
->card_busy() isn't really working for meson-mx-sdio.c, together with
erase/discard. To narrow down that problem, I suggest to try with a
longer erase/discard timeout in a retry fashion, while using
->card_busy(). Along the lines of the below:

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 4c5de6d37ac7..240e52fcdf2d 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1746,6 +1746,11 @@ static int mmc_do_erase(struct mmc_card *card,
unsigned int from,

        /* Let's poll to find out when the erase operation completes. */
        err = mmc_poll_for_busy(card, busy_timeout, MMC_BUSY_ERASE);
+       if (err) {
+               pr_err("%s: Erase poll failed err=%d timeout_ms=%u - retry!\n",
+                       mmc_hostname(host), err, busy_timeout);
+               err = mmc_poll_for_busy(card, 30000, MMC_BUSY_ERASE);
+       }

 out:
        mmc_retune_release(card->host);
-- 

Let's see what this gives us...

Kind regards
Uffe

>
>
>  drivers/mmc/host/meson-mx-sdio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
> index 8b038e7b2cd3..fe02130237a8 100644
> --- a/drivers/mmc/host/meson-mx-sdio.c
> +++ b/drivers/mmc/host/meson-mx-sdio.c
> @@ -570,7 +570,7 @@ static int meson_mx_mmc_add_host(struct meson_mx_mmc_host *host)
>         mmc->f_max = clk_round_rate(host->cfg_div_clk,
>                                     clk_get_rate(host->parent_clk));
>
> -       mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23;
> +       mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY;
>         mmc->ops = &meson_mx_mmc_ops;
>
>         ret = mmc_of_parse(mmc);
> --
> 2.26.0
>
