Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71DF1AE5A7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 21:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbgDQTPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 15:15:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729817AbgDQTPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:15:23 -0400
Subject: Re: [GIT PULL] Please pull proc fixes for v5.7-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587150923;
        bh=59QsyVQ+uH21tLg/8z12tr1wiCiqmq20dLhe9KhICgs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uY6ToPLdls/QzmoR/6ifqiKyPPsEY9axtnMxGXdJ38GjV7CdtBheaN9c+GlUrttOw
         NZhhpJ/R5dPRSk6tfWoN3BEQGuCiduYTGnHxaAekQUGT6jdQctRej+e1HAp18X1HhZ
         4nm1IHDMv/uidXRYodg3wNiSoAHhRuPN9S+EUVG0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87y2quc7ug.fsf@x220.int.ebiederm.org>
References: <87y2quc7ug.fsf@x220.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87y2quc7ug.fsf@x220.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
 for-linus
X-PR-Tracked-Commit-Id: 4fa3b1c417377c352208ee9f487e17cfcee32348
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d286d5ebcf6cb93b340f2439fe16a90b544c6e5
Message-Id: <158715092303.7925.4541101563964901618.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Apr 2020 19:15:23 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Apr 2020 12:58:31 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d286d5ebcf6cb93b340f2439fe16a90b544c6e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
