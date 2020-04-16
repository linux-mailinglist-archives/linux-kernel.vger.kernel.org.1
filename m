Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E221AD2AC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 00:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgDPWPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 18:15:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729350AbgDPWPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 18:15:24 -0400
Subject: Re: [GIT PULL] chrome-platform fixes for v5.7-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587075323;
        bh=XpIMQIWcueISAg4dETpJJ6SrYPt+w6B/MF4ltSLjw6M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RuXJfsdl/UC/GrJgGhkr4moi25PlubdEYenQiOYM3WTTF2mdbs8+uxEB0de7IE3GO
         5FFcFptk/Z6Bu4cwb2+Wrlkoz8qbdYyPC8wWlSEvYSrR8Y9ujVFyrlF+2L/Mb3k3/L
         xWDttIFvhRKtspNxr7rjByiERBPKqMxb7Lxr8h1M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200416214035.GA1586@google.com>
References: <20200416214035.GA1586@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200416214035.GA1586@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
 tags/tag-chrome-platform-fixes-for-v5.7-rc2
X-PR-Tracked-Commit-Id: 538b8471fee89eaf18f6bfbbc0576473f952b83e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2fcd80144b93ff90836a44f2054b4d82133d3a85
Message-Id: <158707532371.2733.17062166003215775460.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Apr 2020 22:15:23 +0000
To:     Benson Leung <bleung@google.com>
Cc:     torvalds@linux-foundation.org, bleung@kernel.org,
        bleung@chromium.org, bleung@google.com,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 Apr 2020 14:40:35 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-fixes-for-v5.7-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2fcd80144b93ff90836a44f2054b4d82133d3a85

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
