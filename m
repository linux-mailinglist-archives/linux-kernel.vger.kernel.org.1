Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 236AB19F5BF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 14:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgDFMXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 08:23:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44082 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbgDFMXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 08:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RQo2OeDfd3m+4rXBRNxBZJdmUxyXALb8lqu8vJKOiPA=; b=T3An/islyD62Q4dxt/D9Hy+mVe
        yvurDqxme6dUP6xwB/OOGBcKVk7VCcxxImAYQ0WwRRKtNjBJlC8gSFWd6UJuqPcqoVtX3Myt36dqs
        BHszbcFPCUv4vJ0fLTXFJ6VuiMsH7M4PTaLD4NoS0F4YZCBTaVj5txSfF0vOcIpOu8zDenonM2VZ1
        hNeTZa+MUD73sn2ElnID2IAeLxqsS4FXJnbgcWbF/XaSJrV2D2SeEP6gRdWcD2Xrqdy/E1zVsKeKC
        x2GS8ZiKS0R1I1NjgTMFB4WOwqgpeWiU6mR7i0VhB5JWJQCLm4STPG6pARo2ZjqSRUS4d0J9KbkX4
        m2Yo/0Mw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLQn1-0002hG-3h; Mon, 06 Apr 2020 12:23:43 +0000
Date:   Mon, 6 Apr 2020 05:23:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 1/2] x86,module: Detect VMX modules and disable
 Split-Lock-Detect
Message-ID: <20200406122343.GA10683@infradead.org>
References: <20200402123258.895628824@linutronix.de>
 <20200402124205.242674296@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402124205.242674296@linutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 02:32:59PM +0200, Thomas Gleixner wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> It turns out that with Split-Lock-Detect enabled (default) any VMX
> hypervisor needs at least a little modification in order to not blindly
> inject the #AC into the guest without the guest being ready for it.
> 
> Since there is no telling which module implements a hypervisor, scan the
> module text and look for the VMLAUNCH instruction. If found, the module is
> assumed to be a hypervisor of some sort and SLD is disabled.
> 
> Hypervisors, which have been modified and are known to work correctly,
> can add:
> 
>   MODULE_INFO(sld_safe, "Y");
> 
> to explicitly tell the module loader they're good.
> 
> NOTE: it is unfortunate that struct load_info is not available to the
>       arch module code, this means CONFIG_CPU_SUP_INTEL gunk is needed
>       in generic code.
> 
> NOTE: while we can 'trivially' fix KVM, we're still stuck with stuff
>       like VMware and VirtualBox doing their own thing.

This is just crazy.  We have never cared about any out tree module, why
would we care here where it creates a real complexity.  Just fix KVM
and ignore anything else.
