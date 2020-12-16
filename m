Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8872DC96C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 00:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgLPXLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 18:11:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:56376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbgLPXLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 18:11:32 -0500
Subject: Re: [GIT PULL] memblock: debug enhancements
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608160251;
        bh=qQUg28ueUZHU0ojUz/H9tqiaUIwXSE9t5lC+GOyVQNk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ko3g05qmKyzOBwBMlPhhCbbdby3KDH7wcl0gJ7q5Uot43RpbxDCCyyO8hvRA58nd6
         JKaI2UB9Lt/G2scG7894oAbYySE8bvwEJv8RewjfX4p6v/nEHKztPOjpAzFMvHjwzI
         vs+yQzbUZ9sMIUW+oGahqlb7ms3wTAB9XakxYwB05SKLSAZa6wDbP6ClVc53GMDdpz
         fzfHpwgUzX3oH7g8W7cbjszJWLSEDQxUCUFFW9dcOtHxESq+LEnpPp7f8epkH1rzms
         5YGyWu/AEkg6CfFDOAYHSw4YarWl9xmMtYFQr/e7bMJ2t1rYDQwV7W6Bq5T8OcPIlj
         80XYFRXXkhkUw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201214131731.GA247200@kernel.org>
References: <20201214131731.GA247200@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201214131731.GA247200@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git/ tags/memblock-v5.11-rc1
X-PR-Tracked-Commit-Id: 5bdba520c1b318578caffd325515b35d187f8a0e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fff875a18382f1983b4a27be9282e697dbccb3db
Message-Id: <160816025139.24445.6413430286923393867.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 23:10:51 +0000
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        vinmenon@codeaurora.org, Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 15:17:31 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git/ tags/memblock-v5.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fff875a18382f1983b4a27be9282e697dbccb3db

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
