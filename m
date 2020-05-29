Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C94D1E8801
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 21:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgE2Tit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 15:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgE2Tis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 15:38:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA9FC03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=haxBCLZK191WvSRZKZ1Qr1Z9EeArQFQQqh0rwS/dLXE=; b=PzSh0r/vlnH5S37MZzmGmBXaGM
        x4kSRUc34jbWvJfN9CB7HiBLkdaFEc8uNiHnQS2pHJs/qViz4qpzMBgKJDqfTbGm+ZfdfOeRMnp6p
        90Bfho/2nf+iliJYO3XORMg6hjdWKgkwLff44kTM6SJLMcE8vbQKk1iWicwiiW/LsKjY7MxxtR8kR
        ogP/FswfHv82uKGEMNO4DYD4zMue0mUXVpwFOgda0Bz7BwZgoPalZ20g8F+4FcIonLvnDRqSiPKOz
        obznAYumRIgxbgR51Huo6jf7mJertuTR5cpIjgzMmTfUzUMA/b6JOv8pBxlHnAeyRUaR4Q7T4axct
        vCDmRuFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jekq0-0001Wc-De; Fri, 29 May 2020 19:38:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 97B2E30047A;
        Fri, 29 May 2020 21:38:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4DE302021AF87; Fri, 29 May 2020 21:38:38 +0200 (CEST)
Date:   Fri, 29 May 2020 21:38:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, will@kernel.org, tglx@linutronix.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        a.darwish@linutronix.de, rostedt@goodmis.org, bigeasy@linutronix.de
Subject: Re: [PATCH v2 3/6] lockdep: Change hardirq{s_enabled,_context} to
 per-cpu variables
Message-ID: <20200529193838.GQ706495@hirez.programming.kicks-ass.net>
References: <20200528140535.206916549@infradead.org>
 <20200528140946.831087909@infradead.org>
 <20200529161647.GE706460@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529161647.GE706460@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 06:16:47PM +0200, Peter Zijlstra wrote:
> On Thu, May 28, 2020 at 04:05:38PM +0200, Peter Zijlstra wrote:
> > +#include <asm/percpu.h>
> > +#include <asm/percpu.h>
> 
> If we change those to <linux/percpu-defs.h>, in direct conflict with
> what the header says about itself, all builds seem to be good again.
> 
> s390, sparc64, power64 all build again.

n/m that gives other fail :/
