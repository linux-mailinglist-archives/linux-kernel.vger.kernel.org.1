Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D02429E1F2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbgJ2CEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:04:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50142 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727123AbgJ1VjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603921159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zz/rYHzbdwS5oO9mTj6GBWZMaU6ccgIUfTjgF1V630k=;
        b=QNaFISWZCUU6gvSgFLIWBNY3TFv4rnJ88hUys6wK1v+TqGgcXTu88Me0TcSmG4iIhFusGu
        JnrFDoFRxC/jLKt9c39gCcvovvOZXR1bEIcYfg6IRZykOqpcobNjhDzwbGPTK7VitSoXZI
        FfpFhx62XoWnN1EAJ4xm8mguyRDLMFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-qr1HlNFmMMaZY2jM8T8Rxw-1; Wed, 28 Oct 2020 10:37:55 -0400
X-MC-Unique: qr1HlNFmMMaZY2jM8T8Rxw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0538B1009E35;
        Wed, 28 Oct 2020 14:37:50 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-112-47.phx2.redhat.com [10.3.112.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A2A560BF1;
        Wed, 28 Oct 2020 14:37:43 +0000 (UTC)
Date:   Wed, 28 Oct 2020 10:37:42 -0400
From:   Phil Auld <pauld@redhat.com>
To:     "John B. Wyatt IV" <jbwyatt4@gmail.com>
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
Subject: Re: [PATCH 0/8] Style and small fixes for core-scheduling
Message-ID: <20201028143742.GB121779@lorien.usersys.redhat.com>
References: <20201028121917.635203-1-jbwyatt4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028121917.635203-1-jbwyatt4@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Wed, Oct 28, 2020 at 05:19:09AM -0700 John B. Wyatt IV wrote:
> Patchset of style and small fixes for the 8th iteration of the
> Core-Scheduling feature.
> 
> Style fixes include changing spaces to tabs, inserting new lines before
> declarations, removing unused braces, and spelling.
> 
> Two small fixes involving changing a main() to main(void) and removing an
> unused 'else'.
> 
> All issues were reported by checkpatch.
> 
> I am a new Linux kernel developer interning with the Outreachy project.
>

Welcome!

> Please feel free to advise on any corrections or improvements that can be
> made.

Thanks for these. I wonder, though, if it would not make more sense
to post these changes as comments on the original as-yet-unmerged
patches that you are fixing up? 


Cheers,
Phil

> 
> John B. Wyatt IV (8):
>   sched: Correct misspellings in core-scheduling.rst
>   sched: Fix bad function definition
>   sched: Fix some style issues in test_coresched.c
>   sched: Remove unused else
>   sched: Add newline after declaration
>   sched: Remove unneeded braces
>   sched: Replace spaces with tabs
>   sched: Add newlines after declarations
> 
>  Documentation/admin-guide/hw-vuln/core-scheduling.rst | 8 ++++----
>  arch/x86/include/asm/thread_info.h                    | 4 ++--
>  kernel/sched/core.c                                   | 6 ++++--
>  kernel/sched/coretag.c                                | 3 ++-
>  tools/testing/selftests/sched/test_coresched.c        | 8 ++++----
>  5 files changed, 16 insertions(+), 13 deletions(-)
> 
> -- 
> 2.28.0
> 

-- 

