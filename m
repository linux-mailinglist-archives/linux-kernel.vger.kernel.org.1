Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511812A5A63
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 23:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbgKCW6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 17:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729575AbgKCW6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 17:58:39 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0321C061A04
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 14:58:38 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id a7so24496169lfk.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 14:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tNac8HNLE00Dbwz8t1yzhVyitl7+yNqN0tC3TOZ7uVU=;
        b=lL9nbjzjMJDsdViJoWfCpeQI+/QggG5+5MAJjiaBqsnftDueWMr+NLcxM87G0Bov5h
         lf/3wEi/V+f23ndIkCpyOco/b01/JwHobRGP3moJPD/0cRC0H7dgalEHDrSNbEWtWq6c
         Y0xYV2hQfWFzrsz5edWvgTas04uKm4p4PDEjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tNac8HNLE00Dbwz8t1yzhVyitl7+yNqN0tC3TOZ7uVU=;
        b=cRNz8tlGPp1HT9QoaRUEwft8GARaDVcsfUYoclVDnPoOF7/1LSGjHJQkz+C+0VAN1F
         MrlqsO1g1ZL2+bbbtKl424aV2rb9aB0sGK74ncquheSRB97wj/5nz6dRa3Adgn2vDXS/
         GWCXlIH5zKwdCyLiwVhjsyeFSITTeQJGZYh66t41Da7kvafdD1Kk4whS2CwuBspfDhMG
         S+gpPDp5i3MjPDfCU/XVg2DGEtsCz4TXCfUi6rRPblWFvg28RZ+3r385HG+zvvlxxpBS
         KntAwroqpEd+3jNPOsjpGjYskbtpDtMFQ5nIJGqm7kUjbndd3fRQFkcmBZQ9g2nrrPXg
         O2pQ==
X-Gm-Message-State: AOAM532SXugslEKy6gWkJLuuGWXqjZV6wkqMmwAdnrgrdsvgPxoX0dKg
        3kSROe3QM5hPtLJdgLDlczW/zi46tuE9eN8o7g5VTQ==
X-Google-Smtp-Source: ABdhPJzAAQm6lplXZGkvzp/jqHJ1GiOKomPzELC3I1EzT5pG1/JVMXWKMFt6iG7S/Hcm7zuNq4FhL8v9WrNb9yWWv+A=
X-Received: by 2002:a05:6512:34d3:: with SMTP id w19mr8030260lfr.418.1604444317196;
 Tue, 03 Nov 2020 14:58:37 -0800 (PST)
MIME-Version: 1.0
References: <20201103153132.2717326-1-kpsingh@chromium.org>
 <20201103153132.2717326-9-kpsingh@chromium.org> <87AD7DC4-63DD-4DE2-B035-A3FA2D708601@fb.com>
In-Reply-To: <87AD7DC4-63DD-4DE2-B035-A3FA2D708601@fb.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Tue, 3 Nov 2020 23:58:26 +0100
Message-ID: <CACYkzJ4nFq9ugMvW9K9yO8JK8uv1Q86aCh5wsnPPhR7_7=TQJA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 8/8] bpf: Exercise syscall operations for
 inode and sk storage
To:     Song Liu <songliubraving@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 3, 2020 at 11:32 PM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Nov 3, 2020, at 7:31 AM, KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
>
> A short commit log would be great...

Sure :) No excuses for not having one, will add it in the next revision.

- KP

[...]

> > +                                   serv_sk))
> > +             goto close_prog;
>
> We shouldn't need this goto, otherwise we may leak serv_sk.

Good point, I will just move the close(serv_sk); along with the other
descriptor clean up.

>
> > +
> >       close(serv_sk);
> >
> > close_prog:
> > +     close(rm_fd);
> >       close(task_fd);
> >       local_storage__destroy(skel);
> > }
> > --
> > 2.29.1.341.ge80a0c044ae-goog
> >
>
