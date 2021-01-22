Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3114B3009C7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 18:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbhAVR3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 12:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729677AbhAVQym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:54:42 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717F2C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 08:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v3cTsSAtb1g200zNB0IkZQE4PzGibeoCJUAHIzGFIMo=; b=VrFtiLFTZvjYn3fhjhxA+XbF4U
        f9q50+3EXscgQv8qKheTxmxmMJuJK+7WtgWeRW4PJlUoIhNy+jXFmGv17Cy0Mk0F8IDhAJZs+sg4+
        LTLeCMRRmGwQQUgGSsscU7Qk7feGVtvEXlr9Kbcxo1RydqG1RCcwCRVIiOasfNFmfVbkNUhg0xepw
        M4mkpcBiYAD+WY6kS6NVK+vV3E4lDumBQV8yY22PnQueHZz7L6zz+Na5AA1GFyOakfdRIoV9eigqH
        J72Nai1q8e9NtEIYxvMiDyCNzwh85eBlr7JS48kQJSCHMYYqT0IyuVwDU3Qpdc7GniFUWdjJR/pRC
        7y+WMUfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l2zgv-0000Uf-V1; Fri, 22 Jan 2021 16:53:46 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE2509842C2; Fri, 22 Jan 2021 17:53:43 +0100 (CET)
Date:   Fri, 22 Jan 2021 17:53:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        ardb@kernel.org, jpoimboe@redhat.com
Subject: Re: [RFC PATCH 4/8] preempt: Introduce CONFIG_PREEMPT_DYNAMIC
Message-ID: <20210122165343.GE16371@worktop.programming.kicks-ass.net>
References: <20210118141223.123667-1-frederic@kernel.org>
 <20210118141223.123667-5-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118141223.123667-5-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 03:12:19PM +0100, Frederic Weisbecker wrote:
> +config HAVE_PREEMPT_DYNAMIC
> +	bool
> +	depends on HAVE_STATIC_CALL_INLINE

I think we can relax this to HAVE_STATIC_CALL, using trampolines
shouldn't be too bad, and that would put it in reach of arm64.

> +	depends on GENERIC_ENTRY
> +	help
> +	   Select this if the architecture support boot time preempt setting
> +	   on top of static calls. It is strongly advised to support inline
> +	   static call to avoid any overhead.
