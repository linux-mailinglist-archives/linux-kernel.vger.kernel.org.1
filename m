Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A71A2AB265
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 09:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbgKIIaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 03:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgKIIaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 03:30:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DBDC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 00:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WJeiuDS5RY1g3teULikUl+DUtvsKRlIt991FGUDmgtA=; b=TWVMBwSqijPntybV+L3JaZ86z2
        HLb0JV1XmG3sSeGJmrnExfj9YvC7c5bfkgQP6H2eYyCcPHTzRb9w+Z+4yBJnQyRoGz3j3kD6ChUij
        OdWLkIh7zWy0BoRNsItw41hZzUoTX29PgoiiMDcdxscu2Q9p1gOJ9l/KxYSPETYRRclj2xFdS4uh3
        pvhI3T/oi7mxUYDj5r8msz9nCMG3h5my+SBAE1C0UlKE1grId83/NBJ36y7LoFkSXsoeYhrqpxou4
        ShY0J/ECic2cnLsdu7Bm8sc12HorhWKDMcJChGpzDECL5YdSbnp56Fm149eA7G6Q9jcrBYe10oujH
        txrE2LfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kc2Yq-0003D4-ED; Mon, 09 Nov 2020 08:30:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D58A53010D2;
        Mon,  9 Nov 2020 09:29:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C0A142C356C90; Mon,  9 Nov 2020 09:29:58 +0100 (CET)
Date:   Mon, 9 Nov 2020 09:29:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH 2/4] x86/bus_lock: Handle warn and fatal in #DB for bus
 lock
Message-ID: <20201109082958.GZ2594@hirez.programming.kicks-ass.net>
References: <20201108042918.1011889-1-fenghua.yu@intel.com>
 <20201108042918.1011889-3-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201108042918.1011889-3-fenghua.yu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 08, 2020 at 04:29:16AM +0000, Fenghua Yu wrote:
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

> +void handle_bus_lock(struct pt_regs *regs)
> +{
> +	if (!bld)
> +		return;
> +
> +	pr_warn_ratelimited("#DB: %s/%d took a bus_lock trap at address: 0x%lx\n",
> +			    current->comm, current->pid, regs->ip);
> +}

So the Changelog above, and the state_show() below, seem to suggest
there should be SIGBUS code in #DB, but I'm having trouble spotting it.

> +static void sld_state_show(void)
> +{
> +	if (!bld && !sld)
> +		return;
> +
> +	switch (sld_state) {
> +	case sld_off:
> +		pr_info("disabled\n");
> +		break;
> +
> +	case sld_warn:
> +		if (bld)
> +			pr_info("#DB: warning about user-space bus_locks\n");
> +		else
> +			pr_info("#AC: crashing the kernel about kernel split_locks and warning about user-space split_locks\n");
> +		break;
> +
> +	case sld_fatal:
> +		if (sld)
> +			pr_info("#AC: crashing the kernel on kernel split_locks and sending SIGBUS on user-space split_locks\n");
> +		else
> +			pr_info("#DB: sending SIGBUS on user-space bus_locks\n");
> +		break;
> +	}
> +}
