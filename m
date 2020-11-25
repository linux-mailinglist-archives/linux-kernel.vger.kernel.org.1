Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11CF2C4159
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 14:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgKYNq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 08:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgKYNq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 08:46:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A77C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 05:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2wKI8RYv0bVfSPNfFQE9o0e5gpFpVXfZLwEElJH4yO0=; b=tOpKgRX3Vxp9G/ml5rHjQ5pniU
        q304QasuZq2zb2+PG4L3X3CdcQNXTuMY10iqXHweVl+FUFRUe58JN9CvlIvd0JpjOWyXiWD8axe85
        2pDO/Syn1kseWbz2EyBdvOcPP38npCidwSoaicG49XbFXp0++iSl5ScFvp2vhPOa1ruVW8B49nNv2
        jC4tZdCdPrPC5hSJheMQu4QWapOlW5DwY18npU0jukd6Aoegc2EGFrG1AQEKno66yxmthH1LUPfSc
        KU0ucBdqboha+4Qnj5taQ5F2MIO/LncW6HPXQN/RCBn+Wj7lCRamEx4FkXSmhop7bYgOFkodzLMGs
        YbBHCn1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khv74-00089Q-TE; Wed, 25 Nov 2020 13:45:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B5282300DAE;
        Wed, 25 Nov 2020 14:45:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9836A200DF1C9; Wed, 25 Nov 2020 14:45:37 +0100 (CET)
Date:   Wed, 25 Nov 2020 14:45:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
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
Subject: Re: [PATCH -tip 31/32] sched: Add a coresched command line option
Message-ID: <20201125134537.GA2414@hirez.programming.kicks-ass.net>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-32-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117232003.3580179-32-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 06:20:01PM -0500, Joel Fernandes (Google) wrote:
> Some hardware such as certain AMD variants don't have cross-HT MDS/L1TF
> issues. Detect this and don't enable core scheduling as it can
> needlessly slow those device down.
> 
> However, some users may want core scheduling even if the hardware is
> secure. To support them, add a coresched= option which defaults to
> 'secure' and can be overridden to 'on' if the user wants to enable
> coresched even if the HW is not vulnerable. 'off' would disable
> core scheduling in any case.

This is all sorts of wrong, and the reason is because you hard-coded
that stupid policy.

Core scheduling should always be available on SMT (provided you did that
CONFIG_ thing). Even on AMD systems RT tasks might want to claim the
core exclusively.
