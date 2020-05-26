Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437521E3150
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 23:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390310AbgEZVlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 17:41:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36790 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390013AbgEZVlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 17:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YfUnwlF87BHKUnjZClLXeqPvxvA2sw0C8ADZZj9RRFA=; b=YGrPpPgePF7qfhH/HLM3Fx26ql
        Q9L0tUaFmEzyxty8+CCxLqK4pKy10xWivwJ8xD89SzqmebHFka3ag5klQ7X9XSQhlHOxTZrTqCFOk
        dql936h8Y6onfgcozl1GxKANkSzcphger8ckqFtKGRA0Z1byzIKsGPSe3OcntMpe8eyapEyyqcDIj
        jYWGR9AqHV3RE+uJq694fMqFST6Gnop7gX+eospUZmF70NpsbEwh5o0KVOEmbyeNNwXhMfqPy+8co
        S1o2uqrkvqzoRhodaxClGS3BodMYSxJDJ7JapulRb4ixf3HGD2ygqYydIV1onj1YYRRkrVUZf9kb+
        oO7MykAg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdhIC-0007q1-DT; Tue, 26 May 2020 21:39:24 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 56F669834AB; Tue, 26 May 2020 23:39:13 +0200 (CEST)
Date:   Tue, 26 May 2020 23:39:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [RFC] perf/core: allow ftrace for functions in
 kernel/event/core.c
Message-ID: <20200526213913.GG2483@worktop.programming.kicks-ass.net>
References: <20200526212826.4097888-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526212826.4097888-1-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 02:28:26PM -0700, Song Liu wrote:
> It is useful to trace functions in kernel/event/core.c. Allow ftrace for
> them by removing $(CC_FLAGS_FTRACE) from Makefile.

Did you try using the ftrace event with perf with this on?
