Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47ACA1A107C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 17:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgDGPpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 11:45:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbgDGPpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:45:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BF2E2072A;
        Tue,  7 Apr 2020 15:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586274301;
        bh=FlKVGqQMyJuvf5J0f6P2UXfF1yvsJXMzzfpKz7C46g0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bZMoaD50VGZ9nEP44054yOKoO1YccQ4iCRIbjeWLuAzYsFqhQa6kSJhByh6ojjJX/
         KdERoC+D3GCULNhS2uBGazEw6deLa4EYWALomip+HgFegsGoniTkBY4ayjz6kx3Fak
         tId3OpXZXXA6l1e5xEO1oXnsosEAz3HHtzalGsOs=
Date:   Tue, 7 Apr 2020 17:44:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hch@infradead.org, sean.j.christopherson@intel.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, jeyu@kernel.org, rasmus.villemoes@prevas.dk,
        pbonzini@redhat.com, fenghua.yu@intel.com, xiaoyao.li@intel.com,
        nadav.amit@gmail.com, thellstrom@vmware.com, tony.luck@intel.com,
        rostedt@goodmis.org, jannh@google.com, keescook@chromium.org,
        David.Laight@aculab.com, dcovelli@vmware.com, mhiramat@kernel.org
Subject: Re: [PATCH 3/4] x86,module: Detect VMX vs SLD conflicts
Message-ID: <20200407154459.GA915708@kroah.com>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.352324393@infradead.org>
 <20200407143543.GB876345@kroah.com>
 <20200407152412.GE20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407152412.GE20730@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 05:24:12PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 07, 2020 at 04:35:43PM +0200, Greg KH wrote:
> > On Tue, Apr 07, 2020 at 01:02:39PM +0200, Peter Zijlstra wrote:
> > > It turns out that with Split-Lock-Detect enabled (default) any VMX
> > > hypervisor needs at least a little modification in order to not blindly
> > > inject the #AC into the guest without the guest being ready for it.
> > > 
> > > Since there is no telling which module implements a hypervisor, scan
> > > all out-of-tree modules' text and look for VMX instructions and refuse
> > > to load it when SLD is enabled (default) and the module isn't marked
> > > 'sld_safe'.
> > > 
> > > Hypervisors, which have been modified and are known to work correctly,
> > > can add:
> > > 
> > >   MODULE_INFO(sld_safe, "Y");
> > > 
> > > to explicitly tell the module loader they're good.
> > 
> > What's to keep any out-of-tree module from adding this same module info
> > "flag" and just lie about it?  Isn't that what you are trying to catch
> > here, or is it a case of, "if you lie, your code will break" as well?
> 
> If they lie they get to keep both pieces.
> 
> The thing I worry about is them lying about "intree", is there anything
> that avoids that?

Yeah, the build system should be enforcing that.  I haven't looked in a
while if that really is able to be "faked", but no distro would do that
so it shouldn't be an issue except for custom systems.

greg k-h
