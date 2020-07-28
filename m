Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99BD231221
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 21:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732559AbgG1TFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 15:05:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728872AbgG1TFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:05:03 -0400
Subject: Re: [GIT PULL] arch/sh additional critical fixes 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595963103;
        bh=VJ21Fy5lkc2JeRPH5FaXBLq9kIaU/AnArQ5U050SnS0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bUBJZCgyZCA+gfz9c267w6I4S+4MYcho1a2JlKouaWyulqx6p/4kwTfusd/pvtkxi
         7H0ilZ1O8sHBYKH2ozoCq7zAABKCK8BZhjt+AKfIcdih+8ZCsE526MzpP2oOo4W7Qw
         2VSSGvgwN4dFuJ1V4YrHLmG8sqsw90m2adV0HrwU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200727220922.GP6949@brightrain.aerifal.cx>
References: <20200727220922.GP6949@brightrain.aerifal.cx>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200727220922.GP6949@brightrain.aerifal.cx>
X-PR-Tracked-Remote: git://git.libc.org/linux-sh tags/sh-for-5.8-part2
X-PR-Tracked-Commit-Id: 04a8a3d0a73f51c7c2da84f494db7ec1df230e69
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4764e61e1d57c0bc3569dbc540af8bb28e18d2e6
Message-Id: <159596310349.13897.16698050689187298046.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jul 2020 19:05:03 +0000
To:     Rich Felker <dalias@libc.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Jul 2020 18:09:24 -0400:

> git://git.libc.org/linux-sh tags/sh-for-5.8-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4764e61e1d57c0bc3569dbc540af8bb28e18d2e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
