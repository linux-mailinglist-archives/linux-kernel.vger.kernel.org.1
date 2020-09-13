Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2384626804A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 18:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgIMQdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 12:33:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgIMQdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 12:33:20 -0400
Subject: Re: [GIT PULL] USB/Thunderbolt fixes for 5.9-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600014800;
        bh=m3Nw1iJDRliR6heb2YTwzjSa5ato8SQ8HppNjMQAx3g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sX+GVuWaGgPboBbaLrUEq9aPVBxiSOZ7u2YJXJxoXH7Zi8n4zyauUeYvvE1LKPEx1
         o0Z0vaavcQMFCctC4X4hd5kLIHqT1GVf86DLcYEumOlYpWd75GuK8/o5G5nK4PwfT4
         GEPNA+d/dWnzHMuScyv8OPUFj57TOA+mOYmwlPpg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200913084024.GA907010@kroah.com>
References: <20200913084024.GA907010@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200913084024.GA907010@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.9-rc5
X-PR-Tracked-Commit-Id: a29c0adbb688ddee61b731804fb360898412fe7e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4c26faa426c17274884f759f708bc9ee22fd59a
Message-Id: <160001480009.6953.13788614724449131476.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Sep 2020 16:33:20 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 13 Sep 2020 10:40:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.9-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4c26faa426c17274884f759f708bc9ee22fd59a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
