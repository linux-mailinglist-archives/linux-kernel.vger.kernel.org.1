Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1EA2DC977
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 00:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgLPXMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 18:12:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:56506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729029AbgLPXMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 18:12:12 -0500
Subject: Re: [GIT PULL] Devicetree updates for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608160253;
        bh=PVtVRIBBhH6Zx7UjfcxZpHzYnRizNDy0iTHzZCDRoWo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SUTYXuS15nXPldwjXjKIjHUkMvcEivAVU2sV5/o/0fbMBfHmNby4ZlolPyTvT1atC
         Cnkkqp7KBLgGcjDDqyEKmxGBJO+2dlGWVH+fLOFY2XbGYfpxNPcL1l7VfGgpbW93Wa
         Z11PYL6NO2GZIM5PNCw2g5fpH3uu9opQpXHmQ4rvnaHUN86k+eseoUs0/6tjRrW/6W
         wus+vO/jwPSqwYo8Kc6gmKcVsT1Dr1CWiJoAZZ5a1xGezPfJT3pti9JrA3cAPm/HZQ
         7gnEn9AYSqujaGqItyk6u3xAqAxHnuvqkjBdv933iS2vGk6MeUOajavp6qA5Z5Hjmx
         jC/zW+W6nCNsg==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201216174932.GA2165438@robh.at.kernel.org>
References: <20201216174932.GA2165438@robh.at.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201216174932.GA2165438@robh.at.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.11
X-PR-Tracked-Commit-Id: e33dc2f3636749c2f949a59c2ff8acd4a69c9c78
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 62746f92b10a4add6a7db87ff59b901276746b11
Message-Id: <160816025338.24445.9253365635565075869.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 23:10:53 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 16 Dec 2020 11:49:32 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/62746f92b10a4add6a7db87ff59b901276746b11

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
