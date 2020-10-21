Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5266129514C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 19:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503360AbgJURFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 13:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503353AbgJURF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 13:05:29 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40619C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 10:05:29 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a5so3368577ljj.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 10:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jZ8rX4nMXu9yVxF6VhEpyRT/HJL/yeSOHN33lmmqE3Q=;
        b=d6nJua3ZU/+MbORwAQIhOyj2afUAGnde4GMpRV2HxlMNrYs0QlTInEU5dTEigbF5Df
         dmv41P9p05B6BQtvCcM2OmGGKAdgaTWy1b42EvZb4/P124a6kJRtmA9iy0DRhNfGxKOc
         95gwtWQc4/Bu6Cew4ZrJmy92LVxyerHew+FaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jZ8rX4nMXu9yVxF6VhEpyRT/HJL/yeSOHN33lmmqE3Q=;
        b=V4SHsdm/scpguZGjqslY7CNaspLtNbltXzeJsZurSI0vU8kp7ii+RqcANz3kFWlZbC
         VO+OiOvOTkjrShCF2DGrziNyxsWW8ngGtBxcbbRUHTzO7yRpIRcj9ppARQKbm9o3R/Ax
         CxL9SZgms4IAzlq2srdUrgRACu8HvT7+raJoOE/iYfQQFipz4jy1RIV29/QWLttegK3E
         8MLJdHOMBhqNDRJmy+dAR8u/DGvcN7hu1YWLEf0y57OGXimEPLvnLeCtC2Ukh3tSS4+6
         8kDf4fBWl/r8QDEnDZ64/MWrxJN7rZ9fJXS6re5OOfughu+EVys+1xgUfNMSHzI4SjBr
         gUKw==
X-Gm-Message-State: AOAM533/ppDeNAEWAQtbbhhwIRo4lodtAwQTJEORRfhSyqVQLsRNzVI6
        k07/yKUuCdYmZM+0c3+nStI1t0GsZVa6rQ==
X-Google-Smtp-Source: ABdhPJyBrRy0khjijyZ4dBqfVOwxwDHhHGrSaZJekBmG9auxprxx8EmxfZhIJ+QXOZAqVm9svYOqqg==
X-Received: by 2002:a2e:9689:: with SMTP id q9mr1727715lji.434.1603299927424;
        Wed, 21 Oct 2020 10:05:27 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id o21sm478410lff.265.2020.10.21.10.05.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 10:05:24 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id j30so4053956lfp.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 10:05:22 -0700 (PDT)
X-Received: by 2002:a19:c703:: with SMTP id x3mr1474665lff.105.1603299922233;
 Wed, 21 Oct 2020 10:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvHze+hKROmiB0uL90S8h9ppO9S9Xe7RWwv808QwOd_Yw@mail.gmail.com>
In-Reply-To: <CA+G9fYvHze+hKROmiB0uL90S8h9ppO9S9Xe7RWwv808QwOd_Yw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Oct 2020 10:05:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg5-P79Hr4iaC_disKR2P+7cRVqBA9Dsria9jdVwHo0+A@mail.gmail.com>
Message-ID: <CAHk-=wg5-P79Hr4iaC_disKR2P+7cRVqBA9Dsria9jdVwHo0+A@mail.gmail.com>
Subject: Re: mmstress[1309]: segfault at 7f3d71a36ee8 ip 00007f3d77132bdf sp
 00007f3d71a36ee8 error 4 in libc-2.27.so[7f3d77058000+1aa000]
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        X86 ML <x86@kernel.org>, LTP List <ltp@lists.linux.it>,
        lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        zenglg.jy@cn.fujitsu.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 9:58 AM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> LTP mm mtest05 (mmstress), mtest06_3 and mallocstress01 (mallocstress) tested on
> x86 KASAN enabled build. But tests are getting PASS on Non KASAN builds.
> This regression started happening from next-20201015 nowards

Is it repeatable enough to be bisectable?

             Linus
