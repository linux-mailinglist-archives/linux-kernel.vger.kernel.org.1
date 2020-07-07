Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E28021723C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 17:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbgGGPag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 11:30:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729592AbgGGPYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:24:10 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B76F3207CD;
        Tue,  7 Jul 2020 15:24:08 +0000 (UTC)
Date:   Tue, 7 Jul 2020 11:24:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Subject: Re: [PATCH v2 05/15] tools lib traceevent: Introduced new
 traceevent API, for adding new plugins directories.
Message-ID: <20200707112407.746cca77@oasis.local.home>
In-Reply-To: <CAM9d7chfvJwodpVrHGc5E2J80peRojmYV_fD8x3cpn9HFRUw2g@mail.gmail.com>
References: <20200702185344.913492689@goodmis.org>
        <20200702185704.248123446@goodmis.org>
        <CAM9d7chfvJwodpVrHGc5E2J80peRojmYV_fD8x3cpn9HFRUw2g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jul 2020 00:06:38 +0900
Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > +/**
> > + * tep_add_plugin_path - Add a new plugin directory.
> > + * @tep: Trace event handler.
> > + * @path: Path to a directory. All files with extension .so in that  
> 
> Is the extension (".so") fixed?  I think a new API has the suffix argument
> which may change it... ?

So this should add a "suffix" argument? NULL for ".so"?

> 
> 
> > + *       directory will be loaded as plugins.
> > + *@prio: Load priority of the plugins in that directory.
> > + *
> > + * Returns -1 in case of an error, 0 otherwise.
> > + */
> > +int tep_add_plugin_path(struct tep_handle *tep, char *path,
> > +                       enum tep_plugin_load_priority prio)
> > +{
> > +       struct tep_plugins_dir *dir;
> > +
> > +       if (!tep || !path)
> > +               return -1;
> > +
> > +       dir = calloc(1, sizeof(*dir));
> > +       if (!dir)
> > +               return -1;
> > +
> > +       dir->path = strdup(path);  
> 
> It needs to check the return value..

Yes it does indeed.

BTW, since these patches are already in trace-cmd.git, would be OK if
we just write patches on top of this series to address your concerns.
This way, we would be also adding them to trace-cmd.git as well.

I eventually want a separate libraries repo on kernel.org that this
lives in and remove it from the tools/lib directory of the kernel.

-- Steve


> 
> > +       dir->prio = prio;
> > +       dir->next = tep->plugins_dir;
> > +       tep->plugins_dir = dir;
> > +
> > +       return 0;
> > +}
> > +
> > +void tep_free_plugin_paths(struct tep_handle *tep)
> > +{
> > +       struct tep_plugins_dir *dir;
> > +
> > +       if (!tep)
> > +               return;
> > +
> > +       dir = tep->plugins_dir;
> > +       while (dir) {
> > +               tep->plugins_dir = tep->plugins_dir->next;
> > +               free(dir->path);
> > +               free(dir);
> > +               dir = tep->plugins_dir;
> > +       }
> > +}
> > +
> >  void
> >  tep_unload_plugins(struct tep_plugin_list *plugin_list, struct tep_handle *tep)
> >  {
> > --
> > 2.26.2
> >
> >  

