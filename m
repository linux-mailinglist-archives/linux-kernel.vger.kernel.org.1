Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E7A2B5CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 11:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgKQKUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 05:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgKQKUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:20:06 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FC0C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 02:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/K+4+Zm/ZKgF8bJkUMhAJ+qFtGVKkOc3Jr86ss2O0EM=; b=hx7OM4qWwP4IFbkWrOdoVny4BJ
        xmDTfQyihxlNbAZo7seF3pOAXvnjAdB+BI7u30SRaUXNKoVw/QFOvCYy6vhJNx6qJ8SeA1E7Y8/O9
        5kUG5ra5vW+ffz+m7EpgQo+xTExXAV6a5DKJTPzgGqDQHOLPcOnoIW1u26I4mp8U/B0c5x3xaZ3VP
        jFLiDiJ501B2cGvyG+NgbKXYpGa5hkjm5lmvlW+HAnCmwYdHGtjcyorNrMcknjAH1QWm6afVRr78J
        ZhH7aUM7K/H2yH8d5dWOTj6ZANyMxXhXW42rdGYUpvsCRwK7HW4x7/V4xc7s8J1uOXLerA0sNwsDj
        SpUvNNaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1key5c-0006A4-6O; Tue, 17 Nov 2020 10:19:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D86E1304D28;
        Tue, 17 Nov 2020 11:19:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C2CB2200DCF08; Tue, 17 Nov 2020 11:19:54 +0100 (CET)
Date:   Tue, 17 Nov 2020 11:19:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH] perf/x86: fix sysfs type mismatches
Message-ID: <20201117101954.GD3121406@hirez.programming.kicks-ass.net>
References: <20201113183126.1239404-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113183126.1239404-1-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 10:31:26AM -0800, Sami Tolvanen wrote:
> This change switches rapl to use PMU_FORMAT_ATTR, and fixes two other
> macros to use device_attribute instead of kobj_attribute to avoid
> callback type mismatches that trip indirect call checking with Clang's
> Control-Flow Integrity (CFI).
> 
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Thanks!
