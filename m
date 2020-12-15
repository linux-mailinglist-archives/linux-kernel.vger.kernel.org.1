Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F302DB469
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 20:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732025AbgLOTWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 14:22:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57181 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732010AbgLOTVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 14:21:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608060025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e9Ft2jf7WLx7YMIoenNJ17dYCnQX+WoOOkTwQ2EE+ss=;
        b=Bo7qOJhn3BslHy1jGZjg54+4B7/khL0UtQtaBTVkZv7DVYNt1iauxR4e/pw/wEeigQ19gL
        ptDQRnr1tou5ylc7mPdEXwvmtrnyA6sSygppHVq1q6OSoeF36f6NcthL/L9spCWjeFaHEy
        +5/wVlWZFbmp5uSpzFDgbumBgMGcDYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-cphLiQH2M2-vuCnVRn7KdA-1; Tue, 15 Dec 2020 14:20:23 -0500
X-MC-Unique: cphLiQH2M2-vuCnVRn7KdA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 733A8100A440;
        Tue, 15 Dec 2020 19:20:20 +0000 (UTC)
Received: from krava (ovpn-112-106.ams2.redhat.com [10.36.112.106])
        by smtp.corp.redhat.com (Postfix) with SMTP id B27B95D9D7;
        Tue, 15 Dec 2020 19:20:17 +0000 (UTC)
Date:   Tue, 15 Dec 2020 20:20:16 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 4/8] perf daemon: Add daemon command
Message-ID: <20201215192016.GG698181@krava>
References: <20201212104358.412065-1-jolsa@kernel.org>
 <20201212104358.412065-5-jolsa@kernel.org>
 <20201215154408.GE258566@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215154408.GE258566@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 12:44:08PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sat, Dec 12, 2020 at 11:43:54AM +0100, Jiri Olsa escreveu:
> > Adding daemon command that allows to run record sessions
> > on background. Each session represents one perf record
> > process and is configured in config file.
> > 
> > Example:
> > 
> >   # cat config.daemon
> >   [daemon]
> >   base=/opt/perfdata
> > 
> >   [session-1]
> >   run = -m 10M -e cycles -o /opt/perfdata/1/perf.data --overwrite --switch-output -a
> > 
> >   [session-2]
> >   run = -m 20M -e sched:* -o /opt/perfdata/2/perf.data --overwrite --switch-output -a
> > 
> > Default perf config has the same daemon base:
> > 
> >   # cat ~/.perfconfig
> >   [daemon]
> >   base=/opt/perfdata
> > 
> > Starting the daemon:
> > 
> >   # perf daemon --config config.daemon
> > 
> > Check sessions:
> 
> "Check"? You mean that using 'perf daemon' without any args will just
> attach to whatever daemon is running and list the current sessions?
> 
> So we can only have one daemon running in a machine?
> 
> That seems constraining, perhaps we can give each daemon a name?

as I explained in the other email, the difference is the base path
specified for both daemon and other commands

I made other changes showing line for daemon process itself
with base path:

  $ sudo /opt/perf/bin/perf daemon
  [690174:daemon] base: /opt/perfdata
  [690175:top] perf record -e cycles --switch-output=1m --switch-max-files=6 -a

  $ sudo /opt/perf/bin/perf daemon -v
  [690174:daemon] base: /opt/perfdata
    output:  /opt/perfdata/output
    lock:    /opt/perfdata/lock
    up:      268 minutes
  [690175:top] perf record -e cycles --switch-output=1m --switch-max-files=6 -a
    base:    /opt/perfdata/top
    output:  /opt/perfdata/top/output
    control: /opt/perfdata/top/control
    ack:     /opt/perfdata/top/ack
    up:      268 minutes

jirka

