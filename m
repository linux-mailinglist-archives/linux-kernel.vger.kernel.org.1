Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07317298328
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 19:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418237AbgJYSfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 14:35:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1418142AbgJYSfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 14:35:23 -0400
Subject: Re: [GIT PULL] NTB bug fixes for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603650923;
        bh=kExHd0yLkxkzVTFsuZPtRMBrsCYlaLr1PerYBJELOXE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=o6EaqYXocg3Wr5843zvN/7r0LSwFG8yLPifV7QaNKEtqlpjq3T9eN+v913oVmVGNN
         sI70wT/GFJHCMRkXfdybpWO591ZrB2KBCOGzzmJbCQlXtKr5KmMZSv67Ri+TtPsAk8
         H3n4fEefYZK70Gw6GXGuWsZ3mEf/U/BiDreEeusw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201025133637.GA7862@athena.kudzu.us>
References: <20201025133637.GA7862@athena.kudzu.us>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201025133637.GA7862@athena.kudzu.us>
X-PR-Tracked-Remote: git://github.com/jonmason/ntb tags/ntb-5.10
X-PR-Tracked-Commit-Id: b8e2c8bbdf7778c6e3c65db21ababb1dfa794282
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5acf0ed8a5f0af084b0fdb53b0c7aad47dab29b
Message-Id: <160365092329.20889.3283622153980705366.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Oct 2020 18:35:23 +0000
To:     Jon Mason <jdmason@kudzu.us>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ntb@googlegroups.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 25 Oct 2020 09:36:37 -0400:

> git://github.com/jonmason/ntb tags/ntb-5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5acf0ed8a5f0af084b0fdb53b0c7aad47dab29b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
