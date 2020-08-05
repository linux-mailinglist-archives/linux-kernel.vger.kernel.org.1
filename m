Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9FB623D41B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 01:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgHEXIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 19:08:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgHEXIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 19:08:53 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20DCB2086A;
        Wed,  5 Aug 2020 23:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596668933;
        bh=AfgbVOY92Om6cAQN2okLShzei8UXh1G0FdHJs5uSP1c=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=jsj0bsXh6oWAI2T5hOUiH2fyjgHmhEm036VCrPHjyuC6yLPyaZ1NTDBbqxDXrXa+P
         anzRjXGxP1EYcX8CZz/Y5nWcBhb6d3c8SV57S9FmcJiKUrI5XzVGJt2QOkD8nKKxKO
         B7T8c2beSI/sQikZl0pgQs5uU/pNUP8zfW3Wd2os=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F1BC83522B4B; Wed,  5 Aug 2020 16:08:52 -0700 (PDT)
Date:   Wed, 5 Aug 2020 16:08:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kcc@google.com, dvyukov@google.com, elver@google.com
Cc:     linux-kernel@vger.kernel.org
Subject: Finally starting on short RCU grace periods, but...
Message-ID: <20200805230852.GA28727@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

If I remember correctly, one of you asked for a way to shorten RCU
grace periods so that KASAN would have a better chance of detecting bugs
such as pointers being leaked out of RCU read-side critical sections.
I am finally starting entering and testing code for this, but realized
that I had forgotten a couple of things:

1.	I don't remember exactly who asked, but I suspect that it was
	Kostya.  I am using his Reported-by as a placeholder for the
	moment, but please let me know if this should be adjusted.

2.	Although this work is necessary to detect situtions where
	call_rcu() is used to initiate a grace period, there already
	exists a way to make short grace periods that are initiated by
	synchronize_rcu(), namely, the rcupdate.rcu_expedited kernel
	boot parameter.  This will cause all calls to synchronize_rcu()
	to act like synchronize_rcu_expedited(), resulting in about 2-3
	orders of magnitude reduction in grace-period latency on small
	systems (say 16 CPUs).

In addition, I plan to make a few other adjustments that will
increase the probability of KASAN spotting a pointer leak even in the
rcupdate.rcu_expedited case.

But if you would like to start this sort of testing on current mainline,
rcupdate.rcu_expedited is your friend!

							Thanx, Paul
