Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9808D28DF22
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 12:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388177AbgJNKmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 06:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387774AbgJNKmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 06:42:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E35C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 03:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LJVu+MlSQ135OMTrfXm0jmGtS2Z0lA/6W3TfbIbUafc=; b=fg1wqkFqIpJ6+zIvUU2P4p4vpk
        CRX+M4+TIKpl8LpbBxOY+4593crTmzXahsH6EpTqlT8cznm3MsFD8YsJJmyZDWWadZYvTmcMpBEV3
        y8k/mCTSoEAi7uXb1d56Za1N7Pxdk0zCQzTLc6GKoE7RgrWT5BnwSU9Spsd1gNRPjLQk9LVgKNCn6
        LEaGbS68TENVqpMAMKGIhIJOy3n9BWaI1lJfkFGNp7l76c/kl00tT7oY8RBhmyBOKz2xidDdrDHb6
        UN7ll7n72py8kE+fZqLpGhPDjUF8N9h7adKOm1bhuxLjJ1vN+VlvHxHinZ3vJ2LWtczn4FdGgSMaz
        0Cjwhzkg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSeEB-0005xu-Lk; Wed, 14 Oct 2020 10:41:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9DBC23069AE;
        Wed, 14 Oct 2020 12:41:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7BC3C20696FD8; Wed, 14 Oct 2020 12:41:48 +0200 (CEST)
Date:   Wed, 14 Oct 2020 12:41:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Brown, Len" <len.brown@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        X86 ML <x86@kernel.org>, "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 13/22] x86/fpu/xstate: Expand dynamic user state area
 on first use
Message-ID: <20201014104148.GD2628@hirez.programming.kicks-ass.net>
References: <20201001203913.9125-1-chang.seok.bae@intel.com>
 <20201001203913.9125-14-chang.seok.bae@intel.com>
 <CALCETrWKMYcuyohpctb1SoDueU1-nwAtrirJbdJTp4tZwCMXZA@mail.gmail.com>
 <BYAPR11MB346371298609756EFD2DDA1EE0040@BYAPR11MB3463.namprd11.prod.outlook.com>
 <c4669d5f-11b8-3879-562c-78a791b86229@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4669d5f-11b8-3879-562c-78a791b86229@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 03:43:59PM -0700, Dave Hansen wrote:
> On 10/13/20 3:31 PM, Brown, Len wrote:
> > vmalloc() does not fail, and does not return an error, and so there is no concept
> > of returning a signal.
> 
> Well, the order-0 allocations are no-fail, as are the vmalloc kernel
> structures and the page tables that might have to be allocated.  But,
> that's not guaranteed to be in place *forever*.  I think we still need
> to check for and handle allocation failures, even if they're not known
> to be possible today.

Quite, on top of that, we could run out of vmalloc space (unlikely, but
sitll).

You really have to deal with vmalloc() failing.
