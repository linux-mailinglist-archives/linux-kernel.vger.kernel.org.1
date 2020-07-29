Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27494232637
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 22:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgG2UgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 16:36:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:6113 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgG2UgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 16:36:01 -0400
IronPort-SDR: wcBGI4d037GG7fgAAUh79+DxRxegNzVhp6NY16IMqh47lKNoXFTDzF+skZQOKC0nOZS+LgB9QR
 beXbj93rLKzA==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="150667373"
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; 
   d="scan'208";a="150667373"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 13:35:57 -0700
IronPort-SDR: 83oOGSBPSz3itEV+umgLccoWbvJ9zGv82wsY+5G6/hrhkXOXtCV1HLb9KChduu3MiIn7D4wk0k
 HAZpL+eIIknA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; 
   d="scan'208";a="490410820"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jul 2020 13:35:57 -0700
Date:   Wed, 29 Jul 2020 20:35:57 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Li, Xiaoyao" <xiaoyao.li@intel.com>, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] x86/bus_lock: Enable bus lock detection
Message-ID: <20200729203557.GA318595@otcwcpicx6.sc.intel.com>
References: <1595021700-68460-1-git-send-email-fenghua.yu@intel.com>
 <20200729030232.GE5583@linux.intel.com>
 <e23b04a2adc54a5dbca48271987de822@intel.com>
 <20200729184614.GI27751@linux.intel.com>
 <20200729194259.GA318576@otcwcpicx6.sc.intel.com>
 <20200729200033.GJ27751@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729200033.GJ27751@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Sean,

On Wed, Jul 29, 2020 at 01:00:33PM -0700, Sean Christopherson wrote:
> On Wed, Jul 29, 2020 at 07:42:59PM +0000, Fenghua Yu wrote:
> > > Smushing the two into a single option is confusing, e.g. from the table
> > > below it's not at all clear what will happen if sld=fatal, both features
> > > are supported, and the kernel generates a split lock.
> > > 
> > > Given that both SLD (per-core, not architectural) and BLD (#DB recursion and
> > > inverted DR6 flag) have warts, it would be very nice to enable/disable them
> > > independently.  The lock to non-WB behavior for BLD may also be problematic,
> > > e.g. maybe it turns out that fixing drivers to avoid locks to non-WB isn't
> > > as straightforward as avoiding split locks.
> > 
> > But the two features are related if both of them are enabled in hardware:
> > If a split lock happens, SLD will generate #AC before instruction execution
> > and BLD will generate #DB after instruction execution.
> > 
> > The software needs to make them exclusive. The same kernel option reflects
> > the relationship and make them exclusive, e.g. "fatal" enables SLD and
> > disables BLD, "warn" does the other way.
> 
> Why do they need to be exclusive?  We've already established that BLD catches
> things that SLD does not.  What's wrong with running sld=fatal and bld=ratelimit
> so that split locks never happen and kill applications, and non-WB locks are
> are ratelimited?

Sorry if I didn't explain bus lock and split lock detections clearly before.

There are two causes of bus locks:
1. a locked access across cache line boundary: this is split lock.
2. a locked access to non-WB memory.

BLD detects both causes and SLD only detects the first one, i.e. BLD can detect
both split lock AND lock to non-WB memory.

If sld=fatal and bld=ratelimit (both sld and bld are enabled in hw),
a split lock always generates #AC and kills the app and bld will never have
a chance to trigger #DB for split lock. So effectively the combination makes
the kernel to take two different actions after detecting a bus lock: if the
bus lock comes from a split lock, fatal (sld); if the bus lock comes from
lock to non-WB memory, ratelimit (bld). Seems this is not a useful combination
and is not what the user really wants to do because the user wants ratelimit
for BLD, right?

> > If using two different kernel options, the user needs to give right options
> > to make both work, e.g. can the user give this combination
> > "split_lock_detect=fatal bus_lock_detect=warn"? What does the combination
> > mean?
> 
> Split locks are fatal, non-WB locks are logged but not fatal.

Similar here: bus lock from a split lock is fatal (sld triggers #AC) and
bus lock from lock to non-WB mem is warn (bld triggers #DB). Seems not what
the user really wants, right?

Thanks.

-Fenghua
