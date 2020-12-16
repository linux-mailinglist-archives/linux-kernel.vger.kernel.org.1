Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58E02DC96E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 00:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgLPXLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 18:11:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727896AbgLPXLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 18:11:32 -0500
Subject: Re: [GIT PULL] Backlight for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608160252;
        bh=6CckuZx2mu4pWgTwasf5JzchTW6QGXz+Nt8y1gurH2c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rCDGZuduCbrJ3yZHW3UScJcNHUSF2Yv97d5UGMRGwDW8+LkQDMdkK9cvXeQ7dYRxD
         u/pYZNDhLU0qAGw/nzwkA4qiMV0gJLbJZGGG3tSpF9nztddMMB6Oh3kQByGPmU0KI+
         ULbcdZIa5DiO/+oWkh2Z9TSdgrAEyOOgZl8dDjRAwViCg6UwpTPcqngAh9qk/oyLPk
         C91qy9oc7F5nRNO8S24W1KVg2xYu5PKJ2YZcBrtukNjM8cdTn5W/gUTUGuUTIAF94M
         UceyREMnHjmG4oXqKXaHvt9G41zBK+xEguIcx9WSPPnbYJ6Hqpf09j0uGsSSOJ3zz3
         o3dm8uHpF7JkA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201216074908.GD4776@dell>
References: <20201216074908.GD4776@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201216074908.GD4776@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-5.11
X-PR-Tracked-Commit-Id: 789eb04b6c569e3e5007afd040bef5d7216d2f3a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 84e010ec8f8668c579b78a27b0e81a49ac6c837a
Message-Id: <160816025230.24445.10876264573086428170.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 23:10:52 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 16 Dec 2020 07:49:08 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/84e010ec8f8668c579b78a27b0e81a49ac6c837a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
