Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989962C197B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 00:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgKWXfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 18:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgKWXfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 18:35:15 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1F4C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 15:35:13 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id j19so15721064pgg.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 15:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EqCdcY0NjJYGsiQJ8eTnyGd/Mw2TsG9juC2Rv9pve2o=;
        b=ew89d2b5uePmAzmlDIwTELvqG17w7Iuqx1lCm3J9X1/izXZun8Y+EorDdHiYRafpU5
         KG8hL9TjkBscWYCUhVVqdklnqEWP86o36mAd15I0GST1gsOjFtsYKi1n3O1afXbFqbb3
         ydbEURqlMK6CTsYGFcYbHwc0RxzLn9rvEHNrzuZrIKRxfQ8yHx5DDvUMI6o4ciej4MBS
         lQISo+C9cUg1yzMorIkuVpdQu6BCO6P+S3kOrXzDn7qIxBU/bqiUhFH7j3IsA3MXxwHz
         BflK19SkMlbnYFpXNE6pzvlTMP5zzdArnO73TNh2MVgYsAIE5DL8iTUh3XAhEI04978Q
         zc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EqCdcY0NjJYGsiQJ8eTnyGd/Mw2TsG9juC2Rv9pve2o=;
        b=mDOwL/B/sXvVa/rlbk4A2kOn5BmuNk0b5qxAgVy8ZS6UbaDi4wPzbJDaEmoENHiMu8
         puoU8WtpHpNLdS74et+UaSOziUUq7XCJ+HVCMGbzFDoroKHhGV3j02iAd6k07OZ07SDd
         TYXYaoGfUup6btuzlNHtEtZqR+i/AtZuDVhps8aK5NhyjnJBTu6BcZCEEVcCU8PT1gr7
         05JF94IRCYm8WsKWkT+ntD7HEqblUoc16263cd5OuQTqHwIIl4hCsN0nRpVU5XJyxouJ
         aQp/UXRhzrvpMiCOGhqrY3fZYygl6VN1d9OwL6NzKwsMt2snIuxH3scxlKc0bMaptg7K
         85Dg==
X-Gm-Message-State: AOAM531QCu0CbEvqeW5niVlbR3kL+akeNqMI/e9QFgITAlrDWNx5rZ6Y
        NRlKjlqZk1UPJ9XUlNlVvUM=
X-Google-Smtp-Source: ABdhPJwyF1heqY48MuLB1Enrle7ejk3o0VhV8EX0p3PHRfErA/9TTufA/ansD9p1F0OwcwRLHCyI6w==
X-Received: by 2002:a63:485:: with SMTP id 127mr1401720pge.29.1606174513156;
        Mon, 23 Nov 2020 15:35:13 -0800 (PST)
Received: from localhost (61-68-227-232.tpgi.com.au. [61.68.227.232])
        by smtp.gmail.com with ESMTPSA id e8sm12853179pfj.157.2020.11.23.15.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 15:35:11 -0800 (PST)
Date:   Tue, 24 Nov 2020 10:35:08 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
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
        "Paul E . McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH -tip 13/32] sched: Trivial forced-newidle balancer
Message-ID: <20201123233508.GC8893@balbir-desktop>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-14-joel@joelfernandes.org>
 <20201123043836.GG110669@balbir-desktop>
 <1de89fd3-fb5f-5aaa-8ea6-7a12d3307fa4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1de89fd3-fb5f-5aaa-8ea6-7a12d3307fa4@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 11:07:27PM +0800, Li, Aubrey wrote:
> On 2020/11/23 12:38, Balbir Singh wrote:
> > On Tue, Nov 17, 2020 at 06:19:43PM -0500, Joel Fernandes (Google) wrote:
> >> From: Peter Zijlstra <peterz@infradead.org>
> >>
> >> When a sibling is forced-idle to match the core-cookie; search for
> >> matching tasks to fill the core.
> >>
> >> rcu_read_unlock() can incur an infrequent deadlock in
> >> sched_core_balance(). Fix this by using the RCU-sched flavor instead.
> >>
> > ...
> >> +
> >> +		if (p->core_occupation > dst->idle->core_occupation)
> >> +			goto next;
> >> +
> > 
> > I am unable to understand this check, a comment or clarification in the
> > changelog will help. I presume we are looking at either one or two cpus
> > to define the core_occupation and we expect to match it against the
> > destination CPU.
> 
> IIUC, this check prevents a task from keeping jumping among the cores forever.
> 
> For example, on a SMT2 platform:
> - core0 runs taskA and taskB, core_occupation is 2
> - core1 runs taskC, core_occupation is 1
> 
> Without this check, taskB could ping-pong between core0 and core1 by core load
> balance.

But the comparison is p->core_occuption (as in tasks core occuptation,
not sure what that means, can a task have a core_occupation of > 1?)

Balbir Singh.
