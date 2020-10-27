Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAEF29A81D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895803AbgJ0JoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:44:25 -0400
Received: from casper.infradead.org ([90.155.50.34]:35904 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895793AbgJ0JoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=pus4Itp4UoghEjF3f335YQWvx2sMVGqfb8omYZntFyU=; b=WfCzPus7cGTdP7efUNJENd3yHQ
        tOT2qc4mSYXs5BtrA/Hjp/FyEzPG9wxp/XVrKk6SYmR8X9AwBtA+pRU/cTtopJZhixsrMcFrK25rt
        ZCWPdCRzFXlNBDYU8Tnb70JaQSCjfzSGpZQKLQgNoGYjMMltjJy8PX2Tl9XxPsAy6znprm1nLjIqc
        k6KzjDG489Pd+3XcBCGEAxnu9AsH/P+m1i+emfcNQYBXOP13vFTA3J8VZ1EkQkLV+xH2uhLKzz8xt
        blW/UNDdCAbeE7LykfUBLEsOjhuipDvtcIdgxDhM0DkWmYq/7PKe23uwYQKYE3gAuLOqNoVDXmsct
        6pznYT2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXLWE-0006hv-Hr; Tue, 27 Oct 2020 09:43:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 47BD3305815;
        Tue, 27 Oct 2020 10:43:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 279242B7AC14D; Tue, 27 Oct 2020 10:43:53 +0100 (CET)
Message-ID: <20201027091504.712183781@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 27 Oct 2020 10:15:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, luto@kernel.org, me@kylehuey.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, rocallahan@gmail.com,
        alexandre.chartre@oracle.com, paulmck@kernel.org,
        frederic@kernel.org, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, mhiramat@kernel.org,
        pmladek@suse.com, joel@joelfernandes.org, rostedt@goodmis.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, brgerst@gmail.com,
        jpoimboe@redhat.com, daniel.thompson@linaro.org,
        julliard@winehq.org, pgofman@codeweavers.com, peterz@infradead.org
Subject: [PATCH 0/3] x86/debug: Fixes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Triggered by the x86/entry rework, the resulting #DB cleanup (obviously :/)
broke something. Kyle reported that ptrace_get_debugreg(6) no longer contained
DR_STEP after PTRACE_SINGLESTEP which broke RR.

While looking at this, I realized that a kernel #DB should not consume a
userspace BTF, and equally a kernel #DB should not clobber the (userspace)
ptrace DR6 state. Both these have been busted since forever afaict.

I've added a few Wine folks to Cc, with the hope that they can test Wine
on 5.10-rc and make sure it all still works as expected. There have been
significant changes. Although hopefully it all works again after these
patches.

