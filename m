Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A552AFB2F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 23:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgKKWPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 17:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKWPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 17:15:19 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12827C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 14:15:19 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id e17so3435992ili.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 14:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=91r94iUTubA0MQQr1EcWS8Ca7E+cJ1bjSDANsENfj5E=;
        b=MRn7h105jseFtjCynfvmm6KGobPP/y6Zm+duoe0ES8mCsTxCU/X7iUeZdPzBR5lMv9
         CiA1qy0yEYzuU5U00uYkdGTUQXjx/8TYWPz3EbHcCwzaiQrAyVZKsVjw5EiQJXwk3pcZ
         MKLLTceD5+ZRE6oWx0VdVpyFthoDnwR9nLjn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=91r94iUTubA0MQQr1EcWS8Ca7E+cJ1bjSDANsENfj5E=;
        b=XBTEX12m53OCIQXcFEtRpAoCLt/6ObIyrqhuRx8q/sx6gwDpAr+ywkGVgSEg86uihM
         ljkKYoplM5T3evl6ok6AZGOXq4JUSO9X5D1V7CVZSs1G5tHwrAwKL7rBNSvCOF1b96u1
         3jRftaDkQLPAiDaJ3joSf/1t2YAZGkjyItKSN7w0pSZmo+FNZmMkf2gntUp0tW0vGsjJ
         U0CvPxlM/lgkcwnlChtp2UcmEdEu7LugtX4RoAaHfcswJQU4JyXRBG2PQRpbQrKIVM6j
         4ZVBN+4qXIDNIYKAlLMh8pYemuqfaXGGzA/iDiJhJBIs4zqrvTnTid7HgRpPzrKXoerv
         tvdw==
X-Gm-Message-State: AOAM530uiNERd8L9OSKjwuZaWY0dM9Eccc9RVSCqqI0Dr0UJGqY6cI4h
        /ChDa90vUAw9EWKjFa0xCKE1GqjVaYFIbecmICnoJg==
X-Google-Smtp-Source: ABdhPJzLLA1PgJkS/cbLDf4+ek/wuZobrGBnev+6L8cHKv47Z7xeVzHurTeNFeddYGNTvnKoKzNhbnDeVeys9toN3MA=
X-Received: by 2002:a92:c0c9:: with SMTP id t9mr6742653ilf.262.1605132918419;
 Wed, 11 Nov 2020 14:15:18 -0800 (PST)
MIME-Version: 1.0
References: <20201111211011.1381848-1-joel@joelfernandes.org>
 <20201111211011.1381848-2-joel@joelfernandes.org> <CAEXW_YTKTdBC_uD8E90FUNwoUWeyVG5XpFWvu-LO7X_fncnZnw@mail.gmail.com>
 <b1a1e07d-0df2-72c2-c3da-78e42fa355e8@amazon.com> <CAEXW_YRQ_GDcCxFcLrYjwNTG1nDZwUovczPSyOCvxXHq614DFw@mail.gmail.com>
In-Reply-To: <CAEXW_YRQ_GDcCxFcLrYjwNTG1nDZwUovczPSyOCvxXHq614DFw@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 11 Nov 2020 17:15:07 -0500
Message-ID: <CAEXW_YSC+qh8a4nhh6EC2jCaUZd1S59_enWT_rJSXSx5YHjFhw@mail.gmail.com>
Subject: Re: [RFC 1/2] x86/bugs: Disable coresched on hardware that does not
 need it
To:     Alexander Graf <graf@amazon.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
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
        konrad.wilk@oracle.com, Dario Faggioli <dfaggioli@suse.com>,
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

On Wed, Nov 11, 2020 at 5:13 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Wed, Nov 11, 2020 at 5:00 PM Alexander Graf <graf@amazon.com> wrote:
> > On 11.11.20 22:14, Joel Fernandes wrote:
> > >> Some hardware such as certain AMD variants don't have cross-HT MDS/L1TF
> > >> issues. Detect this and don't enable core scheduling as it can
> > >> needlessly slow the device done.
> > >>
> > >> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > >> index dece79e4d1e9..0e6e61e49b23 100644
> > >> --- a/arch/x86/kernel/cpu/bugs.c
> > >> +++ b/arch/x86/kernel/cpu/bugs.c
> > >> @@ -152,6 +152,14 @@ void __init check_bugs(void)
> > >>   #endif
> > >>   }
> > >>
> > >> +/*
> > >> + * Do not need core scheduling if CPU does not have MDS/L1TF vulnerability.
> > >> + */
> > >> +int arch_allow_core_sched(void)
> > >> +{
> > >> +       return boot_cpu_has_bug(X86_BUG_MDS) || boot_cpu_has_bug(X86_BUG_L1TF);
> >
> > Can we make this more generic and user settable, similar to the L1 cache
> > flushing modes in KVM?
> >
> > I am not 100% convinced that there are no other thread sibling attacks
> > possible without MDS and L1TF. If I'm paranoid, I want to still be able
> > to force enable core scheduling.
> >
> > In addition, we are also using core scheduling as a poor man's mechanism
> > to give customers consistent performance for virtual machine thread
> > siblings. This is important irrespective of CPU bugs. In such a
> > scenario, I want to force enable core scheduling.
>
> Ok,  I can make it new kernel command line option with:
> coresched=on
> coresched=secure (only if HW has MDS/L1TF)
> coresched=off

Also, I would keep "secure" as the default.  (And probably, we should
modify the informational messages in sysfs to reflect this..)

 - Joel
