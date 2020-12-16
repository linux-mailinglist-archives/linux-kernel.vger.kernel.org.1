Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E432DB9C9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 04:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbgLPDpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 22:45:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:38024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgLPDpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 22:45:30 -0500
Subject: Re: [GIT PULL] signal enhancements for v5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608090253;
        bh=q84sJ4xiX+tl/ZmDwYyorhuZ6xfMwIw2yHnMGdjwjmQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rBnEpnuAdkej/bUGKWjOKdE3Y1igkqav2vr1IhqgcSr7m6BtQVWzGLJNM5ALyEoWY
         qNnJ94VcL5fHyM+Vt3bF6HWvV6dY3eeOwBIAJnfScRtUOvZz/WlNNTW0FDEAArPLzr
         xTiquCMwv+Lr9FOZOKIqKmb/+Td1NiLvoViG75UFSjQr5TNRfXJvHgN7bkxNRLPEVH
         X07mz2jjOKA/8Jqd7tNIH7lyjbcTPitirroM/ORuJNYe/a6ZyinqBUQCm5AQN9bzIO
         /tkqZOXS0yM58MDK9jCBD1iezZukrFBJg69aqH811cP4rBi1etMReIKgZeYID/ABMN
         6f4ubjTN7qBLQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87bleubsgy.fsf@x220.int.ebiederm.org>
References: <87bleubsgy.fsf@x220.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87bleubsgy.fsf@x220.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git signal-for-v5.11
X-PR-Tracked-Commit-Id: bc54a5cda97917155b8da0d99afe1dc0ed0b30db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6febd8bef36e64fc1f4aaff1f6302be5c653ad64
Message-Id: <160809025327.9893.1610622527927404349.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 03:44:13 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 15 Dec 2020 16:43:41 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git signal-for-v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6febd8bef36e64fc1f4aaff1f6302be5c653ad64

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
