Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD922B498E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 16:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbgKPPiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 10:38:06 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:33969 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730349AbgKPPiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1605541084; x=1637077084;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=1v9wS2Qp/8kB1+fCpTZjPgZwtAbdEkdRzut9GLGdSoQ=;
  b=VBE4gmxDfOVinkNAO6HLntDScqrkPjHIx2k0FktWrEclBIBDU/sT4xQw
   Fz0cJ4+vX0qGZUam5LeFvqYTxRZbeuTTYE7M8kGyCpaqTksqDVkCkTBNy
   Dr54DAW8XaJhmp6RCpX91pMDrVusW6+H2hmPiJQ2Jc8U39UjcLcCqAG2V
   0=;
X-IronPort-AV: E=Sophos;i="5.77,482,1596499200"; 
   d="scan'208";a="95805448"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 16 Nov 2020 15:37:55 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (Postfix) with ESMTPS id 3F6BEC060C;
        Mon, 16 Nov 2020 15:37:52 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 16 Nov 2020 15:37:51 +0000
Received: from edge-dns-1.e-ind6.amazon.com (10.43.161.34) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 16 Nov 2020 15:37:41 +0000
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
 <0b311000-98a2-039a-6b47-75fb9895324f@amazon.com>
 <20201113155520.GA2156685@google.com>
From:   Alexander Graf <graf@amazon.com>
Message-ID: <1e370095-0f2b-7d5d-4ca6-198c56189309@amazon.com>
Date:   Mon, 16 Nov 2020 16:37:39 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201113155520.GA2156685@google.com>
Content-Language: en-US
X-Originating-IP: [10.43.161.34]
X-ClientProxiedBy: EX13D01UWB003.ant.amazon.com (10.43.161.94) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.11.20 16:55, Joel Fernandes wrote:
> =

> =

