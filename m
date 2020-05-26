Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F681C94D0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 17:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgEGPUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 11:20:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60525 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725948AbgEGPUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 11:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588864801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lEDflb33kmptJElJGFEePXtYMvwt2BZsPr7hf50RPSY=;
        b=IAtlSzeZQqpFvsVaj9+lxSWD9+mwd/aKvrTBAc+JQ/FyDqkIBeNrxdSLGz7q/Ki/sewmvV
        ueq4rmJNWlxEdP+HLt7DKn7E9ycRsSUcw1eWrt94fhr24s6mR30VBy88YDnWva6bo6L1Gf
        Qi0afy6ngdGMP5c5anwnUVT705MFAfw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-ldwYSd5bMRO5o5DY85gAFw-1; Thu, 07 May 2020 11:19:56 -0400
X-MC-Unique: ldwYSd5bMRO5o5DY85gAFw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 507791005510;
        Thu,  7 May 2020 15:19:55 +0000 (UTC)
Received: from krava (unknown [10.40.194.212])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 23555707B0;
        Thu,  7 May 2020 15:19:52 +0000 (UTC)
Date:   Thu, 7 May 2020 17:19:50 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 3/4] perf stat: Copy counts from prev_raw_counts to
 evsel->counts
Message-ID: <20200507151950.GG2804092@krava>
References: <20200507065822.8255-1-yao.jin@linux.intel.com>
 <20200507065822.8255-4-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507065822.8255-4-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 02:58:21PM +0800, Jin Yao wrote:
> It would be useful to support the overall statistics for perf-stat
> interval mode. For example, report the summary at the end of
> "perf-stat -I" output.
> 
> But since perf-stat can support many aggregation modes, such as
> --per-thread, --per-socket, -M and etc, we need a solution which
> doesn't bring much complexity.
> 
> The idea is to use 'evsel->prev_raw_counts' which is updated in
> each interval and it's saved with the latest counts. Before reporting
> the summary, we copy the counts from evsel->prev_raw_counts to
> evsel->counts, and next we just follow non-interval processing.

I did not realize we already store the count in prev_raw_counts ;-) nice catch!

> 
> In evsel__compute_deltas, this patch saves counts to the position
> of [cpu0,thread0] for AGGR_GLOBAL. After copying counts from
> evsel->prev_raw_counts to evsel->counts, we don't need to
> modify process_counter_maps in perf_stat_process_counter to let it
> work well.

I don't understand why you need to store it in here.. what's the catch
in process_counter_maps?

thanks,
jirka

