Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A11E27A6BD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 07:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgI1FMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 01:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgI1FMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 01:12:13 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AD9C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 22:12:13 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id r8so7202484qtp.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 22:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VlMjWdTSP4HviN0so4jvAwCqJvrMDP53UXwYxfndYEI=;
        b=Dn/d+8GlDku+z+Zg/e84kp9PvTrhxJpf8eqvrZ+AUb/OotOcg11WcaGmRwn1I6zDTu
         QAvvS4GIuJ5SkBHKgfiAGpCHL9LSsxd9PsTOOITZtvo26UfRf2RuuLdb2bGRt4+rUi1o
         f0FQFOQ0EowmS0Tvy0SlWe/3ql5U+hVBK2Pprl6psYxi7gzonC0KDWSxLib/a8xDFu43
         6L5ppe19G8hAsPQWY/o30smk9F/F6h6zEvyfoqvaVbu6JFR0LoAtn2X7+zqr3AJeZL9u
         PTG8y9g1UsybnkyWy+zl/QdPXVYugrM+xTlRySkvlCzJm91bCzIUwT9Oe5MzvRWBm/JU
         Lu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VlMjWdTSP4HviN0so4jvAwCqJvrMDP53UXwYxfndYEI=;
        b=kxtpe7YWJFbPj5qyQ+MBEIBg2WhHJ+gWEFcu4UmgK0NsQTadjHA7ln+aHULx4mJaJz
         lal9NL3UL03U0hcSrJ/IFGHplFzOm5YiHTkvB05ep1A1gXePvQ2UvNfHS77UaDC1HnGZ
         Msj/d3gr7QceOWEXJYg0eAUxNrVyk01LKpqK083UYTGtbDDSPbuU5CYv5LIIGZBTjZ8c
         YywtoGeq9Or9zWFANlvYajLviABbaqU2RUL0D6gsfSzBf74a+Ic0Bx2gqIolKKwGoLFj
         zvtUhD+od/1pBlvaS0KGL65IL0wxCXtvEhb1Oh57NE6lXRutGyJ0rEAtZSiYCjcUS9SG
         yzoA==
X-Gm-Message-State: AOAM532iSl5ejkoskGHBhB2QmFlDDsyPiX4KVdz9aQdy49dppnLdEpOO
        Fgkny8E3MczuvaBkmiNwkmRgtjEhe7qULWweTTdL/A==
X-Google-Smtp-Source: ABdhPJzgaTRHtuA591lCaAVpxUJ3+RXwvTK+CvoSkkFjsdfPabjYSNBc8LkQ9J/VJOzqJMtueuEMe8c71f4bwoaYTsQ=
X-Received: by 2002:ac8:5215:: with SMTP id r21mr10885089qtn.257.1601269931666;
 Sun, 27 Sep 2020 22:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <1595640639-9310-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <384ce711-25c5-553b-8d22-965847132fbd@i-love.sakura.ne.jp>
 <0f7233f7-a04a-e9c9-7920-3a170cc97e4b@i-love.sakura.ne.jp>
 <CACT4Y+bjPr=64Lq1-ARD6T=K9LmC_Aor4BRXPcZVtUU8vF0oGg@mail.gmail.com>
 <20200916115057.GO2674@hirez.programming.kicks-ass.net> <CACT4Y+agTiEF-1i9LbAgp-q_02oYF0kAPZGAAJ==-wx2Xh7xzQ@mail.gmail.com>
 <72b034b7-f9ff-c744-5307-6fd84f38ae26@i-love.sakura.ne.jp>
In-Reply-To: <72b034b7-f9ff-c744-5307-6fd84f38ae26@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 28 Sep 2020 07:12:00 +0200
Message-ID: <CACT4Y+YNXqvNhuyL7WNvQz_YZNuzm=msFpf0540=Hd9VMgNqEg@mail.gmail.com>
Subject: Re: [PATCH v2] lockdep: Allow tuning tracing capacity constants.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 2:24 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2020/09/16 21:14, Dmitry Vyukov wrote:
> > On Wed, Sep 16, 2020 at 1:51 PM <peterz@infradead.org> wrote:
> >>
> >> On Wed, Sep 16, 2020 at 01:28:19PM +0200, Dmitry Vyukov wrote:
> >>> On Fri, Sep 4, 2020 at 6:05 PM Tetsuo Handa
> >>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>>>
> >>>> Hello. Can we apply this patch?
> >>>>
> >>>> This patch addresses top crashers for syzbot, and applying this patch
> >>>> will help utilizing syzbot's resource for finding other bugs.
> >>>
> >>> Acked-by: Dmitry Vyukov <dvyukov@google.com>
> >>>
> >>> Peter, do you still have concerns with this?
> >>
> >> Yeah, I still hate it with a passion; it discourages thinking. A bad
> >> annotation that blows up the lockdep storage, no worries, we'll just
> >> increase this :/
> >>
> >> IIRC the issue with syzbot is that the current sysfs annotation is
> >> pretty terrible and generates a gazillion classes, and syzbot likes
> >> poking at /sys a lot and thus floods the system.
> >>
> >> I don't know enough about sysfs to suggest an alternative, and haven't
> >> exactly had spare time to look into it either :/
> >>
> >> Examples of bad annotations is getting every CPU a separate class, that
> >> leads to nr_cpus! chains if CPUs arbitrarily nest (nr_cpus^2 if there's
> >> only a single nesting level).
> >
> > Maybe on "BUG: MAX_LOCKDEP_CHAINS too low!" we should then aggregate,
> > sort and show existing chains so that it's possible to identify if
> > there are any worst offenders and who they are.
> >
> > Currently we only have a hypothesis that there are some worst
> > offenders vs lots of normal load. And we can't point fingers which
> > means that, say, sysfs, or other maintainers won't be too inclined to
> > fix anything.
> >
> > If we would know for sure that lock class X is guilty. That would make
> > the situation much more actionable.
> >
>
> Dmitry is thinking that we need to use CONFIG_LOCKDEP=n temporary until lockdep
> problems are resolved. ( https://github.com/google/syzkaller/issues/2140 )
>
> But I think it is better to apply this patch (and revert this patch when it became
> possible to identify if there are any worst offenders and who they are) than using
> CONFIG_LOCKDEP=n.
>
> CONFIG_LOCKDEP=n causes "#syz test" request to cause false response regarding locking
> related issues, for we are not ready to enforce "retest without proposed patch
> when test with proposed patch did not reproduce the crash".

FWIW patch testing for previously reported bugs should still work
because it uses the kernel config associated with the bug report.

> I think that "not detecting lock related problems introduced by new patches" costs
> more than "postpone fixing lock related problems in existing code".
