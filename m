Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94554217C09
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 02:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbgGHACv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 20:02:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35650 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbgGHACu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 20:02:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so1144246wmf.0;
        Tue, 07 Jul 2020 17:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vpxopt2Khk0HAnbQE7M23zoSpPESbE8YjxfhosY0Dr4=;
        b=VPLzzsgPbayHzSYAeTrxO1mKE+tgCVCIQx7J9l3DG5VeaqxSbBsmChRIrsXnGIH0dK
         i4kLJZxUIy984nFWHQ8NfOJXTPT/kiob4l5N6ElYPSxx6JQplelltDteXx3XSfZdKMU7
         Rhxbl6ZlE9iLAJaOzSFcJey3VRlY97TjvBAyGQvX6KUONyFAJHIenMRPPkXRiDJ9iOkc
         FY/VrnJfoJeceiTimVtJB5G/EW6O1sn1WA73rH2zdn1FeaLr7txpYPUcaT5o7PLhEWd4
         vLKgKVxDnjq+uhjRaghqN33niIwG5QPfSnpf0BlX+M4XYC9o8HiMPVLSGkEJ9pGM8cZS
         /X0w==
X-Gm-Message-State: AOAM533E+KaHXyUOpnxftJYAsIWW6eJjUKh3Tz1Fyv+uHJRv8U3GwA2y
        jt2rowjYVU4AmdGp55mda4hSYvJkIb0x2XGM0h0=
X-Google-Smtp-Source: ABdhPJzL+mtungvxvI3PHj4vPvRIolyOrH6lVMezOj/m2hU0YHBPrKPGBLrFBbh6jBgcs/j8dw83ahDud1JeS1kp3R0=
X-Received: by 2002:a05:600c:410f:: with SMTP id j15mr6323689wmi.128.1594166568212;
 Tue, 07 Jul 2020 17:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200702185344.913492689@goodmis.org> <20200702185704.248123446@goodmis.org>
 <CAM9d7chfvJwodpVrHGc5E2J80peRojmYV_fD8x3cpn9HFRUw2g@mail.gmail.com> <20200707112407.746cca77@oasis.local.home>
In-Reply-To: <20200707112407.746cca77@oasis.local.home>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 8 Jul 2020 09:02:37 +0900
Message-ID: <CAM9d7cgMgqFDvKhs6xwdBSMsaG=3ZG0RtxwgQDCTLGkML1MY4Q@mail.gmail.com>
Subject: Re: [PATCH v2 05/15] tools lib traceevent: Introduced new traceevent
 API, for adding new plugins directories.
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 12:24 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 8 Jul 2020 00:06:38 +0900
> Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > +/**
> > > + * tep_add_plugin_path - Add a new plugin directory.
> > > + * @tep: Trace event handler.
> > > + * @path: Path to a directory. All files with extension .so in that
> >
> > Is the extension (".so") fixed?  I think a new API has the suffix argument
> > which may change it... ?
>
> So this should add a "suffix" argument? NULL for ".so"?

I think it's just fine to change the comment.  The file extension handling
belongs to the plugin load API and we are adding the directory path
here IMHO.

>
> >
> >
> > > + *       directory will be loaded as plugins.
> > > + *@prio: Load priority of the plugins in that directory.
> > > + *
> > > + * Returns -1 in case of an error, 0 otherwise.
> > > + */
> > > +int tep_add_plugin_path(struct tep_handle *tep, char *path,
> > > +                       enum tep_plugin_load_priority prio)
> > > +{
> > > +       struct tep_plugins_dir *dir;
> > > +
> > > +       if (!tep || !path)
> > > +               return -1;
> > > +
> > > +       dir = calloc(1, sizeof(*dir));
> > > +       if (!dir)
> > > +               return -1;
> > > +
> > > +       dir->path = strdup(path);
> >
> > It needs to check the return value..
>
> Yes it does indeed.
>
> BTW, since these patches are already in trace-cmd.git, would be OK if
> we just write patches on top of this series to address your concerns.
> This way, we would be also adding them to trace-cmd.git as well.

I'm ok with it.  I'll review more patches soon..

Thanks
Namhyung

>
> I eventually want a separate libraries repo on kernel.org that this
> lives in and remove it from the tools/lib directory of the kernel.
>
> -- Steve
>
>
> >
> > > +       dir->prio = prio;
> > > +       dir->next = tep->plugins_dir;
> > > +       tep->plugins_dir = dir;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +void tep_free_plugin_paths(struct tep_handle *tep)
> > > +{
> > > +       struct tep_plugins_dir *dir;
> > > +
> > > +       if (!tep)
> > > +               return;
> > > +
> > > +       dir = tep->plugins_dir;
> > > +       while (dir) {
> > > +               tep->plugins_dir = tep->plugins_dir->next;
> > > +               free(dir->path);
> > > +               free(dir);
> > > +               dir = tep->plugins_dir;
> > > +       }
> > > +}
> > > +
> > >  void
> > >  tep_unload_plugins(struct tep_plugin_list *plugin_list, struct tep_handle *tep)
> > >  {
> > > --
> > > 2.26.2
> > >
> > >
>
