Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE962CA336
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgLAMzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 07:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbgLAMzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:55:37 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62204C0613CF;
        Tue,  1 Dec 2020 04:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pWCGGm6vAOOB6XjfY9NPEKZ7NidMPZA3DbM3NESM+a8=; b=Pe2hyQMBylnanNfaplB7XgK7bt
        Z8Z7XUQdEPyZlLoeM0SavBZZL4w3ayvNGNin5votAVWyy7W5Be1aJ+uSYau9wsffsr45wbAh69+3N
        vJtO/WLNKAOI2OEDb8kWz/NLB5NKxXH3bmWHwj9Ykk8ShAXlfW6XOisH6EVF5tVmtNgEw/DeQKYTQ
        fZKdR4y7puTeUIoRBQr2iMcmuOqGyyFt8rXTyL13SdQilzhoHV7SNHIAsozNd7ywgdmtlJld41LtQ
        YkD6+/1nPmHEBR4qc8O9IjjBhucxhKrKoq9vt/FWwMlslS6Hqz2PoXUE5ApXFiQcf4mPylbUAIgaN
        UoE0CaLg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kk5BA-0005LQ-Gh; Tue, 01 Dec 2020 12:54:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 01DF1305815;
        Tue,  1 Dec 2020 13:54:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B8B8520139F36; Tue,  1 Dec 2020 13:54:45 +0100 (CET)
Date:   Tue, 1 Dec 2020 13:54:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 07/16] completion: drop init_completion define
Message-ID: <20201201125445.GW2414@hirez.programming.kicks-ass.net>
References: <cover.1606823973.git.mchehab+huawei@kernel.org>
 <e657bfc533545c185b1c3c55926a449ead56a88b.1606823973.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e657bfc533545c185b1c3c55926a449ead56a88b.1606823973.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 01:09:00PM +0100, Mauro Carvalho Chehab wrote:
> Changeset cd8084f91c02 ("locking/lockdep: Apply crossrelease to completions")
> added a CONFIG_LOCKDEP_COMPLETE (that was later renamed to
> CONFIG_LOCKDEP_COMPLETIONS).
> 
> Such changeset renamed the init_completion, and add a macro
> that would either run a modified version or the original code.
> 
> However, such code reported too many false positives. So, it
> ended being dropped later on by
> changeset e966eaeeb623 ("locking/lockdep: Remove the cross-release locking checks").
> 
> Yet, the define remained there as just:
> 
> 	 #define init_completion(x) __init_completion(x)
> 
> Get rid of the define, and return __init_completion() function
> to its original name.
> 
> Fixes: e966eaeeb623 ("locking/lockdep: Remove the cross-release locking checks")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---

Your patch is weird, did you add -C 1000 or something?
