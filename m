Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F8C21F963
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 20:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgGNS1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 14:27:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbgGNS1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:27:32 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76A26227BF;
        Tue, 14 Jul 2020 18:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594751252;
        bh=u/ahli5bacfgvLQRLRo8d+/MPlcd1svqsLIQFen1ioY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=wKPY9Ly7FNpA2n5SLz0sefIlx9tmr1enyxhCec8qmDLuezXkMFGRP9ex6+FJg1XIK
         f5cGoVCDMH47KjkOYKoHPA/Z8K375kTZySrXotJJtfBtKzPL6L8v6MQK3QwLU4yilX
         YWq9hV2hsgzKNq2tHw4OkJTu3xI4+rbrVLEoA6Pc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 619B93522635; Tue, 14 Jul 2020 11:27:32 -0700 (PDT)
Date:   Tue, 14 Jul 2020 11:27:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, arnd@arndb.de, elver@google.com, ethp@qq.com,
        frederic@kernel.org, jbi.octave@gmail.com, joel@joelfernandes.org,
        lihaoliang@google.com, madhuparnabhowmik10@gmail.com,
        mchehab+huawei@kernel.org, peter.enderborg@sony.com,
        rdunlap@infradead.org, richard.weiyang@linux.alibaba.com,
        urezki@gmail.com, zou_wei@huawei.com, tglx@linutronix.de
Subject: Re: [GIT PULL tip/core/rcu] RCU commits for v5.9
Message-ID: <20200714182732.GU9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200714172701.GA31369@paulmck-ThinkPad-P72>
 <20200714181426.hhguqzrcqdubyvae@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714181426.hhguqzrcqdubyvae@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 08:14:26PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-07-14 10:27:01 [-0700], Paul E. McKenney wrote:
> > Joel Fernandes (Google) (5):
> >       rcu/tree: Skip entry into the page allocator for PREEMPT_RT
> 
> If it is too late to drop this then I am going send a revert okay?

I believe that Ulad and Joel are working on an update.

Now that you mention it Ulad and Joel, how is this coming along?

							Thanx, Paul
