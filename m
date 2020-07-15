Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F730221528
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 21:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgGOTcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 15:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgGOTcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 15:32:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1140DC061755;
        Wed, 15 Jul 2020 12:32:53 -0700 (PDT)
Date:   Wed, 15 Jul 2020 21:32:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594841571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h3ZtpJhPWfienzS6KSRdpCoqdEdUY7hLyESs4LYy87o=;
        b=opeGBUU0Km5h9n/E8ozxgvlvS0jssPdHjWnrj09AHc/Z0ECXSrpw0TgunqI0QQN3VoATZI
        G4Ks00Havy1oKYlpXi2Xul5pvYePd0NE2qVfBt3/+9Q90GD2Vca3VkHx3eiGk5JqK5VSZW
        f8m4o2rAT5Geg4I7fw368/FHBKjEno6vbf3SN9LrTJq9LBPuIcPEv8yJ543SwygAH0w0YW
        YtfWzmGIikSwam30e+yMTcvDLxvfLX3ruSWvNNx4RIpcVrDsz1ZOmOUK9mr/D11pTIl+Eb
        xLGTDt+Y03icyfWMx1brZngDAfgJEFuYrtzniWbiTPEwtEyWmx4R3L6WTWHlIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594841571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h3ZtpJhPWfienzS6KSRdpCoqdEdUY7hLyESs4LYy87o=;
        b=wdER8ko3tdcNTTXPV2aMj3jks22cJywWY/NJY3QdvIddTlTFyj3ptvbixkBGazMBo/fAwh
        Iqx8KQDkSbXv8hCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: Drop the lock before entering to page
 allocator
Message-ID: <20200715193250.axntj7jdt6bw52dr@linutronix.de>
References: <20200715183537.4010-1-urezki@gmail.com>
 <20200715185628.7b4k3o5efp4gnbla@linutronix.de>
 <20200715190243.GA26735@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200715190243.GA26735@pc636>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-15 21:02:43 [+0200], Uladzislau Rezki wrote:
> 
> <snip>
>     spin_lock();
>     __get_free_page(GFP_NOWAIT | __GFP_NOWARN);
>     spin_unlock();
> <snip>
> 
> Also, please note we do it for regular kernel.

ach right okay then.

> >
> > What happened to the part where I asked for a spinlock_t?
> > 
> What do you mean?

Please drop that raw_spinlock_t for the kfree_rcu() based locking and
use just a plain spinlock_t for the locking. Then you can keep the same
code flow for RT and !RT without any special cases and everything.

> --
> Vlad Rezki

Sebastian
