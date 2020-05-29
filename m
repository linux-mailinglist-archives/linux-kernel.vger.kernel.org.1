Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988831E8B69
	for <lists+linux-kernel@lfdr.de>; Sat, 30 May 2020 00:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgE2WgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 18:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgE2WgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 18:36:23 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB47C08C5C9
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 15:36:23 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id y13so3615826eju.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 15:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pkaPTbVettT2R0A3KgmKKJgTEE6zzS8EojK08/B14Qg=;
        b=Z4rMmFUzf5ubLYu7hlUg65RB05j0wPmYHagJD/J4x4UiHKMkgNfakTsGHxP7wVdJCk
         HKogEtVwtsZxy5VCiFdd/SmMIUVyNL2S/jhBfrBUrGG6kCRThE5t2Sb0iJgDi40P2Wcd
         9qCGlZRi6ck7W/XHfqb0YEajlDYOllz4HVNtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pkaPTbVettT2R0A3KgmKKJgTEE6zzS8EojK08/B14Qg=;
        b=ZefqNlgv75ffC55mB+Gy22YKalrs9TbjxsNj9n02e10Qe5tWrwaQ1FypPRygrGTbU7
         hbv0EO98HzorBisXaBXG7pP9pbjtgZt7F5TcQbFwMzE13KoDNORcKS+aHiaRybf3jK4k
         nV+QwrfpAJori3p/NFw6RRHetgKYAKqhCxl/HVAv2JRfNHR7pQMhgEuE6GgUUk8XrOKs
         SkBHfkr0IzDUa2gcx0JyqPCmASSasBTcWaV2TsKVyY2JDTYELiqmV3L8akFISne8TG+1
         oHoFIe5tHZFTJDnLD/Zc81GWye6ZS14qJseuEQB12C1mPGmsBu96usTZH8YSFZ101uug
         QE+g==
X-Gm-Message-State: AOAM532D6NTtRMk8cKEi+mAM0YfGg0j0pYgaB7sDOjDJLVCD0L8N7bqx
        NHTTrpEjkMJqX68IH8jMTBfvjESocEQYBPxzdW12uQ==
X-Google-Smtp-Source: ABdhPJwCfJXcu3bKxFNGb3kyf1DzD1gVpmpiFAQ3f0riwIDJij5mbbXnpMisTJa5pcCeEjG3VvtZjZmZbyhNj4OBEOA=
X-Received: by 2002:a17:906:9404:: with SMTP id q4mr9616572ejx.138.1590791781525;
 Fri, 29 May 2020 15:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200528110858.3265-1-sargun@sargun.me> <20200528110858.3265-3-sargun@sargun.me>
 <20200529103253.jepm6dzsqzhwtlpj@wittgenstein> <20200529133154.gn2xg6lr7xmkp34p@wittgenstein>
In-Reply-To: <20200529133154.gn2xg6lr7xmkp34p@wittgenstein>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Fri, 29 May 2020 15:35:45 -0700
Message-ID: <CAMp4zn_N0CrVzWQzRfcZC3Wip6dxsfp=LYZf=U2ESiAAV55_UA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] seccomp: Introduce addfd ioctl to seccomp user notifier
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 6:31 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> > > +           /* Check if we were woken up by a addfd message */
> > > +           addfd = list_first_entry_or_null(&n.addfd,
> > > +                                            struct seccomp_kaddfd, list);
> > > +           if (addfd && n.state != SECCOMP_NOTIFY_REPLIED) {
> > > +                   seccomp_handle_addfd(addfd);
> > > +                   mutex_unlock(&match->notify_lock);
> > > +                   goto wait;
> > > +           }
> > >             ret = n.val;
> > >             err = n.error;
> > >             flags = n.flags;
> > >     }
> > >
> > > +   /* If there were any pending addfd calls, clear them out */
> > > +   list_for_each_entry_safe(addfd, tmp, &n.addfd, list) {
> > > +           /* The process went away before we got a chance to handle it */
> > > +           addfd->ret = -ESRCH;
> > > +           list_del_init(&addfd->list);
> > > +           complete(&addfd->completion);
> > > +   }
>
> I forgot to ask this in my first review before, don't you need a
> complete(&addfd->completion) call in seccomp_notify_release() before
> freeing it?
>

When complete(&knotif->ready) is called in seccomp_notify_release,
subsequently the notifier (seccomp_do_user_notification) will be woken up and
it'll fail this check:
if (addfd && n.state != SECCOMP_NOTIFY_REPLIED)

Falling through to:
/* If there were any pending addfd calls, clear them out */
list_for_each_entry_safe(addfd, tmp, &n.addfd, list) {
    /* The process went away before we got a chance to handle it */
    addfd->ret = -ESRCH;
    list_del_init(&addfd->list);
    complete(&addfd->completion);
}

Although ESRCH isn't the "right" response, this fall through behaviour
should work.
