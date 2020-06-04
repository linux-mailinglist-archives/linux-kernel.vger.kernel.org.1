Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACB91EEA38
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 20:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbgFDSZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 14:25:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730797AbgFDSZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 14:25:11 -0400
Subject: Re: [GIT PULL] Backlight for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591295110;
        bh=xbkuIb1IrPmAGiEDPD0QHvDkKjBbmuKgqqnQvCagGoI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RCeYCMAlZtMcZV3KGc4gYLBs+4QgFG5dm9TSdcxB35ICNBaVL6vQSONaqmThMbo+T
         OsIhz8WBSWKucLg+yHA99ruqvoYiDq8V7p9YFIBb4AQQznd9A+QInSh2nKd/Yw1oI9
         W5dhB1mGFKpj4XETcK1jXhauUDyOUQ1RNIOg8G8E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200603090429.GN3714@dell>
References: <20200603090429.GN3714@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200603090429.GN3714@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git
 tags/backlight-next-5.8
X-PR-Tracked-Commit-Id: 479da1f538a2f3547e15f9d5922c611b69ec2fbc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 302d5b3321aa61ff4ab15f0abc737d923355d33d
Message-Id: <159129511087.18772.13000522552151392314.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Jun 2020 18:25:10 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 Jun 2020 10:04:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/302d5b3321aa61ff4ab15f0abc737d923355d33d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
