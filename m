Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9353924EF47
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Aug 2020 20:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgHWSjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 14:39:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbgHWSjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 14:39:25 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.9-3 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598207964;
        bh=hIKoVmpC88VP1ZThEbWeQVRYJkQKluOV7vCcJ3XkcvI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=J16Vx4irGTsvEoj+6w5Krxn8bXfPOXR8rzPSggBAewZUx7aTVygXGxnaRSkMD9D+C
         Xl8zz3va8W1QUwsEzhNmfYvaKAPf9plTbairHqH0o2bLK9rnDkr68CGwWKZjiYqTe+
         RJlvh2YZ/fW46lOXC98MeUYDRM+SmT2EkQcYnfuQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87v9h9h6gq.fsf@mpe.ellerman.id.au>
References: <87v9h9h6gq.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87v9h9h6gq.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.9-3
X-PR-Tracked-Commit-Id: 64ef8f2c4791940d7f3945507b6a45c20d959260
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb95712138ec5e480db5160b41172bbc6f6494cc
Message-Id: <159820796470.12134.6083209572149218193.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Aug 2020 18:39:24 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        aneesh.kumar@linux.ibm.com, anju@linux.vnet.ibm.com,
        atrajeev@linux.vnet.ibm.com, christophe.leroy@csgroup.eu,
        fbarrat@linux.ibm.com, hegdevasant@linux.vnet.ibm.com,
        kjain@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        mdroth@linux.vnet.ibm.com, mikey@neuling.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Aug 2020 22:50:13 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.9-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb95712138ec5e480db5160b41172bbc6f6494cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
