Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF27299376
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1787384AbgJZRM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:12:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34504 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1787215AbgJZRM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6BL74GG/GU7T+OZHWA4ZwCz98Vw3V+JJr/MYkeOc1pw=; b=KMYHIio0bD27ubImFg/uC09LdZ
        ThlxstJV1PpLhIweeWjkIbu6I85HAlUOTHo0lBd8V8wR5woEWEB9hWGnGv+bnSh/UmMB23PNAQUwp
        PvgxPDYtlI8CU5il6r3tJrozpU5+/odZQK5/APHnUzyrxL/m9H5RRrqSsbnpfUtcvO9L040izpkT7
        5XoPdYkYQ5rVmodTu2F94mjEYaJFWLmHLpTD+ZSr0tZA6nHIFNsf1MVrm+QnvRu6RlK6XA6hSi1C5
        QIfWyndmIdnnS68XgLd6PvV1T6bW3hyiS5CKJD4eB/tXJetGqEadYX2o36sRVAZVtID702biRTGhR
        2wTYyCDg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kX62j-0000OZ-Hs; Mon, 26 Oct 2020 17:12:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 39F873006D0;
        Mon, 26 Oct 2020 18:12:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2C5E02BAA7DD6; Mon, 26 Oct 2020 18:12:24 +0100 (CET)
Date:   Mon, 26 Oct 2020 18:12:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     psodagud@codeaurora.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Elliot Berman <eberman@codeaurora.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Trilok Soni <tsoni@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] smp: Add bootcpus parameter to boot subset of CPUs
Message-ID: <20201026171224.GV2611@hirez.programming.kicks-ass.net>
References: <1603404243-5536-1-git-send-email-eberman@codeaurora.org>
 <87v9f04n8r.fsf@nanos.tec.linutronix.de>
 <a6d7f84679240fcf580520230a88c058@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6d7f84679240fcf580520230a88c058@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 10:08:47AM -0700, psodagud@codeaurora.org wrote:
> On 2020-10-23 14:59, Thomas Gleixner wrote:
> > On Thu, Oct 22 2020 at 15:04, Elliot Berman wrote:
> > > In a heterogeneous multiprocessor system, specifying the 'maxcpus'
> > > parameter on kernel command line does not provide sufficient control
> > > over which CPUs are brought online at kernel boot time, since CPUs may
> > > have nonuniform performance characteristics. Thus, add bootcpus kernel
> > > parameter to control which CPUs should be brought online during kernel
> > > boot. When both maxcpus and bootcpus is set, the more restrictive of
> > > the
> > > two are booted.
> > 
> > What for? 'maxcpus' is a debug hack at best and outright dangerous on
> > certain architectures. Why do we need more of that? Just let the machine
> > boot and offline the CPUs from user space.
> 
> Hi Thomas and Peter,
> 
> Based on my understanding with maxcpus option provides, maximum no of CPUs
> are brough up during the device boot up. There is a different case, in which
> we want to restrict which CPUs to be brough up.
> On a system with 8 cpus, if we set maxcpus as 3, cpu0, cpu1, and cpu2 are
> brough up during the bootup.  For example, if we want to bring core0, core3
> and core4 current maxcpu(as 3) setting would not help us.
> On some platform we want the flexibility on which CPUs to bring up during
> the device bootup. bootcpus command line is helping to bring specific CPUs
> and these patches are working downstream.

That's a lot of words, but exactly 0 on _WHY_ you would want to do that.
