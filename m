Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F70217288
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 17:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbgGGPfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 11:35:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727079AbgGGPfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:35:42 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B12D206E2;
        Tue,  7 Jul 2020 15:35:41 +0000 (UTC)
Date:   Tue, 7 Jul 2020 11:35:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Subject: Re: [PATCH v2 03/15] tools lib traceevent: Add
 tep_load_plugins_hook() API
Message-ID: <20200707113539.448dde87@oasis.local.home>
In-Reply-To: <CAM9d7cgLBWCrEHwz+Lhv5x5EXGcNWB0QQoeGh3OKh2JfR=dV9Q@mail.gmail.com>
References: <20200702185344.913492689@goodmis.org>
        <20200702185703.946652691@goodmis.org>
        <CAM9d7cgLBWCrEHwz+Lhv5x5EXGcNWB0QQoeGh3OKh2JfR=dV9Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jul 2020 23:55:34 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> > -static void
> > -load_plugins(struct tep_handle *tep, const char *suffix,
> > -            void (*load_plugin)(struct tep_handle *tep,
> > -                                const char *path,
> > -                                const char *name,
> > -                                void *data),
> > -            void *data)
> > +void tep_load_plugins_hook(struct tep_handle *tep, const char *suffix,
> > +                          void (*load_plugin)(struct tep_handle *tep,
> > +                                              const char *path,
> > +                                              const char *name,
> > +                                              void *data),
> > +                          void *data)  
> 
> Can we have a comment (or a doc) for this API?  I'm not sure how it's used..

Actually, this requires a man page.

> 
> 
> >  {
> >         char *home;
> >         char *path;
> >         char *envdir;
> >         int ret;
> >
> > -       if (tep->flags & TEP_DISABLE_PLUGINS)
> > +       if (tep && tep->flags & TEP_DISABLE_PLUGINS)
> >                 return;  
> 
> Is it ok to call with a NULL tep handle?

Hmm, it looks like we could possibly pass this in without a tep handle,
if the plugins don't need a it. I'm not sure we have a use case for
that. I'll need to look deeper at this.

Thanks for the review!

-- Steve

> >
> >         /*
> > @@ -386,7 +385,7 @@ load_plugins(struct tep_handle *tep, const char
> > *suffix,
> >          * check that first.
> >          */
> >  #ifdef PLUGIN_DIR
> > -       if (!(tep->flags & TEP_DISABLE_SYS_PLUGINS))
> > +       if (!tep || !(tep->flags & TEP_DISABLE_SYS_PLUGINS))
> >                 load_plugins_dir(tep, suffix, PLUGIN_DIR,
> >                                  load_plugin, data);
> >  #endif
> > @@ -423,7 +422,7 @@ tep_load_plugins(struct tep_handle *tep)
> >  {
> >         struct tep_plugin_list *list = NULL;
> >
> > -       load_plugins(tep, ".so", load_plugin, &list);
> > +       tep_load_plugins_hook(tep, ".so", load_plugin, &list);
> >         return list;
> >  }
