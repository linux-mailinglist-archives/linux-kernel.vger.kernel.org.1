Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF3520C2E4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jun 2020 18:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgF0QAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jun 2020 12:00:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgF0QAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 12:00:13 -0400
Subject: Re: [GIT PULL] arm64 fixes for -rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593273612;
        bh=vgGeqMJX4pazWmgXo79pEFvTNFsCBZcMP2uwkVjBk9Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mMxMN3yfZ1PUzFlgB05I2WaUQx+Iu8KLObil0G8MKHvxMcDH0URktt0BruNSMSc6h
         Jvcyy9et4cY1KtTSS17eXz+6L3tIM+mwf8htfYXidJp4XkKn3Al4NbZGOeFOE8Tc9R
         62yjLRqAlY/elImxdBd/0JAqDp8XAPc5XWrwqN2E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200626132131.GA9750@willie-the-truck>
References: <20200626132131.GA9750@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200626132131.GA9750@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 108447fd0d1a34b0929cd26dc637c917a734ebab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8530684fd37c151bbcf6c101ea3d0d784e221d98
Message-Id: <159327361263.7015.5382660920716001107.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Jun 2020 16:00:12 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Jun 2020 14:21:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8530684fd37c151bbcf6c101ea3d0d784e221d98

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