>>> +static enum coresched_cmds coresched_cmd __ro_after_init =3D CORE_SCHE=
D_SECURE;
>>> +
>>> +static int __init coresched_parse_cmdline(char *arg)
>>> +{
>>> +       if (!strcmp(arg, "off"))
>>> +               coresched_cmd =3D CORE_SCHED_OFF;
>>> +       else if (!strcmp(arg, "on"))
>>> +               coresched_cmd =3D CORE_SCHED_ON;
>>> +       else if (!strcmp(arg, "secure"))
>>> +               coresched_cmd =3D CORE_SCHED_SECURE;
>>> +       else
>>> +               pr_crit("Unsupported coresched=3D%s, defaulting to secu=
re.\n",
>>> +                       arg);
>>> +
>>> +       return 0;
>>
>>
>> Instead of calling the matching function over and over again, can we just
>> configure a static branch (see below) based on the command line setting
>> here? Or do we not know about the bugs yet?
> [...]
>>> +static bool __coresched_supported(void)
>>> +{
>>> +       /* coreched=3Doff command line option. */
>>> +       if (coresched_cmd_off())
>>> +               return false;
>>> +
>>> +       /*
>>> +        * Some arch may not need coresched, example some x86 may not n=
eed
>>> +        * coresched if coresched=3Dsecure option is passed (=3Dsecure =
is default).
>>> +        */
>>> +       return arch_allow_core_sched();
>>> +}
>>> +
>>>    void sched_core_get(void)
>>>    {
>>> +       if (!__coresched_supported())
>>> +               return;
>>
>> I would expect core scheduling to be basically an option that you set on=
ce
>> and never flip. This sounds like a prefect use case for a static branch =
to
>> me?
> =

> Something ike so then? If Ok, let me know if I can add your Reviewed-by t=
ag.
> =

> thanks!
> =

> ---8<-----------------------
> =

> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Subject: [PATCH] sched: Add a coresched command line option
> =

> Some hardware such as certain AMD variants don't have cross-HT MDS/L1TF
> issues. Detect this and don't enable core scheduling as it can
> needlessly slow those device down.
> =

> However, some users may want core scheduling even if the hardware is
> secure. To support them, add a coresched=3D option which defaults to
> 'secure' and can be overridden to 'on' if the user wants to enable
> coresched even if the HW is not vulnerable. 'off' would disable
> core scheduling in any case.
> =

> Also add a sched_debug entry to indicate if core scheduling is turned on
> or not.
> =

> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>   arch/x86/kernel/cpu/bugs.c | 19 +++++++++++++++++++
>   include/linux/cpu.h        |  1 +
>   include/linux/sched/smt.h  |  4 ++++
>   kernel/cpu.c               | 38 ++++++++++++++++++++++++++++++++++++++
>   kernel/sched/core.c        |  6 ++++++
>   kernel/sched/debug.c       |  4 ++++
>   6 files changed, 72 insertions(+)
> =

> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index dece79e4d1e9..7607c9cd7f0f 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -43,6 +43,7 @@ static void __init mds_select_mitigation(void);
>   static void __init mds_print_mitigation(void);
>   static void __init taa_select_mitigation(void);
>   static void __init srbds_select_mitigation(void);
> +static void __init coresched_select(void);
> =

>   /* The base value of the SPEC_CTRL MSR that always has to be preserved.=
 */
>   u64 x86_spec_ctrl_base;
> @@ -103,6 +104,9 @@ void __init check_bugs(void)
>          if (boot_cpu_has(X86_FEATURE_STIBP))
>                  x86_spec_ctrl_mask |=3D SPEC_CTRL_STIBP;
> =

> +       /* Update whether core-scheduling is needed. */
> +       coresched_select();
> +
>          /* Select the proper CPU mitigations before patching alternative=
s: */
>          spectre_v1_select_mitigation();
>          spectre_v2_select_mitigation();
> @@ -1808,4 +1812,19 @@ ssize_t cpu_show_srbds(struct device *dev, struct =
device_attribute *attr, char *
>   {
>          return cpu_show_common(dev, attr, buf, X86_BUG_SRBDS);
>   }
> +
> +/*
> + * When coresched=3Dsecure command line option is passed (default), disa=
ble core
> + * scheduling if CPU does not have MDS/L1TF vulnerability.
> + */
> +static void __init coresched_select(void)
> +{
> +#ifdef CONFIG_SCHED_CORE
> +       if (!coresched_cmd_secure())

Make this a positive branch instead please :).

/*
  * Disable core scheduling on non-MDS, non-L1TF systems
  * when coresched=3Dsecure (default)
  */
if (coresched_cmd_secure() &&
     !boot_cpu_has_bug(X86_BUG_MDS) &&
     !boot_cpu_has_bug(X86_BUG_L1TF))
         static_branch_disable(&sched_coresched_supported);

> +               return;
> +       if (!boot_cpu_has_bug(X86_BUG_MDS) && !boot_cpu_has_bug(X86_BUG_L=
1TF))
> +               static_branch_disable(&sched_coresched_supported);
> +#endif
> +}
> +
>   #endif
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index d6428aaf67e7..d1f1e64316d6 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -228,4 +228,5 @@ static inline int cpuhp_smt_disable(enum cpuhp_smt_co=
ntrol ctrlval) { return 0;
>   extern bool cpu_mitigations_off(void);
>   extern bool cpu_mitigations_auto_nosmt(void);
> =

> +extern bool coresched_cmd_secure(void);
>   #endif /* _LINUX_CPU_H_ */
> diff --git a/include/linux/sched/smt.h b/include/linux/sched/smt.h
> index 59d3736c454c..561064eb3268 100644
> --- a/include/linux/sched/smt.h
> +++ b/include/linux/sched/smt.h
> @@ -17,4 +17,8 @@ static inline bool sched_smt_active(void) { return fals=
e; }
> =

>   void arch_smt_update(void);
> =

> +#ifdef CONFIG_SCHED_CORE
> +extern struct static_key_true sched_coresched_supported;
> +#endif
> +
>   #endif
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 6ff2578ecf17..b1cdfc7616b4 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2552,3 +2552,41 @@ bool cpu_mitigations_auto_nosmt(void)
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
> +       if (coresched_cmd =3D=3D CORE_SCHED_OFF)
> +               static_branch_disable(&sched_coresched_supported);
> +       return 0;
> +}
> +early_param("coresched", coresched_parse_cmdline);
> +
> +/* coresched=3Dsecure */
> +bool coresched_cmd_secure(void)
> +{
> +       return coresched_cmd =3D=3D CORE_SCHED_SECURE;
> +}
> +EXPORT_SYMBOL_GPL(coresched_cmd_secure);
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5ed26b469ed6..959fddf7d8de 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -333,8 +333,12 @@ static void __sched_core_disable(void)
>          printk("core sched disabled\n");
>   }
> =

> +DEFINE_STATIC_KEY_TRUE(sched_coresched_supported);
> +
>   void sched_core_get(void)
>   {
> +       if (!static_branch_likely(&sched_coresched_supported))
> +               return;
>          mutex_lock(&sched_core_mutex);
>          if (!sched_core_count++)
>                  __sched_core_enable();
> @@ -343,6 +347,8 @@ void sched_core_get(void)
> =

>   void sched_core_put(void)
>   {
> +       if (!static_branch_likely(&sched_coresched_supported))
> +               return;
>          mutex_lock(&sched_core_mutex);
>          if (!--sched_core_count)
>                  __sched_core_disable();
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 88bf45267672..935b68be18cd 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -782,6 +782,10 @@ static void sched_debug_header(struct seq_file *m)
>                  "sysctl_sched_tunable_scaling",
>                  sysctl_sched_tunable_scaling,
>                  sched_tunable_scaling_names[sysctl_sched_tunable_scaling=
]);
> +#ifdef CONFIG_SCHED_CORE
> +       SEQ_printf(m, "  .%-40s: %d\n", "core_sched_enabled",
> +                  !!static_branch_likely(&__sched_core_enabled));
> +#endif
>          SEQ_printf(m, "\n");
>   }
> =

> =


[...]

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index a36f08d74e09..8de377dc8592 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -698,6 +698,15 @@
>                         /proc/<pid>/coredump_filter.
>                         See also Documentation/filesystems/proc.rst.
> =

> +       coresched=3D

It would be nice to list the possible arguments here too.

> +                       [SCHED_CORE] Enable/disable the core scheduling f=
eature.
> +                       A value of 'on' keeps coresched on always. A valu=
e of

This reads as if coresched=3Don means that all your tasks are core =

scheduled. I'd prefer if you could clarify the option a bit to mean that =

this *plus* tagging gets your core scheduling.


Alex

> +                       'off' keeps coresched off always. A value of 'sec=
ure'
> +                       keeps it on only if the system has vulnerabilitie=
s. Defaults
> +                       to 'secure'. A user who has a non-security usecas=
e that needs
> +                       core scheduling, such as improving performance of=
 VMs by
> +                       tagging vCPU should pass 'on' to force it on.
> +
>         coresight_cpu_debug.enable
>                         [ARM,ARM64]
>                         Format: <bool>





Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



