Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD68C28D72A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 01:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389175AbgJMXtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 19:49:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbgJMXtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 19:49:06 -0400
Subject: Re: [GIT PULL] Audit patches for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602632946;
        bh=iqwXsC+IW/4sXD73g5MBISbErELW9qDSMdUCT/nAmFc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GKO22gF8UcfAHlXLFICWlM2FdvKFOyibdYZrt38PB4gBWfvFIHi0ajIBF5UDeAJg8
         dkoZN0Y+I0ZKbnppJGdMRcQMdi+zk7XTAFbPZbj/a8l8hLgwL7zj0qWY/eF7UYH1kX
         gftKb0+da+I6XgicfbYslIcIBkw+5izKFuHbYht4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhTNqnzrtu1DHquVF7kK9v9tCAa8q=V3f9kUZi_nLTzfYg@mail.gmail.com>
References: <CAHC9VhTNqnzrtu1DHquVF7kK9v9tCAa8q=V3f9kUZi_nLTzfYg@mail.gmail.com>
X-PR-Tracked-List-Id: Linux Audit Discussion <linux-audit.redhat.com>
X-PR-Tracked-Message-Id: <CAHC9VhTNqnzrtu1DHquVF7kK9v9tCAa8q=V3f9kUZi_nLTzfYg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git stable-5.10
X-PR-Tracked-Commit-Id: c07203516439b9cd9f7b3cbed82a77164de5af40
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01fb1e2f42d607ef5eb7a7ca54a0f0901fb5856c
Message-Id: <160263294623.20088.15009242434075942173.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Oct 2020 23:49:06 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 20:51:22 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git stable-5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01fb1e2f42d607ef5eb7a7ca54a0f0901fb5856c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
