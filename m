Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E1423AFF8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 00:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgHCWKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 18:10:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729497AbgHCWKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:10:05 -0400
Subject: Re: [GIT PULL] RCU changes for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596492605;
        bh=HBMwVE6RQbuowtbOoRbsvu3OXPOlO2TlcRgtjHFfjgU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tXZbQhvCCajHyRGaQ16pYj8H50JfqppAHk4jF5IJiQcQO+QkkUoiDm/KHulRnlMzb
         Gw92539M9Ca0kLE5twFB54tx53UukQYF5DNXOybT31CKI6n0/mOj/5NaFlxqTZgIJq
         /EzKNCqLlhptEd+3Ye6y+CAir+lXU3G7PZ150938=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803113032.GA415083@gmail.com>
References: <20200803113032.GA415083@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803113032.GA415083@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-2020-08-03
X-PR-Tracked-Commit-Id: c1cc4784ce6e8cceff1013709abd74bcbf7fbf24
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f0cb6660acb0d4756df880a3e60e73daa9c244e
Message-Id: <159649260513.26696.9986057276164405777.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Aug 2020 22:10:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 13:30:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-2020-08-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f0cb6660acb0d4756df880a3e60e73daa9c244e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
