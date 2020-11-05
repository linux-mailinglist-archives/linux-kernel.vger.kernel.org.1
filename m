Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0A92A87EF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 21:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732260AbgKEUV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 15:21:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:34718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732231AbgKEUV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 15:21:26 -0500
Subject: Re: [GIT PULL] regulator fixes for v5.10-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604607685;
        bh=nBBcIqtN2nJZ+S+em3An97qre10nS8RejcCwFFjlGe0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=M0ioyD1fm5TbQBQquc7WTmZMCRXN1byKUBmzH7O4eBy4zX17tPJJan5IwPTNc/7jf
         KOnvOsGuYxF1JW1dDtCLCVKEKY3X0rrZni0snPmjP/TYxl/eWsEa1bhp9YX+gsmF2Y
         4W+oDbE22s8Hsg1Krvdu2yH3EDxeTl8HxIPmbeNc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201105164547.AE3AD221F8@mail.kernel.org>
References: <20201105164547.AE3AD221F8@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201105164547.AE3AD221F8@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.10-rc2
X-PR-Tracked-Commit-Id: cf1ad559a20d1930aa7b47a52f54e1f8718de301
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d55978f95ca3cb66ed9161f4ef5d6e6b9569c2b
Message-Id: <160460768564.18865.16111467494218015739.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Nov 2020 20:21:25 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 05 Nov 2020 16:45:25 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.10-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d55978f95ca3cb66ed9161f4ef5d6e6b9569c2b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
