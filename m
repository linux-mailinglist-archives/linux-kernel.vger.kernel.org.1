Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A3C29F9FF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 01:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgJ3AvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 20:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ3AvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 20:51:00 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FCCC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 17:40:56 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id o129so3806393pfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 17:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t04LAB4/uHC3GHWy32ADQEmYDaM2o62QHxLiFW9vSfE=;
        b=Aeft59JMItTB9GP3MIm5jonpoCFuLKrOVKfksHFfagiD+7DjTGrR69c+FUQ62o0e/Z
         ZPcDhryq7vr/O0awAr4yiM5DGdQ2wUxbL05EQD7n+yAmS5Ie7n2MwlcNTDlkF4bNPQAh
         divlvT3ml1VGZm0J8SBl4J9RuOXOxMwizrcBgFeG9VevlwYVRre0FSUgtLuqu+4q1fmr
         SV9UJ2fNqLs1BctWPZe8/NfjmnRYy+hrxL+OLMmcOI9S7r1LiThZENxoh2/UAPNmGCuH
         FKRaQdUnm9a/HhzZRu3cICIh4UrByAD2CNo32i6oJfDnOW26MWbOeaA44LAxH+Op1DAK
         ktQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t04LAB4/uHC3GHWy32ADQEmYDaM2o62QHxLiFW9vSfE=;
        b=BtftFyNInwxN37N7ONdq4Sw7g/vV37GIFbh7ZhlWyTmGIxvpleJcwn3kK2E3sG4+jw
         ZVIruH5M2SSfAi99GJ37IWrOXaiyT+8SLINp9WdzPlRuw5W40PWCrroOo6kP4T05Ge4g
         VZXkHCWxsMKI9yVF5LIztTjT5buQppF0IpCjdCXMD4pBAjvkXRAOD+qivEiwq2cLyRKF
         F/WbLuv/DAXEzlAqeH/NTbGYUm8/di6nlqpANNeOSxfDNbgoo2p/YxotVCTe7WqSHOok
         SVZeITF2Jg/nk0ZYlFKh15fdwgxG5iS8MZNaSk/REV/fv/0qX3yZzTblCNGlbsyO76wp
         Zvqw==
X-Gm-Message-State: AOAM532JaUjqOOitkKsAEnTivBDRMm7IdVrR6CVssr+jAAWZebwEaLUQ
        E4g+Mne7F0bb5/RiUif+Vjl9oyAKxWiofgzK8bAkeT//F6JFGQ==
X-Google-Smtp-Source: ABdhPJwtaID4D19g+FPm5kX0gbRn8OQJAMDr7PR/Z7ZuVuxijPrn9M2GpI/9pTEehwjK1dlufpinkTKSnuCKG254O6U=
X-Received: by 2002:a63:2f41:: with SMTP id v62mr6132224pgv.10.1604018456312;
 Thu, 29 Oct 2020 17:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20201029193357.389593-1-krzk@kernel.org>
In-Reply-To: <20201029193357.389593-1-krzk@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 29 Oct 2020 17:40:43 -0700
Message-ID: <CAKwvOdnKgWN4D0_py00__AaTT+xGK3mjGYPDvBVykw6g=1845A@mail.gmail.com>
Subject: Re: [PATCH] memory: pl353-smc: fix compile test on !ARM_AMBA
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        naga.sureshkumar.relli@xilinx.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ authors/reviewers of commit fee10bd22678 ("memory: pl353: Add driver
for arm pl353 static memory controller")

On Thu, Oct 29, 2020 at 12:34 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The pl353-smc driver uses module_amba_driver so it has a build
> dependency on CONFIG_ARM_AMBA:
>
>     /usr/bin/arm-linux-gnueabi-ld: drivers/memory/pl353-smc.o: in function `pl353_smc_driver_init':
>     pl353-smc.c:(.init.text+0x10): undefined reference to `amba_driver_register'
>
> However it still can be compile tested on platforms other than ARM,
> which in practice is limited to those selecting ARM_AMBA (so only
> ARM64).
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: ea0c0ad6b6eb ("memory: Enable compile testing for most of the drivers")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/memory/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index 00e013b14703..eebd2ddcd860 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -191,8 +191,8 @@ config DA8XX_DDRCTL
>  config PL353_SMC
>         tristate "ARM PL35X Static Memory Controller(SMC) driver"
>         default y if ARM
> -       depends on ARM
> -       depends on ARM_AMBA || COMPILE_TEST
> +       depends on ARM || COMPILE_TEST
> +       depends on ARM_AMBA
>         help
>           This driver is for the ARM PL351/PL353 Static Memory
>           Controller(SMC) module.
> --
> 2.25.1
>


-- 
Thanks,
~Nick Desaulniers
