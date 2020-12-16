Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62462DC751
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 20:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgLPTpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 14:45:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:59054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728549AbgLPTpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 14:45:07 -0500
Subject: Re: [GIT PULL] Audit patches for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608147866;
        bh=cdSRwOpAczOXkd5n5aOubZAtoQrjTIc5NC1NPzrZsqM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NvuYocBicfEECJDsGLvQCEH8w/0hkFxvmI8Jk5DtLhL/y8APN5xLEZW0Ad17ccVtD
         Bgae6IkXQ2U4bGXqQHWoY1xMH4Ai73y4WsmHIcjgwQa9ZlnXwGveEyjI3u6V4fiUBL
         GCfcePOozikt/zSWM1EDgjRPRVgpoLlF2S3QqQ36crOM9qi8h6GSD0hiVcyXGPSfb1
         u2wDXby/WTlHsX4rUUqzSbwxIPIomvZ35JaV2Yv1lcaqvQrLdIKec3XhAUYUuzSmmJ
         A/1KAtuEhck19FYYZSvKH1bNzpKi0d4zxk5mz1JvEghHNwFTAtsVZ7h3PZd7AUgbAb
         IPbAyH5vWIfmA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhT5ZQaz48+DNLTKqA5x1yMQL65iQyMW7=Qby5toyc2_0w@mail.gmail.com>
References: <CAHC9VhT5ZQaz48+DNLTKqA5x1yMQL65iQyMW7=Qby5toyc2_0w@mail.gmail.com>
X-PR-Tracked-List-Id: Linux Audit Discussion <linux-audit.redhat.com>
X-PR-Tracked-Message-Id: <CAHC9VhT5ZQaz48+DNLTKqA5x1yMQL65iQyMW7=Qby5toyc2_0w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20201214
X-PR-Tracked-Commit-Id: 6b3211842a115d697fbf78d09f3e83852200e413
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d5de2ddc6ba924d7c10460a1dc3aae8786b9d52
Message-Id: <160814786650.14944.9288287963650099860.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 19:44:26 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 20:57:59 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20201214

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d5de2ddc6ba924d7c10460a1dc3aae8786b9d52

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
