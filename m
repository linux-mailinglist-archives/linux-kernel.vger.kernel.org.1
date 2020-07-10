Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E035D21BBA5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 18:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgGJQzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 12:55:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728249AbgGJQzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:55:04 -0400
Subject: Re: [GIT PULL] MMC fixes for v5.8-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594400104;
        bh=lup3G2Zv1bViC8syBK8NKScLFpdnQGZ+QAlzRP14P+o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LV43mZYQxPL26PCjYwNSFUKvqv5dnEbt+Eu/ys0VAFop8aND0jUikVg0W3EzVdSvq
         J3vSfYUP7gClddbPBUhpTwU/MtbNlDSDxjHXXlGfpZX8mp8SfFBQIX+sdCf3vqz0Zm
         sux8Fh7MNLb2rPecACMPxJ6JBPYRWn0YrmbvqdZM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200710075234.24987-1-ulf.hansson@linaro.org>
References: <20200710075234.24987-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200710075234.24987-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.8-rc1
X-PR-Tracked-Commit-Id: 3ec2d5113ea5e182b759b613dc1f7108ba7aac9e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d45f47a46854b304ebda238b6121f95370b195ec
Message-Id: <159440010452.18761.2008001668438382664.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Jul 2020 16:55:04 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Jul 2020 09:52:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d45f47a46854b304ebda238b6121f95370b195ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
