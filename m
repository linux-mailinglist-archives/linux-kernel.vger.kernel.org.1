Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F7B1EBF79
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 17:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgFBP4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 11:56:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgFBP4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 11:56:31 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 338E420757;
        Tue,  2 Jun 2020 15:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591113391;
        bh=5FRbTyMEHqZ/disi9S3ygHA1ZLKo5uP3F/8Q4bd3NF4=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=hJItRM3K+8+Qs4lFmthfk57ZH2mtGUt75GCgNA8towZ9AT+0zKDuc8NY9KaKwAp8m
         /BlphWpDJw5iQHobKibwMKxVLP3raJRFaCm/zNdof8ocSaq0P0bTDAgvNRpMcVYUUQ
         0JS1EBftve1DNzPRoA1fZy9+C0myDABq6hoWVFZ8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1394C352283B; Tue,  2 Jun 2020 08:56:31 -0700 (PDT)
Date:   Tue, 2 Jun 2020 08:56:31 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     geert@linux-m68k.org, wangkefeng.wang@huawei.com,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL rcu/urgent] Fix printk format warning
Message-ID: <20200602155631.GA1638@paulmck-ThinkPad-P72>
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

This pull request contains a single commit that fixes a printk() format
error that appears on 32-bit architectures.  This could be argued to
be a minor bug, but it is a regression from this week's merge window,
and is in code that is never used in production.  Therefore the risk of
adding this late in process is quite low, more than worth it to fix the
irritation/confusion that the bug can cause.

And a big "Thank you!!!" to Geert (CCed) for bringing this to my
attention, as it has slipped through the cracks earlier.

The following changes since commit b1fcf9b83c4149c63d1e0c699e85f93cbe28e211:

  rcu: Provide __rcu_is_watching() (2020-05-19 15:51:21 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git urgent-for-mingo

for you to fetch changes up to b3e2d20973db3ec87a6dd2fee0c88d3c2e7c2f61:

  rcuperf: Fix printk format warning (2020-06-02 08:41:37 -0700)

----------------------------------------------------------------
Kefeng Wang (1):
      rcuperf: Fix printk format warning

 kernel/rcu/rcuperf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
