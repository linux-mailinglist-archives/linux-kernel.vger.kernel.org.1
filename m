Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090DF2BFC89
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 23:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgKVWla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 17:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgKVWl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 17:41:29 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF40C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 14:41:29 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id k5so1453665plt.6
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 14:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7qVjazRK/V3lBu7OCD/QeDeirETDO0A195L4HDxXUug=;
        b=j4apR2DTXgWoTUUHKbRvTyxm2fy8/RpK1X0anc/b/mJO538fOTtIYzM8noBGBQRK+a
         gbiM/SBzND8+5j08xU/8bBOfVmTkuuKigBdw5M9+YXTR/RhWtVxHvvwSEATI7O4ZVSun
         mDCF2EfrccF2deN4jttYFY4CWNJWF0xq9HE7CgHcNXrRu66Fno9DwJnT1i89imO6UlRB
         OATWGkEaI82219jp/Mwvh0lhSaG+FFG+ydZ3aVyH6chYOrF0TlZUMMLvhzhZiiFB9GEh
         SG7b0K0ZPNSNfk2Dwxft372CnvqzGI4DM8GI4Gm6obtWh6JSvf3foXRVwwJxnZUuNYul
         LgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7qVjazRK/V3lBu7OCD/QeDeirETDO0A195L4HDxXUug=;
        b=rI3HqN7B1aA1iW7oR41Glwt+WTV3rvGFkddKcEBCcpDN4QDXmeLsLSeQ9+C+6SW3/J
         ui7B84DKJjrEGMKVkCPdBxHn54mFSdnTqo7xoX1YGd5129N/MT50hjgyKSxc7d4OM0KM
         mDuIltFB7jWckpOVTh5TpuIpXbist+NUl9RP6App+Sl1BTleCObrfxyY+ih3I8fG0I7B
         RpH7XPoeScIgRe5akw7Lcuz/3hwNMtAfsjJmlM2Br2Q6sbLKLboFN/r5bS+TeZdgfue0
         O0in8TPToC0qf1J0CH6vMDhEBQ/PDoU6Yd8nr3sh/iFHgmWpSaSMnVvIEIkk2wCIPm5g
         hkOA==
X-Gm-Message-State: AOAM531HY5j5v26D5BNEh0Rda8zKUEMI5svEmgKA1VJxsDYxVZXIN5sJ
        yLoBhoEaR7aR89KPVTNfynE=
X-Google-Smtp-Source: ABdhPJxVDIRwLDR3XIuxvLIbD2oZDHATla0lP2eJ7QVu0LfP5AqMxN+6mEJ13NGSAFzpCCnkjw2hqQ==
X-Received: by 2002:a17:902:ea85:b029:da:b27:396a with SMTP id x5-20020a170902ea85b02900da0b27396amr1938341plb.9.1606084888891;
        Sun, 22 Nov 2020 14:41:28 -0800 (PST)
Received: from localhost (61-68-227-232.tpgi.com.au. [61.68.227.232])
        by smtp.gmail.com with ESMTPSA id d68sm9280237pfd.32.2020.11.22.14.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 14:41:27 -0800 (PST)
Date:   Mon, 23 Nov 2020 09:41:23 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH -tip 10/32] sched: Fix priority inversion of cookied task
 with sibling
Message-ID: <20201122224123.GE110669@balbir-desktop>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-11-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117232003.3580179-11-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 06:19:40PM -0500, Joel Fernandes (Google) wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> The rationale is as follows. In the core-wide pick logic, even if
> need_sync == false, we need to go look at other CPUs (non-local CPUs) to
> see if they could be running RT.
> 
> Say the RQs in a particular core look like this:
> Let CFS1 and CFS2 be 2 tagged CFS tags. Let RT1 be an untagged RT task.
> 
> rq0            rq1
> CFS1 (tagged)  RT1 (not tag)
> CFS2 (tagged)
> 
> Say schedule() runs on rq0. Now, it will enter the above loop and
> pick_task(RT) will return NULL for 'p'. It will enter the above if() block
> and see that need_sync == false and will skip RT entirely.
> 
> The end result of the selection will be (say prio(CFS1) > prio(CFS2)):
> rq0             rq1
> CFS1            IDLE
> 
> When it should have selected:
> rq0             r1
> IDLE            RT
> 
> Joel saw this issue on real-world usecases in ChromeOS where an RT task
> gets constantly force-idled and breaks RT. Lets cure it.
> 
> NOTE: This problem will be fixed differently in a later patch. It just
>       kept here for reference purposes about this issue, and to make
>       applying later patches easier.
>

The changelog is hard to read, it refers to above if(), whereas there
is no code snippet in the changelog. Also, from what I can see following
the series, p->core_cookie is not yet set anywhere (unless I missed it),
so fixing it in here did not make sense just reading the series.

Balbir
