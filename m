Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99B725B1A1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 18:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgIBQ1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 12:27:24 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:29630 "EHLO
        esa2.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgIBQ0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1599064004;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=YfR7qFQ6lEnKcTjso08AlQu8bZPg3hKojO7X7QBPHn0=;
  b=T4r4QLnoyJMHys5MxUOZ46p/hoGomKatIgssJ4AB3S2kdsJxenXFDXk0
   EOkX5YRS8VgI8iqyJlAjIq5yNjL45KlKA3zqAca8eudRpulrXaKAKSlK7
   fFiWi9rjeWwg2aPs/s2mnsYQTs8n1XzVxIaX/QeH84U2GYm5/QFVeflHi
   4=;
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: PrzPGBdcOOZUYWLsFL9RAjiWG5UaWmrLsk34DoGETdKXfWpocC9QHZVtQv+06f8ZBZRgkL4W0c
 4eNh3ClOIxOzGNI1EVpcSyNE8dKmJwAmKs0XZDjfLwbzlxRQF3a/7/MM5KNETYNiNsRM8BpW+h
 x7VYvW2nI0MCd3OTZiEiS8rhqLF3QwRjmDbA3YKV3tU4GdAqkPVC+5toOOTyaZQZ0W0RwMN3A0
 dg5UWx5OGJzxrRG0LfeG8EsxIqWTvmlMQSwIXL2gQefTWCntm09duJfYx7SuZNnnTqfbtVVN/E
 vI0=
X-SBRS: 2.7
X-MesageID: 25861089
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.76,383,1592884800"; 
   d="scan'208";a="25861089"
Subject: Re: [PATCH 01/13] x86/entry: Fix AC assertion
To:     Brian Gerst <brgerst@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>,
        "Alexandre Chartre" <alexandre.chartre@oracle.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Frederic Weisbecker" <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Sean Christopherson" <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Daniel Thompson" <daniel.thompson@linaro.org>
References: <20200902132549.496605622@infradead.org>
 <20200902133200.666781610@infradead.org>
 <CAMzpN2i9C5Sj-M0b9Y7VtOphDJs2Z9NPux9Dg347PSeNBaXRMQ@mail.gmail.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <f3441d27-1ae1-ddc8-de6d-519ed825b2b8@citrix.com>
Date:   Wed, 2 Sep 2020 17:26:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMzpN2i9C5Sj-M0b9Y7VtOphDJs2Z9NPux9Dg347PSeNBaXRMQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 FTLPEX02CL05.citrite.net (10.13.108.178)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2020 16:58, Brian Gerst wrote:
> On Wed, Sep 2, 2020 at 9:38 AM Peter Zijlstra <peterz@infradead.org> wrote:
>> From: Peter Zijlstra <peterz@infradead.org>
>>
>> The WARN added in commit 3c73b81a9164 ("x86/entry, selftests: Further
>> improve user entry sanity checks") unconditionally triggers on my IVB
>> machine because it does not support SMAP.
>>
>> For !SMAP hardware we patch out CLAC/STAC instructions and thus if
>> userspace sets AC, we'll still have it set after entry.
>>
>> Fixes: 3c73b81a9164 ("x86/entry, selftests: Further improve user entry sanity checks")
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Acked-by: Andy Lutomirski <luto@kernel.org>
>> ---
>>  arch/x86/include/asm/entry-common.h |   11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> --- a/arch/x86/include/asm/entry-common.h
>> +++ b/arch/x86/include/asm/entry-common.h
>> @@ -18,8 +18,16 @@ static __always_inline void arch_check_u
>>                  * state, not the interrupt state as imagined by Xen.
>>                  */
>>                 unsigned long flags = native_save_fl();
>> -               WARN_ON_ONCE(flags & (X86_EFLAGS_AC | X86_EFLAGS_DF |
>> -                                     X86_EFLAGS_NT));
>> +               unsigned long mask = X86_EFLAGS_DF | X86_EFLAGS_NT;
>> +
>> +               /*
>> +                * For !SMAP hardware we patch out CLAC on entry.
>> +                */
>> +               if (boot_cpu_has(X86_FEATURE_SMAP) ||
>> +                   (IS_ENABLED(CONFIG_64_BIT) && boot_cpu_has(X86_FEATURE_XENPV)))
>> +                       mask |= X86_EFLAGS_AC;
> Is the explicit Xen check necessary?  IIRC the Xen hypervisor will
> filter out the SMAP bit in the cpuid pvop.

The Xen check isn't anything to do with SMAP.

64bit PV guest kernels run in Ring3, so userspace's choice of AC for
real alignment check purposes needs to not leak into kernel context.

Xen's ABI for a user => kernel context switch should clear AC on behalf
of the kernel, but the fact still remains that if AC actually leaks into
context for whatever reason, stuff is going to break.

~Andrew
