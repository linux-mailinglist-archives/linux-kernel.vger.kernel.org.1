Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DE62CAD08
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404409AbgLAUJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392341AbgLAUJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:09:19 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B2FC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 12:08:39 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id q5so2584305qkc.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 12:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rzel40zSudejgIjeov/IizCnVcxFKEcYDOuHATdDn1Y=;
        b=m+O9c0ZJGiiiIEpOnhSk1nsDkDSieTY5j5gdo2mPNGjjLo153Eh3W0I3+7bwRghcsp
         N8FH1aj7QaMrVltKRMylAHSLyKz7SQb6zxgAj26zYH9Q6aJwkBsJz+eQpwKNzRdF+rKb
         gEP7OfIhjwYpB1iZ91PMyRsgqSxDfFiVExkqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rzel40zSudejgIjeov/IizCnVcxFKEcYDOuHATdDn1Y=;
        b=oJZQt28T3dFNXMDy3X/IrSQPQUYeaPTLOMlMRU2+4P1juP5JKqE4ElvxhGC/rWsqwS
         5XSI//JwvRuWrrAWhN+R7AkqLR7NJP+679v69Oq5B27eJ2PWtsIwgwbo1nwy668LZB/S
         uEmxLzBwhwIe3PZPUYhXsCx8QHopTisMJrAWLjK0M/2fXyg1EIDthJeRbOfn2uMebEqx
         bKZxujkblNXDRMOxVBu8V9bXriseX4CNE1aebGL2jEkq321Gx08c43y3DWoeMGjVJ5j/
         Cjh3/cJhHYFOhiE6k+kNygo9JcOEcDwnAivjkkiCjjTpDFwYJUEeUI/oy1Z618WXflq2
         bu3g==
X-Gm-Message-State: AOAM530Up/E1szJmJ9DiMzYM6kRe5Ihj2e1+HInnXmZZxspQjjqGIW/O
        kLwsx08qCDKkzTFhrjjccyXswg==
X-Google-Smtp-Source: ABdhPJwTlvwQSumsluEKI7+7HNXWFrfskYOhdBlDX/QMuYIrTy12av3yA4R+RRvju+UV9VElMYSIvg==
X-Received: by 2002:a05:620a:632:: with SMTP id 18mr4682664qkv.173.1606853318835;
        Tue, 01 Dec 2020 12:08:38 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id r89sm768703qtd.16.2020.12.01.12.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 12:08:38 -0800 (PST)
Date:   Tue, 1 Dec 2020 15:08:37 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
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
Message-ID: <20201201200837.GA226869@google.com>
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

Hi Peter,

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

There's 2 parts that Google's usecase has. The first part is set by a
privileged process, and the second part (color) is set within the container.
Maybe we can just put the "color" feature behind a CONFIG option for Google
to enable?

> All this API stuff here is a complete and utter trainwreck. Please just
> delete the patches and start over. Hint: if you use stop_machine(),
> you're doing it wrong.

Ok, the idea was to use stop_machine() as in your initial patch. It works
quite well in testing. However I agree with its horrible we ought to do
better (or at least try).

Maybe we can do a synchronize_rcu() after changing cookie, to ensure we are
no longer using the old cookie value in the scheduler.

> At best you now have the requirements sorted.

Yes.

thanks,

 - Joel

