Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B692B0865
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgKLP27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbgKLP26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:28:58 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE41C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 07:28:58 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id r7so5593180qkf.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 07:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kWlLP1fvplGLswtT3F9tB+2xW0ceWAiGAM8RQ0cG9pY=;
        b=o10nIJGfNvX/Je/WJdwfsWStEd+06X/CGjWmujwYPc31wLH3B0tEB02mq432HpyEzb
         s3LXcZsxQaqrWCpgdSxukDTeTv83/lBINpVRRlSoqHCF7BrPnq5sczyeHJR2O9fRXLA1
         4/pp2DpyRtPqXDKgJlZ3VGoP7XttaMk0xwBwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kWlLP1fvplGLswtT3F9tB+2xW0ceWAiGAM8RQ0cG9pY=;
        b=qu9l63xOpC1QzIiYBJjvyfGxbXP66p0NeCO63Fvxaqio6DN4ofq5yOZq4XvCW1Wl5m
         tzuMv4QzZc2g8Ld/Q9FXzb7zK9sA8Gg0l3TFtpD4sLdsis7q8nLQ5ZLDl+iKQMz2XNOn
         4ddH32o6WVhaytpgLKrTzSNI2kWCIU24SesIhVmeJZrKJ7J8wf+7dIqowbQNLX5pFuAV
         F3J5Rir659gnNM00A1xBB4LRtY8qT6jAW6eoRQKOv9BB+kWRrYwJWbrYFDUeZs97czFl
         IC6kiD4vKIL03TLCz0iyTdmaQudXLigWAVjdmCzLnvo0IXFuekigEkzSCGpyKaZjM7ev
         8TBg==
X-Gm-Message-State: AOAM533iKhKNdFhu1AZ3Nob2H5VisCDA0csXvE47RAOnv9cvzZPLC2Cn
        f/g4BrsaEw78idjosP6lZRwk+A==
X-Google-Smtp-Source: ABdhPJyLYKrMKGmvnUp9wG7kmXnbqHHflFq4gZQvtPXfhdF+ry2zY4OKYDdpQI6DGv+HGCHwR3EMcA==
X-Received: by 2002:a05:620a:80d:: with SMTP id s13mr246231qks.133.1605194937245;
        Thu, 12 Nov 2020 07:28:57 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d82sm4950096qkc.14.2020.11.12.07.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 07:28:56 -0800 (PST)
Date:   Thu, 12 Nov 2020 10:28:56 -0500
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
Message-ID: <20201112152856.GA1617512@google.com>
References: <20201111211011.1381848-1-joel@joelfernandes.org>
 <20201111211011.1381848-2-joel@joelfernandes.org>
 <CAEXW_YTKTdBC_uD8E90FUNwoUWeyVG5XpFWvu-LO7X_fncnZnw@mail.gmail.com>
 <b1a1e07d-0df2-72c2-c3da-78e42fa355e8@amazon.com>
 <CAEXW_YRQ_GDcCxFcLrYjwNTG1nDZwUovczPSyOCvxXHq614DFw@mail.gmail.com>
 <CAEXW_YSC+qh8a4nhh6EC2jCaUZd1S59_enWT_rJSXSx5YHjFhw@mail.gmail.com>
 <76aa80c6-b797-f776-90fc-ef4585c41262@amazon.com>
 <20201112134005.GA1549282@google.com>
 <8d4a522a-4ba7-f9f9-0acd-11b0def561c2@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d4a522a-4ba7-f9f9-0acd-11b0def561c2@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 03:52:32PM +0100, Alexander Graf wrote:
