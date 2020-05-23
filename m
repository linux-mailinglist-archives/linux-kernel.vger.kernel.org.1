Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFFC21DFA40
	for <lists+linux-kernel@lfdr.de>; Sat, 23 May 2020 20:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388039AbgEWSaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 May 2020 14:30:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387981AbgEWSaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 14:30:04 -0400
Subject: Re: Re: [GIT PULL] Driver core fixes for 5.7-rc7 - take 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590258604;
        bh=p6+SizcZTYXX03pbpHU6FKUCi0gx9R5sYMkIVvq53fI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fkiuWJPKQPNsypaQm9aBtIs368zUlnP27fAzsenRxX2bQscM+ziDZ51qplctXr7dx
         gu2gvsu2x9pqni9UU5FTmAXdgPIrWHcJddRkbMeFZWnrJB55xiY48UNQTqpzEo+qap
         gojge09ReywEU53Yr6cqMI5b7q6q72RZunoZPb88=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200523152922.GA224858@kroah.com>
References: <20200523131759.GA55886@kroah.com>
 <20200523152922.GA224858@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200523152922.GA224858@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 tags/driver-core-5.7-rc7
X-PR-Tracked-Commit-Id: e6764aa0e5530066dd969eccea2a1a7d177859a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23f0dac848412dafd197566b62d831d5a68b5b6b
Message-Id: <159025860396.7121.10569259616701627909.pr-tracker-bot@kernel.org>
Date:   Sat, 23 May 2020 18:30:03 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 23 May 2020 17:29:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.7-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23f0dac848412dafd197566b62d831d5a68b5b6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
