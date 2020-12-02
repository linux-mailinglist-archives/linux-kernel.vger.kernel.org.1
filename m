Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBF12CC5F8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389576AbgLBSyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387760AbgLBSyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:54:10 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCEFC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:53:30 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id u21so1809696qtw.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iFnMmWJa+gzL59L1V90z2bFntM7x08yfzyITaNDP1dQ=;
        b=DoeoPlUtbTS8Yl226741iKKBAt/wvHDna506b0JhW2rsrMMdV8v9xj/58N47CKj5dO
         x7s2FXj3zzrvvVylgOOV0bv3MBTk881c415ljZ4gIW/JdhXOnmkF/B7lhBzSimP812TL
         jnCqyyEEsWeS8sF7drIB2HTySF/cOrA3ucfzvT4oVQ+KP6zgDp1/4DdgaoifN9cYXpmj
         IGpm3k4WZ2op/Gh9rpRyl1EcIdfGM+yRpML+6lF93P/zYYo7muXnoCDH5t2C1WvQGKw0
         RQlg+PrFPWd3rmrK9IFM4SwodtSilHFoGe+rf1d8aHogPR9qG5il7NW7dkCDqcHjQYja
         ZGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=iFnMmWJa+gzL59L1V90z2bFntM7x08yfzyITaNDP1dQ=;
        b=M+OMtS1TT0FZd27/2AlE4Oh/GfpYShu14drOK2SxGcRkEFuJLm7tyA502jaggbjZS1
         shLSkwAX3Z+ACcfjhAEggPKTWRbUbtu0IJQqNDT4PogdPwvIA+0UbYJ+Pe0R0yEhJvET
         cPuuZSpWXXV0qnNJ9mRkqkNEE/AeiW3tR5TvlHUhxIz2CwfbuYguvh855hAxj4Ly8FNf
         /NIhPSkI90r6SWDNWD+KAsnYO+zbIiHWxRuEUU8eTZRx0lYZ19gpn2cXoWxVln8L1vhe
         goIK0smg1jJv3ud8mKsBYR+0LGUz01nVJaK9qlQFcvN2sH3W+0xOuOycHX036GJi98FW
         m1xQ==
X-Gm-Message-State: AOAM533ZR1VpBUWTPhR4ksq36Kj8LZf8OxmTiyXjogvHZaR1+8RfpT6k
        rYtPtK2atfCZpkpdfNzhLdM=
X-Google-Smtp-Source: ABdhPJzondQHOrxCr1ftrVSVmpYTN6pFwPkl+G2K8hb1UbVLkClhx3ZB40Fka8K2O6d+tLl1OSHPsg==
X-Received: by 2002:ac8:580c:: with SMTP id g12mr4160635qtg.340.1606935209140;
        Wed, 02 Dec 2020 10:53:29 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:8dbd])
        by smtp.gmail.com with ESMTPSA id 72sm2658201qkn.44.2020.12.02.10.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 10:53:28 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 2 Dec 2020 13:53:00 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Don <joshdon@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
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
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>,
        Jesse Barnes <jsbarnes@google.com>, chris.hyser@oracle.com,
        Ben Segall <bsegall@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Oleg Rombakh <olegrom@google.com>
Subject: Re: [PATCH -tip 26/32] sched: Add a second-level tag for nested
 CGroup usecase
Message-ID: <X8fijKlASP4yo8kp@mtj.duckdns.org>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-27-joel@joelfernandes.org>
 <20201125134237.GZ2414@hirez.programming.kicks-ass.net>
 <CABk29Nv7+nD1oU9iBhAFAuFoiPM5i7eCOtuG7vuQVcE8+Va=nw@mail.gmail.com>
 <20201202080211.GD3021@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202080211.GD3021@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Dec 02, 2020 at 09:02:11AM +0100, Peter Zijlstra wrote:
> > the user might only want subsets of {B, C, D, E} to share.  For
> > instance, the user might only want {B,C} and {D, E} to share.  One way
> > to solve this would be to allow the user to write the group cookie
> > directly.  However, this interface would need to be restricted to
> > privileged users, since otherwise the cookie could be configured to
> > share with any arbitrary cgroup.  The purpose of the 'color' field is
> > to expose a portion of the cookie that can be modified by a
> > non-privileged user in order to achieve this sharing goal.
> > 
> > If this doesn't seem like a useful case, I'm happy to drop this patch
> > from the series to unblock it.
> 
> Well, the traditional cgroup way of doing that would be to:
> 
>          A
> 	/ \
>        T1 T2
>       / \
>      B   C
> 
> And tag T1 if you want B,C to share.
> 
> So me the color thing reads like an end-run around the cgroup hierarchy.

+1

and please cc me on cgroup related changes.

Thanks.

-- 
tejun
