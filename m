Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7742B0ED6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 21:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgKLUK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 15:10:26 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:34447 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgKLUK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 15:10:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1605211824; x=1636747824;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=YCb4IKXRvUcVjcqy4YVSaT9FQ+nWKNFF+tC8aoAVXe0=;
  b=rAIAclbL6U9zziiqf758xcrXt9/Ys8QWqarMDLGn7VmyggMpM9ptqo3u
   Eb7Qqlmkh2g5d3deQDcA6xEIdHXIvKfc8w0jP2Fy1x7f1ur6y/p79KmNp
   mlYkDxTQji+likJS8ieEi5S9WpZiy11gi8mSqlmPh2ZYOSTlFArqEfChJ
   w=;
X-IronPort-AV: E=Sophos;i="5.77,472,1596499200"; 
   d="scan'208";a="63563805"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 12 Nov 2020 20:10:17 +0000
Received: from EX13MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id 127BDA240D;
        Thu, 12 Nov 2020 20:09:59 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 12 Nov 2020 20:09:58 +0000
Received: from edge-cache-322.e-ind6.amazon.com (10.43.160.229) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 12 Nov 2020 20:09:48 +0000
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
 <20201112134005.GA1549282@google.com> <20201112144014.GB1549282@google.com>
From:   Alexander Graf <graf@amazon.com>
Message-ID: <0b311000-98a2-039a-6b47-75fb9895324f@amazon.com>
Date:   Thu, 12 Nov 2020 21:09:46 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201112144014.GB1549282@google.com>
Content-Language: en-US
X-Originating-IP: [10.43.160.229]
X-ClientProxiedBy: EX13D07UWB003.ant.amazon.com (10.43.161.66) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.11.20 15:40, Joel Fernandes wrote:
> =

> On Thu, Nov 12, 2020 at 08:40:05AM -0500, Joel Fernandes wrote:
>> On Wed, Nov 11, 2020 at 11:29:37PM +0100, Alexander Graf wrote:
>>>
>>>
>>> On 11.11.20 23:15, Joel Fernandes wrote:
>>>>
>>>> On Wed, Nov 11, 2020 at 5:13 PM Joel Fernandes <joel@joelfernandes.org=
> wrote:
>>>>>
>>>>> On Wed, Nov 11, 2020 at 5:00 PM Alexander Graf <graf@amazon.com> wrot=
e:
>>>>>> On 11.11.20 22:14, Joel Fernandes wrote:
>>>>>>>> Some hardware such as certain AMD variants don't have cross-HT MDS=
/L1TF
>>>>>>>> issues. Detect this and don't enable core scheduling as it can
>>>>>>>> needlessly slow the device done.
>>>>>>>>
>>>>>>>> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs=
.c
>>>>>>>> index dece79e4d1e9..0e6e61e49b23 100644
>>>>>>>> --- a/arch/x86/kernel/cpu/bugs.c
>>>>>>>> +++ b/arch/x86/kernel/cpu/bugs.c
>>>>>>>> @@ -152,6 +152,14 @@ void __init check_bugs(void)
>>>>>>>>     #endif
>>>>>>>>     }
>>>>>>>>
>>>>>>>> +/*
>>>>>>>> + * Do not need core scheduling if CPU does not have MDS/L1TF vuln=
erability.
>>>>>>>> + */
>>>>>>>> +int arch_allow_core_sched(void)
>>>>>>>> +{
>>>>>>>> +       return boot_cpu_has_bug(X86_BUG_MDS) || boot_cpu_has_bug(X=
86_BUG_L1TF);
>>>>>>
>>>>>> Can we make this more generic and user settable, similar to the L1 c=
ache
>>>>>> flushing modes in KVM?
>>>>>>
>>>>>> I am not 100% convinced that there are no other thread sibling attac=
ks
>>>>>> possible without MDS and L1TF. If I'm paranoid, I want to still be a=
ble
>>>>>> to force enable core scheduling.
>>>>>>
>>>>>> In addition, we are also using core scheduling as a poor man's mecha=
nism
>>>>>> to give customers consistent performance for virtual machine thread
>>>>>> siblings. This is important irrespective of CPU bugs. In such a
>>>>>> scenario, I want to force enable core scheduling.
>>>>>
>>>>> Ok,  I can make it new kernel command line option with:
>>>>> coresched=3Don
>>>>> coresched=3Dsecure (only if HW has MDS/L1TF)
>>>>> coresched=3Doff
>>>>
>>>> Also, I would keep "secure" as the default.  (And probably, we should
>>>> modify the informational messages in sysfs to reflect this..)
>>>
>>> I agree that "secure" should be the default.
>>
>> Ok.
> =

> Something like so then:
> =

> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index dece79e4d1e9..3c2457d47f54 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -152,6 +152,21 @@ void __init check_bugs(void)
>   #endif
>   }
> =

