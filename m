Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C611EED39
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 23:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgFDVPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 17:15:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbgFDVPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 17:15:12 -0400
Subject: Re: [GIT PULL] exec cleanups for v5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591305312;
        bh=z1ahmK8ir9vqTkieu8coaO9Ejgdd4+6c1NBu80hSJnc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Cfjh1phOy6o2AVxkXgl6IxkzckDELlvCdzLKo/BWPItbrddzqsR6kgAn+JgYpRg2d
         EEY5muUYQ2+EymhYDA2O3WyPDRKubnmNem5rm55q9xM07XWCFgUZh9EGb7ORF6uKj0
         TsY35+6dCn0trK/td/Jh0nxAFx7GBnsgnZ2AHLic=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87k10mioer.fsf@x220.int.ebiederm.org>
References: <87k10mioer.fsf@x220.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87k10mioer.fsf@x220.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
 exec-linus
X-PR-Tracked-Commit-Id: 3977e285ee89a94699255dbbf6eeea13889a1083
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15a2bc4dbb9cfed1c661a657fcb10798150b7598
Message-Id: <159130531241.6506.11306405374069488186.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Jun 2020 21:15:12 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 04 Jun 2020 15:09:16 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exec-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15a2bc4dbb9cfed1c661a657fcb10798150b7598

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
