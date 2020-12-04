Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8512CEBD2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 11:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388071AbgLDKEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 05:04:22 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45753 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388059AbgLDKEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 05:04:21 -0500
Received: by mail-ot1-f68.google.com with SMTP id h18so656773otq.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 02:04:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GLHkAaCfT5pWLivXy5Xgz7u2ThT5u7Up7pqYnjb3zk4=;
        b=r7wRhnDa36wMElIeRzQu6LYuOHGGk3wzvBlzSck5cVlaaT+I9lKkguYrrlXNn3datH
         O3HoLU4H05JbpXQo0A642hFpp69/oXCSPkftrj4Bf783xtlqE+R/VNsZguv9x1OQfxiY
         iZvzXDYD2wt40c0WWpIn/QHblYN2wxQfp6lGhG5inktgipJA2MPzGjuOSxJABAziYmfP
         M8vX6txgXLtbcPStPBkKEaf78q9h3U+uaxM+z7XwiwqloTE409mUQi7NRdlTsDbHrEuz
         JXLsio1qlINmd2/DfDURf77QPAlzdLwFt3JSy8YWFpmbQxm/KtMvN00M1BaoG5Zdr99H
         YFUg==
X-Gm-Message-State: AOAM533H8wELSFx3N2pQRroPtnPB3ZFhqAQKApJEH5tlo6Nn+cRjZSo5
        QZqTVslIDWuun7YUMltu6AUVU39LBReHKDpkqnfyYY/ATzA=
X-Google-Smtp-Source: ABdhPJwneqGTjDCkbUTC2ItnGioumAlpRvEPmt3RmzMhCsLQ/Q/or7PoHA7wd7YwsmnMcli7X16du4mh6qdRhD9gAXg=
X-Received: by 2002:a9d:2203:: with SMTP id o3mr3024405ota.107.1607076220971;
 Fri, 04 Dec 2020 02:03:40 -0800 (PST)
MIME-Version: 1.0
References: <58bba4310da4c29b068345a4b36af8a531397ff7.1605847196.git.fthain@telegraphics.com.au>
In-Reply-To: <58bba4310da4c29b068345a4b36af8a531397ff7.1605847196.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 4 Dec 2020 11:03:30 +0100
Message-ID: <CAMuHMdVYf83+y1aUR6HqCgr-CLfWYvbuynpfogLrt3cXA-9_aA@mail.gmail.com>
Subject: Re: [PATCH] macintosh/adb-iop: Send correct poll command
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joshua Thompson <funaho@jurai.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Fri, Nov 20, 2020 at 5:54 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> The behaviour of the IOP firmware is not well documented but we do know
> that IOP message reply data can be used to issue new ADB commands.
> Use the message reply to better control autopoll behaviour by sending
> a Talk Register 0 command after every ADB response, not unlike the
> algorithm in the via-macii driver. This poll command is addressed to
> that device which last received a Talk command (explicit or otherwise).
>
> Cc: Joshua Thompson <funaho@jurai.org>
> Fixes: fa3b5a9929fc ("macintosh/adb-iop: Implement idle -> sending state transition")

WARNING: Unknown commit id 'fa3b5a9929fc', maybe rebased or not pulled?

32226e817043?

> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Thanks, will queue in the m68k for-v5.11 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
