Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D3A283361
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 11:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgJEJfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 05:35:46 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33761 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgJEJfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 05:35:45 -0400
Received: by mail-oi1-f196.google.com with SMTP id m7so8142222oie.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 02:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fOHq8ttm+axOfCqb3gilUIhzEo0SNEuwrnUmi/HXg9U=;
        b=ayjZUsUJNo/Hku8gxkjfwW4zSr4FglBPJtP/VdlavXnPlFuQ+t/yoUz2M9wrAmVhCr
         7F7p1f0qblimMMRiOsPzNFPyMHTbk418B2j8xRnT4XFqR/tO/BQx4fpmBYdWAVYRQEYn
         aME7iERpF/dh3YqZNrnA3x7m7w2uVkSWK4rOLBqqj5HmZYJGPKqR2bzrYKlRLksqJPTW
         +sAVnqEJNGsJYdSlanNgUvCo20nwMEpQY812RwjvUW6vAVCjE7+dXlR+UspEx+3Z9V8K
         zbucboiLWipyAF68fxFkiAC2aQQOJc3iv+QxktF/2QhW3qrbg2dT+LuM1JsdOKpLOfec
         If8w==
X-Gm-Message-State: AOAM530J9bhHRHD9YFhtUPZvmaPUlytMNevexL46utMBYTLviubwUd5r
        SwYj8SRwlG3OH6Z0xKOm7Pxra6ZItzqFh+yNzToDpONlYXQ=
X-Google-Smtp-Source: ABdhPJxQvtVwBT1CE/ubaIowPCNTvuRGIsiC4PHbnUUYk3h8xeBuuUD9hBlEsEMtLK07G31CeRc3ifBGlIs04D/cMr8=
X-Received: by 2002:aca:c490:: with SMTP id u138mr3264897oif.54.1601890544653;
 Mon, 05 Oct 2020 02:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201005093024.16032-1-geert@linux-m68k.org>
In-Reply-To: <20201005093024.16032-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 5 Oct 2020 11:35:33 +0200
Message-ID: <CAMuHMdVqpgro9Qzn39fK9R2-2xDm6LDe6uOB5gSTrdRxbecNXQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.9-rc8
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 5, 2020 at 11:33 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.9-rc8[1] to v5.9-rc7[3], the summaries are:
>   - build errors: +3/-6

  + /kisskb/src/drivers/gpio/gpiolib-cdev.c: error: implicit
declaration of function 'in_ia32_syscall'
[-Werror=implicit-function-declaration]:  => 430:6
  + /kisskb/src/drivers/gpio/gpiolib-cdev.c: error: unknown type name
'compat_u64':  => 432:4

x86_64/um-all{mod,yes}config

  + error: rk3399_gru_sound.c: relocation truncated to fit:
R_NDS32_WORD_9_PCREL_RELA against `.text':  => (.text+0x6a8)

nds32-allyesconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/549738f15da0e5a00275977623be199fbbf7df50/ (all 192 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/a1b8638ba1320e6684aa98233c15255eb803fac7/ (all 192 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
