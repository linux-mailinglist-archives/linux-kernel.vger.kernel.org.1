Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841212933B0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 05:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391199AbgJTDmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 23:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391172AbgJTDmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 23:42:04 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF942C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 20:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=7Kkfr9DELie+hza5hnjVEJ8RrhQuKsRDtDHENuyGRTg=; b=BVUKpXXDDIxma3oBhedB12GUPL
        jPFLKu9uecc1tHQ0aeUnnFbXvTPO6GpNEtHX3Ub2bBG39Qm1+j1md6Y44ficsp/GThVXawIay8rZf
        Xl+wf0aBkR0xtlb23VvK6xrpHfOBe72cwmbN6v3gCmJduX6aTm4C6SonFIF0cvzzVcM4opv6dnAfu
        mGs56jKso0xBvxeCjwlaAKTT+j3LAAMCowzvovi1BLNxMUwrIq4qwVMCVFQXPYSlFdolHsR2VVkPp
        PDnIUhdZkcRIcsMmJ9ov38UrvbCIeiNJuAE5YT+kpAt9Vzynxg4l0T5oGivPdjbIC4Lb/RbrOmW5g
        XrC2Z4Hw==;
Received: from [2601:1c0:6280:3f0::9850] (helo=dragon.site)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kUiWT-0002Mp-9t; Tue, 20 Oct 2020 03:41:17 +0000
Subject: Re: [PATCH v8 -tip 13/26] kernel/entry: Add support for core-wide
 protection of kernel-mode
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
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
        chris.hyser@oracle.com, Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-14-joel@joelfernandes.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <13fac0b7-37cb-7313-efb6-ebe166121f8f@infradead.org>
Date:   Mon, 19 Oct 2020 20:41:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201020014336.2076526-14-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/20 6:43 PM, Joel Fernandes (Google) wrote:
> 
> ---
>   .../admin-guide/kernel-parameters.txt         |   7 +
>   include/linux/entry-common.h                  |   2 +-
>   include/linux/sched.h                         |  12 +
>   kernel/entry/common.c                         |  25 +-
>   kernel/sched/core.c                           | 229 ++++++++++++++++++
>   kernel/sched/sched.h                          |   3 +
>   6 files changed, 275 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 3236427e2215..48567110f709 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4678,6 +4678,13 @@
>   
>   	sbni=		[NET] Granch SBNI12 leased line adapter
>   
> +	sched_core_protect_kernel=

Needs a list of possible values after '=', along with telling us
what the default value/setting is.


> +			[SCHED_CORE] Pause SMT siblings of a core running in
> +			user mode, if at least one of the siblings of the core
> +			is running in kernel mode. This is to guarantee that
> +			kernel data is not leaked to tasks which are not trusted
> +			by the kernel.
> +


thanks.
