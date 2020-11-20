Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEBA2BA477
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 09:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgKTIRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 03:17:21 -0500
Received: from mail-oo1-f65.google.com ([209.85.161.65]:41611 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgKTIRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 03:17:20 -0500
Received: by mail-oo1-f65.google.com with SMTP id 123so2023460ooi.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 00:17:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wgLd9BBo4uYIF4N/NL617CUs8tQbYdNBRQ1iVnTQmdw=;
        b=THnYhHkJGXK/Wgt21q/Mj5m13xTuwc/ZkjcJQ7qqiG5om6U53vVUw1l3OeYdatRpzV
         lRPju9s9eYKbI0wGc+KDudZ+221ZBwoeMkn1Tw2ZbqOdkDrbtb8V1Uw/Q/ATURq6jaP0
         RrWVi+wm11jwq+JEgOhueFLU1y9GH3I3FrRJ0dj5JzTk6r7/5bRcRRyfC8QyZncLPSgO
         q/AlkcUdIrdM5eN4l9cecjmwtkOMsW1Enk61sXfLBeHhNplvCNLaKFpQ0vNN/ss52q7q
         8tlkqvumPAeiJPBO2jyZUVxxtl+KQ6zjS2fynEVUujMW2yyeuna0C7lGtNRUmwmCoBxI
         MWhw==
X-Gm-Message-State: AOAM533NS7MfmT3huoAv7cFWNgt52LRSovgG+K4vAw7SeFwN2NVi+yg8
        0ak5Yooh+PSu5FMDrb83ae1UF2x0Juph4enohaHKsBig/YPGLg==
X-Google-Smtp-Source: ABdhPJz2rlvtnz62/IN8qU2Va4dApiOA7G8a+PqbUd2beP0jChAoN8gyHy+iOieFRLBTeVj1h9hn8kHu10tYD85QmCg=
X-Received: by 2002:a4a:e80b:: with SMTP id b11mr13222498oob.1.1605860240013;
 Fri, 20 Nov 2020 00:17:20 -0800 (PST)
MIME-Version: 1.0
References: <1605852494-23515-1-git-send-email-tangyouling@loongson.cn>
In-Reply-To: <1605852494-23515-1-git-send-email-tangyouling@loongson.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 20 Nov 2020 09:17:08 +0100
Message-ID: <CAMuHMdVhskCPQKRvdQP=pqZ+ojGoRf22UNxiYHYM9Ae9DiyZ0A@mail.gmail.com>
Subject: Re: [PATCH 2/2] m68k: Add a missing ELF_DETAILS in link script
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Sam Creasey <sammy@sammy.net>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 7:08 AM Youling Tang <tangyouling@loongson.cn> wrote:
> Commit c604abc3f6e3 ("vmlinux.lds.h: Split ELF_DETAILS from STABS_DEBUG")
> after should add a missing ELF_DETAILS, at the same time, the .comment
> section has been included in the ELF_DETAILS.
>
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.11 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
