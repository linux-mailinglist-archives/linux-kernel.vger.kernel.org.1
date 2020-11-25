Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900022C3A34
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 08:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgKYHhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 02:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgKYHhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 02:37:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB28C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 23:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c+b1e14nMThTTnbxa3kx91xDxtOtG1x9augxAZM+Ejw=; b=rYDWtjSsjL0FtGSIEQHua96/Jt
        F8YYHbESjZLcu2mRVmtdJhegQKpng52Fd1lT3lPX1rRiSBvb1sEyjlqsmckj9hiMiN2O8Q25ZkD4x
        WuWBQZTX9uyPNHnAu2hplEW16NyGGiffGaTfNgK7yZ+JhkLKtXJtJP0+1KcJg5K4HHH36ubCMuGFy
        LB919xrbH80j3jaVgR5dXZ9gUSQgrM4gRdrfip9JHoWF7RyvLG5Q0uPTg+83rfMDz6sa26dDa0Woi
        8selwbLQxQkhlI3uBzq4srWOoVnRRwoNa36SxvI0vAqLzd8oVFizWVqSr8MAcUbUKBpZblIDKLg7k
        bS96rWxQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khpM8-0002me-If; Wed, 25 Nov 2020 07:36:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BC7283012DF;
        Wed, 25 Nov 2020 08:36:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9EFFB2009B1B4; Wed, 25 Nov 2020 08:36:46 +0100 (CET)
Date:   Wed, 25 Nov 2020 08:36:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Sperbeck <jsperbeck@google.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC] perf/x86: Fix a warning on x86_pmu_stop()
Message-ID: <20201125073646.GL2414@hirez.programming.kicks-ass.net>
References: <20201121025011.227781-1-namhyung@kernel.org>
 <20201123142321.GP3021@hirez.programming.kicks-ass.net>
 <CAM9d7cji+M+qVm4g48Jcgnfjm-=3HVVtv49ntDpksQx8aBdSyQ@mail.gmail.com>
 <20201124080951.GE2414@hirez.programming.kicks-ass.net>
 <CABPqkBSvcj1c5-SO4PQLc2KLLf7_0bW4ftUyvFobyd0OVAmLrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBSvcj1c5-SO4PQLc2KLLf7_0bW4ftUyvFobyd0OVAmLrA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 12:19:34AM -0800, Stephane Eranian wrote:
> Hi,
> 
> Another remark on the PEBS drainage code, it seems to me like a test
> is not quite correct:
> intel_pmu_drain_pebs_nhm()
> {
> ...
>                if (p->status != (1ULL << bit)) {
>                         for_each_set_bit(i, (unsigned long *)&pebs_status, size)
>                                 error[i]++;
>                         continue;
>                 }
> 
> The kernel cannot disambiguate when 2+ PEBS counters overflow at the
> same time. This is what the comment for this code suggests.
> However, I see the comparison is done with the unfiltered p->status
> which is a copy of  IA32_PERF_GLOBAL_STATUS at the time of
> the sample. This register contains more than the PEBS counter overflow
> bits. It also includes many other bits which could also be set.
> 
> Shouldn't this test use pebs_status instead (which covers only the
> PEBS counters)?

Hmm, yes, think so.
