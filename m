Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEA11CF916
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 17:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbgELPZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 11:25:07 -0400
Received: from netrider.rowland.org ([192.131.102.5]:34215 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726891AbgELPZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:25:06 -0400
Received: (qmail 2205 invoked by uid 500); 12 May 2020 11:25:05 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 May 2020 11:25:05 -0400
Date:   Tue, 12 May 2020 11:25:05 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Akira Yokosawa <akiyks@gmail.com>
cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        <linux-kernel@vger.kernel.org>, <vpillai@digitalocean.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 4/3] docs: litmus-tests: Clarify about the RCU
 pre-initialization test
In-Reply-To: <fd7e7c6f-fda1-7f2b-19f3-a09b73b10de8@gmail.com>
Message-ID: <Pine.LNX.4.44L0.2005121124290.26505-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020, Akira Yokosawa wrote:

> From 7bb979aacd8788d174df8a56e9803ba9e5b7a381 Mon Sep 17 00:00:00 2001
> From: Joel Fernandes (Google) <joel@joelfernandes.org>
> Date: Mon, 11 May 2020 22:06:46 -0400
> Subject: [PATCH 4/3] docs: litmus-tests: Clarify about the RCU pre-initialization test
> 
> Since this test returned to tools/memory-model/, make sure that it is
> at least referenced from Documentation/litmus-tests/'s README.
> 
> Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Co-developed-by: Akira Yokosawa <akiyks@gmail.com>
> [Alan: grammar nit]
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> ---
> I said in the earlier message:
> 
> > The explanation under tools/memory-model/litmus-tests/README also need the same
> > rewording.
> 
> , but obviously I was confused. It is good as is.
> 
> This is on top of my earlier patch series.
> 
> Joel, Alan, does this work with you?
> 
>         Thanks, Akira
> --
>  Documentation/litmus-tests/README | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
> index ac0b270b456c..b79e640214b9 100644
> --- a/Documentation/litmus-tests/README
> +++ b/Documentation/litmus-tests/README
> @@ -24,6 +24,10 @@ Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
>  RCU (/rcu directory)
>  --------------------
>  
> +MP+onceassign+derefonce.litmus (under tools/memory-model/litmus-tests/)
> +    Demonstrates the use of rcu_assign_pointer() and rcu_dereference() to
> +    ensure that an RCU reader will not see pre-initialization garbage.
> +
>  RCU+sync+read.litmus
>  RCU+sync+free.litmus
>      Both the above litmus tests demonstrate the RCU grace period guarantee

That's fine with me.

Alan

