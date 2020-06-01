Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEDAD1EB271
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 01:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgFAXze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 19:55:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728887AbgFAXzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 19:55:08 -0400
Subject: Re: [git pull] uaccess __copy_to_user
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591055708;
        bh=Lrlg5REYFrwSNquOV5J/idJJxR2xlsu8rLNybN+dmpk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xgEh+Q56Xkn3JKWFc5eit51bNTDiTXk7YetPridQh43cy3PXdkqmdh49gW7tN1EQ6
         oPggQwrK5vXbn7BeXfVzurTL/RY/i7wDlVB7TUCWOydIwZrIVEp/VEjAAx4o4Qe6dF
         AKH0Rm8kPYkuHLLScupU1FIAhoL+1Ridfreu7taY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601183159.GF23230@ZenIV.linux.org.uk>
References: <20200601183159.GF23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601183159.GF23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
 uaccess.__copy_to_user
X-PR-Tracked-Commit-Id: 0702e4f39034f15855def3165fe7213c7c2c0163
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 062ea674ae8ad93530dbf7176c59daef098863df
Message-Id: <159105570805.29263.17331996368597513222.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 23:55:08 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 19:31:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.__copy_to_user

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/062ea674ae8ad93530dbf7176c59daef098863df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
