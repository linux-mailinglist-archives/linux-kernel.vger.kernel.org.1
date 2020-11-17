Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA632B5F0A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 13:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgKQMZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 07:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQMZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 07:25:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A896CC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 04:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DvYt+WD3IHi6VoXoeuxoqSgNL9/bqPVrK/sQVb4claM=; b=d9eAvwRaqjGLWkQwHn+1GTMOk1
        o5ucvibTbFL8MqKQxx77d+7NFbCt23wkuYoBFsjj1KoJgFx3cpC8aZi8IWpm9gZ3h0YT4UWZaDhQM
        4vwI/N5AGXedd41qqapBjk3/91dLR2hOu0lmqsmyseTdts/Q5X1NDgqlYo19ZmNX3+nBn6n+lGXJI
        bG26Mkhbfl7d3fgb6OyIVwzMDATL5cDA54exRMNCIzdVpV+0dBXW9OzO3jNejF0z+Xi/IIf7ytn0Y
        4IncRtTtei8/mMzVHJLwlEUKtZtRBa7JPJLwylWFyy2sweZYdVuKnEV2z25wsXpv260bnhu99HPge
        RE2LfcCQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kf02b-0008CY-Fm; Tue, 17 Nov 2020 12:24:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BADC83012DC;
        Tue, 17 Nov 2020 13:24:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ABB8F203C45DF; Tue, 17 Nov 2020 13:24:55 +0100 (CET)
Date:   Tue, 17 Nov 2020 13:24:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v2 2/4] x86/bus_lock: Handle warn and fatal in #DB for
 bus lock
Message-ID: <20201117122455.GG3121406@hirez.programming.kicks-ass.net>
References: <20201111192048.2602065-1-fenghua.yu@intel.com>
 <20201111192048.2602065-3-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111192048.2602065-3-fenghua.yu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 07:20:46PM +0000, Fenghua Yu wrote:
> #DB for bus lock is enabled by bus lock detection bit 2 in DEBUGCTL MSR
> while #AC for split lock is enabled by split lock detection bit 29 in
> TEST_CTRL MSR.
> 
> Delivery of #DB for bus lock in userspace clears DR6[11]. To avoid
> confusion in identifying #DB, #DB handler sets the bit to 1 before
> returning to the interrupted task.
> 
> Use the existing kernel command line option "split_lock_detect=" to handle
> #DB for bus lock:
> 
> split_lock_detect=
> 		#AC for split lock		#DB for bus lock
> 
> off		Do nothing			Do nothing
> 
> warn		Kernel OOPs			Warn once per task and
> 		Warn once per task and		and continues to run.
> 		disable future checking 	When both features are
> 						supported, warn in #DB
> 
> fatal		Kernel OOPs			Send SIGBUS to user
> 		Send SIGBUS to user
> 		When both features are
> 		supported, fatal in #AC.
> 
> Default option is "warn".
> 
> Hardware only generates #DB for bus lock detect when CPL>0 to avoid
> nested #DB from multiple bus locks while the first #DB is being handled.
> So no need to handle #DB for bus lock detected in the kernel.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Sane enough I suppose,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

The one thing I found still missing is a better description of the
things tickling SLD vs BLD. IIRC BLD detects a wider range of issues.
Therefore it _might_ make sense to allow SLD && BLD when fatal, instead
of only SLD.

Still, that's nitpicking.
