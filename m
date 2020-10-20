Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020BC28CEDA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 15:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbgJMNCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 09:02:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbgJMNCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 09:02:32 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 110CC22B2C;
        Tue, 13 Oct 2020 13:02:29 +0000 (UTC)
Date:   Tue, 13 Oct 2020 09:02:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zamir SUN <sztsian@gmail.com>
Cc:     Tony Jones <tonyj@suse.de>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Ziqian SUN (Zamir)" <zsun@redhat.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Yordan Karadzhov <ykaradzhov@vmware.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Al Stone <ahs3@debian.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [ANNOUNCE] libtraceevent.git
Message-ID: <20201013090228.78256290@gandalf.local.home>
In-Reply-To: <CAHnb8o61XwvgkMnryaOv-=qCDf-o5OpezQAAk-44R+KgCc8Vcw@mail.gmail.com>
References: <20201007130750.49349844@gandalf.local.home>
        <20201012101208.GF1099489@krava>
        <20201012111950.55a73588@gandalf.local.home>
        <20201012184120.GN13697@suse.de>
        <20201012151732.6e439886@gandalf.local.home>
        <CAHnb8o61XwvgkMnryaOv-=qCDf-o5OpezQAAk-44R+KgCc8Vcw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Oct 2020 11:06:16 +0800
Zamir SUN <sztsian@gmail.com> wrote:

> On Tue, Oct 13, 2020 at 3:17 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> >
> > [ Removing the powertop mailing list because it's rejecting everything ]
> >
> > On Mon, 12 Oct 2020 11:41:20 -0700
> > Tony Jones <tonyj@suse.de> wrote:
> >  
> > > On Mon, Oct 12, 2020 at 11:19:50AM -0400, Steven Rostedt wrote:
> > >  
> > > > Once it's shown that it works for all the package maintainers, I will tag
> > > > it which should create the tarballs automatically on the above link.  
> > >
> > > Hi.
> > >
> > > It builds fine for me after manually creating the tarball from git.
> > > Once there is an official versioned tarball I'll push it into
> > > openSUSE.
> > >
> > > I presume some perf Makefile changes will be forthcoming to use it,
> > > rather than continuing to force build it out of TRACE_EVENT_DIR
> > >  
> >
> > Zamir found this issue with the Documentation man pages:
> >
> > Note, I'm not sure the proper way to fix this. I think this is the last
> > issue I need to resolve before making the tag.
> >  
> 
> If anyone interested in, the discussion of this document compiling is
> in the thread "libtraceevent: make doc-install tries different file
> names than generated".
> 
> With the patch Steve mentioned, I can package this in RPM already. And
> it's pending review in Fedora now.
> https://bugzilla.redhat.com/show_bug.cgi?id=1887470
> 
> So, for me, there is no more issue for Fedora packaging.
> 

So should I just add that one patch and tag it?

-- Steve
