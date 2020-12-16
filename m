Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB77B2DC75C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 20:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgLPTqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 14:46:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:59368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbgLPTqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 14:46:00 -0500
Subject: Re: [GIT PULL] seccomp updates for v5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608147896;
        bh=aVaz3TfQ4P1Hj4bTDcVvg45sUGsvM2ghrd91Ew2K9/0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VUVhGOKN4/zAKM+SBNPNjQh4W/ssTs4Ov1Q1OV0FmrDoDwN2xmlwqxpgk/mYTjcsP
         vehbw3Rewa2COeWeseNETfIueruhN9wOqkgCvOHoBZaWb9Adzl4J5ytLG2LePFx687
         ea/EXP0Cke898K6VG5ZoPx/m7g+WWl9R1vUCNz7Lj8mOV9+k+f5A/vfnMimdU5SWbN
         3yN/5sDed/W7QO0k/48NbV8przrmDOfciktLgGOOJoc0A/asKZ/E2u527Sz3y1loY1
         OUECIB01xnalr1xnFRBqiWWhzp7rwZo5E9J1cpjPOlSw6X3IReUxovs3S6Tv9ZRdFp
         VLKdhclHre6TQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202012151225.4881A90257@keescook>
References: <202012151225.4881A90257@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202012151225.4881A90257@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.11-rc1
X-PR-Tracked-Commit-Id: 2c07343abd8932200a45ff7b10950e71081e9e77
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e994cc240a3b75744c33ca9b8d74f71f0fcd8852
Message-Id: <160814789591.14944.6819855635157503678.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 19:44:55 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Shuah Khan <shuah@kernel.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Tyler Hicks <code@tyhicks.com>,
        YiFei Zhu <yifeifz2@illinois.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 15 Dec 2020 12:30:17 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e994cc240a3b75744c33ca9b8d74f71f0fcd8852

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
