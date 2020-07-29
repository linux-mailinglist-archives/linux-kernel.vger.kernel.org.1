Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E732324D6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 20:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgG2SqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 14:46:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:42230 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgG2SqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 14:46:16 -0400
IronPort-SDR: rUEMD/u/32G4BWs8782r9v8/XPzJyTC1UeO+ZmsORF7wP/jmTQD8xV866oWdXW5SnG+IHtOhUK
 hR62A13l23Qg==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="148945236"
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; 
   d="scan'208";a="148945236"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 11:46:14 -0700
IronPort-SDR: 8p8p/gJ42/EP79DBtF9sjkHLnSReOQc5cGfc6ytiz5oyEzCpI+VmibgL1wq7HSAL2oa0Ll5ACS
 Y+gDsIC5IqDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; 
   d="scan'208";a="490853723"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jul 2020 11:46:14 -0700
Date:   Wed, 29 Jul 2020 11:46:14 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     "Yu, Fenghua" <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Li, Xiaoyao" <xiaoyao.li@intel.com>, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] x86/bus_lock: Enable bus lock detection
Message-ID: <20200729184614.GI27751@linux.intel.com>
References: <1595021700-68460-1-git-send-email-fenghua.yu@intel.com>
 <20200729030232.GE5583@linux.intel.com>
 <e23b04a2adc54a5dbca48271987de822@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e23b04a2adc54a5dbca48271987de822@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 11:09:16AM -0700, Yu, Fenghua wrote:
> > > Some CPUs have ability to notify the kernel by an #DB trap after the
> > > instruction acquires a bus lock and is executed. This allows the
> > > kernel to enforce user application throttling or mitigations and also
> > > provides a better environment to debug kernel split lock issues since
> > > the kernel can continue instead of crashing.
> > >
> > > #DB for bus lock detect fixes all issues in #AC for split lock detect:
> > 
> > Fixes "all" issues... and creates some new ones, e.g. there are use cases
> > where preventing the split lock from happening in the first place is strongly
> > desired.  It's why that train wreck exists.
> 
> Bus Lock Detection doesn't replace Split Lock Detection. If both features
> are enabled, default behavior is warning from bus lock, fatal behavior is
> still from split lock. See the behavior table as follows.
> 
> > 
> > > 1) It's architectural ... just need to look at one CPUID bit to know it
> > >    exists
> > > 2) The IA32_DEBUGCTL MSR, which reports bus lock in #DB, is per-thread.
> > >    So each process or guest can have different behavior.
> > > 3) It has support for VMM/guests (new VMEXIT codes, etc).
> > >
> > > Use the existing kernel command line option "split_lock_detect=" to
> > > handle #DB for bus lock:
> > 
> > Are SLD and BLD mutually exclusive?  Can we even guarantee that given the
> > track record of SLD?  If not, we'll likely want to allow the user to choose
> > between SDL and BLD via split_lock_detect.
> 
> The two hardware features can be enabled on the same platform.
> But they are mutually exclusive in the kernel because #AC from SLD happens
> before the instruction is executed and #DB happens after the instruction is
> executed.
> 
> Right now, if both of them are enabled, "warn" behavior goes to
> bus lock and "fatal" behavior goes to split lock.
> 
> Do you want the user to override the behaviors by something like this?
> 
> split_lock_detect=warn[,sld]: if given "sld" while both features are enabled,
> warn behavior is from split lock instead of bus lock detection.
> 
> split_lock_detect=fatal[,bld]: if given "bld" while both features are enabled,
> fatal behavior is from bus lock detection.

IMO these should be completely independent features (that happen to share
some code).

BLD in fatal mode doesn't make any sense because it can't be fatal without
a completely different implementation, e.g. the bus lock has already
happened and the application can eat the SIGBUS.  The current SLD code
works because the split lock is prevented entirely, i.e. eating SIGBUS
doesn't allow the application to make forward progress.

Smushing the two into a single option is confusing, e.g. from the table
below it's not at all clear what will happen if sld=fatal, both features
are supported, and the kernel generates a split lock.

Given that both SLD (per-core, not architectural) and BLD (#DB recursion and
inverted DR6 flag) have warts, it would be very nice to enable/disable them
independently.  The lock to non-WB behavior for BLD may also be problematic,
e.g. maybe it turns out that fixing drivers to avoid locks to non-WB isn't
as straightforward as avoiding split locks.

> > >  /*
> > >   * Default to sld_off because most systems do not support split lock
> > > detection
> > > - * split_lock_setup() will switch this to sld_warn on systems that
> > > support
> > > - * split lock detect, unless there is a command line override.
> > > + * sld_state_setup() will switch this to sld_warn on systems that
> > > + support
> > > + * split lock/bus lock detect, unless there is a command line override.
> > >   */
> > >  static enum split_lock_detect_state sld_state __ro_after_init =
> > > sld_off;  static u64 msr_test_ctrl_cache __ro_after_init;
> > > +/* Split lock detection is enabled if it's true. */ static bool sld;
> > > +/* Bus lock detection is enabled if it's true. */ static bool bld;
> > 
> > Why can't these be tracked/reflected in X86_FEATURE_*?
> 
> sld and bld are enabled depending on kernel parameter "split_lock_detect=".
> They are not static and cannot be tracked by static X86_FEATURE_*.

X86_FEATURE_* flags aren't static, the kernel sets/clears them all over the
place.
