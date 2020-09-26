Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1E4279CF1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 01:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgIZX4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 19:56:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:29838 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgIZX4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 19:56:01 -0400
IronPort-SDR: laUGDarGpf/YJM6rItsMCJfal2oxqJ2iU78kG/nPEkuUcMk22zXknrJwk968pJmUxd4TwA9Lfx
 otntnoeB4JEQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9756"; a="223405183"
X-IronPort-AV: E=Sophos;i="5.77,308,1596524400"; 
   d="scan'208";a="223405183"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2020 16:55:59 -0700
IronPort-SDR: 16qpF8Nv+9XSDhlGydbmHZL3aFM7rY+m+fnK6lBFOzFrsEm7zJT0u+RJRFdhcAXq7Zd5nXnFpW
 aBIsQVrn8gdw==
X-IronPort-AV: E=Sophos;i="5.77,308,1596524400"; 
   d="scan'208";a="456346504"
Received: from bxing-mobl.amr.corp.intel.com (HELO [10.209.182.165]) ([10.209.182.165])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2020 16:55:58 -0700
Subject: Re: Can we credibly make vdso_sgx_enter_enclave() pleasant to use?
To:     Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Jethro Beekman <jethro@fortanix.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathaniel McCallum <npmccallum@redhat.com>,
        linux-sgx@vger.kernel.org
References: <CALCETrUhQjQQa-BqNHPgdDfD9GDJZXJWSQ_M0tDF_ri5RfyTsw@mail.gmail.com>
 <20200925190915.GD31528@linux.intel.com>
 <CALCETrWDgb_mVPDmKy_7oFg03cOxO-GAUS8kOFrfGiPp9RjboA@mail.gmail.com>
 <20200925222938.GI31528@linux.intel.com>
 <CALCETrUV-cx6dii2cOcav01GSdo9qx6+GYeoPH9nHMXwg-geQQ@mail.gmail.com>
From:   "Xing, Cedric" <cedric.xing@intel.com>
Message-ID: <5d0f1809-bbfa-1ab9-a533-fb99419884c9@intel.com>
Date:   Sat, 26 Sep 2020 16:55:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CALCETrUV-cx6dii2cOcav01GSdo9qx6+GYeoPH9nHMXwg-geQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/2020 12:05 PM, Andy Lutomirski wrote:
> On Fri, Sep 25, 2020 at 3:29 PM Sean Christopherson
> <sean.j.christopherson@intel.com> wrote:
>>
>> On Fri, Sep 25, 2020 at 01:20:03PM -0700, Andy Lutomirski wrote:
>>> On Fri, Sep 25, 2020 at 12:09 PM Sean Christopherson
>>> <sean.j.christopherson@intel.com> wrote:
>>>> But where would the vDSO get memory for that little data structure?  It can't
>>>> be percpu because the current task can get preempted.  It can't be per instance
>>>> of the vDSO because a single mm/process can have multiple tasks entering an
>>>> enclave.  Per task might work, but how would the vDSO get that info?  E.g.
>>>> via a syscall, which seems like complete overkill?
>>>
>>> The stack.
>>
>> Duh.
>>
>>> The vDSO could, logically, do:
>>>
>>> struct sgx_entry_state {
>>>    unsigned long real_rbp;
>>>    unsigned long real_rsp;
>>>    unsigned long orig_fsbase;
>>> };
>>>
>>> ...
>>>
>>>    struct sgx_entry_state state;
>>>    state.rbp = rbp;  [ hey, this is pseudocode.  the real code would be in asm.]
>>>    state.rsp = rsp;
>>>    state.fsbase = __rdfsbase();
>>>    rbp = arg->rbp;
>>>
>>>    /* set up all other regs */
>>>    wrfsbase %rsp
>>>    movq enclave_rsp(%rsp), %rsp
>>
>> I think this is where there's a disconnect with what is being requested by the
>> folks writing run times.  IIUC, they want to use the untrusted runtime's stack
>> to pass params because it doesn't require additional memory allocations and
>> automagically grows as necessary (obviously to a certain limit).  I.e. forcing
>> the caller to provide an alternative "stack" defeats the purpose of using the
>> untrusted stack.
> 
> I personally find this concept rather distasteful.  Sure, it might
> save a couple cycles, but it means that the enclave has hardcoded some
> kind of assumption about the outside-the-enclave stack.
> 

It's more than just a couple of cycles. It's convenience. Yes, an 
enclave may overflow the caller's stack with big allocations but those 
are rare. In more common cases less than the red zone size (128 bytes) 
are required. And we should optimize for the more common cases.

And yes again, the enclave has to assume something about the stack. But 
please note that the vDSO has to save its "context" somewhere so that it 
can switch back to it. The "context" currently is anchored at RBP so the 
enclave has to preserve it. If not RBP, the "context" has to anchor 
"something else", and we have to assume the enclave preserve that 
"something else". That said, we can't get rid of assumptions. RBP is a 
reasonable choice because it is simple without obvious side effects, 
i.e. most compilers/ABIs preserve RBP so developers don't have to pay 
extra attention to it generally.

If I were asked to opine on the API, I'd say I like the most the initial 
version with callback support. The stack parameters were easier to 
set/retrieve than struct members (requiring hand-crafted offset macros) 
in asm, and didn't need any padding. The callback was easy to use 
(non-NULL pointer) or skip (NULL pointer). Standard/unified error codes 
were easier to handle than separate error/exit_reason. Additional data 
for callback could be captured in a structure enclosing 
sgx_enclave_exception so no need to be explicitly passed (languages that 
don't support offsetof/container_of can always employ an asm wrapper). 
The current API looks confusing and overly complicated to me, even 
though it still works.

> Given that RBP seems reasonably likely to be stable across enclave
> executions, I suppose we could add a flag and an RSP value in the
> sgx_enclave_run structure.  If set, the vDSO would swap out RSP (but
> not RBP) with the provided value on entry and record the new RSP on
> exit.  I don't know if this would be useful to people.
> 

I would say, if one wants to use a different untrusted stack for calling 
the enclave, he/she could switch stack before calling vDSO. Given this 
isn't commonly required, I vote NO here.


> I do think we need to add at least minimal CFI annotations no matter what we do.
> 

Can't agree more.
