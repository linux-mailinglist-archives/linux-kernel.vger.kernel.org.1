Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7612FF776
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 22:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbhAUVlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 16:41:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:39408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727369AbhAUVha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 16:37:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93770206BE;
        Thu, 21 Jan 2021 21:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611265009;
        bh=AMRMEOl7orgQrizigaReBPT5WU7MyTdhrtgNyIc7HH4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FuCjFFNNaPC3vY9JPrkDQW2lWTCkyCZxhqu+2NbmSHfNpHOR4KC4/OoQeYB1mTpnh
         LTm02xvezDOwLlaeYYpor5aBWWS+mkv1h3tt88RmI+mgzZrNK5CNV36nRcV0W4IOfm
         ceSaGRwvnooAgoRj6z5RQldkDElg1X8+ZCbitdcd4mRXUS0d0eCuWp2mKxU4udgbMW
         6Bv4vwkv5s80g5BdZaWIa/2WrwDWraA+IfmunqWsChEo6BhHG15y7BmWRDgGDuOJkB
         /nO8bw+Cr1pKav7xL4y3PGLgJjwHk1W/nDrvutZh6g1UIjZ7V5LdJs/p33s1gz5Bx8
         Rnt6QIrR0DxZQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4D3B535226D8; Thu, 21 Jan 2021 13:36:49 -0800 (PST)
Date:   Thu, 21 Jan 2021 13:36:49 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Mark Rutland <mark.rutland@arm.com>, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] tools/nolibc: fix build issues on aarch64 after
 unistd cleanup
Message-ID: <20210121213649.GU2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210121072031.23777-1-w@1wt.eu>
 <20210121111117.GA48431@C02TD0UTHF1T.local>
 <20210121141809.GC24174@1wt.eu>
 <20210121195432.GS2743@paulmck-ThinkPad-P72>
 <20210121201714.GA24484@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121201714.GA24484@1wt.eu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 09:17:14PM +0100, Willy Tarreau wrote:
> On Thu, Jan 21, 2021 at 11:54:32AM -0800, Paul E. McKenney wrote:
> > > > It would be great if this could be applied soon so that it's possible to
> > > > use the rcutorture scripts without applying local hacks.
> > > 
> > > Makes sense. I was wondering, should we mark them for stable ? I don't
> > > know if anyone relies on these tests to validate stable kernels in
> > > fact.
> > 
> > I added Fixes tags that should make this happen, and they are now visible
> > at -rcu branch "dev".  Could you please check them for me?
> 
> I've just rerun all previous tests from my history and all of them are
> OK. Please note however that I only did the manual build test, not through
> the whole kvm.sh script, but a diff shows that the involved files are byte
> for byte identical to those that Valentin and Mark tested, so for me that's
> OK as well.

Byte-for-byte identical works for me, thank you!

> By the way, thank you for having completed the commit messages, I hope you
> didn't spend too much time on this.

Not a problem!  I definitely had the easy end of this job.  ;-)

							Thanx, Paul
