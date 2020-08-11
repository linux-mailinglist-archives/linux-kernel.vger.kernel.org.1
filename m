Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC0D242234
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 00:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgHKWAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 18:00:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgHKWAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 18:00:00 -0400
Subject: Re: [GIT PULL] arm64 fix for 5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597183200;
        bh=XWjFDV1hJdjAa/nR5SVad2zNjY2lB4N6n0y9GY88vrU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Y31iQP6R+s7HvcdO4hmdvcp9IhZlc0Qa9he0d2LdtqijU7Yvl6jhwCOIVqpC3Oze4
         AD5nECyR5Dr+01AF8oPJWnAn4y1oMuXuvfGG0189UhfkTXnwKq4pbDojz5J2fGb5R8
         P9AIytQnamPK3URzvm1tPoMrEfayWrxjpqJkoDb8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200811173957.GA11571@gaia>
References: <20200811173957.GA11571@gaia>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20200811173957.GA11571@gaia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 3df14264ad9930733a8166e5bd0eccc1727564bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb5baaa9238ecf8f13b112232c7bbe0d3d598ee8
Message-Id: <159718320056.19600.16990916723096769196.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Aug 2020 22:00:00 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Aug 2020 18:40:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb5baaa9238ecf8f13b112232c7bbe0d3d598ee8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
