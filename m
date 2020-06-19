Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5BEE201D49
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 23:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgFSVtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 17:49:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728040AbgFSVtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 17:49:02 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4841221F2;
        Fri, 19 Jun 2020 21:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592603341;
        bh=Xzr/+QfY6CtZJxt8lOGxsNXu9vgdJe1YUoiDmUaj8tc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CDDEq/aBaRT7m7+Szx1dQselTg/zpsaKdPelKvdR87PO/tSF1nRFFRUjRNphv6BKq
         hF/9tUveikVRHShVvD4vKnOsZixuMKblvlVQ3IPMWgWfDYJb5UdfMDrUyM6vGmGW/a
         Y48133UPY+dibAPtUcB64wn/Hm0rxaY5HJh0pzVU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 74B913522B50; Fri, 19 Jun 2020 14:49:01 -0700 (PDT)
Date:   Fri, 19 Jun 2020 14:49:01 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     will@kernel.org, peterz@infradead.org, bp@alien8.de,
        tglx@linutronix.de, mingo@kernel.org, dvyukov@google.com,
        cai@lca.pw, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] kcsan: Re-add GCC support, and compiler flags
 improvements
Message-ID: <20200619214901.GA12084@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200618093118.247375-1-elver@google.com>
 <20200619032530.GI2723@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619032530.GI2723@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 08:25:30PM -0700, Paul E. McKenney wrote:
> On Thu, Jun 18, 2020 at 11:31:15AM +0200, Marco Elver wrote:
> > Re-add GCC as a supported compiler and clean up compiler flags.
> > 
> > To use KCSAN with GCC before GCC 11 is released, the following will get
> > a stable GCC 10 and cherry-pick the patches required for KCSAN support:
> > 
> > 	git clone git://gcc.gnu.org/git/gcc.git && cd gcc
> > 	git checkout -b gcc-10-for-kcsan releases/gcc-10.1.0
> > 	git cherry-pick \
> > 	    4089df8ef4a63126b0774c39b6638845244c20d2 \
> > 	    ab2789ec507a94f1a75a6534bca51c7b39037ce0 \
> > 	    06712fc68dc9843d9af7c7ac10047f49d305ad76
> > 	./configure --prefix <your-prefix> --enable-languages=c,c++
> > 	make -j$(nproc) && make install
> 
> Unless there are objections, I will pull this in Friday (tomorrow)
> afternoon, Pacific Time.

Hearing no objections, queued and pushd, thank you!

							Thanx, Paul

> > Marco Elver (3):
> >   kcsan: Re-add GCC as a supported compiler
> >   kcsan: Simplify compiler flags
> >   kcsan: Disable branch tracing in core runtime
> > 
> >  Documentation/dev-tools/kcsan.rst | 3 ++-
> >  kernel/kcsan/Makefile             | 4 ++--
> >  lib/Kconfig.kcsan                 | 3 ++-
> >  scripts/Makefile.kcsan            | 2 +-
> >  4 files changed, 7 insertions(+), 5 deletions(-)
> > 
> > -- 
> > 2.27.0.290.gba653c62da-goog
> > 
