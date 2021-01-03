Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8F12E8EB8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 23:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbhACWx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 17:53:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55363 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726019AbhACWxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 17:53:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609714348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HbOe2bYAAuE9fhSTVX9AdEfAuXcyidg3sV/DLg0ptrQ=;
        b=YYCpbsOYRtWRoqI0lYCnwS363orMjSosZD4O59CZQhtO2MJ9GwuqPTuHG5MGJXEBWHHXJU
        0yp60JMH8PiOaaTvddQIC66nKEvk50Ilo2NWLaobsW9Kxnw9F/fw8CZpDQuxZJZTvNasts
        AadF5ytNeltPJeVmQH/mV5oSY8uIvOY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-ch8GWXr7O9K4IHsjz2o_mQ-1; Sun, 03 Jan 2021 17:52:25 -0500
X-MC-Unique: ch8GWXr7O9K4IHsjz2o_mQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 683FB107ACE4;
        Sun,  3 Jan 2021 22:52:23 +0000 (UTC)
Received: from krava (unknown [10.40.192.17])
        by smtp.corp.redhat.com (Postfix) with SMTP id E9AD21A8A3;
        Sun,  3 Jan 2021 22:52:19 +0000 (UTC)
Date:   Sun, 3 Jan 2021 23:52:19 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Joe Mario <jmario@redhat.com>, David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/11] perf c2c: Sort cacheline with all loads
Message-ID: <20210103225219.GA850408@krava>
References: <20201213133850.10070-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201213133850.10070-1-leo.yan@linaro.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 13, 2020 at 01:38:39PM +0000, Leo Yan wrote:
> This patch set is to sort cache line for all load operations which hit
> any cache levels.  For single cache line view, it shows the load
> references for loads with cache hits and with cache misses respectively.
> 
> This series is a following for the old patch set "perf c2c: Sort
> cacheline with LLC load" [1], in the old patch set it tries to sort
> cache line with the load operations in last level cache (LLC), after
> testing we found the trace data doesn't contain LLC events if the
> platform isn't a NUMA system.  For this reason, this series refines the
> implementation to sort on all cache levels hits of load operations; it's
> reasonable for us to review the load and store opreations, if detects
> any cache line is accessed by multi-threads, this hints that the cache
> line is possible for false sharing.
> 
> This patch set is clearly applied on perf/core branch with the latest
> commit db0ea13cc741 ("perf evlist: Use the right prefix for 'struct
> evlist' record methods").  And the changes has been tested on x86 and
> Arm64, the testing result is shown as below.

SNIP

> 
> 
>   [...]
> 
> Changes from v1:
> * Changed from sorting on LLC to sorting on all loads with cache hits;
> * Added patches 06/11, 07/11 for refactoring macros;
> * Added patch 08/11 for refactoring node header, so can display "%loads"
>   rather than "%hitms" in the header;
> * Added patch 09/11 to add local pointers for pointing to output metrics
>   string and sort string (Juri);
> * Added warning in percent_hitm() for the display "all", which should
>   never happen (Juri).
> 
> [1] https://lore.kernel.org/patchwork/cover/1321514/
> 
> 
> Leo Yan (11):
>   perf c2c: Add dimensions for total load hit
>   perf c2c: Add dimensions for load hit
>   perf c2c: Add dimensions for load miss
>   perf c2c: Rename for shared cache line stats
>   perf c2c: Refactor hist entry validation
>   perf c2c: Refactor display filter macro
>   perf c2c: Refactor node display macro
>   perf c2c: Refactor node header
>   perf c2c: Add local variables for output metrics
>   perf c2c: Sort on all cache hit for load operations
>   perf c2c: Update documentation for display option 'all'
> 
>  tools/perf/Documentation/perf-c2c.txt |  21 +-
>  tools/perf/builtin-c2c.c              | 548 ++++++++++++++++++++++----
>  2 files changed, 487 insertions(+), 82 deletions(-)

Joe might want to test it first, but it looks all good to me:

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

