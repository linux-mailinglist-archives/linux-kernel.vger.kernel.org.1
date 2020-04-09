Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1FE1A2E9F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 06:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgDIEzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 00:55:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:44590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbgDIEza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 00:55:30 -0400
Subject: Re: [GIT PULL] chrome-platform changes for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586408130;
        bh=cWRQCtrlTDdL8U+k2fQvJ7I/8GpqVP8VinRoB7sPoPs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=myg+8e6q9CTygKATX2NYP0xFCEESRThSIUFOHoqy4uAEZelmBlHuOrLipUnxhC6WR
         nB72Tw+e3MCjNAoRm959eGm53rDdJ3s49QKD6bmdWcvkXVnCgfpPXIP8V8UkKN7P2X
         QsjJ1tz2MVTEsq/SsmzF26+UfUq0qD1HkQGyxkqM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200408055336.GA123431@google.com>
References: <20200408055336.GA123431@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200408055336.GA123431@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
 tags/tag-chrome-platform-for-v5.7
X-PR-Tracked-Commit-Id: a46387712da12b61bf1ce1a3f63b60a17b098960
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 413a103cf6e507f6304ec42b89ed45428942c43f
Message-Id: <158640813050.3202.5614073362747400593.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Apr 2020 04:55:30 +0000
To:     Benson Leung <bleung@google.com>
Cc:     torvalds@linux-foundation.org, bleung@kernel.org,
        bleung@chromium.org, bleung@google.com,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 Apr 2020 22:53:36 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/413a103cf6e507f6304ec42b89ed45428942c43f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
