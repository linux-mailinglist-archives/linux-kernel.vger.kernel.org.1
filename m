Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5AD62DB0DA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 17:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbgLOQEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 11:04:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:43764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730648AbgLOQEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 11:04:00 -0500
Date:   Tue, 15 Dec 2020 13:03:32 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608048199;
        bh=MpNBMUCnw7FLCqgC/Rqie4175x+gGZruV6wF+wP9K48=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=MP2fUgxIycnhXuDCAnpl2v8KbgEPqGStWwo3LsNH+/q3wxMI6z+gexf8xaGIb490S
         Qm92+pxr6k2BipP9MfXX76/sTCtnJMb3f+9oSnrHlE2rm98XrAvEdYjibWGTGBk0kF
         cYCwPoPv7K2XEwCh9e8FvZ56URwH5BQdv6AuYQbhRqJZ6QN7S8HLJr2eiGZmLVLfFp
         TT9ZujLSXnq/uaU9eWF0UJUBz/PUESU3V1YgD7kkD6oNV69/jAP1Wjj/9j/bDvWwr8
         5FeUA32Wm4UEg9ubn7+8K1wrEJ2kv9CyPC6G9y5uAn+UfDG0gVGlT0LLeexNDaRjX+
         IkQAsJpnZWUBQ==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 2/3] perf tools: Allow to enable/disable events via
 control file
Message-ID: <20201215160332.GN258566@kernel.org>
References: <20201210204330.233864-1-jolsa@kernel.org>
 <20201210204330.233864-3-jolsa@kernel.org>
 <20201215151413.GE252952@kernel.org>
 <20201215152420.GC658008@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215152420.GC658008@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 15, 2020 at 04:24:20PM +0100, Jiri Olsa escreveu:
> On Tue, Dec 15, 2020 at 12:14:13PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Dec 10, 2020 at 09:43:29PM +0100, Jiri Olsa escreveu:
> > > Adding new control events to enable/disable specific event.
> > > The interface string for control file are:
> > > 
> > >   'enable-<EVENT NAME>'
> > >   'disable-<EVENT NAME>'
> > 
> > Wwy do we have "enable-" as the "tag" for this?
> 
> the whole 'enable-' is prefix for command that enables specific event
> following '-' starts the event name
> 
> > 
> > Also is it possible to use "enable sched:*" and have that match what is
> > in the evlist and enable (or disable, if using "disable sched:*") what
> > matches?
> 
> yep, that should be possible to add
> 
> > 
> > This second suggestion can be done on top of this, i.e. as an
> > enhancement, but mixing up the command (enable, disable) with its
> > arguments looks strange.
> 
> the '-' determines that there's event name following,
> pure 'enable' switches on everything

I see it, but why not use the more natural ' ' space to separate the
command from its arguments? Just like in a bash command line, say?

I.e. why not:

  enable

to enable everything, and:

  enable sched:sched_switch

To enable just the "sched:sched_switch" event?

- Arnaldo
