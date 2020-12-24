Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46DA2E28EC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 23:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgLXWAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 17:00:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:40270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729004AbgLXWAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 17:00:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 6F18F229CA;
        Thu, 24 Dec 2020 21:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608847160;
        bh=472ZjBiNherYRAamBzdPkopGnEioMOalNjCSQnIOgP0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pSCKSP2+YZd49gjS9/wamPywjioIoteizxDb7xZcCR0mxRLkPo/TX14A8fpbs3nws
         EaxIxdwZqiQyERMBzJr4wIodYdCjWhxGY8920rbzTDxR0M1zSgEz0aw9Y7okLiSHlA
         iCc8lIlRKiCYNIh3yohGA4qFU7Lr5j1mx4o+lnqk0e7vAqARL5jPFuQ4NleMHHtPu0
         6ws9u8WOEekrWasiH11msMb+G+Tj00L54cLpWUW9afwhWsnaRNis4vWoNaIpE3MoRq
         eMqviiJnZ7foPsYym0cpqW0yrqcvD9AWCE9NXB9Yv2NtolHx2A4AViTg9/SdcdrP6X
         DFEbfr7bn/qrg==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 69CA9604E9;
        Thu, 24 Dec 2020 21:59:20 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for 5.11, take 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201223181120.GA797630@robh.at.kernel.org>
References: <20201223181120.GA797630@robh.at.kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201223181120.GA797630@robh.at.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.11-1
X-PR-Tracked-Commit-Id: 2b8f061a4f505aad11fd36adb24c3138ad09b96b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 14571d5f22d3f7f6ecb97e037a2e346b3fb488bd
Message-Id: <160884716042.31605.4746239064993257708.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Dec 2020 21:59:20 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 23 Dec 2020 11:11:20 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.11-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/14571d5f22d3f7f6ecb97e037a2e346b3fb488bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
