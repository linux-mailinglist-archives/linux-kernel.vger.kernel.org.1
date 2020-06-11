Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D10B1F5FA8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 03:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgFKBuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 21:50:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgFKBuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 21:50:24 -0400
Subject: Re: [git pull] uaccess misc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591840223;
        bh=UkomBBFKEy6mr/Yt72L+NB9xj5N2wGrKTzOcdmIBG5I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Cz3o8DeTZfRokk4uomQKg52umlP/rrPL2NhaJqH89fdoveqFNpnxj2d1MuuoDUYlz
         qTboLbb/55tYa+tcRZ7ymwdUjzLxc2/KdGOLIqIRJ3MZDg/M50eT1veQIiYXzGmysG
         2z0kncMOqX2D5fwW6qtNj1Je/Xgg/3rHOTG88Kwo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200610202509.GT23230@ZenIV.linux.org.uk>
References: <20200610202509.GT23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200610202509.GT23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.misc
X-PR-Tracked-Commit-Id: b7e4b65f3fe92abbf4a1f57987a54c820969aebd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4382a79b2746faf9db98a34ae1a1cbd364473f75
Message-Id: <159184022383.24802.1000748704629192996.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jun 2020 01:50:23 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 10 Jun 2020 21:25:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4382a79b2746faf9db98a34ae1a1cbd364473f75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
