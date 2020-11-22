Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331172BC571
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 12:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgKVLot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 06:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbgKVLos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 06:44:48 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F8BC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 03:44:48 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id t37so11500838pga.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 03:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4XdkuR1JHFqSFQIRQy3v8og91BQ7xzazW+qD0CqM6L4=;
        b=PaDQNV49fzHSyPfcqyjr2Bn9p112tgCsAaGU671InWpP7Jb2Wl5s+2EfJMtmbfdPFc
         I1Sun7uW6mR87hh7UUsMPYqDEcQ2uv+ta4iHNYvjwXn2MgFpuINAOHI4MeLV/WqVZ0AE
         ogsrk2f6bzG2M67MPbe7WHXfSaniddmBzVPlQlFZcdFn5iI2TOds8voK3g6lpGAfqERQ
         b3UrsdfaO7YGPqZ5NQtbpYRY/jNaNL/f//FVNegzccsh7pNVVLms9U3Uq6BShWaJSk08
         mnp5pZ6fvvreBaWHPzPzLIoWcoE5xlK7E4BTCd32JfVmvdvBOLmCqSdjkPQYOLFiw296
         PT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4XdkuR1JHFqSFQIRQy3v8og91BQ7xzazW+qD0CqM6L4=;
        b=G+zS9tgPndQPQWjFSjYdEsBmIFG7qhsk+zrjaKkwby0wuTOUZDE48nX93t3DPea2Hw
         HBFyA45Syvs1y/NhAkkmLVDj7p4Y35mEt5qYj1nC65mQckW9zpUKwQrhHmjjXewJfAqF
         LggN/GW5YZCvpi7AS9Pt9U8MLxT74RzlaD+PeQKf7QKzEgn1vrI/FsorwEseoULhodkk
         t+ZFs7nQqAIaUtMR5FxTLNN6E7sMwBKVE62UH5L27C9jnNaNzL+KgAXRLOlMXObL9+69
         2+PoMApO/kOW3MhrxxCmHRt/5teNCOG+Hr+oCe5+//cMOIQ6bsXtph7SYd7iFtlIsR0D
         yh2g==
X-Gm-Message-State: AOAM530VWnR8cWLgoDw4+BAx5KD+Vy5h26q2pQUp2V2rmnxnwynozM/P
        llI87f9tK2z/znCaR0h0328=
X-Google-Smtp-Source: ABdhPJygrbxbEJVF3H9xQ+uy13n3BiByaxBCJnXFiWShqcLggnB1/bILZb+GtxgQf+cPanaqL3AzLA==
X-Received: by 2002:a62:7f4c:0:b029:198:bfe:96f6 with SMTP id a73-20020a627f4c0000b02901980bfe96f6mr550796pfd.23.1606045487428;
        Sun, 22 Nov 2020 03:44:47 -0800 (PST)
Received: from localhost (61-68-227-232.tpgi.com.au. [61.68.227.232])
        by smtp.gmail.com with ESMTPSA id r66sm7633564pfc.114.2020.11.22.03.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 03:44:46 -0800 (PST)
Date:   Sun, 22 Nov 2020 22:44:42 +1100
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
Subject: Re: [PATCH -tip 09/32] sched/fair: Snapshot the min_vruntime of CPUs
 on force idle
Message-ID: <20201122114442.GD110669@balbir-desktop>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-10-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117232003.3580179-10-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 06:19:39PM -0500, Joel Fernandes (Google) wrote:
> During force-idle, we end up doing cross-cpu comparison of vruntimes
> during pick_next_task. If we simply compare (vruntime-min_vruntime)
> across CPUs, and if the CPUs only have 1 task each, we will always
> end up comparing 0 with 0 and pick just one of the tasks all the time.
> This starves the task that was not picked. To fix this, take a snapshot
> of the min_vruntime when entering force idle and use it for comparison.
> This min_vruntime snapshot will only be used for cross-CPU vruntime
> comparison, and nothing else.
> 
> This resolves several performance issues that were seen in ChromeOS
> audio usecase.
> 
> NOTE: Note, this patch will be improved in a later patch. It is just
>       kept here as the basis for the later patch and to make rebasing
>       easier. Further, it may make reverting the improvement easier in
>       case the improvement causes any regression.
>

This seems cumbersome, is there no way to track the min_vruntime via
rq->core->min_vruntime?

Balbir Singh.
