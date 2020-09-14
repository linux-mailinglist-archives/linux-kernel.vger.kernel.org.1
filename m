Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6304526943F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgINR4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:56:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgINR4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 13:56:10 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D50720757;
        Mon, 14 Sep 2020 17:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600106169;
        bh=Z/6+2FbuT+UpF3bfCcpG4mMBS5EfKC9wHW891sxUTIw=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=wYoScC2uI3LVDxlg/5Zp81dYtExAdor84VQ2DRtuf/R1rEDU+aO1vHuHMLZfCaFMp
         1l+A7p6ODo8Vr29ENXZPqUVKECg7tNWpXQBN4pMgKDFDLsVfme8VFwcfoC41leE1/u
         PScswbsFA39Dr4XTk3DpKQ/QLcm0inNIE8VULEEQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 581D03522BA0; Mon, 14 Sep 2020 10:56:09 -0700 (PDT)
Date:   Mon, 14 Sep 2020 10:56:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, grandmaster@al2klimov.de,
        kernel-team@fb.com
Subject: [GIT PULL memory-model] LKMM commits for v5.10
Message-ID: <20200914175609.GA14435@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Ingo!

This pull request contains Linux-Kernel Memory-Model commits for v5.10.
These have been subjected to LKML review:

	https://lore.kernel.org/lkml/20200831182012.GA1965@paulmck-ThinkPad-P72

All of these have also been subjected to the kbuild test robot and
-next testing.  The following changes since v5.9-rc1 are available in
the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git lkmm

for you to fetch changes up to 0ce0c78eff7d22c8a261de6c4305a5abb638c200:

  tools/memory-model: Expand the cheatsheet.txt notion of relaxed (2020-09-04 11:58:15 -0700)

----------------------------------------------------------------
Alexander A. Klimov (1):
      Replace HTTP links with HTTPS ones: LKMM

Paul E. McKenney (4):
      tools/memory-model: Update recipes.txt prime_numbers.c path
      tools/memory-model: Improve litmus-test documentation
      tools/memory-model: Add a simple entry point document
      tools/memory-model: Expand the cheatsheet.txt notion of relaxed

 tools/memory-model/Documentation/cheatsheet.txt   |   33 +-
 tools/memory-model/Documentation/litmus-tests.txt | 1074 +++++++++++++++++++++
 tools/memory-model/Documentation/recipes.txt      |    4 +-
 tools/memory-model/Documentation/references.txt   |    2 +-
 tools/memory-model/Documentation/simple.txt       |  271 ++++++
 tools/memory-model/README                         |  160 +--
 6 files changed, 1410 insertions(+), 134 deletions(-)
 create mode 100644 tools/memory-model/Documentation/litmus-tests.txt
 create mode 100644 tools/memory-model/Documentation/simple.txt
