Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD2C2FCCB4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 09:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbhATI1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 03:27:30 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:34981 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730931AbhATIWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 03:22:48 -0500
Received: by mail-ot1-f48.google.com with SMTP id 36so11103028otp.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 00:22:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RTXeC5aayNTWG15s0puHZNF76pw0KopLItiiCJO0kOQ=;
        b=KkSWZ4qN4LZqk+U5NOiV5IXtDlCxtGKR4MLgsE2tKknD8O3MWimoA+2AEjedSUlSZQ
         UsBZmIGOJnZL7UWg94BMaWl4FQ3dpVLNg6BSLF65q9PtC3LBO9qj1LtmoOgZy9RIJ8Fc
         ekrunzE038EThZC+3Q99VGtsLGDJIaSofY9wUVenjc51vUsOZJwF/TE4PFw5y9a6+OBl
         d2/ws4txi5lVN+d0BIgXnvaEQ5q0pQ1WWxDgUKfTXkNDmWq1pwklt6nRzRaMuWvaIdFM
         sFHREWRPbiuGMx4DWX/neVTLz74TjiqmBpDgA+a04ldxZC1ekvtgLkuZzofKcCuBte86
         jBYw==
X-Gm-Message-State: AOAM531u/aolxoIVQ5KZ1hGJItT4g/S9c/cwLrK9ZneHWX23XHNjNULy
        nrVXWwFL8uG3VrW09DTVXpif8MfEKjJPNpBbrO0=
X-Google-Smtp-Source: ABdhPJxL5N6wcJt6qVIc7MnWrCD+HV3MnF0jSYoMJDcejUYzcgd7QSTfMA5KTzHLd5LSmr1z299EJDfFUqtnk9s2zX8=
X-Received: by 2002:a05:6830:210a:: with SMTP id i10mr6283207otc.145.1611130924295;
 Wed, 20 Jan 2021 00:22:04 -0800 (PST)
MIME-Version: 1.0
References: <20210119080938.1832733-1-geert@linux-m68k.org> <CAAhSdy3woKdo1=sZRO3ua=hK6M8NM7dp3nMFX99dKoUOC6+W5Q@mail.gmail.com>
In-Reply-To: <CAAhSdy3woKdo1=sZRO3ua=hK6M8NM7dp3nMFX99dKoUOC6+W5Q@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Jan 2021 09:21:53 +0100
Message-ID: <CAMuHMdXwrsgQNAF=7cObLw-j7jGvKERPaMd76FJaD2whhGSdrg@mail.gmail.com>
Subject: Re: [PATCH v4] drivers/soc/litex: Add restart handler
To:     Anup Patel <anup@brainfault.org>
Cc:     Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup,

On Tue, Jan 19, 2021 at 9:18 AM Anup Patel <anup@brainfault.org> wrote:
> On Tue, Jan 19, 2021 at 1:40 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Let the LiteX SoC Controller register a restart handler, which resets
> > the LiteX SoC by writing 1 to CSR_CTRL_RESET_ADDR.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> We have SBI System Reset Extension (SRST) in upcoming
> SBI v0.3 spec. Using this SBI extension, you will not require a
> dedicated reboot driver for various projects such as Linux kernel,
> U-Boot, EDK2, FreeBSD kernel, etc.
>
> The OpenSBI v0.9 (released yesterday) already has SBI SRST
> extension implemented so we will just need platform hooks for
> LiteX.
>
> The Linux support for SRST extension is already available on
> LKML so far no comments: https://lkml.org/lkml/2020/11/25/6

Thanks, that would cover RISC-V.
But what about other users of LiteX, like openrisc and powerpc?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
