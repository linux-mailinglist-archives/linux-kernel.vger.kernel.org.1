Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2DD267C2F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 22:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgILUAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 16:00:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgILUAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 16:00:13 -0400
Subject: Re: [GIT PULL] libnvdimm fix for v5.9-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599940813;
        bh=1ua1ZLcXCb6tiC1TrMgSMt7ael1GjTGFk4a21WBy/XE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bi81i9xpRDQCGKP8qfnwZNY1pQDXBfUU1b/p7NLurRFWhZddrmc3v/BUI+Y7KsaTL
         byyrQV6qBQWCCm8Q7+tCMclywCZ66/ZlMjoXwxTqWc/JjfSMWrn0ZPRPTyhmn2yIne
         DjkFSGgHFn0e9S9MmcwSpS3qSvC5QwRj2iiTb8VM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a0ded0398e87c8c7bcfc2d9f5c9e3af11dda8db0.camel@intel.com>
References: <a0ded0398e87c8c7bcfc2d9f5c9e3af11dda8db0.camel@intel.com>
X-PR-Tracked-List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
X-PR-Tracked-Message-Id: <a0ded0398e87c8c7bcfc2d9f5c9e3af11dda8db0.camel@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git tags/libnvdimm-fix-v5.9-rc5
X-PR-Tracked-Commit-Id: 6180bb446ab624b9ab8bf201ed251ca87f07b413
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f8b0a5b3f7e5f03b188de9025b60c15559790f9
Message-Id: <159994081331.29146.2263821994238588407.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Sep 2020 20:00:13 +0000
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Sep 2020 22:19:57 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git tags/libnvdimm-fix-v5.9-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f8b0a5b3f7e5f03b188de9025b60c15559790f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
