Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06E92F764C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 11:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbhAOKKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 05:10:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20007 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726484AbhAOKKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 05:10:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610705318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0H6FRAzGkQ+YmvRRrLcGZORaAK/rqd8MdD3CZsENJzY=;
        b=GZLoQbWcM5DhdPc9SoZM5bWed39JXUF4/0ZDDD3AjlGfiGphbm7vRyrHmFCs0QUEVwX0wK
        sbkUjrBsAGDp2AcT1hmrWKEp/Fn6RT23gV7HYbHAUgVfhyeApv9OXJmHLboUuxPkBpifpo
        a0BTvcYurXBMK80vEZ6fAdgo5am17i4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-LHZ11OHKPTeZmEzckqrVgg-1; Fri, 15 Jan 2021 05:08:37 -0500
X-MC-Unique: LHZ11OHKPTeZmEzckqrVgg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D49E4800C7A;
        Fri, 15 Jan 2021 10:08:34 +0000 (UTC)
Received: from krava (unknown [10.40.194.69])
        by smtp.corp.redhat.com (Postfix) with SMTP id CD5F860BF3;
        Fri, 15 Jan 2021 10:08:30 +0000 (UTC)
Date:   Fri, 15 Jan 2021 11:08:29 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>
Subject: Re: [PATCH v7 5/5] perf metric: Don't compute unused events.
Message-ID: <20210115100829.GA1478666@krava>
References: <20210112230434.2631593-1-irogers@google.com>
 <20210112230434.2631593-6-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112230434.2631593-6-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 03:04:34PM -0800, Ian Rogers wrote:
> For a metric like:
>   EVENT1 if #smt_on else EVENT2
> 
> currently EVENT1 and EVENT2 will be measured and then when the metric is
> reported EVENT1 or EVENT2 will be printed depending on the value from
> smt_on() during the expr parsing. Computing both events is unnecessary and
> can lead to multiplexing as discussed in this thread:
> https://lore.kernel.org/lkml/20201110100346.2527031-1-irogers@google.com/
> 
> This change modifies the expression parsing code by:
>  - getting rid of the "other" parsing and introducing a boolean argument
>    to say whether ids should be computed or not.
>  - expressions are changed so that a pair of value and ids are returned.
>  - when computing the metric value the ids are unused.
>  - when computing the ids, constant values and smt_on are assigned to
>    the value.
>  - If the value is from an event ID then the event is added to the ids
>    hashmap and the value set to bottom (encoded as NAN).
>  - Typically operators union IDs for their inputs and set the value to
>    bottom, however, if the inputs are constant then these are computed and
>    propagated as the value.
>  - If the input is constant to certain operators like:
>  IDS1 if CONST else IDS2
>    then the result will be either IDS1 or IDS2 depending on CONST (which
>    may be evaluated from an entire expression), and so IDS1 or IDS2 may
>    be discarded avoiding events from being programmed.
>  - The ids at the end of parsing are added to the context.

there's lot of refactoring going on, any chance this could be broken
down to more patches?

thanks,
jirka

