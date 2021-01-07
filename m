Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C682ECF60
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 13:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbhAGMOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 07:14:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24971 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725835AbhAGMOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 07:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610021570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w+Qhkxk/Uv91dwi/kOmRndgNe4yDhOMBToriQzlJFT8=;
        b=dOWBsoA0fkDg0hy6Rb7pNQiHuYjTT4bioo2YfBtu9GQAu7O3MsMoR/Rc0nd99/jJEuzJg0
        Ngw9SoxYgVZmbxZVnZd5kX+vJdiVIKrFaiA43m+uYeW0s/4NEWfkIDsrd4+PQDzH9uaCIy
        06acZQPLu69ErhO+tU6AYlk6EdYRTrY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-pf5bByIHNuuh1dDfOYeIJQ-1; Thu, 07 Jan 2021 07:12:46 -0500
X-MC-Unique: pf5bByIHNuuh1dDfOYeIJQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AADE1107ACE3;
        Thu,  7 Jan 2021 12:12:44 +0000 (UTC)
Received: from krava (unknown [10.40.194.125])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7C29519C66;
        Thu,  7 Jan 2021 12:12:41 +0000 (UTC)
Date:   Thu, 7 Jan 2021 13:12:40 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCHv4 0/4] perf tools: Allow to enable/disable events via
 control pipe
Message-ID: <20210107121240.GA1019522@krava>
References: <20201226232038.390883-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201226232038.390883-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 27, 2020 at 12:20:34AM +0100, Jiri Olsa wrote:
> hi,
> adding support to enable/disable specific events via control
> file via following commands:
> 
>     # echo 'enable sched:sched_process_fork' > control
>     # echo 'disabled sched:sched_process_fork' > control
> 
> v4 changes:
>   - some of the patches got merged
>   - rebased to latest perf/core
>   - fixed changelogs
>   - added 'ping' command

any reviews?

thanks,
jirka

> 
> v3 changes:
>   - use ' ' instead of '-' in syntax and add command argument
>     processing [Arnaldo]
>   - add options to evlist [Arnaldo]
>   - add man page changes
> 
> v2 changes:
>   - added acks
>   - change list to evlist [Arnaldo]
>   - add evlist-verbose command [Arnaldo]
>   - add '' to enale-/disable- error message
> 
> The code is available in here:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/control
> 
> thanks,
> jirka
> 
> 
> ---
> Jiri Olsa (4):
>       perf tools: Allow to enable/disable events via control file
>       perf tools: Add evlist control command
>       perf tools: Add stop control command
>       perf tools: Add ping control command
> 
>  tools/perf/Documentation/perf-record.txt |  15 ++++++++++++---
>  tools/perf/builtin-record.c              |  13 +++++++------
>  tools/perf/builtin-stat.c                |   5 +++--
>  tools/perf/util/evlist.c                 | 112 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  tools/perf/util/evlist.h                 |   6 ++++++
>  tools/perf/util/evsel_fprintf.c          |   2 ++
>  tools/perf/util/python-ext-sources       |   1 +
>  tools/perf/util/setup.py                 |   2 +-
>  8 files changed, 141 insertions(+), 15 deletions(-)
> 

