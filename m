Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09852EC259
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 18:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbhAFReF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 12:34:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:51830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbhAFReE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 12:34:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 340FB20657;
        Wed,  6 Jan 2021 17:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609954404;
        bh=wpb69anISqN5bCpmnVBTbLINbWbyjLgTDHtJMe5qmbU=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=MbHL6xaJIQqxIwPNuj6cGWJ1N+OBBYB2m5NCdAm/X4HlaOPFnNFyasyzy6aUA6KzN
         wKbX6tHDL/nBxg6q3OzmOTNp9FB/gXABKjeCwmuLL4xil6DEj7RGoNSoWjJ70xKFGR
         9mKvqzqOWCtUXHiKLZssSLyrfvKqsA0PGSPDrFEvrg23vn0E0+WNzGWzPMRfufsq86
         wM4ucB8YPFV5qD/S+u0E8VeLhvmUJOi6QWs9FmLISiulYHYJcUMU94Y26cAZvwgQ0P
         xC6RahqX+1PKJ0tvPtDu3+LX4BgRYoDfZVa8wM93wBAL4KdxvtQj5bknFhCo08vxxV
         gZw24E8KSYhuQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EDFF435225EC; Wed,  6 Jan 2021 09:33:23 -0800 (PST)
Date:   Wed, 6 Jan 2021 09:33:23 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com
Subject: [PATCH kcsan 0/2] KCSAN updates for v5.12
Message-ID: <20210106173323.GA23292@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides KCSAN updates involving random32.

1.	Rewrite kcsan_prandom_u32_max() without prandom_u32_state(),
	courtesy of Marco Elver.

2.	Re-enable KCSAN instrumentation, courtesy of Marco Elver.

						Thanx, Paul

------------------------------------------------------------------------

 kernel/kcsan/core.c |   26 +++++++++++++-------------
 lib/Makefile        |    3 ---
 2 files changed, 13 insertions(+), 16 deletions(-)
