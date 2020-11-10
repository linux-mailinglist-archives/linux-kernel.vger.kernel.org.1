Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB19F2ADC88
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 18:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgKJRAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 12:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKJRAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 12:00:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A177DC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 09:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IBrCxdWHwHQ6sXA7bvZuczCHTmW9w+ayaLdyn5Qnkqc=; b=o2rtIMBKcSK9SBqIevagzVnlGm
        T67v3pL7glqq0+NCS61P6E3ZobvSgW5zTlFd2I/lezWdq/dkoN3SpafNsympqWTjDk5EhnSD4rIeQ
        TuBThhJV+tyaf+ekfWNXZuNgeDBRQYv4fmGKNWIUsrY0x8X5uwyrdqENomyvjNR4F3LCX7tEHu3Wn
        KSD99fr4FF+z6NGNgS5zd7cCToJkm7VrAicedUC/HeVXce/nsSdyu8kTxyjH+SOCky1uYNvMJFLKg
        m/WnqCxzxR29EHZecJO9tyJ8fwgustjxbGaVWLcfC6D+FUeHPb8cVVhZiBVGrhrXxSJs9wIRMTqtZ
        m23qXGDA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcWzw-0004mO-Ck; Tue, 10 Nov 2020 17:00:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2D987301E02;
        Tue, 10 Nov 2020 17:59:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 17F022BDD3978; Tue, 10 Nov 2020 17:59:59 +0100 (CET)
Date:   Tue, 10 Nov 2020 17:59:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Vaibhav Shankar <vaibhav.shankar@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel/uncore: fix Add BW copypasta
Message-ID: <20201110165959.GO2594@hirez.programming.kicks-ass.net>
References: <20201026215203.3893972-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026215203.3893972-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 10:51:57PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc -Wextra points out a duplicate initialization of one array
> member:
> 
> arch/x86/events/intel/uncore_snb.c:478:37: warning: initialized field overwritten [-Woverride-init]
>   478 |  [SNB_PCI_UNCORE_IMC_DATA_READS]  = { SNB_UNCORE_PCI_IMC_DATA_WRITES_BASE,
> 
> The only sensible explanation is that a duplicate 'READS' was used
> instead of the correct 'WRITES', so change it back.
> 
> Fixes: 24633d901ea4 ("perf/x86/intel/uncore: Add BW counters for GT, IA and IO breakdown")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks!
