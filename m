Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5652B0EB4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 21:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgKLUCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 15:02:13 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:64564 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbgKLUCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 15:02:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1605211330; x=1636747330;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=jn9/YE7mpQGDula9GXZWFRtw+3I00lkrejbrSOYGNSA=;
  b=FdIZFn13y20jHrtE3ssR2ubzh3I222Tbwgz9SgB5r/we2vAf+/aVN1qR
   FXGgsxfl4HUZ7rN3fS78QCSI9V69R1ov9PPQO3N/9kycZNR/8nFaJDu7i
   oOw/dkfnNKZaS4qAMKiihsoG2vSSumgC5muhhfu8JEsxtpvB0I+BYxBRW
   0=;
X-IronPort-AV: E=Sophos;i="5.77,472,1596499200"; 
   d="scan'208";a="86531682"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 12 Nov 2020 20:02:05 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com (Postfix) with ESMTPS id 91EDAA293E;
        Thu, 12 Nov 2020 20:02:01 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 12 Nov 2020 20:02:01 +0000
Received: from edge-cache-322.e-ind6.amazon.com (10.43.162.146) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 12 Nov 2020 20:01:49 +0000
Subject: Re: [RFC 1/2] x86/bugs: Disable coresched on hardware that does not
 need it
To:     Joel Fernandes <joel@joelfernandes.org>
CC:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Tim Chen" <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, <vineeth@bitbyteword.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        <konrad.wilk@oracle.com>, Dario Faggioli <dfaggioli@suse.com>,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>,
        =?UTF-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>,
        "Alexandre Chartre" <alexandre.chartre@oracle.com>,
        <James.Bottomley@hansenpartnership.com>, <OWeisse@umich.edu>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ben Segall <bsegall@google.com>, Josh Don <joshdon@google.com>,
        Hao Luo <haoluo@google.com>,
        "Anand K. Mistry" <amistry@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, "Ingo Molnar" <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Mike Rapoport <rppt@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
References: <20201111211011.1381848-1-joel@joelfernandes.org>
 <20201111211011.1381848-2-joel@joelfernandes.org>
 <CAEXW_YTKTdBC_uD8E90FUNwoUWeyVG5XpFWvu-LO7X_fncnZnw@mail.gmail.com>
 <b1a1e07d-0df2-72c2-c3da-78e42fa355e8@amazon.com>
 <CAEXW_YRQ_GDcCxFcLrYjwNTG1nDZwUovczPSyOCvxXHq614DFw@mail.gmail.com>
 <CAEXW_YSC+qh8a4nhh6EC2jCaUZd1S59_enWT_rJSXSx5YHjFhw@mail.gmail.com>
 <76aa80c6-b797-f776-90fc-ef4585c41262@amazon.com>
 <20201112134005.GA1549282@google.com>
 <8d4a522a-4ba7-f9f9-0acd-11b0def561c2@amazon.com>
 <20201112152856.GA1617512@google.com>
From:   Alexander Graf <graf@amazon.com>
Message-ID: <f2fedf2d-9fad-2648-4c6a-1f3378f6d1b9@amazon.com>
Date:   Thu, 12 Nov 2020 21:01:47 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201112152856.GA1617512@google.com>
Content-Language: en-US
X-Originating-IP: [10.43.162.146]
X-ClientProxiedBy: EX13D15UWA004.ant.amazon.com (10.43.160.219) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.11.20 16:28, Joel Fernandes wrote:
> =

