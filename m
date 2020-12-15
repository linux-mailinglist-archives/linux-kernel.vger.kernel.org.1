Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91682DA513
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 01:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgLOAvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 19:51:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:36972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727186AbgLOAu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 19:50:29 -0500
Subject: Re: [GIT PULL] s390 updates for 5.11 merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607993388;
        bh=+TbnrVcLCbdz6ztoboM4SJgKEhC0ExG6jqf2zx36/WY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GAzyyABrURZdu9VHXCxQWRybaOgmjWLKRAm38t1gHnbNPQWKygN5wwSeavoZPKdcu
         UbiGN1PdcEUBqbBMLCzCk/U5da10HiQSKLO27WnKdoLkDOcsX4iObc/lARYp81DUos
         ZBIk4eVWESK9l2ruh6YOn7q8J4VLoquqOm1YwDxIZRjWegzHPEOQTI/NNobCJicbjf
         rtQJ8/kwdXv8CBVqvdV21Q/YairdZtb+En0W6iqMVa/g05iWs4u7KLHr7jyAWDNVjP
         UZ7EyucHf6dAbfnVnQVLNYMotdy1kBdf7E7oMn5/uw5VylTrtY2MIxVl8OuST+ASnY
         VeN2+9xwK99Xw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201214111823.GA5573@osiris>
References: <20201214111823.GA5573@osiris>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201214111823.GA5573@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.11-1
X-PR-Tracked-Commit-Id: 343dbdb7cb8997a2cb0fd804d6563b8a6de8d49b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 586592478b1fa8bb8cd6875a9191468e9b1a8b13
Message-Id: <160799338884.8612.3055463203148398890.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Dec 2020 00:49:48 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 12:18:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.11-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/586592478b1fa8bb8cd6875a9191468e9b1a8b13

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
