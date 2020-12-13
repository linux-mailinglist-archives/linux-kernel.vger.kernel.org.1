Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317222D903C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 20:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390532AbgLMTkG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Dec 2020 14:40:06 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44498 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732853AbgLMTj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 14:39:59 -0500
Received: by mail-ot1-f67.google.com with SMTP id f16so13655729otl.11
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 11:39:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9CtsVDwoNbPTm3v5e+HpA6cbwiDsDEPWbKL4B1oehZc=;
        b=AsWh8T6SXFyxZRYWoMdmKTu5RB+55gpBZ2D2OlB/neWv+XVXi8kzoVJAamBoerjIjy
         pWcAQEvw359iEwgoUJZYZAkeuP01PDcDFTGVRR3yrYgp85rvpN9bj5lGezitm2CMaCgA
         YzUNJmt96KpSZwuv0D+hmdkhJHQyeOTOPPZgryAOR0UE6j4BCVmR3HHzT3LXnhh41HAM
         MJ9FJdHC6jJb5E7vqS+fqduTCoJt1BJ98Ag1FG+mzVqwW0uaATuNjgfomLUBcM4IPWNp
         L96xsyp0i/oJXsSvh11YlvM+lgcYunLxl+tD0o7G1aw8pkBNp8/q6By3g8a0QdBXHTNG
         +fpw==
X-Gm-Message-State: AOAM5301je8UJqHPII7K69UwCMEE4ISoAcAHNABSIbs8XAz+dLe9WPFi
        ZESzWQy3+IwlE3X0b16+6bH0zxYgrM1pNy3PlUU=
X-Google-Smtp-Source: ABdhPJwC4wvQQzNa66xLyDbpxyVUlVclWiUrLQIUV9Yw9yMKCbEGzT4yJtkd0MM8nhOTjUfp24qRgmJ/l4peJF8rnLo=
X-Received: by 2002:a05:6830:210a:: with SMTP id i10mr17149997otc.145.1607888359063;
 Sun, 13 Dec 2020 11:39:19 -0800 (PST)
MIME-Version: 1.0
References: <20201213182622.23047-1-vincent.stehle@laposte.net>
In-Reply-To: <20201213182622.23047-1-vincent.stehle@laposte.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 13 Dec 2020 20:39:07 +0100
Message-ID: <CAMuHMdXphVnZneudRR48+asCSGzXDVvBxaAQCtrZ3P-cEGHz4w@mail.gmail.com>
Subject: Re: [PATCH] powerpc/ps3: use dma_mapping_error()
To:     =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@laposte.net>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geoff Levand <geoff@infradead.org>,
        Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 13, 2020 at 8:06 PM Vincent Stehlé
<vincent.stehle@laposte.net> wrote:
> The DMA address returned by dma_map_single() should be checked with
> dma_mapping_error(). Fix the ps3stor_setup() function accordingly.
>
> Fixes: 80071802cb9c ("[POWERPC] PS3: Storage Driver Core")
> Signed-off-by: Vincent Stehlé <vincent.stehle@laposte.net>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
