Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377942DDAF3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 22:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgLQVpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 16:45:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:59736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729166AbgLQVpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 16:45:36 -0500
Subject: Re: [GIT PULL] Modules updates for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608241495;
        bh=DHyQFU02RIIfj94rDftGfvDePAwe2t/e2cg+8Dz9oqE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZLVnpvLJuDsfTvMFJHyRu4vcOzpalBz/0ksWNP0+/3Hr5gmBC0Sf9+dgmp0/Q9vF6
         GxNfmw+VCySVxmiqX2SBjF7LY15QBnQMBVNdTIuSdThlWzPEud0/HE/RCjh9gYNko6
         6py7SG+SIMIHkp7EK20y5i/2CI2/U9Q90BOx/18asNqvWnhIv2wt0b8DPLHsbW3TgF
         zci4waELYPjUTc2sYocCRcCBXQlPWYx26Q4Q9MVkuWG99tl5VqWe7bNMyFuSsA1lJ5
         I8ma9LM3PFDwZCfpL73HQbALG2n3Ye2RjkFgKozSx7AvUQLdeeziIXgBWJ2N/NJhCS
         YoGlWcvv2nVjQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201217142020.GA19116@linux-8ccs>
References: <20201217142020.GA19116@linux-8ccs>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201217142020.GA19116@linux-8ccs>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git/ tags/modules-for-v5.11
X-PR-Tracked-Commit-Id: 38dc717e97153e46375ee21797aa54777e5498f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 312dcaf967219effe0483785f24e4072a5bed9a5
Message-Id: <160824149557.19561.500717393705428036.pr-tracker-bot@kernel.org>
Date:   Thu, 17 Dec 2020 21:44:55 +0000
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 17 Dec 2020 15:20:23 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git/ tags/modules-for-v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/312dcaf967219effe0483785f24e4072a5bed9a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
