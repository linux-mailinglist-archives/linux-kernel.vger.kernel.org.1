Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3582DDA78
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 22:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731664AbgLQU7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 15:59:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:45288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731573AbgLQU7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 15:59:10 -0500
Subject: Re: [GIT PULL] Mailbox changes for v5.11]
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608238710;
        bh=8SVbNtUvqTyhvFEiOooJkT03mv5h7yuzqHj1ni8iCKA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ceU4V6WrL/uQVt/LA2cBf2+73BvydRp7WgObhPUIlDwF6nyOCfc1EcX6zWOaHYttn
         vNHdtoIKMOIPttvW8YEBwlL9QD1UwoBva0UauAhgCYRFljGPniwNNRxnNU1gKTW/+6
         4cE5nvoC7Kh/+jKbnujat2/3WexxnMtX6p26TXHYRS1o6l8wLOpr9zbPngrMYvG10Y
         OwG3ng1aHaYX0K4dQ2uSu20D4hCEDAIFAyVYSiazvF821j9lvR6fNEgKF0/78Orx79
         0X1HSwxYDXkwLi3MnPz69oPy0u3RxNvRBvBlnXu1RiE37fs5BPZoG2X3/y0jwPKP98
         UtI6ZCRPOGu4Q==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY29c=nw5Nm4J3Aq4mFtzFPTvS51sVmA9zM+KxHgDaHN=A@mail.gmail.com>
References: <CABb+yY29c=nw5Nm4J3Aq4mFtzFPTvS51sVmA9zM+KxHgDaHN=A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <CABb+yY29c=nw5Nm4J3Aq4mFtzFPTvS51sVmA9zM+KxHgDaHN=A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v5.11
X-PR-Tracked-Commit-Id: 5a6338cce9f4133c478d3b10b300f96dd644379a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 83005cd6bc76eef7bbf46b55bbb00ccc9534c38c
Message-Id: <160823871014.27370.654822236544637196.pr-tracker-bot@kernel.org>
Date:   Thu, 17 Dec 2020 20:58:30 +0000
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 16 Dec 2020 20:17:21 -0600:

> git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/83005cd6bc76eef7bbf46b55bbb00ccc9534c38c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
