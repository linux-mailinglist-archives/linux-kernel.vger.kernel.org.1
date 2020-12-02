Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940D82CB4EA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 07:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgLBGSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 01:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgLBGSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 01:18:53 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A773BC0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 22:18:12 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id n132so333346qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 22:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=caKzWOB4UBzcA6CKNvNm8KcbJgri/lMEEKGcvT6J+cU=;
        b=NZDxE/zJXnE59tyT2130Bk4awx3THHf4DR4Qmk1ZlVOKWiKxmX57gm2jSjy2Y5MQdg
         sdnR2DVhVEDWQap83DvkYK38iONX99gnd0E8F2gL74LJYt/8tlO260UFzqSv9Ku0ai6Z
         Q7BKMG5jRvRW7OHiWHaKgVx4DTXNrq7DXwu3M+xY1LP29mXgC1o4rWlq32DROZwDbb63
         xFjvMPL4CT0SGEchxJgLes3TbnB3VCfPhvRF5JiE9MqTFTSuxIvrFTmtjWlD1l+pBiKJ
         0nPOBEg+kSu9D6mpobJCggAgobbjB71QUPDyGcHEfY+4FSDDJfwGK0SvPg7kmH4rI4My
         4agQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=caKzWOB4UBzcA6CKNvNm8KcbJgri/lMEEKGcvT6J+cU=;
        b=Li3ln9ZoD8f6zRTTZdFwXDH3GWC8G6yC6TI5QJWvnnxcyVNhTKTuGyiAE0AIRD2vq+
         7WgoGUWbG52hXcU0kGLMy7GcB3btF7WAM/1IDLYa5PCxmKvM5aQ0wWnD4spWeMLVXIpI
         6Xsmfzs5Lj5wJIW2jsht8gSEOGoqNThCCJ5Kn+KUR5CaLNftjnAXL1AfUixTMeYS7SwQ
         83mA4y5cTN3cB0dUYCHOpWMDKYLD9CmRxkBWpBsT0tiYxuTdoBzr8GrjeVpuY9uVuqrz
         Im85yh0WBkvH5fLgPl2mUpc4yUToPrhTQ8EzcXdd2Qlj3nizlI3jO12AWBGEHM0apqko
         u9Tw==
X-Gm-Message-State: AOAM532/t5mQV7xNdmTJYfxO+G/z/sVFiMzP1zE5mGovrshiJs+7VZz3
        M8sgYFMzVtYk4qU1eX0s+rwg7oTRo/IYABG9Yhosuw==
X-Google-Smtp-Source: ABdhPJxYZQLspSIvACU/+UGFsmPQF/SpFG9Rb3dzZ7aKLDiT9pqE7OTtUuA7+/p2Xqj4LWopwsCAwMw7wal2LK0yq0Q=
X-Received: by 2002:a37:a97:: with SMTP id 145mr1039672qkk.465.1606889891370;
 Tue, 01 Dec 2020 22:18:11 -0800 (PST)
MIME-Version: 1.0
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-27-joel@joelfernandes.org> <20201125134237.GZ2414@hirez.programming.kicks-ass.net>
In-Reply-To: <20201125134237.GZ2414@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 1 Dec 2020 22:18:00 -0800
Message-ID: <CABk29Nv7+nD1oU9iBhAFAuFoiPM5i7eCOtuG7vuQVcE8+Va=nw@mail.gmail.com>
Subject: Re: [PATCH -tip 26/32] sched: Add a second-level tag for nested
 CGroup usecase
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Peter,

On Wed, Nov 25, 2020 at 5:43 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Why can't the above work by setting 'tag' (that's a terrible name, why
> does that still live) in CDE? Have the most specific tag live. Same with
> that thread stuff.

The motivation is to allow an unprivileged user the ability to
configure the trust hierarchy in a way that otherwise wouldn't be
possible for a given cgroup hierarchy.  For example given a cookie'd
hierarchy such as:

      A
   /  |  |   \
B  C  D  E

the user might only want subsets of {B, C, D, E} to share.  For
instance, the user might only want {B,C} and {D, E} to share.  One way
to solve this would be to allow the user to write the group cookie
directly.  However, this interface would need to be restricted to
privileged users, since otherwise the cookie could be configured to
share with any arbitrary cgroup.  The purpose of the 'color' field is
to expose a portion of the cookie that can be modified by a
non-privileged user in order to achieve this sharing goal.

If this doesn't seem like a useful case, I'm happy to drop this patch
from the series to unblock it.

> All this API stuff here is a complete and utter trainwreck. Please just
> delete the patches and start over. Hint: if you use stop_machine(),
> you're doing it wrong.

Yes, agree on stop_machine(); we'll pull that out of the underlying
interface patch.

Thanks,
Josh
