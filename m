Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B228F2F6A75
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbhANTEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:04:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54273 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725883AbhANTEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610650992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kubOwUj/d7znz4Yip6++7WqwszGyBPvcwoco319NAmY=;
        b=EF4IguKEOUDkoghdX8Bi9tFKAnI0hmn8O3bo/H1XOycP9qw+jO7TCp8DgX2YCIrEc0ZZlo
        lM7v6TZ3jCac54a7KQ0pwM+epnZnNDIgl7VIAsL/TGJDl+FTxPNw455EhudEFSW/6s7R0r
        7OXRmlsF5szkrv5/bFfsUgUgWjtMktw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-2lrGg-GmOTGHVP2ofAclPA-1; Thu, 14 Jan 2021 14:03:08 -0500
X-MC-Unique: 2lrGg-GmOTGHVP2ofAclPA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E6BC1937FC1;
        Thu, 14 Jan 2021 19:03:06 +0000 (UTC)
Received: from krava (unknown [10.40.195.188])
        by smtp.corp.redhat.com (Postfix) with SMTP id 91E3D5D734;
        Thu, 14 Jan 2021 19:03:03 +0000 (UTC)
Date:   Thu, 14 Jan 2021 20:03:02 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        David Laight <David.Laight@aculab.com>,
        Jin Yao <yao.jin@linux.intel.com>
Subject: Re: [PATCH v2] perf test: Fix shadow stat test for non-bash shells
Message-ID: <20210114190302.GE1416940@krava>
References: <20210114050609.1258820-1-namhyung@kernel.org>
 <20210114182022.GA307547@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114182022.GA307547@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 03:20:22PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jan 14, 2021 at 02:06:09PM +0900, Namhyung Kim escreveu:
> > It was using some bash-specific features and failed to parse when
> > running with a different shell like below:
> > 
> >   root@kbl-ppc:~/kbl-ws/perf-dev/lck-9077/acme.tmp/tools/perf# ./perf test 83 -vv
> >   83: perf stat metrics (shadow stat) test                            :
> >   --- start ---
> >   test child forked, pid 3922
> >   ./tests/shell/stat+shadow_stat.sh: 19: ./tests/shell/stat+shadow_stat.sh: [[: not found
> >   ./tests/shell/stat+shadow_stat.sh: 24: ./tests/shell/stat+shadow_stat.sh: [[: not found
> >   ./tests/shell/stat+shadow_stat.sh: 30: ./tests/shell/stat+shadow_stat.sh: [[: not found
> >   (standard_in) 2: syntax error
> >   ./tests/shell/stat+shadow_stat.sh: 36: ./tests/shell/stat+shadow_stat.sh: [[: not found
> >   ./tests/shell/stat+shadow_stat.sh: 19: ./tests/shell/stat+shadow_stat.sh: [[: not found
> >   ./tests/shell/stat+shadow_stat.sh: 24: ./tests/shell/stat+shadow_stat.sh: [[: not found
> >   ./tests/shell/stat+shadow_stat.sh: 30: ./tests/shell/stat+shadow_stat.sh: [[: not found
> >   (standard_in) 2: syntax error
> >   ./tests/shell/stat+shadow_stat.sh: 36: ./tests/shell/stat+shadow_stat.sh: [[: not found
> >   ./tests/shell/stat+shadow_stat.sh: 45: ./tests/shell/stat+shadow_stat.sh: declare: not found
> >   test child finished with -1
> >   ---- end ----
> >   perf stat metrics (shadow stat) test: FAILED!
> 
> Jiri provided an Acked-by for v1, Jiri, can I keep it for this v2?

yep, v2 works for me

Acked-by: Jiri Olsa <jolsa@redhat.com>

jitka

