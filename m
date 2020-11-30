Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4282C9241
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbgK3XLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730540AbgK3XLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:11:19 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CB2C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:10:39 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id l11so19282plt.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aYm3p0jj0sVkrKj/bgD7NF1z8jv/Uy3ub0YZDSBHR1k=;
        b=bhfuwapsRiIEuUZn44jGMBQy5mdjGqflyjT/VJspv8bM+eZJELH98LLWw35xfA3RzG
         9oIbCpG88nBDv1HTY3Mtd/Uzdlr2gulcs5NOhwWpLyvQIm3a88khs3A/5JSm+zkTAi+C
         H++CFP/tLOt2ycvlQ20uqeJB+0X4CV0m78LlTTjJfhzpqyfczntZc0KZ/rVBesbm7NZQ
         MgbCsoiq3UAh2hz6lOVT55EVWER5yUtSOu39Guelo5OkJ1o23sBBmP9TDN+EoQRcGYL2
         3+G0+KrbN56KVoBuYjmttnS9/Oj3bsSWDyCwnpy1O6BF8R0YBSn3597leSxEU6kTa0pu
         fCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aYm3p0jj0sVkrKj/bgD7NF1z8jv/Uy3ub0YZDSBHR1k=;
        b=lfJQy2haY2LQ8QpGLrrK1k6Uvyh5aANgiqxjAX0oSksjfvzjtglXPrTnLqj3u/fv7T
         FgJYjebPWHo+KaiKKskts4MoI85ShxVeOezKEYFkVzPMVHZ/0pJlE59A3i+ZsQQErmmu
         NH387G5TV5+7tfs9hRe/ziN1lXE3cr86zol5sVAuyXdvVQ7VI4jjqQ9Vblfrj+0B1Jf/
         d5rsp1Q+5RNHN0S7Wu2OTavB9hPEGF7QvIXpjXMEUz8HFXCD7GWai3ZR+mEyW5YEAXHD
         kPhdW+pIxRnNsRJ4fi1xeIMspc/QYHseAYMzcHB1vSjAgZ38uF9POrZxnvPss6oJLrQ/
         0q8A==
X-Gm-Message-State: AOAM532/4m4+ATXMJKUW7zxihC6SR6CnNuEYkxsUC+PGpbvYfXg2ZTvz
        qKfUIYHnNfzG/lacti8TMVc=
X-Google-Smtp-Source: ABdhPJwBPdpAIryvVStwofSzNkKPyurPV69Nf+Dj6qCm3AijHsFH+VF4PejkGmbtb/1KmtLtLAQVJQ==
X-Received: by 2002:a17:90b:b15:: with SMTP id bf21mr114253pjb.21.1606777838904;
        Mon, 30 Nov 2020 15:10:38 -0800 (PST)
Received: from localhost (61-68-227-232.tpgi.com.au. [61.68.227.232])
        by smtp.gmail.com with ESMTPSA id m9sm12438pfh.94.2020.11.30.15.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 15:10:37 -0800 (PST)
Date:   Tue, 1 Dec 2020 10:10:34 +1100
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
Subject: Re: [PATCH -tip 26/32] sched: Add a second-level tag for nested
 CGroup usecase
Message-ID: <20201130231034.GF473773@balbir-desktop>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-27-joel@joelfernandes.org>
 <20201125134237.GZ2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125134237.GZ2414@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 02:42:37PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 17, 2020 at 06:19:56PM -0500, Joel Fernandes (Google) wrote:
> > From: Josh Don <joshdon@google.com>
> > 
> > Google has a usecase where the first level tag to tag a CGroup is not
> > sufficient. So, a patch is carried for years where a second tag is added which
> > is writeable by unprivileged users.
> > 
> > Google uses DAC controls to make the 'tag' possible to set only by root while
> > the second-level 'color' can be changed by anyone. The actual names that
> > Google uses is different, but the concept is the same.
> > 
> > The hierarchy looks like:
> > 
> > Root group
> >    / \
> >   A   B    (These are created by the root daemon - borglet).
> >  / \   \
> > C   D   E  (These are created by AppEngine within the container).
> > 
> > The reason why Google has two parts is that AppEngine wants to allow a subset of
> > subcgroups within a parent tagged cgroup sharing execution. Think of these
> > subcgroups belong to the same customer or project. Because these subcgroups are
> > created by AppEngine, they are not tracked by borglet (the root daemon),
> > therefore borglet won't have a chance to set a color for them. That's where
> > 'color' file comes from. Color could be set by AppEngine, and once set, the
> > normal tasks within the subcgroup would not be able to overwrite it. This is
> > enforced by promoting the permission of the color file in cgroupfs.
> 
> Why can't the above work by setting 'tag' (that's a terrible name, why
> does that still live) in CDE? Have the most specific tag live. Same with
> that thread stuff.
> 
> All this API stuff here is a complete and utter trainwreck. Please just
> delete the patches and start over. Hint: if you use stop_machine(),
> you're doing it wrong.
> 
> At best you now have the requirements sorted.

+1, just remove this patch from the series so as to unblock the series.

Balbir Singh.
