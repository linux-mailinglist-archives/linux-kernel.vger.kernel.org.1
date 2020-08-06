Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE3023E3B2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 23:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgHFV7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 17:59:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgHFV7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 17:59:22 -0400
Subject: Re: [GIT PULL] Staging/IIO driver patches for 5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596751162;
        bh=baS6DUd21cONNJO5/4J0WbYb6j+StksFCwz3VjEkgYE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zkJj+hdy+/G6rO6HQeIFKHrmcSJGay3sx5su48uXYPu2mh7aZ9dgXoCXAFvX40NUd
         kwYXOWDTEzj4NLHekpZVjWHa1P1avv2BLpJLydoXI8fbs8vfOY2laYGcAp55zKgmVD
         RLDM2xgYuDigeh1U5W4rgAxn27EIICj+MotSIDmk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200806123047.GA2857204@kroah.com>
References: <20200806123047.GA2857204@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200806123047.GA2857204@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.9-rc1
X-PR-Tracked-Commit-Id: 5bbd90550da8f7bdac769b5825597e67183c9411
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0c419c04557117258d184876d94091d29bbd9a6
Message-Id: <159675116218.18694.5085070310642512251.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Aug 2020 21:59:22 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 Aug 2020 14:30:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0c419c04557117258d184876d94091d29bbd9a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
