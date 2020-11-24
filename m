Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7B72C1F9F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 09:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbgKXIKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 03:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgKXIKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:10:04 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AC3C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 00:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Sg0d2W9lIZVXaKPXvUC0vCuRKlWPQr9QqT8INz/yg80=; b=c1/dYbhkt2kl4iCUCaPRlDv/BD
        eb17+dtyYYfTsjz1A6gFDluM6K0jG/17YKBXAAU1x/uHFzYexx22Yc/yLHTiT5BV4N9wJ2vmTMO/h
        /hVqveDUbfGzfcNU2NQKvzVCHx+UCG4JHnaQOVlwyVmti1VjbYkB4xnm5SdBoftSD/CL8CbCEETg2
        oadbfXEfUY8pmzK93wCsQDTwN7NFDJ9WHuJEvlB9DStMttmVItGBw6YKWLCeKvNaAlZ9rRA6r9mav
        6I2+YUJZtqnyBhm7E7o6sSfdsRaKnLqbTcL7wA0ApniYgDc7bmvPPPulvYK5hDai02Wql64PXpiSb
        DmsLP5Vw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khTOd-0000ZJ-9N; Tue, 24 Nov 2020 08:09:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 72D7E304D28;
        Tue, 24 Nov 2020 09:09:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5E1BF20222D66; Tue, 24 Nov 2020 09:09:51 +0100 (CET)
Date:   Tue, 24 Nov 2020 09:09:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Sperbeck <jsperbeck@google.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [RFC] perf/x86: Fix a warning on x86_pmu_stop()
Message-ID: <20201124080951.GE2414@hirez.programming.kicks-ass.net>
References: <20201121025011.227781-1-namhyung@kernel.org>
 <20201123142321.GP3021@hirez.programming.kicks-ass.net>
 <CAM9d7cji+M+qVm4g48Jcgnfjm-=3HVVtv49ntDpksQx8aBdSyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cji+M+qVm4g48Jcgnfjm-=3HVVtv49ntDpksQx8aBdSyQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 02:01:39PM +0900, Namhyung Kim wrote:

> Yes, it's not about __intel_pmu_pebs_event().  I'm looking at
> intel_pmu_drain_pebs_nhm() specifically.  There's code like
> 
>         /* log dropped samples number */
>         if (error[bit]) {
>             perf_log_lost_samples(event, error[bit]);
> 
>             if (perf_event_account_interrupt(event))
>                 x86_pmu_stop(event, 0);
>         }
> 
>         if (counts[bit]) {
>             __intel_pmu_pebs_event(event, iregs, base,
>                            top, bit, counts[bit],
>                            setup_pebs_fixed_sample_data);
>         }
> 
> There's a path to x86_pmu_stop() when an error bit is on.

That would seem to suggest you try something like this:

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 31b9e58b03fe..8c6ee8be8b6e 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1945,7 +1945,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 		if (error[bit]) {
 			perf_log_lost_samples(event, error[bit]);
 
-			if (perf_event_account_interrupt(event))
+			if (iregs && perf_event_account_interrupt(event))
 				x86_pmu_stop(event, 0);
 		}
 
