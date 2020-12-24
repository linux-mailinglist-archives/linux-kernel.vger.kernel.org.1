Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFFB2E2906
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 23:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgLXWXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 17:23:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:48028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728912AbgLXWXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 17:23:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 223A122AAA;
        Thu, 24 Dec 2020 22:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608848556;
        bh=uASpJbei9JDEaWFN2ydVCWPPVTOXDO20eGZ/yDcYdL0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=N54bb3yUPE+61uKRIBT3ZzhVnR6l4kM2WJXyNSqewJgp6i040+w7+RHlhpMM0kRkl
         1AUH0gSIPsAreC/kacgzZR9yk0gdX+aL2v0GXnbCl+2/wmkiTGgOmQRzZpLH3DtBnG
         BR0hL4Z9eQDD9luVzmy1YsJZ6rNoGWgy5BuHEHbJcSD2n8bkzx+n7oFcI5WVgReH43
         8HkINXSZOGvmWOFz7bgUoePu1Tc/EET+mSspsRjQnkDSv3prwc4c1q2S50lbudPsEF
         DZVpGFWGhw5EWWHIi648nD9txzD7Qcp8kMK1Y1iHxWyD/K27ge8ezKQXLhAJRNnRbr
         erVIGbywjbKxg==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 10BF2604E9;
        Thu, 24 Dec 2020 22:22:36 +0000 (UTC)
Subject: Re: [GIT PULL] A few documentation fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201223130339.4f7b9ec5@lwn.net>
References: <20201223130339.4f7b9ec5@lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201223130339.4f7b9ec5@lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.11-2
X-PR-Tracked-Commit-Id: c635b0cea6b812898563809a13e65278989b2c72
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 71c5f03154ac1cb27423b984743ccc2f5d11d14d
Message-Id: <160884855599.14240.9663132597668337886.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Dec 2020 22:22:35 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 23 Dec 2020 13:03:39 -0700:

> git://git.lwn.net/linux.git tags/docs-5.11-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/71c5f03154ac1cb27423b984743ccc2f5d11d14d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
