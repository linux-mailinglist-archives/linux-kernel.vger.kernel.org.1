Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA16029DB6E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbgJ1X4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgJ1Xyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:54:49 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8F0C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:54:48 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c5so834795qtw.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a6vE6h4Lrq3PfD6ZhI4bffn/VCoz5p+kVa9GnDZBqBg=;
        b=K1alOVg7BbsaWoIzM3EPt/XFxBj6CfPzSYGObFnKmJp7VbMWXtUo2wEub9s1GDaGHk
         lxopwSHtCrI5rbwcViDOKa7z7exOSdV8ylieshQIkI490N7n3HqHk5KCpFK6JRRNHLB9
         56qGofT5bOcT1aUgH4aQIAILIIM3qjkChzQL7xSefwfbrA/5wrlPyn/zyWV6NgJcMrqq
         c4gxYGkhThcN0gedsthpRzw7BxnfOcilw1snStWwIkeoRHuF7DEzT3zEC4pNAYOnL5tg
         hRSNj6YRCY3J7n/iMsCrY78y942DN0Wi6x+DA1NUcEmjlov4n9/PkkaC+g1wFrR6A3ge
         sjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6vE6h4Lrq3PfD6ZhI4bffn/VCoz5p+kVa9GnDZBqBg=;
        b=KBEu9tHAfSFIMjc7dpQZLwpN3JcZGhSramoNlg/RyoZsDCN6AsU1M8OIGHbfo+pgoF
         9ysIolTWFT8mClaSWirIwj3WoEq56qQuOUxY1Vm6ENo1oQI9KnBMtKphwRQo1neW8lGt
         a1nxZZV6zbNyL35wRSvuEV+YbeTl6wA0X27oSgkmBSwZ/UxAyNlxllz7HB/rKUoXHlRA
         IC/tES0fYmvM9YpEZStaOWPjX20tRlq6k/rZOxo1zDzENmZlsmUtXrm3vDgPlvtJRF+L
         wee4fxfAOZXvtQA3RkAxaDAkGYe1HtLNj2fsZif6i/6t339ijU55akaKPrKqx7hbqZkr
         8kcg==
X-Gm-Message-State: AOAM531Mx4euWVVTSNgfd7Q22ZTDFO13cCyfx8WEU09L7zfleUtwRrp7
        z7Up9UFO4cTkx0lTq0EB0I+TKiEZQzFP3NjG1wEasUSzSqOOww==
X-Google-Smtp-Source: ABdhPJzGlSt5aAv1ZLGB7xNjiUUvxmmxT2DKA0N0WRSAio1BCjdgbKuaIweZa1+5o4vyE+PoaK/loQrgkpTt4gNbQmg=
X-Received: by 2002:ac8:6c54:: with SMTP id z20mr5877605qtu.337.1603878075857;
 Wed, 28 Oct 2020 02:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201026125227.54520-1-a.nogikh@gmail.com> <20201026125227.54520-3-a.nogikh@gmail.com>
 <CAC5umyjZn+gtO=u8GhptVggzodbY-vnk9NNTOqyZyUW2up2ASQ@mail.gmail.com> <CANp29Y7sDaxrw+0wEVU0vo56AhKFRvbQSGeRc168gs6S8iK_-g@mail.gmail.com>
In-Reply-To: <CANp29Y7sDaxrw+0wEVU0vo56AhKFRvbQSGeRc168gs6S8iK_-g@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 28 Oct 2020 10:41:04 +0100
Message-ID: <CACT4Y+ZX=FjO0Ohoxnyjb3RqaTdGDpYs-Z4pJyiTo2TYY_ROqQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] docs: add fail_lsm_hooks info to fault-injection.rst
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Aleksandr Nogikh <a.nogikh@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 6:34 PM Aleksandr Nogikh <nogikh@google.com> wrote:
> [...]
> > In addition to this global one, what do you think about per-hook fault
> > injection,
> > i.e. /sys/kernel/debug/fail_lsm_hooks/<FUNC>/retval ?
>
> I was thinking about this, but decided to begin with a simple version
> that could definitely be useful in practice (for syzbot/syzkaller it is just
> necessary to have a fault injection capability that will be triggered via
> fail-nth). If per-hook fault injection can also be useful to someone, I
> can try to add it as well.

Yes, before we add it, it would be useful to have a clear use case
(otherwise we can add an unused thing, or implement it in a way that
slightly misses the use case).
Note that fail-nth allows to fail a single concrete site for testing,
though it's not super convenient for this as one would need to figure
out the right N first. But as a one-off test it should do.


> > In this case, we need a fault_attr for each hook. (Maybe, we can use the same
> > technique that is used to define security_hook_heads).
>
> Yes, that technique should help to implement the feature in a very concise
> way. Thanks for the suggestion.
