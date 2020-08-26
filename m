Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7122524D3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 02:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgHZArz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 20:47:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53734 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbgHZAry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 20:47:54 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598402871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lVTZSlUYnp8Y49gXsZjeOWeu61gcNbwkaYRG72a9CQk=;
        b=M3RsWdO94aKRYM8MPjyY+j2gQVrVYS2xL6b+af8300nlorNFlfykHtvgjyiAZeLlgivUxt
        Od4s8FXykn9dkli/ffnR978mpiCl3i6+mZxawOH99re2eOLh/U/2CmR7PDF0VNQwhfL/Id
        Y4pxww0/45hrbtk4Zcl4ymrGku6bJDy6KaRyXZczq9D6tZuDCexP9mvAC2aDtHhDI7JXh/
        YFxynjpJDfMHiqvRlxzOAlWzAH4qmnVaaacJYWG5rMH7jPD8gEN9AJ5iz5ELjDXx/qAtk/
        RsMCx2VFQ6Ntlt5EJgfGysLt+Byvou97BdrOQ9KtVB+Wa2a0xaxSA52SFN1ekw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598402871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lVTZSlUYnp8Y49gXsZjeOWeu61gcNbwkaYRG72a9CQk=;
        b=ZxJnjc/KSvcSh7P9bwxAHBh4NWWfinO5ixaNHEKN5cl8TpUSXkMZI2Z4wTEhCyJhg74gFe
        8ysMrKfkrHL2IqBg==
To:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org
Cc:     npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, peterz@infradead.org
Subject: Re: [PATCH v2 10/11] lockdep: Only trace IRQ edges
In-Reply-To: <20200821085348.723775490@infradead.org>
References: <20200821084738.508092956@infradead.org> <20200821085348.723775490@infradead.org>
Date:   Wed, 26 Aug 2020 02:47:51 +0200
Message-ID: <87k0xmw7uw.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21 2020 at 10:47, Peter Zijlstra wrote:
> Now, given that the only reason to use the raw_* variant is because you don't
> want tracing, A) seems like a weird option (although it can be done), so we
> pick B) and declare any code that ends up doing:
>
> 	raw_local_irq_save()
> 	local_irq_save()
> 	lockdep_assert_irqs_disabled();
>
> broken. AFAICT this problem has existed forever, the only reason it came
> up is because I changed IRQ tracing vs lockdep recursion and the first

Who is 'I'? I know you made that change and you also rewrote the
changelog, but I only figured that out after scrolling further down. As
this patch is authored by Nick, the above is simply inconsistent. Can we
please have just a reference to the commit which changed that code
instead of a puzzle?

Other than that:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
