Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703892B07D5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 15:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgKLOw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 09:52:58 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:65059 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbgKLOw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 09:52:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1605192776; x=1636728776;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=vhx5GXwWnQ81dlE72vwXtDevDCrMzniuTRUfS+tvvtY=;
  b=cdT0eIZXzJGlLkMYjl4CIrGgt8nribmEDvfdQxDr74UOuOIPXXh/X/do
   IQFd2ORXfvT0EP0pN9z5Zba0uggYIKZD0XCRxIot8IrSARxS3YsyVX5mg
   8XTbN3Pa6nrLhtoFQUdWU/ccz6Z29kL2fNN5fAk3H+/e9YwXTQ5E9o4fa
   E=;
X-IronPort-AV: E=Sophos;i="5.77,472,1596499200"; 
   d="scan'208";a="94656041"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 12 Nov 2020 14:52:49 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id CE7E3A24A5;
        Thu, 12 Nov 2020 14:52:45 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 12 Nov 2020 14:52:45 +0000
Received: from edge-cache-322.e-ind6.amazon.com (10.43.162.146) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 12 Nov 2020 14:52:35 +0000
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
From:   Alexander Graf <graf@amazon.com>
Message-ID: <8d4a522a-4ba7-f9f9-0acd-11b0def561c2@amazon.com>
Date:   Thu, 12 Nov 2020 15:52:32 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201112134005.GA1549282@google.com>
Content-Language: en-US
X-Originating-IP: [10.43.162.146]
X-ClientProxiedBy: EX13D25UWC004.ant.amazon.com (10.43.162.201) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.11.20 14:40, Joel Fernandes wrote:
> =

> On Wed, Nov 11, 2020 at 11:29:37PM +0100, Alexander Graf wrote:
>>
>>
>> On 11.11.20 23:15, Joel Fernandes wrote:
>>>
>>> On Wed, Nov 11, 2020 at 5:13 PM Joel Fernandes <joel@joelfernandes.org>=
 wrote:
>>>>
>>>> On Wed, Nov 11, 2020 at 5:00 PM Alexander Graf <graf@amazon.com> wrote:
>>>>> On 11.11.20 22:14, Joel Fernandes wrote:
>>>>>>> Some hardware such as certain AMD variants don't have cross-HT MDS/=
L1TF
>>>>>>> issues. Detect this and don't enable core scheduling as it can
>>>>>>> needlessly slow the device done.
>>>>>>>
>>>>>>> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
>>>>>>> index dece79e4d1e9..0e6e61e49b23 100644
>>>>>>> --- a/arch/x86/kernel/cpu/bugs.c
>>>>>>> +++ b/arch/x86/kernel/cpu/bugs.c
>>>>>>> @@ -152,6 +152,14 @@ void __init check_bugs(void)
>>>>>>>     #endif
>>>>>>>     }
>>>>>>>
>>>>>>> +/*
>>>>>>> + * Do not need core scheduling if CPU does not have MDS/L1TF vulne=
rability.
>>>>>>> + */
>>>>>>> +int arch_allow_core_sched(void)
>>>>>>> +{
>>>>>>> +       return boot_cpu_has_bug(X86_BUG_MDS) || boot_cpu_has_bug(X8=
6_BUG_L1TF);
>>>>>
>>>>> Can we make this more generic and user settable, similar to the L1 ca=
che
>>>>> flushing modes in KVM?
>>>>>
>>>>> I am not 100% convinced that there are no other thread sibling attacks
>>>>> possible without MDS and L1TF. If I'm paranoid, I want to still be ab=
le
>>>>> to force enable core scheduling.
>>>>>
>>>>> In addition, we are also using core scheduling as a poor man's mechan=
ism
>>>>> to give customers consistent performance for virtual machine thread
>>>>> siblings. This is important irrespective of CPU bugs. In such a
>>>>> scenario, I want to force enable core scheduling.
>>>>
>>>> Ok,  I can make it new kernel command line option with:
>>>> coresched=3Don
>>>> coresched=3Dsecure (only if HW has MDS/L1TF)
>>>> coresched=3Doff
>>>
>>> Also, I would keep "secure" as the default.  (And probably, we should
>>> modify the informational messages in sysfs to reflect this..)
>>
>> I agree that "secure" should be the default.
> =

> Ok.
> =

>> Can we also integrate into the "mitigations" kernel command line[1] for =
this?
> =

> Sure, the integration into [1] sounds conceptually fine to me however it =
is
> not super straight forward. Like: What if user wants to force-enable
> core-scheduling for the usecase you mention, but still wants the cross-HT
> mitigation because they are only tagging VMs (as in your usecase) and not
> other tasks. Idk.

Can we roll this backwards from what you would expect as a user? How =

about we make this 2-dimensional?

   coresched=3D[on|off|secure][,force]

where "on" means "core scheduling can be done if colors are set", "off" =

means "no core scheduling is done" and "secure" means "core scheduling =

can be done on MDS or L1TF if colors are set".

The "force" option would then mean "apply a color to every new task".

What then happens with mitigations=3D is easy. "auto" means =

"coresched=3Dsecure". "off" means "coresched=3Doff" and if you want to forc=
e =

core scheduling for everything if necessary, you just do =

mitigations=3Dauto coresched=3Dauto,force.

Am I missing something obvious? :)

> The best thing to do could be to keep the "auto disable HT" controls and
> logic separate from the "coresched=3Don" logic and let the user choose. T=
he
> exception being, coresched=3Dsecure means that on HW that does not have
> vulnerability, we will not activate the core scheduling.

I'm much more interested in the coresched=3Doff one for mitigations=3D. It'=
s =

what we have introduced a while back to save people from setting 50 =

different command line options.


Alex



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



