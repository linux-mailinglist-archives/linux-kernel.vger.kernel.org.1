Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D251E29E8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 20:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgEZSTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 14:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgEZSTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:19:51 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BB8C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 11:19:50 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id n18so10520313pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 11:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QUWGqAktyAyVHVqHB7sEGDJU8Vip0ew9s4nviisTZjU=;
        b=UK4byS9SomgW1uBVGBHJ9uwSnCx9ri/X9BdHgScEhyeiZZoYkwF3afAuHW9nZN3dYt
         buK34zsM7VFhZEBQHinc+3CzabwvZtZ+gtaBJ3Zq1pzZW2cnjY+J3q/tNoMp1mxyAdYT
         V6tzZiGyUOBorKb0rEV1aRVL7zrrtE4XHGdk7Fc36mHiLBxtutdYyffvnVQTUasOVehl
         41Qu7WvMybf6choeBt3gNcUI/v5+30Jk09X6lpaxu3/T4Zm2gPZgn4Zzmxx44YopskD2
         veWwQl2UwncslmMgJB5vhN3WEALjJ8HyI83tW/f+9UGNsX24pPLMAEDKTW3jK17+DST1
         6/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QUWGqAktyAyVHVqHB7sEGDJU8Vip0ew9s4nviisTZjU=;
        b=s1IvUIfJFXhmT3l6nBmmInbImBPtiIw6DEHjbO3iYCPMpOmVvl5UMiKpLXKeSM1bUS
         kfR1Y/WHDypEAf6zYyxilNcSN2YMFaz4Dkfh4HYeDX7Oqhh5kS+iTEyL+nRo+f0kZ2O/
         LqDjr76nNa9Uv/kSle5FHdjv9neh68IsTMQSzY2mfC4S6capZJbP72+//NTmP0ov0VQn
         nc/4yY1tJYgYgtfER+/kBEBDXw21WKLVz7f+eu3tPTWXBZhD6egziZ9RYvIQT1UWS0B7
         3JLB81BBS1+BnhCu+3xsgmvOSBM4VV+rVwc6/hQeBGzMLXjbNRXunP0xBfwR9W/vZDSc
         JSKQ==
X-Gm-Message-State: AOAM532WfsC8m5/ltYiJ9GeapbyGUoMFV7tp0qu2qB1pjyJVC85VdpRd
        5UY5I8r7PzNmsePraCxhgQXKggJQV+qcz7gnUT6sow==
X-Google-Smtp-Source: ABdhPJxvpXi922kx/E0rTAVTJOD5CCWsatBhE5BzJo32JyfBZNoNexeIGUAW8li/1aX7Zk80smUdSP8+SPOAWNpANcc=
X-Received: by 2002:a63:f00d:: with SMTP id k13mr147710pgh.263.1590517189321;
 Tue, 26 May 2020 11:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200413190644.16757-1-natechancellor@gmail.com>
In-Reply-To: <20200413190644.16757-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 26 May 2020 11:19:38 -0700
Message-ID: <CAKwvOdkwQSCr8E3Cx3nBfw8_xsd861a3W8jOt1CCQU-_XJS12Q@mail.gmail.com>
Subject: Re: [PATCH] powerpc/wii: Fix declaration made after definition
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 12:07 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> A 0day randconfig uncovered an error with clang, trimmed for brevity:
>
> arch/powerpc/platforms/embedded6xx/wii.c:195:7: error: attribute
> declaration must precede definition [-Werror,-Wignored-attributes]
>         if (!machine_is(wii))
>              ^
>
> The macro machine_is declares mach_##name but define_machine actually
> defines mach_##name, hence the warning.
>
> To fix this, move define_machine after the is_machine usage.

s/is_machine/machine_is/

With that fixup, you may add my reviewed by tag.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Fixes: 5a7ee3198dfa ("powerpc: wii: platform support")
> Reported-by: kbuild test robot <lkp@intel.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/989
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  arch/powerpc/platforms/embedded6xx/wii.c | 25 ++++++++++++------------

^ I can run Linux on my Wii...think of the possibilities!

>  1 file changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
> index 67e48b0a164e..a802ef957d63 100644
> --- a/arch/powerpc/platforms/embedded6xx/wii.c
> +++ b/arch/powerpc/platforms/embedded6xx/wii.c
> @@ -172,19 +172,6 @@ static void wii_shutdown(void)
>         flipper_quiesce();
>  }
>
> -define_machine(wii) {
> -       .name                   = "wii",
> -       .probe                  = wii_probe,
> -       .setup_arch             = wii_setup_arch,
> -       .restart                = wii_restart,
> -       .halt                   = wii_halt,
> -       .init_IRQ               = wii_pic_probe,
> -       .get_irq                = flipper_pic_get_irq,
> -       .calibrate_decr         = generic_calibrate_decr,
> -       .progress               = udbg_progress,
> -       .machine_shutdown       = wii_shutdown,
> -};
> -
>  static const struct of_device_id wii_of_bus[] = {
>         { .compatible = "nintendo,hollywood", },
>         { },
> @@ -200,3 +187,15 @@ static int __init wii_device_probe(void)
>  }
>  device_initcall(wii_device_probe);
>
> +define_machine(wii) {
> +       .name                   = "wii",
> +       .probe                  = wii_probe,
> +       .setup_arch             = wii_setup_arch,
> +       .restart                = wii_restart,
> +       .halt                   = wii_halt,
> +       .init_IRQ               = wii_pic_probe,
> +       .get_irq                = flipper_pic_get_irq,
> +       .calibrate_decr         = generic_calibrate_decr,
> +       .progress               = udbg_progress,
> +       .machine_shutdown       = wii_shutdown,
> +};
>
> base-commit: 8f3d9f354286745c751374f5f1fcafee6b3f3136
> --

-- 
Thanks,
~Nick Desaulniers
