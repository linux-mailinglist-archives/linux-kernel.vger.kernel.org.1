Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E914B2C53BE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 13:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389407AbgKZMNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 07:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730660AbgKZMNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 07:13:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB72DC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 04:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HWocZnV4J3w6J2B/yUONmu5RDnId0bFeRr8x3q+37yQ=; b=M3z7Ke/EX90uTN667IzGg8sIUm
        ec8f+zSY4mOD1osHWxks8ZM+HQZ2c/qwEiiE0FaNQThA/JYFu0htUdMTkT4To3TcIbutTMTtGDdNp
        3oaiZdfN3rvVBAKfVK4ujqCqUHqwX+Lqp9e8/bVXTsKVPqCAbV5WgVDSo4IJtK6w5U/ohNjemI+gj
        VUrjfzaiSE8jR+7dwh90SFp/pEh8MU3hCnn+Md54Mj+gP42ZsJJ3ehgREGJvmF88lbbXMsh1mh5rG
        fI6rTD73XUeOEQLSzgq/Z4d9IWA3K0rOZ9202jcVS4tvJ7BduzAbjSvBpIBI/nKRmskBKa1r2RFJB
        Inrpa9yg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiG9S-0000Yx-0J; Thu, 26 Nov 2020 12:13:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3D84C306DD8;
        Thu, 26 Nov 2020 13:13:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 14BAC200D7A4E; Thu, 26 Nov 2020 13:13:29 +0100 (CET)
Date:   Thu, 26 Nov 2020 13:13:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Stephane Eranian <eranian@google.com>,
        John Sperbeck <jsperbeck@google.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH 1/2] perf/x86/intel: Fix a warning on x86_pmu_stop() with
 large PEBS
Message-ID: <20201126121329.GJ3040@hirez.programming.kicks-ass.net>
References: <20201126110922.317681-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126110922.317681-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 08:09:21PM +0900, Namhyung Kim wrote:
> The commit 3966c3feca3f ("x86/perf/amd: Remove need to check "running"
> bit in NMI handler") introduced this.  It seems x86_pmu_stop can be
> called recursively (like when it losts some samples) like below:
> 
>   x86_pmu_stop
>     intel_pmu_disable_event  (x86_pmu_disable)
>       intel_pmu_pebs_disable
>         intel_pmu_drain_pebs_nhm  (x86_pmu_drain_pebs_buffer)
>           x86_pmu_stop
> 
> While commit 35d1ce6bec13 ("perf/x86/intel/ds: Fix x86_pmu_stop
> warning for large PEBS") fixed it for the normal cases, there's
> another path to call x86_pmu_stop() recursively when a PEBS error was
> detected (like two or more counters overflowed at the same time).
> 
> Like in the Kan's previous fix, we can skip the interrupt accounting
> for large PEBS, so check the iregs which is set for PMI only.
> 
> Fixes: 3966c3feca3f ("x86/perf/amd: Remove need to check "running" bit in NMI handler")
> Reported-by: John Sperbeck <jsperbeck@google.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Thanks for both!
