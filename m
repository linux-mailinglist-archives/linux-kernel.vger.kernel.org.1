Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD012276C37
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 10:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgIXIm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 04:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgIXIm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 04:42:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7888C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 01:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=AmLdOkb/yCyJ7hMIvjfhSvkdGbRLKyfV9cffahTR+Ss=; b=HL3wO9Ut0OmkoOnmfnuEWboDNI
        VRzaAYwD3oypZ2IxtTbnxHHSnpa8YrXFatpkfE+kbqo4qALDN4vcwnd0Kb+G/3ECC4WEWVEJUMae7
        ofOsekkZt576zrw0WdWrV+f5ihkhC7FE6GwJ/RqTd5RZqBFtcNXSnPjIA39FwWs80k2oalABb/VP4
        wE+YBDxqZ6IY6O9pBam/HfqFExk3DMYbTP76G7iNmdba+CS2DE7GbNacRsTuDR/53nPNpDwYcXel3
        ZYcQEEE7Ve0oi9aweTlIrQEWS0vVDViHT2XmdNMuqcav2hq8zhLMyxB2MGlU8uLJr0WGp2USlyok9
        7uMjfRNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLMpU-0008Bt-Cr; Thu, 24 Sep 2020 08:42:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DB41C303DA0;
        Thu, 24 Sep 2020 10:42:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B6F142BC141E8; Thu, 24 Sep 2020 10:42:15 +0200 (CEST)
Date:   Thu, 24 Sep 2020 10:42:15 +0200
From:   peterz@infradead.org
To:     George Prekas <prekageo@amazon.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Xu <peterx@redhat.com>,
        Kaitao Cheng <pilgrimtao@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] latency improvement in __smp_call_single_queue
Message-ID: <20200924084215.GD1362448@hirez.programming.kicks-ass.net>
References: <281da382-4511-e1df-6917-154a5914dd43@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <281da382-4511-e1df-6917-154a5914dd43@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 10:00:41AM -0500, George Prekas wrote:
> If an interrupt arrives between llist_add and
> send_call_function_single_ipi in the following code snippet, then the
> remote CPU will not receive the IPI in a timely manner and subsequent
> SMP calls even from other CPUs for other functions will be delayed:
> 
>     if (llist_add(node, &per_cpu(call_single_queue, cpu)))
>         send_call_function_single_ipi(cpu);
> 
> Note: llist_add returns 1 if it was empty before the operation.
> 
> CPU 0                           | CPU 1                     | CPU 2
> __smp_call_single_q(2,f1)       | __smp_call_single_q(2,f2) |
>   llist_add returns 1           |                           |
>   interrupted                   |   llist_add returns 0     |
>       ...                       |   branch not taken        |
>       ...                       |                           |
>   resumed                       |                           |
>   send_call_function_single_ipi |                           |
>                                 |                           | f1
>                                 |                           | f2
> 
> The call from CPU 1 for function f2 will be delayed because CPU 0 was
> interrupted.

Do you happen to have any actual numbers and a use-case where this was
relevant?
