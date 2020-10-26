Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A60298C2D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 12:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1773918AbgJZLkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 07:40:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24977 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1773909AbgJZLkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 07:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603712418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yep4jRy6ziN1RLOThgwnCajSDdRmWtdV3n/5N4e8G8Q=;
        b=Z5NeDghUNfUPBW6X72tTPJ9sMbLAgA2PlzvKvxgP1MN50LMtEGzLXq5jHx3rSrM5vWV0OL
        JibzvzM7zLRL2vIyDlf+FbmyME7/tcqGfKf6Sfx6jimkgFZmDYT+umxbpKHgFvRtFg7wBp
        OKPIE0zCgt82qlrrozOStaAk8RIMKkQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-23dOgxJZMGCB8lCc8HljqA-1; Mon, 26 Oct 2020 07:40:14 -0400
X-MC-Unique: 23dOgxJZMGCB8lCc8HljqA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 216968030A9;
        Mon, 26 Oct 2020 11:40:12 +0000 (UTC)
Received: from krava (unknown [10.40.194.69])
        by smtp.corp.redhat.com (Postfix) with SMTP id EF36860C07;
        Mon, 26 Oct 2020 11:40:09 +0000 (UTC)
Date:   Mon, 26 Oct 2020 12:40:09 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2 2/2] perf stat: Support regex pattern in
 --for-each-cgroup
Message-ID: <20201026114009.GD2726983@krava>
References: <20201024025918.453431-1-namhyung@kernel.org>
 <20201024025918.453431-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201024025918.453431-2-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 24, 2020 at 11:59:18AM +0900, Namhyung Kim wrote:
> To make the command line even more compact with cgroups, support regex
> pattern matching in cgroup names.
> 
>   $ perf stat -a -e cpu-clock,cycles --for-each-cgroup ^foo sleep 1
> 
>           3,000.73 msec cpu-clock                 foo #    2.998 CPUs utilized
>     12,530,992,699      cycles                    foo #    7.517 GHz                      (100.00%)
>           1,000.61 msec cpu-clock                 foo/bar #    1.000 CPUs utilized
>      4,178,529,579      cycles                    foo/bar #    2.506 GHz                      (100.00%)
>           1,000.03 msec cpu-clock                 foo/baz #    0.999 CPUs utilized
>      4,176,104,315      cycles                    foo/baz #    2.505 GHz                      (100.00%)

just curious.. there was another foo/XXX group using the
rest of the cycles, right?


also perhaps we want to warn if there's no match found:

	$ sudo ./perf stat -a -e cpu-clock,cycles --for-each-cgroup ^foo sleep 1

	 Performance counter stats for 'system wide':


	       1.002375575 seconds time elapsed

jirka

