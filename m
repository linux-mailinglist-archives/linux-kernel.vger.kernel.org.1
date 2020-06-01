Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217A81EAFB4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 21:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbgFATff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 15:35:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729601AbgFATfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 15:35:12 -0400
Subject: Re: [GIT PULL] regulator updates for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591040112;
        bh=NHR+2elG8QkQJqhm5Att1M0EH2MZqqd9textnw6aX0A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yXb93WXlMSJOW16pBsBxrDuSko8BuAwcxHf22RP53oOgE3wKrznzfljB0+K+MfGul
         sVC6aRddCfJ4+x8avr2dkiokX4vNDuigG6Y5ftqAKhD9IU2cHtp3jFBSq0ezbkJXO6
         8W+AA7Ki1oM6ltnE1e/fcogD+tMfSHgGp6uPs7gA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601122156.GC45647@sirena.org.uk>
References: <20200601122156.GC45647@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601122156.GC45647@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
 tags/regulator-v5.8
X-PR-Tracked-Commit-Id: 5fb565b69dabd5a256fc116702331b54a4621dc9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d30fc97c60682f9bf5d6898ab370de0007e96742
Message-Id: <159104011248.18844.667645293241136743.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 19:35:12 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 13:21:56 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d30fc97c60682f9bf5d6898ab370de0007e96742

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
