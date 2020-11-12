Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDA12B06CB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgKLNkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728583AbgKLNkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:40:08 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B8CC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 05:40:07 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id n63so3916856qte.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 05:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=81nAiBsdjpUldAoR9BpToGC3oCIjPVlFYGU9myModZ4=;
        b=BbzIHIwiCNuJ39Jv6dogY5LVDT633gdffeAHIIGTHescq16SgewDuzhGpwFpJEdAXm
         46Ax3+u4PWxcXVnaws5U/dZjcWyUC4pG+zgBth1X/rzkGkUczFAbSvtt1KUQnncUMT+g
         +pQrwaQEor3vVs9YVl/hHR3eLVKh4w5IADjaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=81nAiBsdjpUldAoR9BpToGC3oCIjPVlFYGU9myModZ4=;
        b=KiZueWRGxMU76e1msRAzJ6IqPX22sIt7WbOi0PX8rlzPH9NyFBa5gbGe0nOgxprxB3
         ljH8TTH0ci3TPiMFAfZoQgl4y16hQDRM3IzRD+gypWigVx+SvBiWl+0/P/K9IQFz4nx5
         k7I8KK21bjxh90G1Z2gG3kM8N43UU9aRyRnDcsppKcm2lhgzC/x6+0PZM5TE6CdJ5gmy
         k30CafCCqruEUCfW3gl9cq3SLFhMX0XBWYoZensWG23kYSVmEusBa9c/fR4ITHUnKxN/
         Q+TB5u50mkPLlnnG3RVVIiPqWbb9fFWh7dQJmullQcY9R1nmKmh9h8URjQGXACkp4hwq
         62mw==
X-Gm-Message-State: AOAM530Ln1xDw9Yt0tLLxeNW+mEPOH+bOeSKUt8oyEhTZJIUFNw3gY1n
        u3vOKjMm56uY5Vk8h32BRqn8Qw==
X-Google-Smtp-Source: ABdhPJx02E3TXN6Z7yGOr/E6siNbzwJJe09wHS/Qp8p8JPcamRAjDWYUtYA6mg5oTIE9/fi18AtUlA==
X-Received: by 2002:aed:3048:: with SMTP id 66mr29272092qte.374.1605188406848;
        Thu, 12 Nov 2020 05:40:06 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id z26sm4464741qki.40.2020.11.12.05.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 05:40:06 -0800 (PST)
Date:   Thu, 12 Nov 2020 08:40:05 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
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
        =?utf-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>,
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
Subject: Re: [RFC 1/2] x86/bugs: Disable coresched on hardware that does not
 need it
Message-ID: <20201112134005.GA1549282@google.com>
References: <20201111211011.1381848-1-joel@joelfernandes.org>
 <20201111211011.1381848-2-joel@joelfernandes.org>
 <CAEXW_YTKTdBC_uD8E90FUNwoUWeyVG5XpFWvu-LO7X_fncnZnw@mail.gmail.com>
 <b1a1e07d-0df2-72c2-c3da-78e42fa355e8@amazon.com>
 <CAEXW_YRQ_GDcCxFcLrYjwNTG1nDZwUovczPSyOCvxXHq614DFw@mail.gmail.com>
 <CAEXW_YSC+qh8a4nhh6EC2jCaUZd1S59_enWT_rJSXSx5YHjFhw@mail.gmail.com>
 <76aa80c6-b797-f776-90fc-ef4585c41262@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76aa80c6-b797-f776-90fc-ef4585c41262@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 11:29:37PM +0100, Alexander Graf wrote:
> 
> 
> On 11.11.20 23:15, Joel Fernandes wrote:
> > 
> > On Wed, Nov 11, 2020 at 5:13 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > 
> > > On Wed, Nov 11, 2020 at 5:00 PM Alexander Graf <graf@amazon.com> wrote:
> > > > On 11.11.20 22:14, Joel Fernandes wrote:
> > > > > > Some hardware such as certain AMD variants don't have cross-HT MDS/L1TF
> > > > > > issues. Detect this and don't enable core scheduling as it can
> > > > > > needlessly slow the device done.
> > > > > > 
> > > > > > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > > > > > index dece79e4d1e9..0e6e61e49b23 100644
> > > > > > --- a/arch/x86/kernel/cpu/bugs.c
> > > > > > +++ b/arch/x86/kernel/cpu/bugs.c
> > > > > > @@ -152,6 +152,14 @@ void __init check_bugs(void)
> > > > > >    #endif
> > > > > >    }
> > > > > > 
> > > > > > +/*
> > > > > > + * Do not need core scheduling if CPU does not have MDS/L1TF vulnerability.
> > > > > > + */
> > > > > > +int arch_allow_core_sched(void)
> > > > > > +{
> > > > > > +       return boot_cpu_has_bug(X86_BUG_MDS) || boot_cpu_has_bug(X86_BUG_L1TF);
> > > > 
> > > > Can we make this more generic and user settable, similar to the L1 cache
> > > > flushing modes in KVM?
> > > > 
> > > > I am not 100% convinced that there are no other thread sibling attacks
> > > > possible without MDS and L1TF. If I'm paranoid, I want to still be able
> > > > to force enable core scheduling.
> > > > 
> > > > In addition, we are also using core scheduling as a poor man's mechanism
> > > > to give customers consistent performance for virtual machine thread
> > > > siblings. This is important irrespective of CPU bugs. In such a
> > > > scenario, I want to force enable core scheduling.
> > > 
> > > Ok,  I can make it new kernel command line option with:
> > > coresched=on
> > > coresched=secure (only if HW has MDS/L1TF)
> > > coresched=off
> > 
> > Also, I would keep "secure" as the default.  (And probably, we should
> > modify the informational messages in sysfs to reflect this..)
> 
> I agree that "secure" should be the default.

Ok.

> Can we also integrate into the "mitigations" kernel command line[1] for this?

Sure, the integration into [1] sounds conceptually fine to me however it is
not super straight forward. Like: What if user wants to force-enable
core-scheduling for the usecase you mention, but still wants the cross-HT
mitigation because they are only tagging VMs (as in your usecase) and not
other tasks. Idk.

The best thing to do could be to keep the "auto disable HT" controls and
logic separate from the "coresched=on" logic and let the user choose. The
exception being, coresched=secure means that on HW that does not have
vulnerability, we will not activate the core scheduling.

thanks,

 - Joel


> Alex
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/kernel-parameters.txt#n2839
> 
> 
> 
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
> 
> 
