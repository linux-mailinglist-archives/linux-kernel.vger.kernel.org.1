Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEF82AF0B3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 13:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgKKMf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 07:35:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49692 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725961AbgKKMf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 07:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605098156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hNIxXbf0SUtcQ+Hy3GDc6BVT+MewuFvqFKpLUS9Lq+E=;
        b=QEjUHCQ/2URoTn+kUTBwJqAsK9IKAMNwLzRgtzK1ZA0OF1jGFWpgGdWPrBZc5ie/9KzYi7
        HoFYXKLXZYUB8rSKXDUp65nP038qSVAg0mUhOxT0bZZEH6DGWvMYjRPD7AKlOg4C20nL2j
        evT3R4oyPG4ntAAX5cacBkuPkNUKlVY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-etZK_Q43M364TTBlcON6IA-1; Wed, 11 Nov 2020 07:35:52 -0500
X-MC-Unique: etZK_Q43M364TTBlcON6IA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 760761017DC3;
        Wed, 11 Nov 2020 12:35:49 +0000 (UTC)
Received: from krava (unknown [10.40.194.237])
        by smtp.corp.redhat.com (Postfix) with SMTP id EF1371002C2D;
        Wed, 11 Nov 2020 12:35:43 +0000 (UTC)
Date:   Wed, 11 Nov 2020 13:35:42 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Al Grant <Al.Grant@arm.com>, James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/9] perf mem/c2c: Support AUX trace
Message-ID: <20201111123542.GK387652@krava>
References: <20201106094853.21082-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106094853.21082-1-leo.yan@linaro.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 05:48:44PM +0800, Leo Yan wrote:

SNIP

> Changes from v3:
> * Added back the patch 06/09 for introducing the itrace option '-M'
>   (Jiri);
> * Added 'itrace_synth_opts' for memory event (Jiri);
> * Dropped type 'ldst' so don't change any usages for tools (Ian);
> * Dropped the patch "perf mem: Return NULL for event 'ldst' on
>   PowerPC" due type 'ldst' is not added anymore (Ian);
> * Added patch 04/09 "perf c2c: Support memory event
>   PERF_MEM_EVENTS__LOAD_STORE", so can convert the load/store requests
>   to event PERF_MEM_EVENTS__LOAD_STORE (James Clark).
> 
> 
> Leo Yan (9):
>   perf mem: Search event name with more flexible path
>   perf mem: Introduce weak function perf_mem_events__ptr()
>   perf mem: Support new memory event PERF_MEM_EVENTS__LOAD_STORE
>   perf c2c: Support memory event PERF_MEM_EVENTS__LOAD_STORE
>   perf mem: Only initialize memory event for recording
>   perf auxtrace: Add itrace option '-M' for memory events
>   perf mem: Support AUX trace
>   perf c2c: Support AUX trace
>   perf mem: Support Arm SPE events

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

