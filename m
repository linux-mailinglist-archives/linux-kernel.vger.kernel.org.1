Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829FA1B88F6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 21:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgDYTaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 15:30:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbgDYTaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 15:30:18 -0400
Subject: Re: [GIT PULL] Please pull proc_flush_pid fix for v5.7-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587843017;
        bh=n2L4/mjr88k5uaObaoXiyXw7V1lQA62Wol/uoVuasi4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=S0PeTVPM4vZbFXsiIuEXHueT3PRfIqVN7QWb2hITrloFumDCp8mwo/hdLJYQFWu8P
         kg99cHeQQFz/wmfxWNnPsVCwxEKgy2JhAy8AbzlCi+qPUXTVO3TSqP2pVIGe4nTUlw
         2Ol8CQhg4h+kCiWHj/DvKr27Cf6fNX5jiSfKzghM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <878sijo8us.fsf@x220.int.ebiederm.org>
References: <878sijo8us.fsf@x220.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <878sijo8us.fsf@x220.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
 for-linus
X-PR-Tracked-Commit-Id: 6ade99ec6175ab2b54c227521e181e1c3c2bfc8a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b2768df24ec400dd4f7fa79542f797e904812053
Message-Id: <158784301793.5802.14062877392747886162.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Apr 2020 19:30:17 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Apr 2020 10:58:35 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b2768df24ec400dd4f7fa79542f797e904812053

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
