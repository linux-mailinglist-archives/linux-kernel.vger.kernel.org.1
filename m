Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA8A1F1061
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 01:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgFGXUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jun 2020 19:20:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:32798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbgFGXUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 19:20:22 -0400
Subject: Re: [GIT PULL] NTB patches for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591572022;
        bh=hoPJpyFYtIvUclI4ipxEBtMO6cS4qaufbGlMvDMl190=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=f+4BeVE9PiZGjgmdscZA4AUqxWq1Qaq0uKP/4mjPX62bjaoTIXXb41lVwv3yFtxdD
         StgvEYs+aLe288zwHCEvLNe/kP4PPPE2aZ0QT6TT/gfCjH4VSr1XgiGzbg7Z2P0vr9
         qx82xrOxbL0p1IYQvXXAE2INMVfx3ynK6z2ubT8o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200607165501.GA7336@athena.kudzu.us>
References: <20200607165501.GA7336@athena.kudzu.us>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200607165501.GA7336@athena.kudzu.us>
X-PR-Tracked-Remote: git://github.com/jonmason/ntb tags/ntb-5.8
X-PR-Tracked-Commit-Id: 2130c0ba69d69bb21f5c52787f2587db00d13d8a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 787f74fc5050c77e29a96f480f40421336eed5ac
Message-Id: <159157202243.17419.801679395194811680.pr-tracker-bot@kernel.org>
Date:   Sun, 07 Jun 2020 23:20:22 +0000
To:     Jon Mason <jdmason@kudzu.us>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ntb@googlegroups.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 7 Jun 2020 12:55:01 -0400:

> git://github.com/jonmason/ntb tags/ntb-5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/787f74fc5050c77e29a96f480f40421336eed5ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
