Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA352BA406
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 08:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgKTH4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 02:56:32 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37038 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgKTH4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 02:56:31 -0500
Received: by mail-oi1-f193.google.com with SMTP id j15so4180568oih.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 23:56:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TPr5T3DZ53wtsCD7JEASyN08meG9A+0KW3mx3nLQ5mo=;
        b=asOIOAvbTybwhuOqFWIBtMZ9JC5nWJn1j8CM7+eglna/7WCYMx9GojfVynlLRQFAR1
         p5wzrbKdcrS/koedDQ7MZf38a3B9mzSSQJoLXvuSXKy+LJAgknBJMA47J0ATILXb8kmb
         hE01ARfAba9r7pPOKsTO2+TPRnpuN3FyWsnULMxZxKDbdIsNfBOASextpXQULB4XLR+2
         ppIEtwjn1adlKA4jqkxQ6QV5QoCyE/KwQrYTzS6nGVxlJl1zmJEpAKDcgf2PK0Uj2FZn
         TeMCCUXuChdh2gFiPC4EU/0EK77EZ40FY3j8F8HfdqO30ukI4cYUWjC0MBBhHdASNwVe
         2A+Q==
X-Gm-Message-State: AOAM5305kuQ3fwe0wVt6yy5VjIgSB+uk//QeZAEyczhG0jWODyEyLpYj
        6ydD6bYPcmY0o+PNIKxJukjUfmrGRpcLcsVm5+8Fq9iJq5s=
X-Google-Smtp-Source: ABdhPJyZmb4gYamiRVU2ky78A95tTLo5XH/hqASKrT7hIKEXikms3FZsct5p8L8AOBT7x+qbjHMti4y80K8qvUq0ur8=
X-Received: by 2002:aca:c3c4:: with SMTP id t187mr5264945oif.148.1605858989557;
 Thu, 19 Nov 2020 23:56:29 -0800 (PST)
MIME-Version: 1.0
References: <0a7b09f5e5f48e270b82041c19e8f20f54c69216.1605847196.git.fthain@telegraphics.com.au>
In-Reply-To: <0a7b09f5e5f48e270b82041c19e8f20f54c69216.1605847196.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 20 Nov 2020 08:56:18 +0100
Message-ID: <CAMuHMdV7m47yAZm0mAo75Z8X=ONuibKMSwhVdpcbEdPqWjpRHw@mail.gmail.com>
Subject: Re: [PATCH] m68k/mac: Refactor iop_preinit() and iop_init()
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 5:51 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> The idea behind iop_preinit() was to put the SCC IOP into bypass mode.
> However, that remains unimplemented and implementing it would be
> difficult. Let the comments and code reflect this. Even if iop_preinit()
> worked as described in the comments, it gets called immediately before
> iop_init() so it might as well part of iop_init().
>
> Cc: Joshua Thompson <funaho@jurai.org>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.11 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
