Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FACB2FAC79
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 22:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394558AbhARVUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 16:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389683AbhARKMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:12:15 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9A0C061575
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 02:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/hwtfYk7JSTRHzlSI43O5zHuH29/U9J/Rx5PEUyslTM=; b=3CzDYJIr6Z2nifCGUd/oL6dm/C
        b2uYaItqCw9R8hw2KArKJGZ+XeAXxoMu/gS/sAdrtJcbpHoD/Qkd+e9QYG5OyRoEVn4VAQiDWW5Ai
        Sz0AGIJ1l9RLxmnNPW0nuIsMPSEaNcf5bsnUo/AoHeTOydOmhDOe0eu8h7pv7gBJJl32dp343wfhv
        FjDpTu+xdxUCOP/Elw5zwIAJtvHdbPDNud/6OgMXONj4f3Zy8jPTPPg2OkH4US0l0w1xhqbC+kIfi
        9csEYTwipRVBQKgD+hB7dbLZmb4CUCRWMT2QgePPTlahaYfjedE5Fxf7lZbrOBg23aucNDFlRA20l
        OuzHel7w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l1RVP-0004Xi-UB; Mon, 18 Jan 2021 10:11:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6F8F530015A;
        Mon, 18 Jan 2021 11:11:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6061220291083; Mon, 18 Jan 2021 11:11:26 +0100 (CET)
Date:   Mon, 18 Jan 2021 11:11:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Alexey Alexandrov <aalexand@google.com>
Subject: Re: [PATCH] perf/core: Emit PERF_RECORD_LOST for pinned events
Message-ID: <YAVezkTtAkIAImzx@hirez.programming.kicks-ass.net>
References: <20210118034323.427029-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118034323.427029-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 12:43:23PM +0900, Namhyung Kim wrote:
> As of now we silently ignore pinned events when it's failed to be
> scheduled and make it error state not try to schedule it again.
> That means we won't get any samples for the event.
> 
> But there's no way for users to notice and respond to it.  Let's
> emit a lost event with a new misc bit to indicate this situation.

Users should get a read(2) error IIRC, does that not work?
