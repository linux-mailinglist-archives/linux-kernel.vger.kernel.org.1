Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225E52C4B23
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 23:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgKYW5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 17:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgKYW5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 17:57:49 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FB4C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 14:57:37 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id k5so151647plt.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 14:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g64g7U4GAHaKj7z3gZ4urzrJeg/GRUrDZaN3e2rg/7I=;
        b=gX0UGA3R4cMOytViDwEKeKS6Zu+WrrqtPOgPrEI7lBwKoywrWQcz6qxseyyuWERJgH
         u7upTWQTpNQ+MsE34RjsOo+DQhbGgQznlOLyU8DO0A5SYx9QSotFT6QxpQ6sjcF4WUgR
         eGwSPMgFrABuoFZCy0+ekxc3S+FbmJt4NdNfkDq8dXoxc8gEq7oXbyGRwmzv3he4Z56j
         wTy5FGPTZVqVR76MtEABh24iKjko5FtGL4Jsfj0Rr6B1PoFWPDOaebroaoWRdURUVS26
         zRCCXrpoG0QCEUYnFMvSnLariZZWTwdV+w0PCwppNAdbsU+wbfr8gd1S4n4S97IunAHF
         tmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g64g7U4GAHaKj7z3gZ4urzrJeg/GRUrDZaN3e2rg/7I=;
        b=TjuyyFQiVOEH3ydSNvSIk2QGIJTeIRcMxQFnvaxrS9dcgjuplneE8Nr2ibhzi/aets
         3PQA8Y3D8Dqiy/WAMf9bTdlrRwgIE4kR+R0E52RLs8f4yrrDmiBTPkJ1Dt384i3eh/8o
         uEWk3rvONdjms5LrfkL4DaGx66S/rPDZ2EWIzd41q0eQ00iz+Sg20W6eNN3Mgav5T089
         SclkMKhCyJX/wA1rieKDpuDNpT/eCz208cUW34w0P5KbpvgI6t1M0olZlrfsuHAokqBT
         8ZNLqM/2nsPH628caMTD0OMqZLvoibRnKjCVOd3o8O9kQmiwbEv9z0prILfWr/B9CRCq
         Rc0g==
X-Gm-Message-State: AOAM530sv+d1k2KmgE+mWrajPETHa/OQ4TJrRayEM19aaqEunKNeZGW5
        JJFh8dawcnDWcPFag+OEF8o=
X-Google-Smtp-Source: ABdhPJyvVkFLfZfnQm6y0RC2JYXootTiNM952kgugDZiZ/VHS20QQiAInBN/TbFOdEmfMbzXHA9kJQ==
X-Received: by 2002:a17:902:7206:b029:d7:e6db:38c6 with SMTP id ba6-20020a1709027206b02900d7e6db38c6mr119974plb.6.1606345056679;
        Wed, 25 Nov 2020 14:57:36 -0800 (PST)
Received: from localhost (61-68-227-232.tpgi.com.au. [61.68.227.232])
        by smtp.gmail.com with ESMTPSA id u4sm3425319pjg.55.2020.11.25.14.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 14:57:35 -0800 (PST)
Date:   Thu, 26 Nov 2020 09:57:31 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH -tip 14/32] sched: migration changes for core scheduling
Message-ID: <20201125225731.GB163610@balbir-desktop>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-15-joel@joelfernandes.org>
 <20201122235456.GF110669@balbir-desktop>
 <0b2514ef-6cc3-c1a3-280b-5d9062c80a31@linux.intel.com>
 <20201124154237.GZ3021@hirez.programming.kicks-ass.net>
 <d541b70c-c65f-5bf6-5e71-0b9b35457fae@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d541b70c-c65f-5bf6-5e71-0b9b35457fae@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 11:12:53AM +0800, Li, Aubrey wrote:
> On 2020/11/24 23:42, Peter Zijlstra wrote:
> > On Mon, Nov 23, 2020 at 12:36:10PM +0800, Li, Aubrey wrote:
> >>>> +#ifdef CONFIG_SCHED_CORE
> >>>> +		/*
> >>>> +		 * Skip this cpu if source task's cookie does not match
> >>>> +		 * with CPU's core cookie.
> >>>> +		 */
> >>>> +		if (!sched_core_cookie_match(cpu_rq(cpu), env->p))
> >>>> +			continue;
> >>>> +#endif
> >>>> +
> >>>
> >>> Any reason this is under an #ifdef? In sched_core_cookie_match() won't
> >>> the check for sched_core_enabled() do the right thing even when
> >>> CONFIG_SCHED_CORE is not enabed?> 
> >> Yes, sched_core_enabled works properly when CONFIG_SCHED_CORE is not
> >> enabled. But when CONFIG_SCHED_CORE is not enabled, it does not make
> >> sense to leave a core scheduler specific function here even at compile
> >> time. Also, for the cases in hot path, this saves CPU cycles to avoid
> >> a judgment.
> > 
> > No, that's nonsense. If it works, remove the #ifdef. Less (#ifdef) is
> > more.
> > 
> 
> Okay, I pasted the refined patch here.
> @Joel, please let me know if you want me to send it in a separated thread.
>

You still have a bunch of #ifdefs, can't we just do

#ifndef CONFIG_SCHED_CORE
static inline bool sched_core_enabled(struct rq *rq)
{
        return false;
}
#endif

and frankly I think even that is not needed because there is a jump
label __sched_core_enabled that tells us if sched_core is enabled or
not.

Balbir

