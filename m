Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39060272A99
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 17:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgIUPpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 11:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbgIUPpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 11:45:55 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5288C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 08:45:54 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k13so9088499pfg.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 08:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m4CToQzhJGCPsf76V31txgnzK6ZWRX6mgYAAouheShA=;
        b=TQLj+xIAjAfTPnBavQ42k4AVCfkkhAoFpGyGbUfn112tKk+rsze1UjwiBwA6wsXTRb
         +ZGSGwS9rZXnOU2XL+2t7ihw8mFaWP3cE69P58bxQDLvuPPuxPBDbA60yrcfvOJFN3wj
         i9Dq0s39zToBI2wBz9Q5oHyhCensCflvRRNEfuH8NzM9n2mJ2mI93sKe+atdJ31Q3Ktc
         4EJ0IF/bP+f+mqDEHxpue16KzAeupaqJz+L016I0/2k+WHGmEyaNZYT5xOeWbZhkYd8e
         ATVTjRUVzD5PWcnx+yI84wH9GtgZk/KQhtD7y41wdLq4jZtA8w/m7FWsCIjtGRosytPH
         RGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m4CToQzhJGCPsf76V31txgnzK6ZWRX6mgYAAouheShA=;
        b=Q6Zq95xOuGL1lb9LimqhNvi7dE9ALNgTyu1pWew/Mn1eTBa00a0MTiSGA67F60CjSZ
         NN50plzf/fbcy6pGXzroewx3Y0dJYTAoBFGDC3M8sVIuYlb03vcKt/mWgHjudPgPd3q4
         Zl37NCDZCRuk3oOQxQUtWXSNUL4raaBSmBnqB8VbSKD6oj2ex9f9bYbThCHcERH3LkzQ
         q1chDBOoXkOe2SRMKEEOXyj8iiI4IfRBhePI5NIi0M4W0AS+wpm/GuC1F7Oh86vmRsnd
         xfLSzr1sbdF2dEzAI1QDZboVwwWkHMLMfGIxitqYClaTHhadkAPo7WdumXwAZEAqbAcc
         ioLw==
X-Gm-Message-State: AOAM530ULfrCGHMJniOH+bVSDNl1LqnFYKdhOpafnPw8DjlihYe58RhT
        gXl4er0+JA/D2HuD02QGF7hOOCIiAAGEkMGODsLroQ==
X-Google-Smtp-Source: ABdhPJz3eHJzIBLoLRHlWEAAxADnXqcdAbbo2gdehznGZIMv5bAZn6qlumPqDj/AH/GXc8yt9GeA0rG1FYlNmQHjDyE=
X-Received: by 2002:a63:310a:: with SMTP id x10mr234218pgx.10.1600703154282;
 Mon, 21 Sep 2020 08:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200921075131.1334333-1-georgepope@google.com> <CANpmjNO8YNROJsOj+n=hWj=2-LqebBQdZRks1KKQ3Scd05fLjg@mail.gmail.com>
In-Reply-To: <CANpmjNO8YNROJsOj+n=hWj=2-LqebBQdZRks1KKQ3Scd05fLjg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 21 Sep 2020 08:45:43 -0700
Message-ID: <CAKwvOdmxK7Nd_y+Rqf6j1w0idYhfn4J0aumOOLMJ1fo1zToScQ@mail.gmail.com>
Subject: Re: [PATCH] ubsan: introducing CONFIG_UBSAN_LOCAL_BOUNDS for Clang
To:     Marco Elver <elver@google.com>
Cc:     George-Aurelian Popescu <georgepope@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        David Brazdil <dbrazdil@google.com>,
        George Popescu <georgepope@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 2:10 AM Marco Elver <elver@google.com> wrote:
>
> > v1: changed the name of the config to UBSAN_LOCAL_BOUNDS in Kconfig
>
> This version is v2, so this should have said "v2: <summary of what
> changed>". The subject should have said "PATCH v2" (you can get this
> by passing --reroll-count=2 to git).

Prefer `-v2` when using `git format-patch`.
-- 
Thanks,
~Nick Desaulniers
