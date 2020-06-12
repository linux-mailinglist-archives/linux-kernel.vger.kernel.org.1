Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17EE01F7BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 18:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgFLQ5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 12:57:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:11811 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbgFLQ5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:57:10 -0400
IronPort-SDR: VIUf/z2wTphMuL2ttR0KUfnPlB/jW3+lR1rJsyAB9QFjU7EKgsj60eWd9sFIb0ZNX99/JI6mHq
 aI2kzYGpGwtQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 09:57:09 -0700
IronPort-SDR: cYN3WB/aLCmrvg2twmOVAfJCGnnMVkSlh5fXJOYYF2pl53pieeTrb47U/DJlOihIZyxGGIv+9F
 0Jgj9hwZiumA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,504,1583222400"; 
   d="scan'208";a="261013310"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jun 2020 09:57:09 -0700
Date:   Fri, 12 Jun 2020 09:57:09 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/msr: Filter MSR writes
Message-ID: <20200612165709.GB1026@linux.intel.com>
References: <20200612105026.GA22660@zn.tnic>
 <20200612163406.GA1026@linux.intel.com>
 <20200612164602.GC22660@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612164602.GC22660@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 06:46:02PM +0200, Borislav Petkov wrote:
> On Fri, Jun 12, 2020 at 09:34:06AM -0700, Sean Christopherson wrote:
> > The kernel should be tainted if the WRMSR is attempted, regardless of
> > whether it succeeds, and it should happen before the WRMSR.  E.g. pointing
> > MSR_IA32_DS_AREA at a bad address will likely cause an OOPS on the #PF
> 
> If the MSR write fails, MSR_IA32_DS_AREA won't have the bad address. If
> the writes fail, nothing has been changed.

DS_AREA takes a virtual (linear) address, i.e. the address can be legal from
the CPUs perspective but still lead to a #PF due to the address not being
mapped in the page tables.

> > This can be 0600, or maybe 0644, i.e. allow the user to enable/disable
> > writes after the module has been loaded.
> 
> What for?

So users don't have to unload and reload the module just to enable or
disable writes.  I don't think it changes the protections in any way, a
priveleged user still needs to explicitly toggle the control.

> crw------- 1 root root 202, 0 Jun 10 19:54 /dev/cpu/0/msr
> 
> You need root to write to the chrdev.
> 
> Also, the intent is *not* to open it more but to close it so that the
> incentive to design proper interfaces is there.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
