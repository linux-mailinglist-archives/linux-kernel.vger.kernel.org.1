Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905902C7560
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbgK1VtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:49:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38026 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727455AbgK0Tp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 14:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606506349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5gA9oQYSyBT4Z0vJhRDeAJKF5kHu/LWhQyfFb1ooOvQ=;
        b=UzBGcVRF/atUJ5X3W1838AP1FQTJfw1+BMYQDY/1ngYHdndq92Ryz6B/gYEndA0g0+Bfmu
        fDyHuz6zpoXv/PW5NqNuSCAuUWTpfv/BpGPf1qLRTszqiSXqUFYgsIILuZ3ZjJXdARrafv
        4gKvwSJOF5hrCX6TiFbaE0H5+NtlgKQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-5Rvl11ApMEKCsSqgButfqw-1; Fri, 27 Nov 2020 14:45:45 -0500
X-MC-Unique: 5Rvl11ApMEKCsSqgButfqw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 349E01005D50;
        Fri, 27 Nov 2020 19:45:43 +0000 (UTC)
Received: from krava (unknown [10.40.194.2])
        by smtp.corp.redhat.com (Postfix) with SMTP id EE7DB60BD9;
        Fri, 27 Nov 2020 19:45:39 +0000 (UTC)
Date:   Fri, 27 Nov 2020 20:45:39 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 09/25] perf tools: Add support to read build id from
 compressed elf
Message-ID: <20201127194539.GA2788968@krava>
References: <20201126170026.2619053-1-jolsa@kernel.org>
 <20201126170026.2619053-10-jolsa@kernel.org>
 <20201126174620.GA70905@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126174620.GA70905@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 02:46:20PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Nov 26, 2020 at 06:00:10PM +0100, Jiri Olsa escreveu:
> > Adding support to decompress file before reading build id.
> > 
> > Adding filename__read_build_id and change its current
> > versions to read_build_id.
> > 
> > Shutting down stderr output of perf list in the shell test:
> >   82: Check open filename arg using perf trace + vfs_getname          : Ok
> > 
> > because with decompression code in the place we the
> > filename__read_build_id function is more verbose in case
> > of error and the test did not account for that.
> 
> There are two patches here, right? Also the test output shows it after,
> before is missing, showing what the test wasn't accounting for.

hum, I'm not sure I understand, the test fails because the change
introduced more terminal output, so I think it needs to be together

> 
> - Arnaldo
>  
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../tests/shell/trace+probe_vfs_getname.sh    |  2 +-
> >  tools/perf/util/symbol-elf.c                  | 37 ++++++++++++++++++-
> >  2 files changed, 36 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> > index 11cc2af13f2b..3660fcc02fef 100755
> > --- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> > +++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> > @@ -20,7 +20,7 @@ skip_if_no_perf_trace || exit 2
> >  file=$(mktemp /tmp/temporary_file.XXXXX)
> >  
> >  trace_open_vfs_getname() {
> > -	evts=$(echo $(perf list syscalls:sys_enter_open* 2>&1 | egrep 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/') | sed 's/ /,/')
> > +	evts=$(echo $(perf list syscalls:sys_enter_open* >&1 2>/dev/nul | egrep 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/') | sed 's/ /,/')

and one extra 'l' missing in /dev/nul ;-) also perhaps the >&1 is superfluous

jirka

