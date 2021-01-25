Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99267303669
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbhAZGUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:20:47 -0500
Received: from mail-yb1-f179.google.com ([209.85.219.179]:37022 "EHLO
        mail-yb1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbhAYNZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:25:50 -0500
Received: by mail-yb1-f179.google.com with SMTP id z1so13282501ybr.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 05:25:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mybA+IIkOKUfsPE8aZqJZA/LpcRLze1XRIRef0pzfVA=;
        b=tQxod7v4JBW69hD93apD6vjttnsEATqPy5IfPz61OQSh6mgfowxYO08i4L2s+uU7lA
         C+2geU5XZ0tjjV6Xk77qRObAqVtBBRQ5Es+zSmbIW+lLANTlHf088mik3LfsxOwKXH3w
         mN5+0qpaqKwabf3PzKSbK2fvF+ZCIGwmx0Pc+gu8aE9TnEOGa61QQaYtnfEDxsDIRLHR
         kA6v/n5DbXfb2RCLAnDhRT3n6dJm7PrEQPkOgrZyMKtwX5jdVdQZz7eV53OHDoA2zLmN
         6z4CJu3XCSKGg34okhRSnPE3Csk7n1vEqO6C9nU/tHKGzbcSmJzxCdcPII2tmMMgn4Kv
         2CkQ==
X-Gm-Message-State: AOAM531mDKO2vBqnJbTb5CCuhhBrvaDtyVKaCS0/fG61S3Vd5tjUi25r
        txybJP8ANFCeJSXj3A3bQPeub6Kw8Izzn8eDhh0b9/Eb
X-Google-Smtp-Source: ABdhPJx0q+FoaFczNHxa2Z2c4WZ18GfoOBMpXH8A8XAiNI6j2FLuEoWkXwpADn/hBfSjc17vF8UFkpIzwN6IaMXJ1WM=
X-Received: by 2002:a25:ab8d:: with SMTP id v13mr150736ybi.479.1611573942420;
 Mon, 25 Jan 2021 03:25:42 -0800 (PST)
MIME-Version: 1.0
References: <20210123184237.6970-1-kernel@esmil.dk> <20210125110311.pmqddpkh2c247tmx@maple.lan>
In-Reply-To: <20210125110311.pmqddpkh2c247tmx@maple.lan>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Mon, 25 Jan 2021 12:25:31 +0100
Message-ID: <CANBLGcxcpYucmFHtKydi=o_t=eaSbeEZBqY8C4xWLfjpxJkxBw@mail.gmail.com>
Subject: Re: [PATCH] kgdb: use new API for breakpoint tasklet
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 at 12:03, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Sat, Jan 23, 2021 at 07:42:37PM +0100, Emil Renner Berthing wrote:
> > This converts the kgdb_tasklet_breakpoint to use the new API in
> > commit 12cc923f1ccc ("tasklet: Introduce new initialization API")
> >
> > The new API changes the argument passed to the callback function, but
> > fortunately the argument isn't used so it is straight forward to use
> > DECLARE_TASKLET() rather than DECLARE_TASKLET_OLD().
>
> This patch overlaps with a more ambitious patch from Davidlohr.
> Perhaps you can join in with the other thread since the discussion
> there is unresolved. See:
> https://lkml.org/lkml/2021/1/14/1320

Ah, that's cool. Getting rid of tasklets is much better than merely
trying to get rid of the old tasklet API. Please ignore this patch
then.

/Emil
>
> Daniel.
>
>
> >
> > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > ---
> >  kernel/debug/debug_core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> > index af6e8b4fb359..98d44c2bb0a4 100644
> > --- a/kernel/debug/debug_core.c
> > +++ b/kernel/debug/debug_core.c
> > @@ -1090,13 +1090,13 @@ static void kgdb_unregister_callbacks(void)
> >   * such as is the case with kgdboe, where calling a breakpoint in the
> >   * I/O driver itself would be fatal.
> >   */
> > -static void kgdb_tasklet_bpt(unsigned long ing)
> > +static void kgdb_tasklet_bpt(struct tasklet_struct *unused)
> >  {
> >       kgdb_breakpoint();
> >       atomic_set(&kgdb_break_tasklet_var, 0);
> >  }
> >
> > -static DECLARE_TASKLET_OLD(kgdb_tasklet_breakpoint, kgdb_tasklet_bpt);
> > +static DECLARE_TASKLET(kgdb_tasklet_breakpoint, kgdb_tasklet_bpt);
> >
> >  void kgdb_schedule_breakpoint(void)
> >  {
> > --
> > 2.30.0
> >
