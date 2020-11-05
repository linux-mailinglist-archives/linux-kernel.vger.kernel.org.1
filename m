Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7FE2A82AE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 16:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731564AbgKEPwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 10:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730862AbgKEPwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 10:52:07 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC923C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 07:52:07 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id dj6so894217qvb.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 07:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K9PC5HZiLJNVyfvlScE/CP6VZlOUSE6C4WbZdtaM3eQ=;
        b=AreWm3OXjMQZ4P/O9iPHoIatJ6wQwEAZXRXXE6hXpbj8+1RRoGDd0eZd2SiElGcewp
         IZyBL71lNL43ipq179DWqAs9kpWXT4hTBbZzY02nBm/8n5tpUGyKlYpbex4jZUcrbMAO
         B3UA+DoMCQlO87cQtUsr562LZDYfL6RI7RJ0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K9PC5HZiLJNVyfvlScE/CP6VZlOUSE6C4WbZdtaM3eQ=;
        b=VglQLy9BzkuxRkS7ESwwnuEn8lRFIsBX8B9/id46i2WInDgIrbnajgfDyw3XasNpvt
         JEoz7ISJgYxJR8MbnIidoAloRtd/fQvUJZtU6X/qtoIUTmXOFRrByItevWiyvXsOHPQU
         pPV0NpKFqe+/gP0eupAySP052wfw6ez1rZkUdlpXsg+eI7CHMFoCjFZnMutFHCF/Lcid
         AL58jMUXNQREYw0jDOrEZYGkKgyN2j1T+bF4uczSjZAglN3alUoxCTOZtnWVh9g98YJx
         oyr7T8ai0ON2cBvaT0ASmzyp71CtVQVMl7BqOemXZEN/lhL1tJVWfSNMAS6mzOIPhu14
         Vc9A==
X-Gm-Message-State: AOAM530cGCXTV2nS/MNXDTr7toztA7JlJgDgLxLWymEICUPuuFsG4vs7
        e1XnohEPIsNaLcEuMipsMozxxA==
X-Google-Smtp-Source: ABdhPJzV79AfjSt6ttyVRwF+lPKmHnQOcBG4OQLL1fOUk8oSxujBLOEri8/e0UF2x/vHwT6B3/igMA==
X-Received: by 2002:a05:6214:10c4:: with SMTP id r4mr2801058qvs.62.1604591526877;
        Thu, 05 Nov 2020 07:52:06 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id h82sm1227161qke.109.2020.11.05.07.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 07:52:06 -0800 (PST)
Date:   Thu, 5 Nov 2020 10:52:05 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
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
        chris.hyser@oracle.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH v8 -tip 19/26] sched: Add a second-level tag for nested
 CGroup usecase
Message-ID: <20201105155205.GC2656962@google.com>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-20-joel@joelfernandes.org>
 <6c07e70d-52f2-69ff-e1fa-690cd2c97f3d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c07e70d-52f2-69ff-e1fa-690cd2c97f3d@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 02:23:02PM +0800, Li, Aubrey wrote:
> On 2020/10/20 9:43, Joel Fernandes (Google) wrote:
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
> > 
> > The 'color' is a 8-bit value allowing for upto 256 unique colors. IMHO, having
> > more than these many CGroups sounds like a scalability issue so this suffices.
> > We steal the lower 8-bits of the cookie to set the color.
> > 
> 
> So when color = 0, tasks in group A C D can run together on the HTs in same core,
> And if I set the color of taskC in group C = 1, then taskC has a different cookie
> from taskA and taskD, so in terms of taskA, what's the difference between taskC
> and [taskB or taskE]? The color breaks the relationship that C belongs to A.

C does belong to A in the sense, A cannot share with B, this implies C can
never share with B. Setting C's color does not change that fact. So coloring
is irrelevant in your question.

Sure, A cannot share with C either after coloring, but that's irrelevant and
not the point of doing the coloring.

thanks,

 - Joel

