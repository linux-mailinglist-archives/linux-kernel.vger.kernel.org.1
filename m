Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13ED22DB688
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 23:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbgLOWXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 17:23:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:46556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730074AbgLOWWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 17:22:48 -0500
Subject: Re: [GIT PULL] USB / Thunderbolt driver changes for 5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608070927;
        bh=N9MnGmkL2zhrFoIsbF7loiRHZ5RP/FYtFEdGqZpEM00=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SPKpY8IHjHf3CxSvve9Fd7lq6W/YpqPSk1BuNnK0uHnp1zk3moYQLqEvFEghNMnO9
         mP7WjxKfa8+7ZB1BJkTb6n0FNDvMN80hDLT9YvpvJK2vmqxnQB6cYlozsbS34qRL/l
         93P/KPNie7bsmzIDvP1eqX7hcabtdgnsVhlCeF8tJLxZKiEgvabm0hHFFMl02sWVBf
         QdcqxsfRzVMW3kfWZtAZuA50ZGTvrZ3ahhosAcNMwtauaO2qohvkuk0A6tlQ4kO4T3
         Xm+UphNnJAdIMKTOb7aEM24zPJVn5bAp+ayzDrrF9296/IEOPWxzpWBgOqq2Gv4/Le
         NfpkVcFB21xTg==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <X9iNHGpdcl3cAlo4@kroah.com>
References: <X9iNHGpdcl3cAlo4@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <X9iNHGpdcl3cAlo4@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.11-rc1
X-PR-Tracked-Commit-Id: a256e24021bf7ceedd29fe65eb45c7adfffffad2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0cee54c890a40051928991072e5d1cd279611dfd
Message-Id: <160807092731.3012.13573878693310084304.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Dec 2020 22:22:07 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 15 Dec 2020 11:17:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0cee54c890a40051928991072e5d1cd279611dfd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
