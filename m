Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957F22AFA39
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 22:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgKKVOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 16:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgKKVOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 16:14:33 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB9AC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 13:14:31 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id i18so2297429ioa.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 13:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eIq/ejUqSv6Gp/cp6sgKbyYOsHU1PhVukkc0XRFRpO0=;
        b=qhbqHn4vo5c/FvJ5rWXTuDYVhy/Z2VfLGOJqh28mhbWVHM6sKvbBy91ZWeEyCiMIIM
         W3RSUJR4glstgvwvRSs6B8ZCM4/rSWAk/NZEidJDB03WFDRGnXvj8Tid69NHoIWcPqkH
         7VHkavOACv8hJGHZrqOaGj7ajnA4pE04tQBjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eIq/ejUqSv6Gp/cp6sgKbyYOsHU1PhVukkc0XRFRpO0=;
        b=QMEeK2vV64x0eA3AUBqQLIlMSWhJ2ybAiYxz1diV/Bc3KizWGaAUW/N1JaUL0jToXn
         pkF51XsISxiUQpBZEHsURoGAdv1QrhgDibQA4RUDtHmGaaC155VWKO6myzykXkarpcpU
         aLiykIMjVcIH4/wEg1ePMhn54hC2fbzz/OF7UP/cbNlM+L6lS+3xbFry+fJHguuJsVAr
         ZV+aRXxjkdfdimVH+Ouoa9Nip63zod85iuuVwWoaV0WgFgPVLqd2bXisWtIju5xSeD6K
         GVgrLEAgS53C3mmJH1b1xCmCf7q2U/Z2VergQzzROibjCxDjgq+pLM1vDLwOQprbmYcm
         +eMw==
X-Gm-Message-State: AOAM531FoO43Cdh9Mx2F7KrgcVdbHxWWjxcyNOpvnUnmRE5DR5LjPCMT
        rWDkxHi4jO77xEYQ290Fx9GaFaih7Z+EfkekCc2kRVwoD+M=
X-Google-Smtp-Source: ABdhPJyQEBeNmAd3reliZ5kekEqDVkpYU7UAR0Sn53FksfzAlZC1idgbCCORXe2ataU217zHDTLviFW93EliT7aXfOw=
X-Received: by 2002:a6b:5805:: with SMTP id m5mr19817595iob.1.1605129270773;
 Wed, 11 Nov 2020 13:14:30 -0800 (PST)
MIME-Version: 1.0
References: <20201111211011.1381848-1-joel@joelfernandes.org> <20201111211011.1381848-2-joel@joelfernandes.org>
In-Reply-To: <20201111211011.1381848-2-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 11 Nov 2020 16:14:20 -0500
Message-ID: <CAEXW_YTKTdBC_uD8E90FUNwoUWeyVG5XpFWvu-LO7X_fncnZnw@mail.gmail.com>
Subject: Re: [RFC 1/2] x86/bugs: Disable coresched on hardware that does not
 need it
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com,
        Dario Faggioli <dfaggioli@suse.com>,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>,
        =?UTF-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ben Segall <bsegall@google.com>, Josh Don <joshdon@google.com>,
        Hao Luo <haoluo@google.com>,
        "Anand K. Mistry" <amistry@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Mike Rapoport <rppt@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, forgot to CC +Tom Lendacky . Please take a look Tom, thanks.

On Wed, Nov 11, 2020 at 4:10 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> Some hardware such as certain AMD variants don't have cross-HT MDS/L1TF
> issues. Detect this and don't enable core scheduling as it can
> needlessly slow the device done.
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  arch/x86/kernel/cpu/bugs.c | 8 ++++++++
>  kernel/sched/core.c        | 7 +++++++
>  kernel/sched/sched.h       | 5 +++++
>  3 files changed, 20 insertions(+)
>
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index dece79e4d1e9..0e6e61e49b23 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -152,6 +152,14 @@ void __init check_bugs(void)
>  #endif
>  }
>
> +/*
> + * Do not need core scheduling if CPU does not have MDS/L1TF vulnerability.
> + */
> +int arch_allow_core_sched(void)
> +{
> +       return boot_cpu_has_bug(X86_BUG_MDS) || boot_cpu_has_bug(X86_BUG_L1TF);
> +}
> +
>  void
>  x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool setguest)
>  {
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 64c559192634..c6158b4959fe 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -319,6 +319,13 @@ static void __sched_core_enable(void)
>         for_each_online_cpu(cpu)
>                 BUG_ON(!sched_core_empty(cpu_rq(cpu)));
>
> +       /*
> +        * Some architectures may not want coresched. (ex, AMD does not have
> +        * MDS/L1TF issues so it wants SMT completely on).
> +        */
> +       if (!arch_allow_core_sched())
> +               return;
> +
>         static_branch_enable(&__sched_core_enabled);
>         stop_machine(__sched_core_stopper, (void *)true, NULL);
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 3cf08c77b678..a1b39764a6ed 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1203,6 +1203,11 @@ int cpu_core_tag_color_write_u64(struct cgroup_subsys_state *css,
>
>  bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool fi);
>
> +int __weak arch_allow_core_sched(void)
> +{
> +       return true;
> +}
> +
>  #else /* !CONFIG_SCHED_CORE */
>
>  static inline bool sched_core_enqueued(struct task_struct *task) { return false; }
> --
> 2.29.2.222.g5d2a92d10f8-goog
>
