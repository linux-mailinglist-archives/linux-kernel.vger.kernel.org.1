Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2104027B215
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgI1Qkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:40:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:28047 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbgI1Qku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:40:50 -0400
IronPort-SDR: s6ecdiPyRTYSfmUHRbdCCkyE6Z/27OR6/xSDdMVFDCSpbhPvFBwp4lzwtzXm++z8JVgLrDxXp0
 VwtdMgBYsDlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="226172940"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="226172940"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 09:40:50 -0700
IronPort-SDR: /LmDULZR2KYXKBkfire6UySF12ecP+6N3xV2CFAp4dbmBrfrXn608ArC1MNdwZWwlmSd3gYEvW
 nyEyuM/xkz0Q==
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="456892205"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.93.46]) ([10.212.93.46])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 09:40:46 -0700
Subject: Re: [PATCH v38 21/24] x86/vdso: Implement a vDSO for Intel SGX
 enclave call
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-sgx@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jethro Beekman <jethro@fortanix.com>,
        Cedric Xing <cedric.xing@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        andriy.shevchenko@linux.intel.com, asapek@google.com,
        Borislav Petkov <bp@alien8.de>, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        Dave Hansen <dave.hansen@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>, josh@joshtriplett.org,
        kai.huang@intel.com, kai.svahn@intel.com, kmoy@google.com,
        Christian Ludloff <ludloff@google.com>,
        Andy Lutomirski <luto@kernel.org>, nhorman@redhat.com,
        npmccallum@redhat.com, puiterwijk@redhat.com, rientjes@google.com,
        Thomas Gleixner <tglx@linutronix.de>, yaozhangx@google.com
References: <20200915112842.897265-1-jarkko.sakkinen@linux.intel.com>
 <20200915112842.897265-22-jarkko.sakkinen@linux.intel.com>
 <721ca14e-21df-3df1-7bef-0b00d0ff90c3@citrix.com>
 <c1b0019d-d3cb-cc62-f47f-90c2550c22a4@intel.com>
 <CAMe9rOrVhQr9ad_4en2D5GTTqDsJGXqszBmscgenn_87mDxvUA@mail.gmail.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <a22e1e7f-d268-d336-3e5f-5e596b06eb36@intel.com>
Date:   Mon, 28 Sep 2020 09:40:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMe9rOrVhQr9ad_4en2D5GTTqDsJGXqszBmscgenn_87mDxvUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/2020 8:54 AM, H.J. Lu wrote:
> On Mon, Sep 28, 2020 at 8:43 AM Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
>>
>> On 9/25/2020 11:23 AM, Andrew Cooper wrote:
>>> On 15/09/2020 12:28, Jarkko Sakkinen wrote:
>>>> diff --git a/arch/x86/entry/vdso/vsgx_enter_enclave.S b/arch/x86/entry/vdso/vsgx_enter_enclave.S
>>>> new file mode 100644
>>>> index 000000000000..adbd59d41517
>>>> --- /dev/null
>>>> +++ b/arch/x86/entry/vdso/vsgx_enter_enclave.S
>>>> @@ -0,0 +1,157 @@
>>>> +SYM_FUNC_START(__vdso_sgx_enter_enclave)
>>>> <snip>
>>>> +.Lretpoline:
>>>> +    call    2f
>>>> +1:  pause
>>>> +    lfence
>>>> +    jmp     1b
>>>> +2:  mov     %rax, (%rsp)
>>>> +    ret
>>>
>>> I hate to throw further spanners in the work, but this is not compatible
>>> with CET, and the user shadow stack work in progress.
>>
>> Hi Jarkko,
>>
>> These 1: and 2: targets are reached only from these few lines?  If they
>> are direct call/jmp targets, I think it is OK in terms of CET.  If they
>> are reached from an instruction like "jmp *%rax", then we need to put in
>> an "endbr64".
>>
> 
> This also isn't compatible with shadow stack.
> 

Then, when shadow stack is enabled, disable this?

Yu-cheng
