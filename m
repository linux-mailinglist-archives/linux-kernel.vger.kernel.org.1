Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA1D2B9E95
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 00:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgKSXkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 18:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgKSXkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 18:40:43 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56E4C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 15:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=nbuMCLcHNoPm8FVITFvDqVnVa58wCfKUh959Z9CMoqc=; b=w8mDAJFf3fHHmZox3LAtlQZD18
        vUwQsk9d00Of2HSJyZ+oGKfkU8Xtm9mQWJQx40wJrev42F8FGt25xjrC0LK2TzwkgmC369K6vsY3y
        CCGSLGFpC198xVGVgghRzHQOplaArN47zugI1amyaCwP6aOmLZ0crIpopg8QvsYPJ3cuHUeujCXKX
        CLdkKgBIAROnPL1ARH8n90t/hgohPkiB2vsWK4dy2OUu1ShkOb7kZh2QP8TWnA0ETfEOwbkiFwq+Z
        S65SaDc913UtCzJbBC6PFT3mKA7aoS9J7gJbNjrp/E39Mlk9M5bJLa/+sI5mVWyBp9Yah48pDAIP4
        lzFa7Mog==;
Received: from [2601:1c0:6280:3f0::bcc4]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kftWU-00079l-7W; Thu, 19 Nov 2020 23:39:30 +0000
Subject: Re: [PATCH -tip 31/32] sched: Add a coresched command line option
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
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-32-joel@joelfernandes.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2080fa5d-0a64-b006-d746-eb6de42aed8f@infradead.org>
Date:   Thu, 19 Nov 2020 15:39:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201117232003.3580179-32-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On 11/17/20 3:20 PM, Joel Fernandes (Google) wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b185c6ed4aba..9cd2cf7c18d4 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -698,6 +698,20 @@
>  			/proc/<pid>/coredump_filter.
>  			See also Documentation/filesystems/proc.rst.
>  
> +	coresched=	[SCHED_CORE] This feature allows the Linux scheduler

Unless I missed it somewhere else, this "SCHED_CORE" string should be
added to Documentation/admin-guide/kernel-parameters.rst, where there is
a list of "qualifiers" for kernel parameters.

(It looks like you are using it as the name of a Kconfig option, which
makes some sense, but that's not how it's [currently] done. :)


> +			to force hyperthread siblings of a CPU to only execute tasks
> +			concurrently on all hyperthreads that are running within the
> +			same core scheduling group.
> +			Possible values are:
> +			'on' - Enable scheduler capability to core schedule.
> +			By default, no tasks will be core scheduled, but the coresched
> +			interface can be used to form groups of tasks that are forced
> +			to share a core.
> +			'off' - Disable scheduler capability to core schedule.
> +			'secure' - Like 'on' but only enable on systems affected by
> +			MDS or L1TF vulnerabilities. 'off' otherwise.
> +			Default: 'secure'.
> +
>  	coresight_cpu_debug.enable
>  			[ARM,ARM64]
>  			Format: <bool>

thanks.
-- 
~Randy

