Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E082D1A15
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 20:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgLGTze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 14:55:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49413 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725947AbgLGTze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 14:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607370847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tFrKOV1BLc45Eb5xzztDBxsVCtCYfxdlUliSYWsrF50=;
        b=WdQDAzjHG2dLqmbF/nSvFOE2GXGf57VasnT05nwnQtSYviAzdkneH65+ccMK/xcbj7aqqq
        TNvXl9l7m/CGmtMc0pQD+S/Zt6Afrz8ayOrbtikVXkWpKGV9UoRq79U9S1fYZ2xVlxFu+i
        enmIO9ou/jNKad8m98qcaBJtDIboORw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-9JQsb76OP-uKbg4ike39rQ-1; Mon, 07 Dec 2020 14:54:06 -0500
X-MC-Unique: 9JQsb76OP-uKbg4ike39rQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78714192D787;
        Mon,  7 Dec 2020 19:54:04 +0000 (UTC)
Received: from krava (unknown [10.40.192.62])
        by smtp.corp.redhat.com (Postfix) with SMTP id 408241001E73;
        Mon,  7 Dec 2020 19:53:59 +0000 (UTC)
Date:   Mon, 7 Dec 2020 20:53:58 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexei Budankov <abudankov@huawei.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 3/3] perf tools: Allow to list events via control file
Message-ID: <20201207195358.GB4103648@krava>
References: <20201206170519.4010606-1-jolsa@kernel.org>
 <20201206170519.4010606-4-jolsa@kernel.org>
 <20201207162806.GE125383@kernel.org>
 <ebfd55bc-9118-920e-3ffd-0c24833c08b9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebfd55bc-9118-920e-3ffd-0c24833c08b9@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 08:09:06PM +0300, Alexei Budankov wrote:

SNIP

> > sched:sched_move_numa: type: 2, size: 120, config: 0x12c, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ID|CPU|PERIOD|RAW, read_format: ID, disabled: 1, inherit: 1, enable_on_exec: 1, sample_id_all: 1, exclude_guest: 1
> > sched:sched_stick_numa: type: 2, size: 120, config: 0x12b, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ID|CPU|PERIOD|RAW, read_format: ID, disabled: 1, inherit: 1, enable_on_exec: 1, sample_id_all: 1, exclude_guest: 1
> > sched:sched_swap_numa: type: 2, size: 120, config: 0x12a, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ID|CPU|PERIOD|RAW, read_format: ID, disabled: 1, inherit: 1, enable_on_exec: 1, sample_id_all: 1, exclude_guest: 1
> > sched:sched_wake_idle_without_ipi: type: 2, size: 120, config: 0x129, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ID|CPU|PERIOD|RAW, read_format: ID, disabled: 1, inherit: 1, enable_on_exec: 1, sample_id_all: 1, exclude_guest: 1
> > # Tip: use 'perf evlist --trace-fields' to show fields for tracepoint events
> > [acme@five ~]$
> > 
> > Also I think we should use 'evlist' instead of 'list', to be consistent.
> 
> FWIW,
> 
> Or may be even name the command starting with a verb like 'list_events'

I think evlist is better because there's 'perf evlist' command

thanks,
jirka

