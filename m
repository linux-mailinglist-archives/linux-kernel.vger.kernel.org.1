Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D04B295D40
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 13:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897126AbgJVLRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 07:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502527AbgJVLRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 07:17:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27999C0613CE;
        Thu, 22 Oct 2020 04:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LtnWOsuhrFn7+oVdVMoCVndSGLt50TxPAs4a8rGonYE=; b=dM9SNk4zcle/PDQ1qASd5oGeZD
        15OTWVsGJmAwDJbMWe3Ej6eMLj3ozlRrmd93px6u2Pf16reezDP0o7RNDLBS8s8TqfQoKipM1fRTu
        ffh0hX+0SCxzP9gyK6AIjY1VOkKICSYPTNV006ltNaaqX2/xwl/W2oLqbKE6Q0owHKAUJXWT3w4Gu
        sBkQuOW5J4AYILe2395k1EnRX+SLoGepwPACg24NVWITWhyG2l/2VoRSfI0j9wlgl3tmmQigEI4BD
        RpmtCqDULdVvhePJvaPp5ciZXBUBqbzxWrIs4J2u/D6G1e1o2gqdORCIxbnC7YEFqibZU5sBXn7zF
        T+Nk1Lbg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVYaa-0004im-SV; Thu, 22 Oct 2020 11:17:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 48B7F304D28;
        Thu, 22 Oct 2020 13:17:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 32D6A203D0810; Thu, 22 Oct 2020 13:17:00 +0200 (CEST)
Date:   Thu, 22 Oct 2020 13:17:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [sparc64] lockdep: Fix lockdep recursion - call trace
Message-ID: <20201022111700.GZ2651@hirez.programming.kicks-ass.net>
References: <CADxRZqwQ_nvbGrzDzOjzt=R5x6yvsU4AujhpxXYs8cHFwoCjmA@mail.gmail.com>
 <20201022110015.GJ2594@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022110015.GJ2594@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 01:00:16PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 22, 2020 at 12:21:55PM +0300, Anatoly Pugachev wrote:
> > Hello!
> > 
> > Bisected the following linux calltrace after v5.9 :
> > 
> > [    8.650198] systemd[1]: Started Journal Service.
> > [    9.028125] ------------[ cut here ]------------
> > [    9.028171] WARNING: CPU: 11 PID: 499 at
> > net/netfilter/nf_tables_api.c:622 nft_chain_parse_hook+0x7c/0x360
> > [nf_tables]
> > [    9.028185] Modules linked in: nf_tables nfnetlink sunrpc ip_tables
> > x_tables ipv6 crc_ccitt autofs4 ext4 crc16 mbcache jbd2 raid10 raid456
> > async_raid6_recov async_mem
> > cpy async_pq async_xor xor async_tx raid6_pq raid1 raid0 multipath
> > linear md_mod crc32c_sparc64
> > [    9.028243] CPU: 11 PID: 499 Comm: nft Tainted: G        W
> > 5.9.0-rc8-00209-gbaffd723e44d #111
> > [    9.028255] Call Trace:
> > [    9.028269] [<00000000004727e8>] __warn+0xa8/0x120
> > [    9.028278] [<0000000000472c20>] warn_slowpath_fmt+0x34/0x74
> > [    9.028291] [<00000000100c19fc>] nft_chain_parse_hook+0x7c/0x360 [nf_tables]
> 
> > commit 4d004099a668c41522242aa146a38cc4eb59cb1e
> 
> What's unexpected.. while I just queued a another fix for that commit:
> 
>   https://lkml.kernel.org/r/20201022103028.GC2611@hirez.programming.kicks-ass.net
> 
> I don't think that explains this WARN. Let me go prod at it.

This looks like lockdep_is_held() encounters an incremented recursion
count and returns 1, which in this case will trigger the WARN.

But that would mean we're leaking a recursion count somewhere... do you
have CONFIG_DEBUG_PREEMPT enabled?
