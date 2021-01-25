Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB6F302312
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 10:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbhAYJA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 04:00:59 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:41083 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbhAYImu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 03:42:50 -0500
Received: by mail-oi1-f181.google.com with SMTP id m13so6012743oig.8;
        Mon, 25 Jan 2021 00:42:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zmj0pdUkoSOT9BVVzR68XbIFYjfQOs5SmAGy80cJE7o=;
        b=Z44rU/wlfJSroV8sJ0m8ziX6jvyZwMUbmsBUAGP1Qfm2CyCAWMQLXT/zkGJH37+Yha
         bT+gmH8hSN9e1xCJNN8FwJdovbomeZBziDULjFBPA5tTbvQ9ynMEkI6qZPAW5FPYpIX5
         7RbWzA1lshd0uRhc5AHPdW1eiVQlIdBDbh4xib0iLEtElr74LGehSZ7+JpluQFV3x4DY
         7VNlOhep0GqL7kZVL0z/iMgthn5HaXw1WwaOjgUlm5I1NQf0Vjs+Y4IWnZpduAyc2DRQ
         ykSveUudPhCOSQw8z+SwDoGc4fy/wsXyGtWEjBPoZ9WLbnNDkE+EwQpOlY4UBQXgqGaW
         MYmQ==
X-Gm-Message-State: AOAM532ZI8UN48JFjIqHNBvu7aqg9T+Qdtb4fI1nCisgpbTTM1hVESW+
        AhivUjxIauAX+KVUfuLEuWOiEgZigNGpYxD1Zg678BBnoEM=
X-Google-Smtp-Source: ABdhPJyTWLWZmMxdcI7462DBg5yWwgpm5xCAF4I7k9Dy02CzyoVSjGxhTP9XQyrZv3WdwrMDaYqkqjDiNAkBv7iEDKY=
X-Received: by 2002:aca:1219:: with SMTP id 25mr524863ois.54.1611563618938;
 Mon, 25 Jan 2021 00:33:38 -0800 (PST)
MIME-Version: 1.0
References: <20210123034428.2841052-1-swboyd@chromium.org> <20210123034428.2841052-7-swboyd@chromium.org>
In-Reply-To: <20210123034428.2841052-7-swboyd@chromium.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Jan 2021 09:33:28 +0100
Message-ID: <CAMuHMdVaZ1L0n=bFB=__xYwpw6q+fa0U+CuLBpSgDy0djPjwFA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] of/device: Don't NULLify match table in
 of_match_device() with CONFIG_OF=n
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 23, 2021 at 4:44 AM Stephen Boyd <swboyd@chromium.org> wrote:
> This effectively reverts 1db73ae39a97 ("of/device: Nullify match table
> in of_match_device() for CONFIG_OF=n") because that commit makes it more
> surprising to users of this API that the arguments may never be
> referenced by any code. This is because the pre-processor will replace
> the argument with NULL and then the match table will be left unreferenced
> by any code but the compiler optimizer doesn't know to drop it. This can
> lead to compilers warning that match tables are unused, when we really
> want to pass the match table to the API but have the compiler see that
> it's all inlined and not used and then drop the match table while
> silencing the warning. We're being too smart here and not giving the
> compiler the chance to do dead code elimination.
>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> Acked-by: Frank Rowand <frowand.list@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