> 
> 
> On 12.11.20 14:40, Joel Fernandes wrote:
> > 
> > On Wed, Nov 11, 2020 at 11:29:37PM +0100, Alexander Graf wrote:
> > > 
> > > 
> > > On 11.11.20 23:15, Joel Fernandes wrote:
> > > > 
> > > > On Wed, Nov 11, 2020 at 5:13 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > > 
> > > > > On Wed, Nov 11, 2020 at 5:00 PM Alexander Graf <graf@amazon.com> wrote:
> > > > > > On 11.11.20 22:14, Joel Fernandes wrote:
> > > > > > > > Some hardware such as certain AMD variants don't have cross-HT MDS/L1TF
> > > > > > > > issues. Detect this and don't enable core scheduling as it can
> > > > > > > > needlessly slow the device done.
> > > > > > > > 
> > > > > > > > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > > > > > > > index dece79e4d1e9..0e6e61e49b23 100644
> > > > > > > > --- a/arch/x86/kernel/cpu/bugs.c
> > > > > > > > +++ b/arch/x86/kernel/cpu/bugs.c
> > > > > > > > @@ -152,6 +152,14 @@ void __init check_bugs(void)
> > > > > > > >     #endif
> > > > > > > >     }
> > > > > > > > 
> > > > > > > > +/*
> > > > > > > > + * Do not need core scheduling if CPU does not have MDS/L1TF vulnerability.
> > > > > > > > + */
> > > > > > > > +int arch_allow_core_sched(void)
> > > > > > > > +{
> > > > > > > > +       return boot_cpu_has_bug(X86_BUG_MDS) || boot_cpu_has_bug(X86_BUG_L1TF);
> > > > > > 
> > > > > > Can we make this more generic and user settable, similar to the L1 cache
> > > > > > flushing modes in KVM?
> > > > > > 
> > > > > > I am not 100% convinced that there are no other thread sibling attacks
> > > > > > possible without MDS and L1TF. If I'm paranoid, I want to still be able
> > > > > > to force enable core scheduling.
> > > > > > 
> > > > > > In addition, we are also using core scheduling as a poor man's mechanism
> > > > > > to give customers consistent performance for virtual machine thread
> > > > > > siblings. This is important irrespective of CPU bugs. In such a
> > > > > > scenario, I want to force enable core scheduling.
> > > > > 
> > > > > Ok,  I can make it new kernel command line option with:
> > > > > coresched=on
> > > > > coresched=secure (only if HW has MDS/L1TF)
> > > > > coresched=off
> > > > 
> > > > Also, I would keep "secure" as the default.  (And probably, we should
> > > > modify the informational messages in sysfs to reflect this..)
> > > 
> > > I agree that "secure" should be the default.
> > 
> > Ok.
> > 
> > > Can we also integrate into the "mitigations" kernel command line[1] for this?
> > 
> > Sure, the integration into [1] sounds conceptually fine to me however it is
> > not super straight forward. Like: What if user wants to force-enable
> > core-scheduling for the usecase you mention, but still wants the cross-HT
> > mitigation because they are only tagging VMs (as in your usecase) and not
> > other tasks. Idk.
> 
> Can we roll this backwards from what you would expect as a user? How about
> we make this 2-dimensional?
> 
>   coresched=[on|off|secure][,force]
> 
> where "on" means "core scheduling can be done if colors are set", "off"
> means "no core scheduling is done" and "secure" means "core scheduling can
> be done on MDS or L1TF if colors are set".

So support for this force thing is not there ATM in the patchset. We can
always incrementally add it later. I personally don't expect users to be Ok
with tagging every single task as it is equivalent to disabling SMT and makes
coresched useless.

> The "force" option would then mean "apply a color to every new task".
> 
> What then happens with mitigations= is easy. "auto" means
> "coresched=secure". "off" means "coresched=off" and if you want to force
> core scheduling for everything if necessary, you just do mitigations=auto
> coresched=auto,force.
> 
> Am I missing something obvious? :)

I guess I am confused for the following usage:
mitigations=auto,nosmt coresched=secure

Note that auto,nosmt disables SMT selectively *only if needed*. Now, you add
coresched=secure to the mix. Should auto,nosmt disable SMT or not? It should be
disabled if the user did not tag anything (because system is insecure). It
should be enabled, if they tagged things. So it really depends on user doing
the right thing. And it is super confusing already -- I would just rather
keep coresched= separate from mitigations= and document it properly. TBH-
coresched does require system admin / designer to tag things as needed so why
pretend that its easy to configure anyway? :)

thanks,

 - Joel

