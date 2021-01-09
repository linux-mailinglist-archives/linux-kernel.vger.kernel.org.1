Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F143F2EFD1A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 03:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbhAICUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 21:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbhAICUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 21:20:21 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B74C061757
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 18:19:34 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id m5so10684146wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 18:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=052XPomPT0oPS9EFhbYOVhGRK5vb4IUUAo6lA6fY0a0=;
        b=Z//feIYP4BzIRBimKHRKIg3TS3FG+WbtsSOWeEzhIELipSoM/VopcW5yHQ8lBDSyNb
         cYtg10MGwnE3DBvOmC7Cpkkka8+K1+w3YgfHSDm78A6+pyVCRaqWSasoAB5OfPOaXT/k
         YtbB8X2JQ0DgQoyVeZW3R/ffL8fnqs5nVmfG4gr0Kzwnf350NBWSMa2sQuHmz48Cf3Xm
         n7tiAIB8q22oaykBB+CZ6214yMk/0IEKYux2zUP9uEa/x+RWWIL84MlWht+vNT0DTTom
         sLdoXIhK6FD3DANRI8tlhK+mZBRIzG51rgmCIwhhWVAyGx19W1RqftDiE8wf81zgHmO1
         1b0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=052XPomPT0oPS9EFhbYOVhGRK5vb4IUUAo6lA6fY0a0=;
        b=JbhBNcM1urJo+VrfBpPRQHIdcq6ooE03UjJ7PMtAIh9dRQY7DQMi4bxVnBn1Qs5jhG
         SrflJte09tjFRs0QRFvJ70H54CbHS/IR9aydgzWw0guH7gTjvGxAXfMEMYgo2y+HbmSl
         Ui4YD/VHJvKIJOI8CkIDLkcvp5tL9FOzi5iy8dkknwvkBdJs2wLBM9rcHAefPLB4ypHo
         CsieX68+f8wPi2XI8mliMQt4BPXjprlfdYNPDcamJhktq4/L4XB/iKyIr7PVsDGvAPRh
         7amWnMi9LEfwSKBpTSJLL+ysaipHc2K7daNG5ePvRlRmtCOIp+Duz/gKYfBIYf3CSlNz
         +zDw==
X-Gm-Message-State: AOAM533EWiP6gBO93Fvn5VWT3ftaeEw6mhBcRlQkHvXC6I/mhSexjNLT
        rB/J9zT0hRxu0jWvgN8cp5fKw8eBRFjqp57kGR9ZMw==
X-Google-Smtp-Source: ABdhPJyvZEkJKALenbMvuoA7Rd/6gdTN0lh35/p88gWogUSV/ynhdTPItqFJ8Ggl7nc3v8PnPlUz5dEz5QJjKO1PF4Q=
X-Received: by 2002:adf:f0d0:: with SMTP id x16mr6298503wro.162.1610158773355;
 Fri, 08 Jan 2021 18:19:33 -0800 (PST)
MIME-Version: 1.0
References: <20210108205857.1471269-1-surenb@google.com> <X/jZibYD1B42D+r7@google.com>
 <CAJuCfpHa3XHVEjNBDHJNo3RBWGdLnXsgZH9wyiGLqj655GwE2w@mail.gmail.com> <db29d560-45d9-1eb3-60d0-8d6153ac7193@google.com>
In-Reply-To: <db29d560-45d9-1eb3-60d0-8d6153ac7193@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 8 Jan 2021 18:19:22 -0800
Message-ID: <CAJuCfpE3QR-8Lm_0cnCFQsDiU2Ui87E6ARQ+ScQuDZ1TNfm-tg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/madvise: replace ptrace attach requirement for process_madvise
To:     David Rientjes <rientjes@google.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        =?UTF-8?Q?Edgar_Arriaga_Garc=C3=ADa?= <edgararriaga@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>, selinux@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 5:02 PM David Rientjes <rientjes@google.com> wrote:
>
> On Fri, 8 Jan 2021, Suren Baghdasaryan wrote:
>
> > > > @@ -1197,12 +1197,22 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
> > > >               goto release_task;
> > > >       }
> > > >
> > > > -     mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
> > > > +     /* Require PTRACE_MODE_READ to avoid leaking ASLR metadata. */
> > > > +     mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
> > > >       if (IS_ERR_OR_NULL(mm)) {
> > > >               ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
> > > >               goto release_task;
> > > >       }
> > > >
> > > > +     /*
> > > > +      * Require CAP_SYS_NICE for influencing process performance. Note that
> > > > +      * only non-destructive hints are currently supported.
> > > > +      */
> > > > +     if (!capable(CAP_SYS_NICE)) {
> > > > +             ret = -EPERM;
> > > > +             goto release_task;
> > >
> > > mmput?
> >
> > Ouch! Thanks for pointing it out! Will include in the next respin.
> >
>
> With the fix, feel free to add:
>
>         Acked-by: David Rientjes <rientjes@google.com>

Thanks! Will post a new version with the fix on Monday.

>
> Thanks Suren!
