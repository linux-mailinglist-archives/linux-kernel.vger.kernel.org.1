Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D589029AB52
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 12:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750395AbgJ0L7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 07:59:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38898 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750386AbgJ0L7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 07:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603799958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aYSfCDepul2wbwhMPnzTehYxfINaZW91URrAjANGgCo=;
        b=VIDV6HpQe2u3gmRCfwbUrraS6szpy+ul9D7pX/36pglzz+6O7zrjAQlrv7tN5/2QBb4g9k
        bT2YdKeogKcFVXVobGsRPbNFGEMqrfie6+1j2fIc1/5272jmmdwgZis82R8KcYNO2txjgR
        N3yTEJjBOR1KUED/AccOX6pwqExROjc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-sJv2UQPXPT-5ySi0gTcdmA-1; Tue, 27 Oct 2020 07:59:12 -0400
X-MC-Unique: sJv2UQPXPT-5ySi0gTcdmA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C10061084D74;
        Tue, 27 Oct 2020 11:59:10 +0000 (UTC)
Received: from krava (unknown [10.40.195.208])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9612275154;
        Tue, 27 Oct 2020 11:59:08 +0000 (UTC)
Date:   Tue, 27 Oct 2020 12:59:07 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/15] perf data: open data directory in read access
 mode
Message-ID: <20201027115907.GC2900849@krava>
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
 <dc78ce8b-664c-45b9-ad44-4faaeb5d544f@linux.intel.com>
 <20201024154317.GB2589351@krava>
 <a368355b-4bf3-05b8-9fa0-ee3feb58f8bf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a368355b-4bf3-05b8-9fa0-ee3feb58f8bf@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 08:47:06PM +0300, Alexey Budankov wrote:
> 
> On 24.10.2020 18:43, Jiri Olsa wrote:
> > On Wed, Oct 21, 2020 at 06:57:53PM +0300, Alexey Budankov wrote:
> >>
> >> Open files located at trace data directory in case read access
> >> mode is requested. File are opened and its fds assigned to
> >> perf_data dir files especially for loading data directories
> >> content in perf report mode.
> >>
> >> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> >> ---
> >>  tools/perf/util/data.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> >> index c47aa34fdc0a..6ad61ac6ba67 100644
> >> --- a/tools/perf/util/data.c
> >> +++ b/tools/perf/util/data.c
> >> @@ -321,6 +321,10 @@ static int open_dir(struct perf_data *data)
> >>  		return -1;
> >>  
> >>  	ret = open_file(data);
> >> +	if (!ret && perf_data__is_dir(data)) {
> >> +		if (perf_data__is_read(data))
> >> +			ret = perf_data__open_dir(data);
> >> +	}
> > 
> > perf_data__open_dir is also called from perf_session__new
> > is it called twice?
> 
> It is not called twice. It is in different branches.
> This one is for write and the other one is for read.

hum, is that right?

	# ./perf record --threads 
	^C[ perf record: Woken up 15 times to write data ]
	[ perf record: Captured and wrote 1.421 MB perf.data (515 samples) ]

	# gdb ./perf
	GNU gdb (GDB) Fedora 9.1-6.fc32

	(gdb) b perf_data__open_dir
	Breakpoint 1 at 0x5b4753: file util/data.c, line 72.

	(gdb) r --no-pager report --stdio
	Starting program: /home/jolsa/kernel/linux-perf/tools/perf/perf --no-pager report --stdio

	Breakpoint 1, perf_data__open_dir (data=0x7fffffffb0e0) at util/data.c:72
	72      {
	(gdb) bt
	#0  perf_data__open_dir (data=0x7fffffffb0e0) at util/data.c:72
	#1  0x00000000005b538d in open_dir (data=0x7fffffffb0e0) at util/data.c:326
	#2  0x00000000005b546d in perf_data__open (data=0x7fffffffb0e0) at util/data.c:351
	#3  0x00000000005627e8 in perf_session__new (data=0x7fffffffb0e0, repipe=false, tool=0x7fffffffb220) at util/session.c:210
	#4  0x000000000045a572 in cmd_report (argc=0, argv=0x7fffffffd7a8) at builtin-report.c:1372
	#5  0x00000000004f49ec in run_builtin (p=0xaadab0 <commands+240>, argc=2, argv=0x7fffffffd7a8) at perf.c:312
	#6  0x00000000004f4c59 in handle_internal_command (argc=2, argv=0x7fffffffd7a8) at perf.c:364
	#7  0x00000000004f4da0 in run_argv (argcp=0x7fffffffd5ec, argv=0x7fffffffd5e0) at perf.c:408
	#8  0x00000000004f516c in main (argc=2, argv=0x7fffffffd7a8) at perf.c:538

	(gdb) c
	Continuing.

	Breakpoint 1, perf_data__open_dir (data=0x7fffffffb0e0) at util/data.c:72
	72      {
	(gdb) bt
	#0  perf_data__open_dir (data=0x7fffffffb0e0) at util/data.c:72
	#1  0x0000000000562883 in perf_session__new (data=0x7fffffffb0e0, repipe=false, tool=0x7fffffffb220) at util/session.c:234
	#2  0x000000000045a572 in cmd_report (argc=0, argv=0x7fffffffd7a8) at builtin-report.c:1372
	#3  0x00000000004f49ec in run_builtin (p=0xaadab0 <commands+240>, argc=2, argv=0x7fffffffd7a8) at perf.c:312
	#4  0x00000000004f4c59 in handle_internal_command (argc=2, argv=0x7fffffffd7a8) at perf.c:364
	#5  0x00000000004f4da0 in run_argv (argcp=0x7fffffffd5ec, argv=0x7fffffffd5e0) at perf.c:408
	#6  0x00000000004f516c in main (argc=2, argv=0x7fffffffd7a8) at perf.c:538


AFAICS the second (current) call to perf_data__open_dir will
do the job, because the call you added still does not see
directory with proper version and will bail out on call to
  perf_data__is_single_file

perf_session__open call will read headers and update dir version
so the current perf_data__open_dir will open the directory

jirka

