Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1728529DD11
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbgJ2Aeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732016AbgJ1WTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:19:43 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA76FC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:19:42 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id w5so552537qvn.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=CVcyGK+s/f9bZqsQmhebTHh1esD4cvYl9/Wlm95INbI=;
        b=uDMxC6fjJDnSIGJY8GrrxsB/K3C6Gj8Qi7whbl9sNEhTDJrO3ucXNigOr0XXqDeB+o
         F6LTG2aons5C9ubd+7UUQbK09QCBP6M6RuZdpDObIo4Jw9Xf/zaIkjWfvobtcsXUF6Sc
         dxIuIcyoSUKBmsoUXW1BbFvBQqE4ZZ+vAriGbhyYkiP6Uo/yyMDN+VvqT/nDtXpl6nXG
         QTfx7LBqt9z3vniGCjP9CAyI6VkDJlbFFREnHbb1/+qoX2j91XPF1XgYA9b3n6JOl31p
         S6vSTOhlbb9GiBxDOYdh7HLlHAYZaj4gYMl5soAy+Z28vXPruyOn3chx+23GfySuPnrZ
         CymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=CVcyGK+s/f9bZqsQmhebTHh1esD4cvYl9/Wlm95INbI=;
        b=KjaMKMDqPkgQ0PPjxWxH9/uRixPCtiE3mmMkO3WJoAq1P6tnyqaVHk2XYCNBuQ75KU
         pWSY+08we1dlmn7T1vefc2XxLRCd4dxqddZSEiYiuN/xOGi8lVRsZW4W++UPv2iqEDoP
         +shWgJQ9aEP6I9DsZUZsgNpkuotqGrA435qJ13gPgXSIIGtBLyD3OcAtOmIr1Iyx12iB
         aMgmNpiVqfqkHR4R2SuCp8MPu7pzTRUzvFNcPlbxRZ3dLNeJgysL18nVqOZZChDZ7ZxN
         F196PAyf2QNF4JxIN0XrnbsJq0lWN22N7s9rmwqw0hMrqMmP3sZlcV/Ra3G0QWqo1g0C
         S2Vg==
X-Gm-Message-State: AOAM53117RctI9N10odMOhGg6GhaPSSPC318bb/QJT57l7HI+6IUd7SZ
        +fcKwyHyk6/qQ8eksgkgXTjyRxJYjh4C0NyZ
X-Google-Smtp-Source: ABdhPJzDVC1/tpPq0nTJeuAK07yts2PNXubu4HAxTT0K/RcMsNSRDaXcqvR90gEBmU84pJEBWwSzjA==
X-Received: by 2002:aa7:9891:0:b029:161:690b:8dcf with SMTP id r17-20020aa798910000b0290161690b8dcfmr543316pfl.65.1603911523014;
        Wed, 28 Oct 2020 11:58:43 -0700 (PDT)
Received: from ManjaroKDE ([47.144.162.13])
        by smtp.gmail.com with ESMTPSA id 198sm362888pfy.41.2020.10.28.11.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 11:58:42 -0700 (PDT)
Message-ID: <6de890917af3a3aa6544f5d7c892455f71964c44.camel@gmail.com>
Subject: Re: [PATCH 0/8] Style and small fixes for core-scheduling
From:   John Wyatt <jbwyatt4@gmail.com>
To:     Phil Auld <pauld@redhat.com>
Cc:     "' Joel Fernandes (Google)" <joel@joelfernandes.org>,
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
        chris.hyser@oracle.com, Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen ' <tim.c.chen@intel.com>
Date:   Wed, 28 Oct 2020 11:58:34 -0700
In-Reply-To: <20201028143742.GB121779@lorien.usersys.redhat.com>
References: <20201028121917.635203-1-jbwyatt4@gmail.com>
         <20201028143742.GB121779@lorien.usersys.redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

> Hi John,
> 
> Welcome!

Thank you!

> 
> > Please feel free to advise on any corrections or improvements that
> > can be
> > made.
> 
> Thanks for these. I wonder, though, if it would not make more sense
> to post these changes as comments on the original as-yet-unmerged
> patches that you are fixing up? 

Patch 23/26 has a lot of spaces to tabs issues that are isolated to one
file (and one patch if I read it correctly). It would definitely make
sense for those to be a comment. Especially with patch 23 being a later
patch in the patch series. Most of those issues are not fixed by this
patch series I submitted.

For the rest, I am willing to do resubmit as comments if that would be
easier for the submitter.

Please let me know if that is how I should resubmit them.

Being a patch set does makes them easier to verify. Some warnings
against the individual patches, like braces surrounding a one line in a
if block, disappear with later patches as the code is added. For
clarity for the mailing list, I used the jfern tree with the
'coresched-v8-posted-to-list'.

https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/tag/?h=coresched-v8-posted-to-list

Thank you for your feedback.

-- 
Sincerely,
John Wyatt

