Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718972F8E0B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 18:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbhAPRNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 12:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbhAPRKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 12:10:35 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E6CC061345
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 07:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vNVmJZrKuDj2vCmvC6xmw3IOo/UXqLVwa5kqiwmHnOM=; b=WBecyrpweeNtImZCWcy824UlHO
        r1opbQjX8uSRffKDuKTa58rlFLwBTE9fUcUQeMBD8w2zqSBYl4kxBK8mtHFFOQAJy5qCQFuVe623Z
        p2YX2bI7hnr3iCy6JOJES5IdfKU1Dqlej21iCD0DozrbN3uzKVPyDNT1ihi945fNZ/29JXMM8dPuy
        NhSBLY/sS3Hl/d8OlYMTpwpVsmTlmII7ahrBlLAAXFJVkeMTm7xv+lKhblUCwJYtF4UxumFXuZoVZ
        oFXWqubfrovuffr+HGIN6R5Jh1k985JT4N98o//4UhV/6LbthKIeVAVVgZ1bOc5lSO1l2vzimhybG
        wAUfUNJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l0nTj-0005vW-R8; Sat, 16 Jan 2021 15:27:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 70B423010CF;
        Sat, 16 Jan 2021 16:27:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 619D7202A3F5A; Sat, 16 Jan 2021 16:27:02 +0100 (CET)
Date:   Sat, 16 Jan 2021 16:27:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        valentin.schneider@arm.com, cai@redhat.com,
        vincent.donnefort@arm.com, decui@microsoft.com, paulmck@kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org
Subject: Re: [PATCH 3/8] sched: Dont run cpu-online with balance_push()
 enabled
Message-ID: <YAMFxk311hkpQYl3@hirez.programming.kicks-ass.net>
References: <20210116113033.608340773@infradead.org>
 <20210116113919.760767084@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210116113919.760767084@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 12:30:36PM +0100, Peter Zijlstra wrote:
> @@ -7608,6 +7614,12 @@ int sched_cpu_dying(unsigned int cpu)
>  	}
>  	rq_unlock_irqrestore(rq, &rf);
>  
> +	/*
> +	 * Should really be after we clear cpu_online(), but we're in
> +	 * stop_machine(), so it all works.
> +	 */
> +	balance_push_set(cpu, false);

Looking at the RCU thing just now made me realize we run all the DYING
notifiers with cpu_online() already false, so the above comment is wrong
and ordering in fact perfect.


