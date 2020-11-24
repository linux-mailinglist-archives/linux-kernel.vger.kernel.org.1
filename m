Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87002C2986
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388987AbgKXO0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388969AbgKXO0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:26:09 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C871C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:26:09 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id u24so11144649vsl.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m1U2wkaUC0f5IZsZZi8Kkk8TyQbT4OWSXn4hZYgJ55Y=;
        b=CvzctcsDg3pnJEsZvrPD7+Iu/O5YYdvDGHnAX2dfJzvk2VrXj/NzRCEfAxuKUe5bK+
         rlF4hxdmugezTaknWvwI3TdTHWBElgecI2bPuuCClqNXsKFV9DMyh1bbdGXzzDOV5TfU
         Wqjzn5bWA4jwrgpqIN4EKbUkbf5Ym3aZsgYYRO1nm+FF1FfHbooafKdlxJhylF1FV059
         wiX0TAp+PCzPepo99HE70utr6VRPxUXrqVMIr7qRDeEEWt3H7k33cmjtODyI7a/zmBNn
         Mdzzd0WwcpfH086zf3LI56BeVigPgQjZK2C6mG2HNP9qupEG9/znwm0g3v7I7J6T5GHd
         ygZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m1U2wkaUC0f5IZsZZi8Kkk8TyQbT4OWSXn4hZYgJ55Y=;
        b=M7bL00OfttoZMif9h48EjhoS2O6HeGddv/SKIlQyHE+YFCSWdVaBOQN/YZ26IKNzw4
         zIFZrFv/KOqFtxQ5Zpa5SYgEABP7BZX+Llw07EGtkcn3JeAT3UuANcNUf8EFmXnzYv9h
         yX2uzIp06E0AWnNVsKYXKFd6YHo1mrUZp1kqJm45KKOljdagxZrZu9AFDHkGqZrqhRWT
         s6HtmJZXfFTfYoVE8h517BEzXq7sfJTDv/4GMuloASBZL1DOS6vnlGX6Lb7xx5MaLYwr
         9UhzP7Kp4oyKSm0lbZvzeeZ2q5WYnapJ5CGG5+fgdX2DME7l7TkPK0Qmp4PM7WEUbjGP
         tWDA==
X-Gm-Message-State: AOAM5303eUQPFbWalfVWD0A7QZLeIZHhNt1WQXWasoeNbpU/kDztAWkd
        acXUSr6WPAn6FWfckBULrmvT/6C/YE2o+24JYIyaXA==
X-Google-Smtp-Source: ABdhPJw/ERvoKk25DcbRx82AXlOgMkvACdtGdBV2dih2YSXMDeqqhB/n6E4pDzIryXosLG2RNaPoJdh2Myh7KD+v76c=
X-Received: by 2002:a67:8c44:: with SMTP id o65mr3388053vsd.55.1606227968648;
 Tue, 24 Nov 2020 06:26:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605896059.git.gustavoars@kernel.org> <387cab3a466038aa5d1fc34b8b6a7c4f693826ea.1605896060.git.gustavoars@kernel.org>
In-Reply-To: <387cab3a466038aa5d1fc34b8b6a7c4f693826ea.1605896060.git.gustavoars@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Nov 2020 15:25:32 +0100
Message-ID: <CAPDyKFpkQBzryACA3et_RGk2hcMUK=j_fiycykdjCNfur6h45g@mail.gmail.com>
Subject: Re: [PATCH 098/141] mmc: sdhci-of-arasan: Fix fall-through warnings
 for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 at 19:37, Gustavo A. R. Silva <gustavoars@kernel.org> wrote:
>
> In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
> warnings by explicitly adding multiple break statements instead of
> letting the code fall through to the next case.
>
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 829ccef87426..1f7e42b6ced5 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -627,6 +627,7 @@ static int sdhci_zynqmp_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
>         case MMC_TIMING_MMC_HS200:
>                 /* For 200MHz clock, 8 Taps are available */
>                 tap_max = 8;
> +               break;
>         default:
>                 break;
>         }
> @@ -695,6 +696,7 @@ static int sdhci_zynqmp_sampleclk_set_phase(struct clk_hw *hw, int degrees)
>         case MMC_TIMING_MMC_HS200:
>                 /* For 200MHz clock, 30 Taps are available */
>                 tap_max = 30;
> +               break;
>         default:
>                 break;
>         }
> @@ -760,6 +762,7 @@ static int sdhci_versal_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
>         case MMC_TIMING_MMC_HS200:
>                 /* For 200MHz clock, 8 Taps are available */
>                 tap_max = 8;
> +               break;
>         default:
>                 break;
>         }
> @@ -831,6 +834,7 @@ static int sdhci_versal_sampleclk_set_phase(struct clk_hw *hw, int degrees)
>         case MMC_TIMING_MMC_HS200:
>                 /* For 200MHz clock, 30 Taps are available */
>                 tap_max = 30;
> +               break;
>         default:
>                 break;
>         }
> --
> 2.27.0
>