> On Thu, Nov 12, 2020 at 03:52:32PM +0100, Alexander Graf wrote:
>>
>>
>> On 12.11.20 14:40, Joel Fernandes wrote:
>>>
>>> On Wed, Nov 11, 2020 at 11:29:37PM +0100, Alexander Graf wrote:
>>>>
>>>>
>>>> On 11.11.20 23:15, Joel Fernandes wrote:
>>>>>
>>>>> On Wed, Nov 11, 2020 at 5:13 PM Joel Fernandes <joel@joelfernandes.or=
g> wrote:
>>>>>>
>>>>>> On Wed, Nov 11, 2020 at 5:00 PM Alexander Graf <graf@amazon.com> wro=
te:
>>>>>>> On 11.11.20 22:14, Joel Fernandes wrote:
>>>>>>>>> Some hardware such as certain AMD variants don't have cross-HT MD=
S/L1TF
>>>>>>>>> issues. Detect this and don't enable core scheduling as it can
>>>>>>>>> needlessly slow the device done.
>>>>>>>>>
>>>>>>>>> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bug=
s.c
>>>>>>>>> index dece79e4d1e9..0e6e61e49b23 100644
>>>>>>>>> --- a/arch/x86/kernel/cpu/bugs.c
>>>>>>>>> +++ b/arch/x86/kernel/cpu/bugs.c
>>>>>>>>> @@ -152,6 +152,14 @@ void __init check_bugs(void)
>>>>>>>>>      #endif
>>>>>>>>>      }
>>>>>>>>>
>>>>>>>>> +/*
>>>>>>>>> + * Do not need core scheduling if CPU does not have MDS/L1TF vul=
nerability.
>>>>>>>>> + */
>>>>>>>>> +int arch_allow_core_sched(void)
>>>>>>>>> +{
>>>>>>>>> +       return boot_cpu_has_bug(X86_BUG_MDS) || boot_cpu_has_bug(=
X86_BUG_L1TF);
>>>>>>>
>>>>>>> Can we make this more generic and user settable, similar to the L1 =
cache
>>>>>>> flushing modes in KVM?
>>>>>>>
>>>>>>> I am not 100% convinced that there are no other thread sibling atta=
cks
>>>>>>> possible without MDS and L1TF. If I'm paranoid, I want to still be =
able
>>>>>>> to force enable core scheduling.
>>>>>>>
>>>>>>> In addition, we are also using core scheduling as a poor man's mech=
anism
>>>>>>> to give customers consistent performance for virtual machine thread
>>>>>>> siblings. This is important irrespective of CPU bugs. In such a
>>>>>>> scenario, I want to force enable core scheduling.
>>>>>>
>>>>>> Ok,  I can make it new kernel command line option with:
>>>>>> coresched=3Don
>>>>>> coresched=3Dsecure (only if HW has MDS/L1TF)
>>>>>> coresched=3Doff
>>>>>
>>>>> Also, I would keep "secure" as the default.  (And probably, we should
>>>>> modify the informational messages in sysfs to reflect this..)
>>>>
>>>> I agree that "secure" should be the default.
>>>
>>> Ok.
>>>
>>>> Can we also integrate into the "mitigations" kernel command line[1] fo=
r this?
>>>
>>> Sure, the integration into [1] sounds conceptually fine to me however i=
t is
>>> not super straight forward. Like: What if user wants to force-enable
>>> core-scheduling for the usecase you mention, but still wants the cross-=
HT
>>> mitigation because they are only tagging VMs (as in your usecase) and n=
ot
>>> other tasks. Idk.
>>
>> Can we roll this backwards from what you would expect as a user? How abo=
ut
>> we make this 2-dimensional?
>>
>>    coresched=3D[on|off|secure][,force]
>>
>> where "on" means "core scheduling can be done if colors are set", "off"
>> means "no core scheduling is done" and "secure" means "core scheduling c=
an
>> be done on MDS or L1TF if colors are set".
> =

> So support for this force thing is not there ATM in the patchset. We can
> always incrementally add it later. I personally don't expect users to be =
Ok
> with tagging every single task as it is equivalent to disabling SMT and m=
akes
> coresched useless.

It just flips the default from "always consider everything safe" to =

"always consider everything unsafe". Inside a cgroup, you can still set =

the same color to make use of siblings.

Either way, I agree that it can be a follow-up.

> =

>> The "force" option would then mean "apply a color to every new task".
>>
>> What then happens with mitigations=3D is easy. "auto" means
>> "coresched=3Dsecure". "off" means "coresched=3Doff" and if you want to f=
orce
>> core scheduling for everything if necessary, you just do mitigations=3Da=
uto
>> coresched=3Dauto,force.
>>
>> Am I missing something obvious? :)
> =

> I guess I am confused for the following usage:
> mitigations=3Dauto,nosmt coresched=3Dsecure
> =

> Note that auto,nosmt disables SMT selectively *only if needed*. Now, you =
add
> coresched=3Dsecure to the mix. Should auto,nosmt disable SMT or not? It s=
hould be
> disabled if the user did not tag anything (because system is insecure). It
> should be enabled, if they tagged things. So it really depends on user do=
ing
> the right thing. And it is super confusing already -- I would just rather
> keep coresched=3D separate from mitigations=3D and document it properly. =
TBH-
> coresched does require system admin / designer to tag things as needed so=
 why
> pretend that its easy to configure anyway? :)

coresched=3Dsecure still won't allow you to trust your system without =

thinking about it, while nosmt does. So I would say that nosmt does not =

imply anything for coresched (until ,force is available, then we're =

talking ...)

The main thing I'm interested in though is mitigations=3Doff. When you =

know you only care about performance and not side channel security (HPC =

for example), then you can in general just set mitigations=3Doff. That =

should definitely affect the core scheduling setting as well.


Alex



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



