Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4F528E557
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732089AbgJNR1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:27:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732067AbgJNR1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:27:30 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 725F12173E;
        Wed, 14 Oct 2020 17:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602696449;
        bh=urcRiDpreOZGXrgWJTPdPdfjcWzil4vJydUkwWKHjFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v3VBiJH+L1Qdel50WCV2V2GS9qbOORvlj6Leg9nLK4u6GzPB1ZW+NT+4AZmgzMOrp
         E3n/gz+YpiHpQoeWLHwyR3ZMAJAIFEzch6YrNlxMG4/mTLz6ccNiQUe92St8tjkSue
         JM7MaF+jba7nzdX7j3YB30ut0VGxuhnKxKf2Fcy8=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CE3AC4047F; Wed, 14 Oct 2020 14:27:26 -0300 (-03)
Date:   Wed, 14 Oct 2020 14:27:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Peng Fan <fanpeng@loongson.cn>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf bench: Use condition variables in numa.
Message-ID: <20201014172726.GO3100363@kernel.org>
References: <20201012161611.366482-1-irogers@google.com>
 <20201014114500.GB1375972@krava>
 <CAP-5=fWTvVU+M9P8wrsXXbhQ+uZNtgxpjnJt7YHfvPdw9==uuA@mail.gmail.com>
 <20201014161418.GE1395746@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014161418.GE1395746@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 14, 2020 at 06:14:18PM +0200, Jiri Olsa escreveu:
> On Wed, Oct 14, 2020 at 08:39:51AM -0700, Ian Rogers wrote:
> > The pthread_mutex_lock avoids any race on g->nr_tasks_started and
> > g->p.nr_tasks is set up in init() along with all the global state. I
> > don't think there's any race on g->nr_tasks_started and doing a signal
> > for every thread starting will just cause unnecessary wake-ups for the
> > main thread. I think it is better to keep it. I added loops on all the
> > pthread_cond_waits so the code is robust against spurious wake ups.
> 
> ah, I missed that mutex call
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo
