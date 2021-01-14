Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454852F668F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbhANQ6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 11:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbhANQ6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 11:58:03 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B57C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 08:57:22 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id q4so3196127plr.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 08:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6sD1tCBoGAOrvfd86vyt9hIg6YLWE1pvXhNfgkiWDvM=;
        b=mFllyiyBMkF3ksbiFU5nzudfKx1bOEzWgi+LJy1gIMGegLO/wEHcUWoBv494G8wJSi
         4xYXVcN/eagkT7KwBSKDEttLN6to3szcTm5OQuuKY/eD6EqFfxmnMO/uQFZBT3aIYbWN
         /8aSrxdW+sdYs2s79xsURBGckzNCAJTMioV6nbvcdFJScpZoZTHjxSWZvSUkCVPupSsg
         567ADMvqioTW6EmWmyj9beBqFMHu/FkuVQoP8jt1KGSky06V+4Hw1QIW3yNrEC8oc3N/
         LmSHcm78sHM0KtRcRW4UZiWRpc4UNhOAQksYmOw2mIGhIOOgB3yeH+jZNIrw99FUCn7G
         qnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6sD1tCBoGAOrvfd86vyt9hIg6YLWE1pvXhNfgkiWDvM=;
        b=nF4HsZER/oVuz9cTVjjq8lp3QVHe13dd+SQ7DfdafvLK3VE4EzpH9eo6A/QrWU72Dh
         OGIZWEZvg3fDEVs5bwpBF8crYyknOnIAMsRPpqNXicL+//O8caH3zIHvrBM14gTJzs8C
         zll2/0u+3Wp3aqW0QlmmDFT5pHoQdIsPJ4oX0qxBw428bXYTIUFQZ7lSdUbq+UAn4G4c
         x08u8Dlnk7aklQzfnjXdj4dFGwg3rqtnuNOj2PpOHEaoX4vjFjg8axk1H/GCfYSww5FV
         8tc1eCRDezta9lR6a+QUk8sCeQs+2dWadbaI7qfnGbA71dVERvwI7evCtT6aGLFIacxY
         HZPQ==
X-Gm-Message-State: AOAM530USWCl94JxCVKTk3cojkI2Wtk3LpbgFHcAEw2+VYB5AJeWcIgm
        x3yRtVxVWaJ+IZx6nvO6wXm7Fg4Br8chhRjaexbwBA==
X-Google-Smtp-Source: ABdhPJyWdPWhBk6LFGwCn2FbIWPWbQhEmhP+NDlFW1LcmSnkpSTn9osRRvx7suhuAkVxF4KYgth10D50JObrMw2+nO0=
X-Received: by 2002:a17:902:d50d:b029:de:5b13:498d with SMTP id
 b13-20020a170902d50db02900de5b13498dmr3192064plg.38.1610643442083; Thu, 14
 Jan 2021 08:57:22 -0800 (PST)
MIME-Version: 1.0
References: <20210114054831.343327-1-maskray@google.com> <20210114140621.GA15904@linux-8ccs>
In-Reply-To: <20210114140621.GA15904@linux-8ccs>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Thu, 14 Jan 2021 08:57:10 -0800
Message-ID: <CAFP8O3Liydjn=6PwaDdYAhtMS1zC3=aKW6oq6UBOXGr9HKoQ1g@mail.gmail.com>
Subject: Re: [PATCH] module: Ignore _GLOBAL_OFFSET_TABLE_ when warning for
 undefined symbols
To:     Jessica Yu <jeyu@kernel.org>, Sam Ravnborg <sam@ravnborg.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Marco Elver <melver@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 6:06 AM Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Fangrui Song [13/01/21 21:48 -0800]:
> >clang-12 -fno-pic (since
> >https://github.com/llvm/llvm-project/commit/a084c0388e2a59b9556f2de0083333232da3f1d6)
> >can emit `call __stack_chk_fail@PLT` instead of `call __stack_chk_fail`
> >on x86.  The two forms should have identical behaviors on x86-64 but the
> >former causes GNU as<2.37 to produce an unreferenced undefined symbol
> >_GLOBAL_OFFSET_TABLE_.
> >
> >(On x86-32, there is an R_386_PC32 vs R_386_PLT32 difference but the
> >linker behavior is identical as far as Linux kernel is concerned.)
> >
> >Simply ignore _GLOBAL_OFFSET_TABLE_ for now, like what
> >scripts/mod/modpost.c:ignore_undef_symbol does. This also fixes the
> >problem for gcc/clang -fpie and -fpic, which may emit `call foo@PLT` for
> >external function calls on x86.
> >
> >Note: ld -z defs and dynamic loaders do not error for unreferenced
> >undefined symbols so the module loader is reading too much.  If we ever
> >need to ignore more symbols, the code should be refactored to ignore
> >unreferenced symbols.
> >
> >Reported-by: Marco Elver <melver@google.com>
> >Link: https://github.com/ClangBuiltLinux/linux/issues/1250
> >Signed-off-by: Fangrui Song <maskray@google.com>
> >---
> > kernel/module.c | 10 ++++++++--
> > 1 file changed, 8 insertions(+), 2 deletions(-)
> >
> >diff --git a/kernel/module.c b/kernel/module.c
> >index 4bf30e4b3eaa..2e2deea99289 100644
> >--- a/kernel/module.c
> >+++ b/kernel/module.c
> >@@ -2395,8 +2395,14 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
> >                               break;
> >                       }
> >
> >-                      /* Ok if weak.  */
> >-                      if (!ksym && ELF_ST_BIND(sym[i].st_info) == STB_WEAK)
> >+                      /* Ok if weak. Also allow _GLOBAL_OFFSET_TABLE_:
> >+                       * GNU as before 2.37 produces an unreferenced _GLOBAL_OFFSET_TABLE_
> >+                       * for call foo@PLT on x86-64.  If the code ever needs to ignore
> >+                       * more symbols, refactor the code to only warn if referenced by
> >+                       * a relocation.
> >+                       */
> >+                      if (!ksym && (ELF_ST_BIND(sym[i].st_info) == STB_WEAK ||
> >+                                    !strcmp(name, "_GLOBAL_OFFSET_TABLE_")))
> >                               break;
>
> Hi Fangrui,
>
> Thanks for the patch. I am puzzled why we don't already mirror modpost
> here, that particular line of code in modpost to ignore _GLOBAL_OFFSET_TABLE_
> has been there long before my time. Let's properly mirror modpost
> then, and create a similar helper function ignore_undef_symbol() (and
> stick the _GLOBAL_OFFSET_TABLE_ check in there) to account for future
> cases like this.
>
> Thanks,
>
> Jessica

Hi Jessica,

I guess __this_module in scripts/mod/modpost.c:ignore_undef_symbol is
not a problem.
For PPC64 _restgpr0_* and _savegpr0_*, I am not sure ignoring the
undefined functions in kernel/module.c is right.
(I know they can be produced by gcc -Os in some cases
(https://reviews.llvm.org/D79977), but I want to learn whether that is
a real issue before adding them.)

If we ever need to ignore more symbols, the code should be refactored
to not warn for unreferenced undefined symbols as my description says.
