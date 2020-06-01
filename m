Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0181EAFAF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 21:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbgFATfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 15:35:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729598AbgFATfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 15:35:10 -0400
Subject: Re: [GIT PULL] regmap updates for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591040110;
        bh=foF7+4nEBzI/M3/ciVG8wp+31WO2QVMXvs+vnVCBCgE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eBCYAXUFeJmqDfE9f5uH0EjOTALEN5nIGH8Xqt6oMj2iLSd7TIqLSKcdqwbnSjbpc
         S/L/SH5mz1pz48iobO16cdI12MiKj6eZtYYwF/8obXFM2COzc3xcP7T/jgGo/sGEhH
         /dItHtENJNA6MpXC9kVUzOylwpN1zjMaDXdinzA8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601110752.GC5234@sirena.org.uk>
References: <20200601110752.GC5234@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601110752.GC5234@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git
 tags/regmap-v5.8
X-PR-Tracked-Commit-Id: 9b98f92ca446f4302607a88fbb67619af968f3cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 213fd09e1aff05433d6855287808a235c9801c1b
Message-Id: <159104011055.18844.6554937665535830297.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 19:35:10 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 12:07:52 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/213fd09e1aff05433d6855287808a235c9801c1b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
