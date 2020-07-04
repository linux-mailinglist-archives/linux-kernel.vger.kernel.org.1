Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5C1214470
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jul 2020 09:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgGDHFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jul 2020 03:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgGDHFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 03:05:06 -0400
Subject: Re: [GIT PULL] xen: branch for v5.8-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593846305;
        bh=mdISOtGKokzv0rP5dd5e/Ev8OPzF6jG9Dh8+t5MOrZs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=P9TGSqzYJy8tqf7rK2dwN49odgya/v9o89YRQvdExfpDDJKRckKPnXFU53XudClne
         vP86XgbsHqndOBHwmltAMINm85YrQZi4aXjoP6SuY8OA8tENCpIfUOkIny1k+Ouir+
         Hfl0GYTA3qvw0OjG9SfqGUXAJN2W53ow63m3k53A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200704065702.3073-1-jgross@suse.com>
References: <20200704065702.3073-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200704065702.3073-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 for-linus-5.8b-rc4-tag
X-PR-Tracked-Commit-Id: 578c1bb9056263ad3c9e09746b3d6e4daf63bdb0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35e884f89df4c48566d745dc5a97a0d058d04263
Message-Id: <159384630585.17224.3932318630515842404.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Jul 2020 07:05:05 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  4 Jul 2020 08:57:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.8b-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35e884f89df4c48566d745dc5a97a0d058d04263

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
