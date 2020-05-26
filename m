Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53E3E19FE76
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 21:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgDFTvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 15:51:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbgDFTvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 15:51:47 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C311420672;
        Mon,  6 Apr 2020 19:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586202706;
        bh=zABosV0wyQc8OyPayFvXAjVTluR0BdI6Pr7zOxW6RJ8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=e+YhQu2VGrYHMiiWIQ80KAepZSTqdJYDncyA0CeniYzHDuwQr3zy5fkKYjfqKxFDM
         k5N4Ok8QXTfrEl/2yyDibfh6RsW23a5+y0OXb+arDdO3dgS1YbkL4g5mFEbR6AF5Hj
         LcHFjpq3Vl2zHKLzw4XzJubqVtYi3oozynW7DdFU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7DEAA3522B48; Mon,  6 Apr 2020 12:51:46 -0700 (PDT)
Date:   Mon, 6 Apr 2020 12:51:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH v3] kcsan: Add option for verbose reporting
Message-ID: <20200406195146.GI19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200406133543.GB19865@paulmck-ThinkPad-P72>
 <67156109-7D79-45B7-8C09-E98D25069928@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67156109-7D79-45B7-8C09-E98D25069928@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 09:45:44AM -0400, Qian Cai wrote:
> 
> 
> > On Apr 6, 2020, at 9:35 AM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > It goes back in in seven days, after -rc1 is released.  The fact that
> > it was there last week was a mistake on my part, and I did eventually
> > get my hand slapped for it.  ;-)
> > 
> > In the meantime, if it would help, I could group the KCSAN commits
> > on top of those in -tip to allow you to get them with one "git pull"
> > command.
> 
> Testing Linux-next for a week without that commit with KCSAN is a torture, so please do that if that is not much work. Otherwise, I could manually cherry-pick the commit myself after fixing all the offsets.

Just to confirm, you are interested in this -rcu commit, correct?

2402d0eae589 ("kcsan: Add option for verbose reporting")

This one and the following are directly on top of the KCSAN stack
that is in -tip and thus -next:

48b1fc1 kcsan: Add option to allow watcher interruptions
2402d0e kcsan: Add option for verbose reporting
44656d3 kcsan: Add current->state to implicitly atomic accesses
e7b3410 kcsan: Fix a typo in a comment
e7325b7 kcsan: Update Documentation/dev-tools/kcsan.rst
1443b8c kcsan: Update API documentation in kcsan-checks.h

These are on top of this -tip commit:

f5d2313bd3c5 ("kcsan, trace: Make KCSAN compatible with tracing")

You can pull them in via the kcsan-dev.2020.03.25a branch if you wish.

							Thanx, Paul
