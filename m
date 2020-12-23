Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D282E22D7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 00:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgLWXmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 18:42:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:39416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728166AbgLWXmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 18:42:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 5919522287;
        Wed, 23 Dec 2020 23:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608766880;
        bh=3U0cOXliH2KGATub9GEGhs5i24N+jUDgE+u8NWdvuOg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fsU+G6jg+rCQFD8fRHOAjplMk1TZPbbJk2DORJW8LGBk6/G7fNiqN/TcJs47XcTwQ
         ogJaZs0PMwGOQQllmHNp0IkAO+ZLNqTdqa656tvapDdjOnpqazXF9dF9fWKqehUDAo
         2BID/yGyrZwJQ6wS75wbEilIy9lX9oh8zEZTWkSGGTfB/HwMn0tUyn/nkZzuDaxCEZ
         V1iM2IlaM+lMTSaZ5aDuJg7WMBAqPujumN6u07/qcazt0tX9n9kU7+44LE8WdL74LV
         1v6HagDOqeoq/QJyWdV+s+ST8WmiY8PTq0RoLEJO9xrh3KhKKnHrHue8PkMMzmXf93
         xGgdyHuTx6rNA==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 538CE604E9;
        Wed, 23 Dec 2020 23:41:20 +0000 (UTC)
Subject: Re: [GIT PULL] chrome-platform changes for v5.11
From:   pr-tracker-bot@kernel.org
In-Reply-To: <X+KPYZIAZXFOI/YD@google.com>
References: <X+KPYZIAZXFOI/YD@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <X+KPYZIAZXFOI/YD@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v5.11
X-PR-Tracked-Commit-Id: 6ae9b5ffcaeba64c290dfb8bd7b0194b1fdf0c92
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a0881596757fbef5781dc3cde5e8393dc2eb7ae6
Message-Id: <160876688033.7832.17912520134443366472.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Dec 2020 23:41:20 +0000
To:     Benson Leung <bleung@google.com>
Cc:     torvalds@linux-foundation.org, enric.balletbo@collabora.com,
        bleung@chromium.org, bleung@google.com, bleung@kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 22 Dec 2020 16:29:21 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a0881596757fbef5781dc3cde5e8393dc2eb7ae6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
