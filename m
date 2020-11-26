Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A172C4BDD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 01:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgKZALf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 19:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgKZALe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 19:11:34 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A60C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 16:11:33 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id b23so221538pls.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 16:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z6NXjr3K+FY5mGPgYCXq03BqNGRxlaPVVCO3wjYDZzA=;
        b=DSKED7202ns44VkkMrtJuNHtTFpWzX9NPKQXpgcREncWXADa3UQ4ZhvlKajieP1X5G
         M/RjJsDCUVHc8/sOM52caPtZfYf4XdfJcDGrbKDcFxCvOmF6e5SBtt7KYO4TVUGqQf3k
         0J0X4nztFWRYIiZvPh1DIiEIov8sABpJS5GWUFYc1iKOX4+X976CJraoj4dubanggzEU
         g6dXddhMV/T4EWlRdFRYJ31Ry87XSf9q7EbDeq6u9QROy3PZmb6A2BfW4PQsqhx0eHu+
         buFDGfatUvwrv1NYbWOTqZRLKG5nc5ygOANGJn/EgtsX0tjPxUnOPQ7DN0O/5cgcaEiJ
         wpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z6NXjr3K+FY5mGPgYCXq03BqNGRxlaPVVCO3wjYDZzA=;
        b=h6haoJB1lNKiPaCNdU3ZhNaOVy2fC24sYPYsGIRmUn0WAQs/Cuh0b1ymPwd5uN8p1r
         4zH6tYdtrhyjn9JZ3xj12Lmi1iKTtQPvwsp8cTYVLBHtDexka4E7N26LMuG6p+2Pxtew
         zxr9JV4ceDMWEGfZWT9j/Ub+NKu1oHsVyb4hmE8N+aZnbBZXbl7Zs6DhyisTZW/jWEzs
         DjIolet1uliVFtQaVQni3G3oMXwaSXubXV+tNjrCACPvgzeWqXNakk/dmxmSdLKy8Lak
         bR+fp55bU+Qh2s2f3DKsXYXIe7uvG2OW6PU8suEZQ/xv7crI/YIQXMF05+aEEkKdwrOS
         Oyww==
X-Gm-Message-State: AOAM5326wGv0NQjpIsc+qz5tZAikMEDjT9f8xhwQaTY5gEzz8oVWt72B
        yFV4wcsv/HCGXecP2/Wx2pc=
X-Google-Smtp-Source: ABdhPJwGIk+YsO6QDC8fYX6d7EsNKGwoirqf8Jldmgubv3j6fqiMblxttbm1th7E27KN0mqHnrfzXA==
X-Received: by 2002:a17:902:9891:b029:d8:fdf6:7c04 with SMTP id s17-20020a1709029891b02900d8fdf67c04mr351762plp.54.1606349492512;
        Wed, 25 Nov 2020 16:11:32 -0800 (PST)
Received: from localhost (61-68-227-232.tpgi.com.au. [61.68.227.232])
        by smtp.gmail.com with ESMTPSA id g85sm2868683pfb.4.2020.11.25.16.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 16:11:31 -0800 (PST)
Date:   Thu, 26 Nov 2020 11:11:28 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
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
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH -tip 31/32] sched: Add a coresched command line option
Message-ID: <20201126001128.GF163610@balbir-desktop>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-32-joel@joelfernandes.org>
 <20201125134537.GA2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125134537.GA2414@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 02:45:37PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 17, 2020 at 06:20:01PM -0500, Joel Fernandes (Google) wrote:
> > Some hardware such as certain AMD variants don't have cross-HT MDS/L1TF
> > issues. Detect this and don't enable core scheduling as it can
> > needlessly slow those device down.
> > 
> > However, some users may want core scheduling even if the hardware is
> > secure. To support them, add a coresched= option which defaults to
> > 'secure' and can be overridden to 'on' if the user wants to enable
> > coresched even if the HW is not vulnerable. 'off' would disable
> > core scheduling in any case.
> 
> This is all sorts of wrong, and the reason is because you hard-coded
> that stupid policy.
> 
> Core scheduling should always be available on SMT (provided you did that
> CONFIG_ thing). Even on AMD systems RT tasks might want to claim the
> core exclusively.

Agreed, specifically if we need to have special cgroup tag/association to
enable it.

Balbir Singh.
