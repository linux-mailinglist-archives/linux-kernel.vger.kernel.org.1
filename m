Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D99E2C1974
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 00:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgKWXb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 18:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgKWXb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 18:31:57 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93737C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 15:31:55 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id w16so3356378pga.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 15:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zPVEQpM8bFSsJOH8Ws5CLthrlEFdEadV5XDLAsn1FBs=;
        b=A6C3Btj+MzLpo7bsu8E2DBZ3N/ziVH6qxLLNQui9EwgkzPlqzEjadsfc9wzTpIm4ND
         zT8aIG6xp3FKkkV+jjMM919DHE9OUtVKsv3UXQCCWk4Yv04ITgtZ9HChJwIkF1E42OAt
         miIGSys6VZT1+lE/3uvIWrOgKVq1xlG7tlhFj/3TROVXhRcXVoYv9BVy+I6uW7ObjnZ7
         8jEHP1TWMOKQQQNDn4HLgOnf4NR0aVp5bN28wAeTKcOgShwf91Ndr8RaOqGcizzM1fUl
         KSK18ukTC9pU7zzZWP6EHb/hkSODdbLk5+xSPEkkkUKTTndYM+Ml7riU+khh2wZWWtoI
         P7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zPVEQpM8bFSsJOH8Ws5CLthrlEFdEadV5XDLAsn1FBs=;
        b=aZg4LnZst8n7Hy9PDHvg6BtM/Am97+nbYpQfPyYTbDC87V9hJR5T7LKnl9m2b1VXET
         Eh3Peo6U8BhQqj9eE7Q5f8SY0pxZ1KbQC9bWuUvQZVJhJJbjerjUDYm3mAChK5Y6rn/D
         nNs9UqFpyrcVWj7f2JZ2f9SUU3sXL07oHJl0dUaIV4n/YdJskWk9S7JkZVWVYuqXzVwS
         1ZkunGDE1P4r3ns65+n4lmVO7I/8IpC3nZgex9YvhHTLx6F+nRl/iONk6WrOh+5D+7w9
         faHO3t9UHTG+RD6KIF0V1dFBL9zCNbEqwZ6eqoAqComjODzDahw0RidrW8KbJpMMuvKy
         eThw==
X-Gm-Message-State: AOAM5305DrOE2lyIHO0QqyNm8OBCUMfYMVXxdCIDZ4e8P2bsY8ygSxKd
        iwK625VdhKpEj2BcAOdqvVw=
X-Google-Smtp-Source: ABdhPJwylENNKC/wLBnX10wA+7ej4C6FPLbv4H7P4is9Z/eh5xdkpcGcg5glvJRHhoB0fwW5GqHDZw==
X-Received: by 2002:a17:90a:6a0e:: with SMTP id t14mr1407563pjj.95.1606174314995;
        Mon, 23 Nov 2020 15:31:54 -0800 (PST)
Received: from localhost (61-68-227-232.tpgi.com.au. [61.68.227.232])
        by smtp.gmail.com with ESMTPSA id i3sm463722pjd.33.2020.11.23.15.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 15:31:52 -0800 (PST)
Date:   Tue, 24 Nov 2020 10:31:49 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Vineeth Pillai <viremana@linux.microsoft.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
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
Subject: Re: [PATCH -tip 09/32] sched/fair: Snapshot the min_vruntime of CPUs
 on force idle
Message-ID: <20201123233149.GB8893@balbir-desktop>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-10-joel@joelfernandes.org>
 <20201122114442.GD110669@balbir-desktop>
 <2cb42831-5074-e0a9-9e2a-f2a880504026@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cb42831-5074-e0a9-9e2a-f2a880504026@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 07:31:31AM -0500, Vineeth Pillai wrote:
> Hi Balbir,
> 
> On 11/22/20 6:44 AM, Balbir Singh wrote:
> > 
> > This seems cumbersome, is there no way to track the min_vruntime via
> > rq->core->min_vruntime?
> Do you mean to have a core wide min_vruntime? We had a
> similar approach from v3 to v7 and it had major issues which
> broke the assumptions of cfs. There were some lengthy
> discussions and Peter explained in-depth about the issues:
> 
> https://lwn.net/ml/linux-kernel/20200506143506.GH5298@hirez.programming.kicks-ass.net/
> https://lwn.net/ml/linux-kernel/20200515103844.GG2978@hirez.programming.kicks-ass.net/
>

One of the equations in the link is

">From which immediately follows that:

          T_k + T_l
  S_k+l = ---------                                       (13)
          W_k + W_l

On which we can define a combined lag:

  lag_k+l(i) := S_k+l - s_i                               (14)

And that gives us the tools to compare tasks across a combined runqueue.
"

S_k+l reads like rq->core->vruntime, but it sounds like the equivalent
of rq->core->vruntime is updated when we enter forced idle as opposed to
all the time.

Balbir
