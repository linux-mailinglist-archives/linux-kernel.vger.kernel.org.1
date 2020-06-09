Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478711F465D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 20:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732689AbgFISf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 14:35:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728589AbgFISfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 14:35:24 -0400
Subject: Re: [GIT PULL] f2fs for 5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591727724;
        bh=qhY+jtDr7eGsdtq/KDAUivjzemoTiVK0XkiET1MON44=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dpV8+DRzDqLXNKYku543i6f97gTekyIwRdhghnG1DsfVYLkCHo3NgnG0KcHyLZ6YW
         SMYQ1riEEmwD1yFbmx9jtWYqTdU1G69lmbGSj6cdqv2Vr2Iqw3KeEoZAuC07EhIjts
         VtEN+fwFtMZvfClNOsASynONb54VTgcyPuVUeMEY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200609145544.GA171717@google.com>
References: <20200609145544.GA171717@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200609145544.GA171717@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-for-5.8
X-PR-Tracked-Commit-Id: b7b911d59dacb47511a1e604bbfa901beb108305
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42612e7763315cf5d43c4422781e75f9ee57597a
Message-Id: <159172772393.12427.4644781740736919074.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jun 2020 18:35:23 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 9 Jun 2020 07:55:44 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42612e7763315cf5d43c4422781e75f9ee57597a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
