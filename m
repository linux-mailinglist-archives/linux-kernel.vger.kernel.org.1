Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2392E2F1053
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 11:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbhAKKov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 05:44:51 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:36661 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbhAKKou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:44:50 -0500
Received: by mail-ot1-f48.google.com with SMTP id d20so16480065otl.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 02:44:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4fymldqGOkaY/X4BCR3dG+yWyFLPZhv3fozV8pGd9vo=;
        b=S1kHnCAV3ZU19h64W3seHu+/rNGnN7Qyz6kFPYw8jsl8Nz47vCuFH/nDiJHS5fi8Z1
         JD9pfkA3rgYCZIi+5Yu16BDqwpomM/ycE2E377TtR2RzmBZDUG0kHxCpXj8WTC9ML/iA
         kGTglcNwh5i0fD1T+d3w0jKkElTNCDjlcqzO3NpioYP/5aA8a35b836FL+T2CKakj7y/
         qY/2qeuJvILtvhfcmutcaP6P4h7HH3LUa4YVXMap6Sm5kcecfYvbCmburtffraNqQWe/
         rHw9MrDufpALyXWmexNAar+PFujABU3KvJ9lwkM6C6n7jdg5jbnDn0RmvxVAcPrgXyY7
         jppQ==
X-Gm-Message-State: AOAM532wRexoSw6BvUZWqiufRDaettwvGxaZxJqydzHXCfoe00rOEqBe
        WJ2zaEnvX43ZQUJbl6FT4pC3439Db3d35Rt8sWRLsGUjgPY=
X-Google-Smtp-Source: ABdhPJzTU2LJmOP3WoA1NHl+ZSVivudIdUUh+05rYA5QPpwYm2msxc8AR1nIF5KUOT2s1cFIdIN58XLbP5cFYslBr0E=
X-Received: by 2002:a9d:c01:: with SMTP id 1mr10382183otr.107.1610361849532;
 Mon, 11 Jan 2021 02:44:09 -0800 (PST)
MIME-Version: 1.0
References: <20210111103956.290378-1-geert+renesas@glider.be>
In-Reply-To: <20210111103956.290378-1-geert+renesas@glider.be>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Jan 2021 11:43:58 +0100
Message-ID: <CAMuHMdVXdH+2tgS9rUNqwZwRsGjiecW1t1_sJJLJRhpTuzPxcQ@mail.gmail.com>
Subject: Re: [PATCH] ntp: Fix RTC synchronization on 32-bit platforms
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 11:40 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Due to an integer overflow, RTC synchronization now happens every 2s
> instead of the intended 11 minutes.  Fix this by forcing 64-bit
> arithmetic for the sync period calculation.
>
> Fixes: c9e6189fb03123a7 ("ntp: Make the RTC synchronization more reliable")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  kernel/time/ntp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
> index 7404d38315276a96..54d52fab201d283e 100644
> --- a/kernel/time/ntp.c
> +++ b/kernel/time/ntp.c
> @@ -498,7 +498,7 @@ int second_overflow(time64_t secs)
>  static void sync_hw_clock(struct work_struct *work);
>  static DECLARE_WORK(sync_work, sync_hw_clock);
>  static struct hrtimer sync_hrtimer;
> -#define SYNC_PERIOD_NS (11UL * 60 * NSEC_PER_SEC)
> +#define SYNC_PERIOD_NS (11ULL * 60 * NSEC_PER_SEC)
>
>  static enum hrtimer_restart sync_timer_callback(struct hrtimer *timer)
>  {

While the line

    exp = ktime_add_ns(exp, 2 * NSEC_PER_SEC - offset_nsec);

is currently not an issue, it may be wise to change it to

    exp = ktime_add_ns(exp, 2ULL * NSEC_PER_SEC - offset_nsec);

in case someone wants to experiment with values larger then 4s?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
