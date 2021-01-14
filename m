Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39DE2F5AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 07:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbhANGvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 01:51:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:48856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726644AbhANGvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 01:51:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05EA523977;
        Thu, 14 Jan 2021 06:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610607038;
        bh=gcgzaGpS/o/lzYiyBhYilYrNeDtX8uHvz/qFx6Euftw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EIe/oN01T1nF1O8rswELkC9Zc+BZT1R/SkEwGyQ6rhFUBxAfG5FHLfC4P7t/MsWhN
         qirHG/80gIVAxqTV6xP6wfqr/ff7V/IJy9HFDe6+afHqEtmkwBeZUig3Ve5lAtkakb
         WOkoRhJbPXxEK0tDKZt5viyx5KmHF5LS6IqCjhVeMMu1dvaShW/lqL+B84MmQ2utMG
         2eHdFtarV2QghQta6imBj5bsLY4lC0NBycZeVXfmdZnrO94w/lPRvlHXEdxlIssSse
         2M/5RfuFapqK3lpPTkqm4ISwT0g+lewWdasrrHb0atrgSrwqGSCTeGq0v824fayxcW
         GD6GGHvSY0W7Q==
Date:   Thu, 14 Jan 2021 15:50:34 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/bootconfig: Add tracing_on support to helper
 scripts
Message-Id: <20210114155034.1132dc7d1c80a3da6a26d554@kernel.org>
In-Reply-To: <20210113181158.1b9df04c@gandalf.local.home>
References: <160749166410.3497930.14204335886811029800.stgit@devnote2>
        <20210113181158.1b9df04c@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021 18:11:58 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> Just noticed this patch. I'm adding it into my queue for the next merge
> window, as it doesn't look too urgent.

Yes, it is not urgent, but it might be better to backport to 5.10.

Thank you,


> 
> -- Steve
> 
> 
> On Wed,  9 Dec 2020 14:27:44 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Add ftrace.instance.INSTANCE.tracing_on support to ftrace2bconf.sh
> > and bconf2ftrace.sh.
> > 
> > commit 8490db06f914 ("tracing/boot: Add per-instance tracing_on
> > option support") added the per-instance tracing_on option,
> > but forgot to update the helper scripts.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  tools/bootconfig/scripts/bconf2ftrace.sh |    1 +
> >  tools/bootconfig/scripts/ftrace2bconf.sh |    4 ++++
> >  2 files changed, 5 insertions(+)
> > 
> > diff --git a/tools/bootconfig/scripts/bconf2ftrace.sh b/tools/bootconfig/scripts/bconf2ftrace.sh
> > index 595e164dc352..feb30c2c7881 100755
> > --- a/tools/bootconfig/scripts/bconf2ftrace.sh
> > +++ b/tools/bootconfig/scripts/bconf2ftrace.sh
> > @@ -152,6 +152,7 @@ setup_instance() { # [instance]
> >  	set_array_of ${instance}.options ${instancedir}/trace_options
> >  	set_value_of ${instance}.trace_clock ${instancedir}/trace_clock
> >  	set_value_of ${instance}.cpumask ${instancedir}/tracing_cpumask
> > +	set_value_of ${instance}.tracing_on ${instancedir}/tracing_on
> >  	set_value_of ${instance}.tracer ${instancedir}/current_tracer
> >  	set_array_of ${instance}.ftrace.filters \
> >  		${instancedir}/set_ftrace_filter
> > diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
> > index 6c0d4b61e0c2..a0c3bcc6da4f 100755
> > --- a/tools/bootconfig/scripts/ftrace2bconf.sh
> > +++ b/tools/bootconfig/scripts/ftrace2bconf.sh
> > @@ -221,6 +221,10 @@ instance_options() { # [instance-name]
> >  	if [ `echo $val | sed -e s/f//g`x != x ]; then
> >  		emit_kv $PREFIX.cpumask = $val
> >  	fi
> > +	val=`cat $INSTANCE/tracing_on`
> > +	if [ `echo $val | sed -e s/f//g`x != x ]; then
> > +		emit_kv $PREFIX.tracing_on = $val
> > +	fi
> >  
> >  	val=
> >  	for i in `cat $INSTANCE/set_event`; do
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
