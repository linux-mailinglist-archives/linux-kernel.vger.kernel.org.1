Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1094F244E6A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 20:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgHNSPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 14:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728674AbgHNSPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 14:15:12 -0400
Subject: Re: [GIT PULL] Modules updates for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597428912;
        bh=Zud5Ac+lShjtpykh758s4SIW0NUWGvLA92z7Nj6ta38=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nT3CyPQ7qmOrCfJbVzWptpYxwhPHKlUVtCrSwAhSuWpl+QKr58QDgpdv7SsIgYtTZ
         eqToBMtoLpuMLwTO3qG0pEKfc7ltafjg+AWZAtb6HIjYe7AS6yMQipiNZU7GrpVPlR
         jjZ2rir8rRJAM8JiszqEzEXO+3asC/Td9Zbvs+Ec=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200814101712.GA32330@linux-8ccs>
References: <20200814101712.GA32330@linux-8ccs>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200814101712.GA32330@linux-8ccs>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.9
X-PR-Tracked-Commit-Id: 262e6ae7081df304fc625cf368d5c2cbba2bb991
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0fd9cc6b0c72245375520ffc8d97ce5857b63b94
Message-Id: <159742891208.14620.11283409603652178569.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Aug 2020 18:15:12 +0000
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Aug 2020 12:17:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0fd9cc6b0c72245375520ffc8d97ce5857b63b94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
