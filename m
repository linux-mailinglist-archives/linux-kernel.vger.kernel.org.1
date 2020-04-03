Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCA5A19CDD7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 02:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390422AbgDCAkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 20:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390413AbgDCAkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 20:40:15 -0400
Subject: Re: [GIT PULL] hwspinlock updates for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585874415;
        bh=6Fq0RBm47SeNRN3pI4nuUmLYd+7mBF4nPYB411dFPz0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vM10yjNyR9njHFkAy533WNUOolWjt4F3fBiK+AgXk6FfnaI13yWdy+rx7JO+iC26a
         L6eHDSS07ZIF0QNOaxehuehKW9UZ+eE5qP97rFUTWMteZrh7w5MiBgU5nE3kpGWvay
         SND4JZ493ubkPZiss7H4v7OEcJQHEXwAHp0DuJQE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200402010837.GB751391@yoga>
References: <20200402010837.GB751391@yoga>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200402010837.GB751391@yoga>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git
 tags/hwlock-v5.7
X-PR-Tracked-Commit-Id: ef17f5193edd42e8913c93d0b601c101c56a15bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 11786191e2d946410cf5fde482b10cdd5356e76c
Message-Id: <158587441546.31624.17775444987242154271.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Apr 2020 00:40:15 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Apr 2020 18:08:37 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/hwlock-v5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/11786191e2d946410cf5fde482b10cdd5356e76c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
