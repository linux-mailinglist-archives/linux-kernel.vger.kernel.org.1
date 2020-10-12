Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA6328BBAC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389838AbgJLPTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:19:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389771AbgJLPTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:19:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F8862076D;
        Mon, 12 Oct 2020 15:19:52 +0000 (UTC)
Date:   Mon, 12 Oct 2020 11:19:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        Zamir SUN <sztsian@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        zsun@redhat.com, Vitaly Chikunov <vt@altlinux.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Yordan Karadzhov <ykaradzhov@vmware.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Tony Jones <tonyj@suse.de>, John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>, powertop@lists.01.org,
        Al Stone <ahs3@debian.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [ANNOUNCE] libtraceevent.git
Message-ID: <20201012111950.55a73588@gandalf.local.home>
In-Reply-To: <20201012101208.GF1099489@krava>
References: <20201007130750.49349844@gandalf.local.home>
        <20201012101208.GF1099489@krava>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Oct 2020 12:12:08 +0200
Jiri Olsa <jolsa@redhat.com> wrote:

> On Wed, Oct 07, 2020 at 01:07:50PM -0400, Steven Rostedt wrote:
> > I split out tools/lib/traceevent from the kernel tree using "git subtree",
> > which recreates all the commits of a directory and makes that directory a
> > stand alone. I then updated the Makefiles, and copied over some of the
> > header files used to build the library. I pushed this up to:
> > 
> >   https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/
> > 
> > My hope is that this will now be the source of all updates to the
> > libtraceevent library that can be used as a stand alone package that both
> > perf and tracecmd can use. I would also like powertop and rasdaemon to use
> > this as well.  
> 
> hi,
> I'm adding this as fedora package, is there a source arhive somewhere
> in git.kernel.org for libtraceevent that spec could download?
> 

Hi Jiri!

Once it's shown that it works for all the package maintainers, I will tag
it which should create the tarballs automatically on the above link. But I
wanted to fix all the packaging bugs before doing so. I hope this doesn't
make it into a catch-22. Where you can't package till there's a source
tarball, but I can't make a source tarball until I know you can package
it ;-)

-- Steve

