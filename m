Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCE6303CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392638AbhAZMVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404805AbhAZLDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 06:03:21 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7544C061756
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 03:02:40 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id w8so18088906oie.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 03:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WnWYR4SKas2U9WPFSvBQnaZKF78/yaoxJlUG6e0GR8I=;
        b=JaUENZjPJLstjhm2QenVj5RRV4sclmTtqhmC30j6RHOJP64u+ICujmW2GETiVvNIhN
         s0PASlDYuVIkYKAWxdzdQ9eaIRmb8RBAyqhd+bdOKI1lzYkXWfMHCqJUPmfzXwpRhu1Y
         ZfDpx1nhcDn1PzXzR6b+89QM9VmCmTWGQ+Ymcge/HYT9SV+5ZAE4SMc0UUzNDqPdb4OV
         p/3byezzQauHOMpSXb9UboZHpCyzpq3uIKBBSEXyV8pr2956R02IbpZywJIMaIA6P9fV
         k/89QeawNNYtFQ3eU+JBd2CfYqWWn6CRG7E4G9Ii1fVlGjWoFbIgFrMpAcqJ3l03mafJ
         lbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WnWYR4SKas2U9WPFSvBQnaZKF78/yaoxJlUG6e0GR8I=;
        b=TWTY9s0it/JGbK4DzL5GEjJG+XE8xftqdW4YhNnBExVCjhmqAD6tYWqSza9kstjgad
         LqYrtU3IGPFd+myTEdHVwQfvtBDh1+5Vdh9v5AuTlYve4/dT0WUDyESf2KAk/xucUPBH
         g0CQ9ZA+7a0X0/z5sBULjqYx/NB1tyPxia0pXfogsc75GGEZVCYmmJwMY2QderuuqtXV
         m97QsRggM53PbbI7VxSrFsBbUgHSikeBBGsH8BoHgXSLl6X8k+7tIEslwDEa1Jo9hVaO
         n6FJ6zy4MSwfpL9Y9KPb1tzcLgHgC0x++c1sUKajExrD+JOGKiV9UGMeyKF0taeN80zU
         r5Mg==
X-Gm-Message-State: AOAM531qyVtUECXNqn8qvD2kWCCs0dF73aRTHHvvoAQuCKdgQQVLwWyr
        7J2zMPOOq3G53JINBSLhNNmVBOSRz+3G73v8Kpry9g==
X-Google-Smtp-Source: ABdhPJzl3CCxw769cAraiDhVoVbzAEPZYpLKAIzoACnABUpEAljw9mrUvAEgJpSXFq6hsivnFQbQin85cv3W4ce0lBQ=
X-Received: by 2002:aca:c085:: with SMTP id q127mr2922730oif.70.1611658960220;
 Tue, 26 Jan 2021 03:02:40 -0800 (PST)
MIME-Version: 1.0
References: <20210113160557.1801480-1-elver@google.com> <CABVgOSnHh8-s+AYifkDjCDKCkkFcm=WiGSuuf2JFiMvjAU1Kew@mail.gmail.com>
In-Reply-To: <CABVgOSnHh8-s+AYifkDjCDKCkkFcm=WiGSuuf2JFiMvjAU1Kew@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 26 Jan 2021 12:02:28 +0100
Message-ID: <CANpmjNPeKY7HZe0+zYx6BQ+oJ97Hq5j2V9QcHS_gjOJTtr8ENw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kcsan: Make test follow KUnit style recommendations
To:     David Gow <davidgow@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jan 2021 at 05:35, David Gow <davidgow@google.com> wrote:
>
> On Thu, Jan 14, 2021 at 12:06 AM Marco Elver <elver@google.com> wrote:
> >
> > Per recently added KUnit style recommendations at
> > Documentation/dev-tools/kunit/style.rst, make the following changes to
> > the KCSAN test:
> >
> >         1. Rename 'kcsan-test.c' to 'kcsan_test.c'.
> >
> >         2. Rename suite name 'kcsan-test' to 'kcsan'.
> >
> >         3. Rename CONFIG_KCSAN_TEST to CONFIG_KCSAN_KUNIT_TEST and
> >            default to KUNIT_ALL_TESTS.
> >
> > Cc: David Gow <davidgow@google.com>
> > Signed-off-by: Marco Elver <elver@google.com>
>
> Thanks very much -- it's great to see the naming guidelines starting
> to be picked up. I also tested the KUNIT_ALL_TESTS config option w/
> KCSAN enabled, and it worked a treat.
>
> My only note is that we've had some problems[1] with mm-related
> changes which rename files getting corrupted at some point before
> reaching Linus, so it's probably worth keeping a close eye on this
> change to make sure nothing goes wrong.

KCSAN changes go through Paul's -rcu tree, and once there's a stable
commit (latest when it reaches -tip) I would expect Git won't mess
things up.

> Reviewed-by: David Gow <davidgow@google.com>

Thanks for taking a look!

-- Marco

> -- David
>
> [1]: https://www.spinics.net/lists/linux-mm/msg239149.html
