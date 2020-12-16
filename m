Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2C82DB82B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 02:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgLPBB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 20:01:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:51026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726660AbgLPBBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 20:01:25 -0500
Subject: Re: [GIT PULL] hwmon updates for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608080406;
        bh=zN+1kJBwJ1A140GJkDykYX7m3jTzRgzeADHx7HPe5Hg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jA6Mguo5RBHViJ2JoHSwlXgBtq3AVP7iI1fjpjlUTGbuYQK9E9hGLWaH3ia3+5i5d
         82bygSIGuM7ThJBxeg5D6TbCGkaQ25K3etz3z7v2ayb+ujIA5byxkMHs7jhCnzYXd7
         2Grpvt1KkyFo5zILiWUj6mgaU7YLlUgq3fPb3XT5a1C61zY2KhtPPbDCwNoyid6Ogo
         sCOpWHkvmA/KgAUJeK8Kz06DWg5cjoNYv9TWIO7LcDV+3Xol9RnKK4XB+86nohh4qE
         3CHWJ1BuVcg/4HJPdQ1gkx0kVtIoEjJUGMhj3HgGRyJAku7N/d4u2NRT7nsEtNKHYu
         6TXhU+4l6Yy8Q==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201214213044.27252-1-linux@roeck-us.net>
References: <20201214213044.27252-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201214213044.27252-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.11
X-PR-Tracked-Commit-Id: 1a033769a4fe9a86ee791fd553b6a996dd76e026
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f97458173a23c8f218f6041767d0a145a13abe6
Message-Id: <160808040643.29502.7266565145835614289.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 01:00:06 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 13:30:44 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f97458173a23c8f218f6041767d0a145a13abe6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
