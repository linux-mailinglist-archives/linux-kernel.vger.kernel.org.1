Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF8A1F5D32
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 22:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgFJUa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 16:30:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbgFJUaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:30:25 -0400
Subject: Re: [GIT PULL] UBI changes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591821025;
        bh=NIQMWSiGhugs36Pn75PkmLIGCnjwO/j8S4v2zrqpzhs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nylvV9kv/ZqHToXHxeIcqmZeS+G1SqlXQHo4ECp2ahFrVJni6AN9LiCe3s065JGC1
         wQDoi5RFek9epIVjXvaFY1+z++rzS7NOQd6tIrO6LeYR4Gbyqkc+fBvy1kHLa6XTmX
         VT4lms8Z8ZP7+7rav98/yQbDEG0uqLQawM+3KaE8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <818706511.351.1591736518682.JavaMail.zimbra@nod.at>
References: <818706511.351.1591736518682.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <818706511.351.1591736518682.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git
 tags/for-linus-5.8-rc1
X-PR-Tracked-Commit-Id: 4b68bf9a69d22dd512d61d5f0ba01b065b01ede6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e083da7c8a26bc2674d7155bb5a0676b7dbc8ba
Message-Id: <159182102536.16227.7583734197738613136.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Jun 2020 20:30:25 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 9 Jun 2020 23:01:58 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e083da7c8a26bc2674d7155bb5a0676b7dbc8ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
