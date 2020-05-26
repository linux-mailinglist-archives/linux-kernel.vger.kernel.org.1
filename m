Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331031C584C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 16:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgEEOMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 10:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729089AbgEEOMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:12:45 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C501C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:12:45 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x10so2070963oie.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 07:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yjm2cmKVuwlkstPxfFd5MfjFWk/J8R1nDWAUw4Id7r8=;
        b=gSAzcE/ceHx3DD0GHkL/zUqm0ntyLCzjEfid4HO8kPLsHnWLW/F0L8YI2ve23ScdUX
         SR0Z5J4h4hYUhRAu0sf2GUNqwtltdFruppAAsoH8zwvvowS4uwWSYI6fT1Q8LSRLegaC
         J6UdM/icnIHrSTh/q0fEzggv34Jrmx9+Lr8NMLddFudUi4U5QiM/RI/uAJB0oFvMPzbz
         izKi+kCspKWbqnxBLxwB8Elc4lL3Z7ABEXerd1WoTedVc/o4SczYSK0prr4dF5Pix0w4
         ogM72D79j8OK39H5K1HkLXMQe39tDXPeZsYE5K/oiYsHvpadvrMniPLWrvwerrWTx8oq
         1Nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yjm2cmKVuwlkstPxfFd5MfjFWk/J8R1nDWAUw4Id7r8=;
        b=ubqbrrwj2L1KzaBb6KNJS724MEF/jLfAyfFmNRwPAylClV3Lda2fcVZTqqRyd+Nsmg
         P4b23Its5IxCh6wRTdc7qQRwix7nfCpvvEJ/MmXOoBVHgrd1u+y1np2UZKUYqmz2S8ui
         GbZXJ6S0jJldKn9UknHt06c+UH48pd7UJ7xuoaeubKPrsFJV3K7QTEVL7qtLC71Wu4ml
         9JJNOl6FFO94p1C4at/Uti51JP4uGXrl90LG8dD3wW9wC8jonKv3+0Br5NlnOiwO+zAR
         vkBFPLvh17eiejAacgkGjiB3Xc0U8leQQDAXV8S7ikvPbBiblP65wfB8TnlaK+Md3WQl
         S/uQ==
X-Gm-Message-State: AGi0PuaLvmNTrMIsrlUEedIu4NxLRjm8H+3dqIfPvVFMXc09sYxckbey
        VGq5dhT1g/gXaCYvnDa/fVTyntn5nvjU66iuqGdPSQ==
X-Google-Smtp-Source: APiQypIAywvPjEF+eFOU7gfeqV9lG2oqecVKyu+ef21qclXSvVG9C5gqW2wVY/N0EBRjBC6fH8Vm74uN5E+0Jr0Owmg=
X-Received: by 2002:aca:1c08:: with SMTP id c8mr2558360oic.172.1588687963483;
 Tue, 05 May 2020 07:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200505140407.373983-1-arnd@arndb.de>
In-Reply-To: <20200505140407.373983-1-arnd@arndb.de>
From:   Marco Elver <elver@google.com>
Date:   Tue, 5 May 2020 16:12:30 +0200
Message-ID: <CANpmjNNw6M9Gqj6WGTHH4Cegu8roTVu5x6Vqs_tCBxX3gPwL4A@mail.gmail.com>
Subject: Re: [PATCH] omapfb: don't annotate dss_conv_list as __initdata
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 May 2020 at 16:04, Arnd Bergmann <arnd@arndb.de> wrote:
>
> With the kcsan changes, __read_once_size() is not inlined, but
> clang can decide to emit a version that hardcodes the address, which
> in turn triggers a warning for dss_conv_list being __initdata but
> __read_once_size() not being __init:
>
> WARNING: modpost: vmlinux.o(.text+0x6e4d7a): Section mismatch in
> reference from the function __read_once_size() to the variable
> .init.data:dss_conv_list
> The function __read_once_size() references
> the variable __initdata dss_conv_list.
> This is often because __read_once_size lacks a __initdata
> annotation or the annotation of dss_conv_list is wrong.
>
> This is clearly a false positive warning, but it's hard to tell
> who is to blame for it. Work around it by removing the __initdata
> annotation, wasting the space of two pointers in return for getting
> rid of the warning.
>
> Fixes: dfd402a4c4ba ("kcsan: Add Kernel Concurrency Sanitizer infrastructure")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

[+Cc Will]

I think Will is working on a series that completely overhauls
READ_ONCE/WRITE_ONCE, also getting rid of __read_once_size() in the
process, which would make this patch redundant. If we can live with
this warning until the new READ_ONCE/WRITE_ONCE gets merged, we can
probably keep things as-is for now.

Thanks,
-- Marco

> ---
>  drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c b/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c
> index 0ae0cab252d3..29fdff9c95f6 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c
> @@ -19,7 +19,7 @@
>  #include <linux/slab.h>
>  #include <linux/list.h>
>
> -static struct list_head dss_conv_list __initdata;
> +static struct list_head dss_conv_list;
>
>  static const char prefix[] __initconst = "omapdss,";
>
> --
> 2.26.0
>
