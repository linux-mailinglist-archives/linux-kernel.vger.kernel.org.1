Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43331A9A70
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 12:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408611AbgDOK2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 06:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2896469AbgDOKW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 06:22:56 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB62C061A10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 03:22:24 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id 1so1861869vsl.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 03:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LzzdfLUwUBzFYRmKpHR/vr/78mFa7TyklDw5HVocAjI=;
        b=I1dbtE9seuOpci5uQnbnkHGkhrAmN7qweG/vSXEJ+2myJ/NjuLIUlEfkNHUjh4c506
         zro/TedmPpqbKelc/XCRAl09Wa8x+VaDI0YYGZVY//z91gFTicnWaWts+nl51WTgi/+g
         r71FKwUhBsACCxTvdrB0i6mFkQ3wN725EOPkf2QLLNsMx41xy5t88cY35K1hVQMmM47o
         gWnoEZ0hkPslJw8N4RHFLRHvkhQfQd7Hy/62YzyrlMTgk8djWbsqjYJjoV3oQCLc5rVJ
         eu2ofYdKv9gfotYwHAKdkfxcF5FGrl7n/ZSU6rm26UeH6CHXsDsKMinqTZcFXfTOtjZX
         I/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LzzdfLUwUBzFYRmKpHR/vr/78mFa7TyklDw5HVocAjI=;
        b=EH7d8qy/9tkGClQTg9rpdMvbuXcs2AvonwddRXooo2JJ97HgqN5eAhMcN/OMRLEvSO
         wjs8gGzeameRrmq9ZGipSuAtMRI6EQxloIhakqL1x3Kznlyeb+BLuytGh75d2ZiywPyc
         epKNQ7UVZrhkK5YkEFbjlGzYR7E+RG0rK5xsnrumq2oh0COe0rJ0iwtxVMW6mV0owjZi
         td56IjGrmu6E9Et/UUuZ5wCaQ6gJgoOpVE1IkRSTnhWi+nb6xda9m8m8DhQup+WFUqfh
         LoW/qxtFH79PBUK96EpmKljIbenrJkI36/Jz655ubpfEcdQt61GXLRttJCobaCUQDoF7
         dIdw==
X-Gm-Message-State: AGi0PuYQEmutglsnU0hnlDDv2mBFs2widcBducxr5cASKPKOtsW1LRzY
        1zC1p3/mEvxnP7rcWlynDAz82opTCBnrGl12iG9rjQ==
X-Google-Smtp-Source: APiQypKN37l7EKhD4x9xU2qvhkdIXUITkcuPG/U10KjhSNKj8LctO0ixQTgpDqbrESAV0BJVwQJ2C2CFXWsYVjybbzI=
X-Received: by 2002:a67:8b09:: with SMTP id n9mr3621500vsd.191.1586946143715;
 Wed, 15 Apr 2020 03:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200408072105.422-1-yamada.masahiro@socionext.com>
In-Reply-To: <20200408072105.422-1-yamada.masahiro@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Apr 2020 12:21:47 +0200
Message-ID: <CAPDyKFrQkyBk2Xizu8_e-aHj=EzmFbg5TSaYvs66VDaE3hY_fA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci: move SDHCI_CAPABILITIES_1 to a more
 suitable place
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Apr 2020 at 09:21, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> In the SDHCI specification, the Capabilities Register (Offset 0x40h)
> is the 64-bit width register, but in Linux, it is represented as two
> registers, SDHCI_CAPABILITIES and SDHCI_CAPABILITIES_1 so that drivers
> can use 32-bit register accessors.
>
> The upper 32-bit field is associated with SDHCI_CAPABILITIES_1.
>
> Move the definition of SDHCI_CAPABILITIES_1 to the correct place.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/sdhci.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 79dffbb731d3..b786b68e0302 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -220,6 +220,7 @@
>  #define  SDHCI_CAN_64BIT_V4    0x08000000
>  #define  SDHCI_CAN_64BIT       0x10000000
>
> +#define SDHCI_CAPABILITIES_1   0x44
>  #define  SDHCI_SUPPORT_SDR50   0x00000001
>  #define  SDHCI_SUPPORT_SDR104  0x00000002
>  #define  SDHCI_SUPPORT_DDR50   0x00000004
> @@ -236,8 +237,6 @@
>  #define  SDHCI_CAN_DO_ADMA3    0x08000000
>  #define  SDHCI_SUPPORT_HS400   0x80000000 /* Non-standard */
>
> -#define SDHCI_CAPABILITIES_1   0x44
> -
>  #define SDHCI_MAX_CURRENT              0x48
>  #define  SDHCI_MAX_CURRENT_LIMIT       0xFF
>  #define  SDHCI_MAX_CURRENT_330_MASK    0x0000FF
> --
> 2.17.1
>
