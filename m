Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342982DF5AC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 15:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbgLTO3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 09:29:10 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:46953 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbgLTO3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 09:29:09 -0500
Received: by mail-ot1-f54.google.com with SMTP id w3so6539573otp.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 06:28:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KF5+wP+7KlD78JIfhqBLESbVDiU8JmERcp1ag/IZslk=;
        b=Aykkh7B7s3nw03R70wvLLmfVbfGPVy0rSoZcckLdeAFT4GQbHQ3wR13sCIWw0Hy9Ox
         Eer3zU8Rq1ci+HxAuV7BvQyi99MG6INsruiWEXrJZNWbg3FaJZbUZLAgYsL8EXL3xopG
         JrTrwnbS4mff50ZfU0qfubaMRDjX5W/eDbn5gcP2jx+7fB15Q3qWN6bVIAwCwk9T2aFD
         zlPgObmw46Qr+mjolIAxAtxupWHA8r4opJWa8g5UqFmb5i3vjSBspN+vfWQSH9/6GOLX
         UNvN9rFY11Kq/XGnJkRGBFG+75nrmxSwJ20xO9YWmhQ6unBE8PevbGGXkPHj56fK5m4+
         D/eg==
X-Gm-Message-State: AOAM5328vziwRkhwwVchCF7khS7AHuftjkFgaZWal1R5oHjTGBKU6fHA
        E0M9Rlzz/ZbT6Hf7arTHRb2Tz7j6xz1pPRsi1Eg=
X-Google-Smtp-Source: ABdhPJzMK1uiaAN7IbtSoE6qYewgu28eYIxsdob3rWrrC4BIV5Q5HiKpvdwVtEf4WT6Q17Ycwzsh+IL/FcdurzDUWSQ=
X-Received: by 2002:a9d:2203:: with SMTP id o3mr9021505ota.107.1608474508291;
 Sun, 20 Dec 2020 06:28:28 -0800 (PST)
MIME-Version: 1.0
References: <20201220085141.1573113-1-geert@linux-m68k.org> <49a17a22-c657-8e26-6c84-36ef01264c5d@physik.fu-berlin.de>
In-Reply-To: <49a17a22-c657-8e26-6c84-36ef01264c5d@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 20 Dec 2020 15:28:17 +0100
Message-ID: <CAMuHMdUY5OY2s63AJE-EUVLGTM_z9st3iupQv_pWTt84tvN1hQ@mail.gmail.com>
Subject: Re: [PATCH] m68k: Enable seccomp architecture tracking
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Sun, Dec 20, 2020 at 12:24 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 12/20/20 9:51 AM, Geert Uytterhoeven wrote:
> > To enable seccomp constant action bitmaps, we need to have a static
> > mapping to the audit architecture and system call table size.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> > Needed for CONFIG_SECCOMP_CACHE_DEBUG.
> > Note that upstream doesn't have m68k seccomp support yet.
>
> Have we added SECCOMP support for m68k to the kernel yet?

No, but I have applied locally the patches floating on the list...

> It's actually something I was hoping to do over the holidays ;-).

Happy to hear that!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
