Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0EF297D29
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 17:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761901AbgJXPnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 11:43:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31494 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1761856AbgJXPnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 11:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603554195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i/gwggJc9x2gkMG7QEBWrvLnppzZp7adbTPRAFsXqrU=;
        b=SuGCl4T0ejhV6xs7lW0W4u+msc/ArBhsiCcIaUfFUQRhvquMkC7IyceJxfuAxciMAbm0B2
        JBfn6OHq4NWrEhWjpyk79PUsicZdrz0hbsQ0xj12a9ChRjSTkDtERUX+OEN6YUSjFfk6er
        FPQX+N4+zPisUVtZAjvEDPFEYjTK+II=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-y9WN4gSEM925_K4EiATeqQ-1; Sat, 24 Oct 2020 11:43:13 -0400
X-MC-Unique: y9WN4gSEM925_K4EiATeqQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44909107B470;
        Sat, 24 Oct 2020 15:43:12 +0000 (UTC)
Received: from krava (unknown [10.40.192.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2286186B20;
        Sat, 24 Oct 2020 15:43:09 +0000 (UTC)
Date:   Sat, 24 Oct 2020 17:43:09 +0200
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
Subject: Re: [PATCH v2 00/15] Introduce threaded trace streaming for basic
 perf record operation
Message-ID: <20201024154309.GA2589351@krava>
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 06:52:43PM +0300, Alexey Budankov wrote:
> 
> Changes in v2:
> - explicitly added credit tags to patches 6/15 and 15/15,
>   additionally to cites [1], [2]
> - updated description of 3/15 to explicitly mention the reason
>   to open data directories in read access mode (e.g. for perf report)
> - implemented fix for compilation error of 2/15
> - explicitly elaborated on found issues to be resolved for
>   threaded AUX trace capture
> 
> v1: https://lore.kernel.org/lkml/810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com/
> 
> Patch set provides threaded trace streaming for base perf record
> operation. Provided streaming mode (--threads) mitigates profiling
> data losses and resolves scalability issues of serial and asynchronous
> (--aio) trace streaming modes on multicore server systems. The patch
> set is based on the prototype [1], [2] and the most closely relates
> to mode 3) "mode that creates thread for every monitored memory map".

so what I liked about the previous code was that you could
configure how the threads would be created

default --threads options created thread for each cpu like
in your change:

  $ perf record -v --threads ...
  ...
  thread 0 monitor: 0 allowed: 0
  thread 1 monitor: 1 allowed: 1
  thread 2 monitor: 2 allowed: 2
  thread 3 monitor: 3 allowed: 3
  thread 4 monitor: 4 allowed: 4
  thread 5 monitor: 5 allowed: 5
  thread 6 monitor: 6 allowed: 6
  thread 7 monitor: 7 allowed: 7


then numa based:

  $ perf record -v --threads=numa ...
  ...
  thread 0 monitor: 0-5,12-17 allowed: 0-5,12-17
  thread 1 monitor: 6-11,18-23 allowed: 6-11,18-23


socket based:

  $ perf record -v --threads=socket ...
  ...
  thread 0 monitor: 0-7 allowed: 0-7


core based:

  $ perf record -v --threads=core ...
  ...
  thread 0 monitor: 0,4 allowed: 0,4
  thread 1 monitor: 1,5 allowed: 1,5
  thread 2 monitor: 2,6 allowed: 2,6
  thread 3 monitor: 3,7 allowed: 3,7


and user configurable:

  $ perf record -v  --threads=0-3/0:4-7/4 ...
  ...
  threads: 0. monitor 0-3, allowed 0
  threads: 1. monitor 4-7, allowed 4


so this way you could easily pin threads to cpu/core/socket/numa,
or to some other cpu of your choice, because this will be always
game of try and check where I'm not getting LOST events and not
creating 1000 threads

 perf record: Add support for threads numa option value
 perf record: Add support for threads socket option value
 perf record: Add support for threads core option value
 perf record: Add support for threads user option value

jirka

