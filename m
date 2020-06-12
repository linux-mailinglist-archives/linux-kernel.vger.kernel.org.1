Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81341F7DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 21:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgFLTuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 15:50:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgFLTua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:50:30 -0400
Subject: Re: Re: [GIT PULL] proc fixes v2 for v5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591991430;
        bh=aNu94r3BMNRduO1ys2blsrbmxFm9EQ6ybhpb68oJkeA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bSXSPiign7SmPiISSy3Jb2jeIgJdubRg2DZrTTSR876go0CR+afRgcjwASmzi8Fey
         gBUg8Zxqi47CTPElE3rPyf+wT5YgUJfd32mTLoiX0B8STJkbD2vhQZAFnPcoTZ/d6G
         V9Y42UrwvFq/SL8QvlUONFsbUabmXboGJASvurWg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <871rmkozf5.fsf_-_@x220.int.ebiederm.org>
References: <875zc8kxyg.fsf@x220.int.ebiederm.org>
 <87zh9atx0x.fsf@x220.int.ebiederm.org>
 <871rmkozf5.fsf_-_@x220.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <871rmkozf5.fsf_-_@x220.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
 proc-linus
X-PR-Tracked-Commit-Id: ef1548adada51a2f32ed7faef50aa465e1b4c5da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 44ebe016df3aad96e3be8f95ec52397728dd7701
Message-Id: <159199143006.26414.16269571190531175476.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Jun 2020 19:50:30 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Jun 2020 14:29:50 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git proc-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/44ebe016df3aad96e3be8f95ec52397728dd7701

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
