Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C0F2F7487
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 09:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbhAOIqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 03:46:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20341 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730930AbhAOIqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 03:46:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610700298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9VyTGSu/4EdqeONLHwub0wAsTysdWglfufBwrKW4n0M=;
        b=M43QMpv1+99s/WOkPlTBkGJb4Z6xf9wdSvykrOmaOvF83RLBGcH3oTxpmkKn3I/BRSaWS3
        T5ZEeqXSMQDhb9LUy5oWuzqSG5uZtYX4qPY0b6grKqdIN4bR4rORGKw5YHUorjzzzxY9wL
        KfwOUtWkp1qL1r3PRB8ej87pCIfGz+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-nIGqQn1gMb6VBMTslY6LVw-1; Fri, 15 Jan 2021 03:44:52 -0500
X-MC-Unique: nIGqQn1gMb6VBMTslY6LVw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D15671936B6D;
        Fri, 15 Jan 2021 08:44:50 +0000 (UTC)
Received: from krava (unknown [10.40.194.69])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4D26610013C0;
        Fri, 15 Jan 2021 08:44:48 +0000 (UTC)
Date:   Fri, 15 Jan 2021 09:44:47 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Joe Mario <jmario@redhat.com>, David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] perf c2c: Code refactoring
Message-ID: <20210115084447.GC1470103@krava>
References: <20210114154646.209024-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114154646.209024-1-leo.yan@linaro.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 11:46:40PM +0800, Leo Yan wrote:
> This patch series is for several minor code refactoring, which is
> extracted from the patch series "perf c2c: Sort cacheline with all
> loads" [1].
> 
> There has a known issue for Arm SPE store operations and Arm SPE is
> the only consumer for soring with all loads, this is the reason in this
> series drops the changes for dimensions and sorting, and only extracts
> the patches related with code refactoring.  So this series doesn't
> introduce any functionality change.
> 
> The patches have been tested on x86_64 and compared the result before
> and after applying the patches, and confirmed no difference for the
> output result.
> 
> Changes from v3:
> * Refined patch 03/06 to remove unnecessary parentheses and test and
>   return early in the function filter_display() (Joe Perches);
> * Added new patch 04/06 to make argument type as u32 for percent().

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> Changes from v2:
> * Changed to use static functions to replace macros (Namhyung);
> * Added Jiri's Ack tags in the unchanged patches;
> * Minor improvement in the commit logs.
> 
> [1] https://lore.kernel.org/patchwork/cover/1353064/
> 
> 
> Leo Yan (6):
>   perf c2c: Rename for shared cache line stats
>   perf c2c: Refactor hist entry validation
>   perf c2c: Refactor display filter
>   perf c2c: Fix argument type for percent()
>   perf c2c: Refactor node display
>   perf c2c: Add local variables for output metrics
> 
>  tools/perf/builtin-c2c.c | 168 +++++++++++++++++++++++----------------
>  1 file changed, 99 insertions(+), 69 deletions(-)
> 
> -- 
> 2.25.1
> 

