Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC6C219CD61
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 01:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389574AbgDBXQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 19:16:32 -0400
Received: from mailbackend.panix.com ([166.84.1.89]:40484 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730837AbgDBXQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 19:16:31 -0400
Received: from xps-7390 (c-73-241-154-233.hsd1.ca.comcast.net [73.241.154.233])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 48tf8C3bT6z1B4f;
        Thu,  2 Apr 2020 19:16:26 -0400 (EDT)
Date:   Thu, 2 Apr 2020 16:16:25 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        x86 <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Covelli <dcovelli@vmware.com>
Subject: Re: [PATCH 3/3] KVM: VMX: Extend VMX's #AC interceptor to handle
 split lock #AC in guest
In-Reply-To: <20200402190839.00315012@gandalf.local.home>
Message-ID: <alpine.DEB.2.21.2004021613110.10453@xps-7390>
References: <20200402124205.334622628@linutronix.de> <20200402155554.27705-1-sean.j.christopherson@intel.com> <20200402155554.27705-4-sean.j.christopherson@intel.com> <87sghln6tr.fsf@nanos.tec.linutronix.de> <20200402174023.GI13879@linux.intel.com>
 <87h7y1mz2s.fsf@nanos.tec.linutronix.de> <20200402205109.GM13879@linux.intel.com> <87zhbtle15.fsf@nanos.tec.linutronix.de> <08D90BEB-89F6-4D94-8C2E-A21E43646938@vmware.com> <20200402190839.00315012@gandalf.local.home>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 2 Apr 2020, Steven Rostedt wrote:

> If we go the approach of not letting VM modules load if it doesn't have the
> sld_safe flag set, how is this different than a VM module not loading due
> to kabi breakage?

Why not a compromise: if such a module is attempted to be loaded, print up
a message saying something akin to "turn the parameter 'split_lock_detect'
off" as we reject loading it- and if we see that we've booted with it off
just splat a WARN_ON() if someone tries to load such modules?

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
