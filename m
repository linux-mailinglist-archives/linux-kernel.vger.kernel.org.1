Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C4F2783D3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 11:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgIYJTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 05:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbgIYJTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 05:19:44 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4115C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 02:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c8YtDkE4IA3XBuGMSF9QXbuX5IQDMCMfqsNVTZOmUyk=; b=u53q1FSYwBHD2Jq2eoWBv1Trq8
        fW/jq1ovFP1hiBcx82KCgggxixi8WkXP4rTQzLopW3PunT/h2pXol5DB5rXPyoEP7vE9ykcd+PlvH
        RUkbf+9+M6Z8CWXaxRWkM210E8Zq4tuFcxQg3WH+Y2QARpo301PnwOmju3qYLWVfIY9TD8szKotnC
        XNF3JuieIZcp6VSXIl0gvyObIUYv51nGAK7oEtiFlK6ggyPwzV9Uu3dvN62K93rWVHkpXHCmfaADo
        gh+KN/ofbiTIkx46SXRyNtna+3SvXVDc3ni8nun0s3X2JGltULFYOWEk442ULHvF/xi6GNOKa5kOk
        bQHEsbVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLjtA-0002hV-6q; Fri, 25 Sep 2020 09:19:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AA79F3003E5;
        Fri, 25 Sep 2020 11:19:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 95A8020240A54; Fri, 25 Sep 2020 11:19:34 +0200 (CEST)
Date:   Fri, 25 Sep 2020 11:19:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/irq: Use printk_deferred() on raw_spin_lock()
 protected sections
Message-ID: <20200925091934.GW2628@hirez.programming.kicks-ass.net>
References: <e68888438cec9a1da53aaa1647720ade638d6ad4.1600705105.git.bristot@redhat.com>
 <20200924102822.GA2628@hirez.programming.kicks-ass.net>
 <c0dbf88bb7ca4d77ed0576ced82302b81aebe664.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0dbf88bb7ca4d77ed0576ced82302b81aebe664.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 09:08:57AM -0700, Joe Perches wrote:
> On Thu, 2020-09-24 at 12:28 +0200, Peter Zijlstra wrote:
> > On Mon, Sep 21, 2020 at 06:22:12PM +0200, Daniel Bristot de Oliveira wrote:
> > > While testing hotplug I got this BUG:
> > > It was caused by printk() inside a code section protected by a
> > > raw_spin_lock() that ended up calling a serial console that
> > > uses a regular spin_lock().
> > > 
> > > Use the printk_deferred() to avoid calling the serial console
> > > in a raw_spin_lock() protected section.
> > 
> > I consider printk_deferred() to be a bug, can't we just wait for the new
> > printk implementation to land so we don't need all this nonsense?
> 
> It will be good to do a sed fixup for all these
> printk_deferred uses soon,  but in the meantime
> isn't it useful to avoid BUGs?

The kernel isn't PROVE_RAW_LOCK_NESTING clean anyway. Printk is one of
the biggest offenders there anyway, iirc.
