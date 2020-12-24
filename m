Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E531E2E28F1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 23:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgLXWAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 17:00:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:40458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729004AbgLXWAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 17:00:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 76A8322C9D;
        Thu, 24 Dec 2020 21:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608847174;
        bh=tslbC6tu1seKhg4N3jLbDAc30cLoAS5dItk1azrn31E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kvOHaNCnkdBighGw3b2RJ35ELJmjirJ9eYOkuQSlsjXcW24FaDslRwOQhKccOVRmV
         4pf3xmNLJJgUUZFXxS+a6gfR3Wl/OcABmO+AHo+Sk3EeUiaa0lDOPmXFrFc15jxX6H
         y3pLJHwvwwfLbob7i0ugrVLu6jBG0yZi9RhJDoTT0Xx+jm7v77ggASM1VHvwZe5FxM
         nxLNeIM99qebkyTkdrqA7R6EhwNbIS2CLXc89Noi7kBuFEDgvkshQtME6SBfVhHxvU
         EB8gQFzSENozb+zjGe456WynSWyyAGFgD31fEhNReCjRBQVbMfrG95TZvbZ9+7S0Tx
         wxwZpfy3otuFg==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 70D6960159;
        Thu, 24 Dec 2020 21:59:34 +0000 (UTC)
Subject: Re: [GIT PULL] libnvdimm for v5.11
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4iufHK1g-KvhOsh5pwNL=DwK5ydVR7NWePaco5v5XL24A@mail.gmail.com>
References: <CAPcyv4iufHK1g-KvhOsh5pwNL=DwK5ydVR7NWePaco5v5XL24A@mail.gmail.com>
X-PR-Tracked-List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
X-PR-Tracked-Message-Id: <CAPcyv4iufHK1g-KvhOsh5pwNL=DwK5ydVR7NWePaco5v5XL24A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-5.11
X-PR-Tracked-Commit-Id: 127c3d2e7e8a79628160e56e54d2be099bdd47c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1f13d2f7d8a407be09e841f17805b2451271d493
Message-Id: <160884717445.31605.2585474058824378587.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Dec 2020 21:59:34 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Dec 2020 11:01:53 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1f13d2f7d8a407be09e841f17805b2451271d493

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
