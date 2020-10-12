Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FAD28B13F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 11:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbgJLJN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 05:13:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51093 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728859AbgJLJN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 05:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602494037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LfzBE/FgwUq1m0i5a1nd7eVANIytGnMHpB7MFKJjIkQ=;
        b=Bb6D8qBFu1xLHRLWUJtQmYjOJYcjrKMFm/HJ+HNugPtXh4ooqgbePvm+0UfgfPvAhTxYUY
        M7wUSk//pC8X1j1YZeZAKxwLVeZiwd6CaoYk3HQjbPxy+TB3YE2P+y5JHtlF52fBBKBXzX
        pi/SjylsbxShUuQoKhvzqz8GwhGIAuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-EaTJdbepMOyZRJxCadIPIw-1; Mon, 12 Oct 2020 05:13:52 -0400
X-MC-Unique: EaTJdbepMOyZRJxCadIPIw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29FFB802B46;
        Mon, 12 Oct 2020 09:13:51 +0000 (UTC)
Received: from krava (unknown [10.40.195.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id 40F5C10013BD;
        Mon, 12 Oct 2020 09:13:49 +0000 (UTC)
Date:   Mon, 12 Oct 2020 11:13:48 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf c2c: Update usage for showing memory events
Message-ID: <20201012091348.GC1099489@krava>
References: <20201011121022.22409-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201011121022.22409-1-leo.yan@linaro.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 11, 2020 at 08:10:22PM +0800, Leo Yan wrote:
> Since commit b027cc6fdf1b ("perf c2c: Fix 'perf c2c record -e list' to
> show the default events used"), "perf c2c" tool can show the memory
> events properly, it's no reason to still suggest user to use the
> command "perf mem record -e list" for showing events.
> 
> This patch updates the usage for showing memory events with command
> "perf c2c record -e list".
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/builtin-c2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 5938b100eaf4..57bb6cce43e3 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -2916,7 +2916,7 @@ static int perf_c2c__record(int argc, const char **argv)
>  	bool event_set = false;
>  	struct option options[] = {
>  	OPT_CALLBACK('e', "event", &event_set, "event",
> -		     "event selector. Use 'perf mem record -e list' to list available events",
> +		     "event selector. Use 'perf c2c record -e list' to list available events",
>  		     parse_record_events),
>  	OPT_BOOLEAN('u', "all-user", &all_user, "collect only user level data"),
>  	OPT_BOOLEAN('k', "all-kernel", &all_kernel, "collect only kernel level data"),
> -- 
> 2.17.1
> 

