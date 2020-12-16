Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A27E2DC8B2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 23:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgLPWEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 17:04:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:44196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729993AbgLPWEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 17:04:46 -0500
Subject: Re: [GIT PULL] IOMMU updates for 5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608156245;
        bh=S/Ul4lH6lcWEirkzt4WMunpxcnDaYdmPn4tG6s6NqwM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cGouDdgckih4V/BB6n1tgELoYNw02Cx5InmYouvK4X8F8H7i0ZViU7+VHNJXh0apV
         fzKREuDoJxIcRADlqdXWcp2ZiXIZ9x8yKNVazWFqgCilZ0YcC3XCuD12Mq3R75zO8C
         HBN/SvwzsTi8u/dwAM+DlUGo+owD98MvvDElRKBahw3IlSVuA2M1exxVy/jBd3MbAd
         k2UJmkYmEXGGSSh5XR6I3DPmm9+gin1jMySTWg8M5ZODDWylKZyFmQNApCPfeT4Rrx
         VxiCW5Q9O10ebXf4fppk4nn5eyCH6MCj+2Xcxbl+c9zBtNi7EFc1CPRIXYSF0mMR3C
         zUFtu5RVnaLdA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201214234518.GA14575@willie-the-truck>
References: <20201214234518.GA14575@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201214234518.GA14575@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/iommu-updates-v5.11
X-PR-Tracked-Commit-Id: 5ae9a046a452d60b6a6c076f6df7e3f8e34f918f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 19778dd504b5ff5c3c1283aa3da7a56f34c2c3b0
Message-Id: <160815624564.26131.15399501793441701742.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 22:04:05 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, kernel-team@android.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 23:45:18 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/iommu-updates-v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/19778dd504b5ff5c3c1283aa3da7a56f34c2c3b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
