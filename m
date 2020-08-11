Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA77241859
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 10:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgHKIix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 04:38:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:32826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbgHKIix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 04:38:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9C3F0B1ED;
        Tue, 11 Aug 2020 08:39:11 +0000 (UTC)
Subject: Re: [PATCH] x86/paravirt: Add missing noinstr to arch_local*()
 helpers
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        fenghua.yu@intel.com, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        yu-cheng.yu@intel.com, sdeep@vmware.com,
        virtualization@lists.linux-foundation.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Wei Liu <wei.liu@kernel.org>
References: <CANpmjNO860SHpNve+vaoAOgarU1SWy8o--tUWCqNhn82OLCiew@mail.gmail.com>
 <fe2bfa7f-132f-7581-a967-d01d58be1588@suse.com>
 <20200807095032.GA3528289@elver.google.com>
 <16671cf3-3885-eb06-79ff-4cbfaeeaea79@suse.com>
 <20200807113838.GA3547125@elver.google.com>
 <e5bf3e6a-efff-7170-5ee6-1798008393a2@suse.com>
 <CANpmjNPau_DEYadey9OL+iFZKEaUTqnFnyFs1dU12o00mg7ofA@mail.gmail.com>
 <20200807151903.GA1263469@elver.google.com>
 <20200811074127.GR3982@worktop.programming.kicks-ass.net>
 <a2dffeeb-04f0-8042-b39a-b839c4800d6f@suse.com>
 <20200811081205.GV3982@worktop.programming.kicks-ass.net>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <07f61573-fef1-e07c-03f2-a415c88dec6f@suse.com>
Date:   Tue, 11 Aug 2020 10:38:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811081205.GV3982@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.20 10:12, Peter Zijlstra wrote:
> On Tue, Aug 11, 2020 at 09:57:55AM +0200, Jürgen Groß wrote:
>> On 11.08.20 09:41, Peter Zijlstra wrote:
>>> On Fri, Aug 07, 2020 at 05:19:03PM +0200, Marco Elver wrote:
>>>
>>>> My hypothesis here is simply that kvm_wait() may be called in a place
>>>> where we get the same case I mentioned to Peter,
>>>>
>>>> 	raw_local_irq_save(); /* or other IRQs off without tracing */
>>>> 	...
>>>> 	kvm_wait() /* IRQ state tracing gets confused */
>>>> 	...
>>>> 	raw_local_irq_restore();
>>>>
>>>> and therefore, using raw variants in kvm_wait() works. It's also safe
>>>> because it doesn't call any other libraries that would result in corrupt
>>>
>>> Yes, this is definitely an issue.
>>>
>>> Tracing, we also musn't call into tracing when using raw_local_irq_*().
>>> Because then we re-intoduce this same issue all over again.
>>>
>>> Both halt() and safe_halt() are more paravirt calls, but given we're in
>>> a KVM paravirt call already, I suppose we can directly use native_*()
>>> here.
>>>
>>> Something like so then... I suppose, but then the Xen variants need TLC
>>> too.
>>
>> Just to be sure I understand you correct:
>>
>> You mean that xen_qlock_kick() and xen_qlock_wait() and all functions
>> called by those should gain the "notrace" attribute, right?
>>
>> I am not sure why the kick variants need it, though. IMO those are
>> called only after the lock has been released, so they should be fine
>> without notrace.
> 
> The issue happens when someone uses arch_spinlock_t under
> raw_local_irq_*().
> 
>> And again: we shouldn't forget the Hyper-V variants.
> 
> Bah, my grep failed :/ Also *groan*, that's calling apic->send_IPI().

In case you don't want to do it I can send the patch for the Xen
variants.


Juergen