> +/*
> + * When coresched=3Dsecure, do not need coresched if CPU does not have M=
DS/L1TF bugs.
> + */
> +int arch_allow_core_sched(void)
> +{
> +       /*
> +        * x86: Disallow coresched if it is in secure mode and the CPU do=
es not
> +        * have vulnerabilities.
> +        */
> +       if (coresched_cmd_secure())
> +               return boot_cpu_has_bug(X86_BUG_MDS) || boot_cpu_has_bug(=
X86_BUG_L1TF);
> +       else
> +               return true;
> +}
> +
>   void
>   x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool =
setguest)
>   {
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index d6428aaf67e7..1be5cf85a4a6 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -228,4 +228,7 @@ static inline int cpuhp_smt_disable(enum cpuhp_smt_co=
ntrol ctrlval) { return 0;
>   extern bool cpu_mitigations_off(void);
>   extern bool cpu_mitigations_auto_nosmt(void);
> =

> +extern bool coresched_cmd_off(void);
> +extern bool coresched_cmd_secure(void);
> +
>   #endif /* _LINUX_CPU_H_ */
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 6ff2578ecf17..674edf534cc5 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2552,3 +2552,46 @@ bool cpu_mitigations_auto_nosmt(void)
>          return cpu_mitigations =3D=3D CPU_MITIGATIONS_AUTO_NOSMT;
>   }
>   EXPORT_SYMBOL_GPL(cpu_mitigations_auto_nosmt);
> +
> +/*
> + * These are used for a global "coresched=3D" cmdline option for control=
ling
> + * core scheduling. Note that core sched may be needed for usecases other
> + * than security as well.
> + */
> +enum coresched_cmds {
> +       CORE_SCHED_OFF,
> +       CORE_SCHED_SECURE,
> +       CORE_SCHED_ON,
> +};
> +
> +static enum coresched_cmds coresched_cmd __ro_after_init =3D CORE_SCHED_=
SECURE;
> +
> +static int __init coresched_parse_cmdline(char *arg)
> +{
> +       if (!strcmp(arg, "off"))
> +               coresched_cmd =3D CORE_SCHED_OFF;
> +       else if (!strcmp(arg, "on"))
> +               coresched_cmd =3D CORE_SCHED_ON;
> +       else if (!strcmp(arg, "secure"))
> +               coresched_cmd =3D CORE_SCHED_SECURE;
> +       else
> +               pr_crit("Unsupported coresched=3D%s, defaulting to secure=
.\n",
> +                       arg);
> +
> +       return 0;


Instead of calling the matching function over and over again, can we =

just configure a static branch (see below) based on the command line =

setting here? Or do we not know about the bugs yet?

> +}
> +early_param("coresched", coresched_parse_cmdline);
> +
> +/* coresched=3Doff */
> +bool coresched_cmd_off(void)
> +{
> +       return coresched_cmd =3D=3D CORE_SCHED_OFF;
> +}
> +EXPORT_SYMBOL_GPL(coresched_cmd_off);
> +
> +/* coresched=3Dsecure */
> +bool coresched_cmd_secure(void)
> +{
> +       return coresched_cmd =3D=3D CORE_SCHED_SECURE;
> +}
> +EXPORT_SYMBOL_GPL(coresched_cmd_secure);
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5ed26b469ed6..6f586d221ddb 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -333,8 +333,23 @@ static void __sched_core_disable(void)
>          printk("core sched disabled\n");
>   }
> =

> +static bool __coresched_supported(void)
> +{
> +       /* coreched=3Doff command line option. */
> +       if (coresched_cmd_off())
> +               return false;
> +
> +       /*
> +        * Some arch may not need coresched, example some x86 may not need
> +        * coresched if coresched=3Dsecure option is passed (=3Dsecure is=
 default).
> +        */
> +       return arch_allow_core_sched();
> +}
> +
>   void sched_core_get(void)
>   {
> +       if (!__coresched_supported())
> +               return;

I would expect core scheduling to be basically an option that you set =

once and never flip. This sounds like a prefect use case for a static =

branch to me?


Alex

>          mutex_lock(&sched_core_mutex);
>          if (!sched_core_count++)
>                  __sched_core_enable();
> @@ -343,6 +358,8 @@ void sched_core_get(void)
> =

>   void sched_core_put(void)
>   {
> +       if (!__coresched_supported())
> +               return;
>          mutex_lock(&sched_core_mutex);
>          if (!--sched_core_count)
>                  __sched_core_disable();
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index ada56d8ce56f..20d2aa53336e 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1206,6 +1206,11 @@ int cpu_core_tag_color_write_u64(struct cgroup_sub=
sys_state *css,
> =

>   bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool f=
i);
> =

> +int __weak arch_allow_core_sched(void)
> +{
> +       return true;
> +}
> +
>   #else /* !CONFIG_SCHED_CORE */
> =

>   static inline bool sched_core_enqueued(struct task_struct *task) { retu=
rn false; }
> =




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



