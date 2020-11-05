Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A7E2A897B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 23:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732562AbgKEWDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 17:03:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:59716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731508AbgKEWDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 17:03:03 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5C2120728;
        Thu,  5 Nov 2020 22:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604613782;
        bh=c6ZFl+yjxyQ7uCAbVmiMq8un7xcLaCuXbGcgeQweXQs=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=CVX6R+tWKfeSXFg9r1QBBsqJzMnln5TB0Z1JHKlzEFUTBolBmU8eQEnpNAtBEIm/d
         7q3Qu38p1PhgV0bS/wlnT2XDd9anwbOjwEU3AoVlVYayAwQpfpo7G9L6hUXCcKmCZD
         9upR8GVwFm3tt4vvHuOl4hYgjnaNPjGSMliSZtiw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 64EF23522A76; Thu,  5 Nov 2020 14:03:02 -0800 (PST)
Date:   Thu, 5 Nov 2020 14:03:02 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com
Subject: [PATCH kcsan 0/3] KCSAN updates for 5.11
Message-ID: <20201105220302.GA15733@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides KCSAN updates:

1.	Ensure that selftest address is at least PAGE_SIZE.

2.	Never set up watchpoints on NULL pointers.

3.	Fix encoding masks and regain address bit.

						Thanx, Paul

------------------------------------------------------------------------

 encoding.h |   20 +++++++++++---------
 selftest.c |    3 +++
 2 files changed, 14 insertions(+), 9 deletions(-)
