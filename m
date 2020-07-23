Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02BBC22A3B9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 02:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387426AbgGWAfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 20:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733289AbgGWAfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 20:35:05 -0400
Subject: Re: [GIT PULL] exfat fixes for 5.8-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595464504;
        bh=VmAiQHb3oWqZS9WuYmkFHNW9LpA82Zq9LL900Bl5i00=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1UzXAU9oqyIxo6o+HVTUqo7o7KvbTPsuEKnaGMHv4YJx25+2+0sXr0Oq0O1BeSoOw
         P+riwdRad5CAJBwPoO9BA0EcRw79LytaL8mzpBfQ9dfyOstoMF9G3anoQfeVHxSY8t
         TMQ/ALEdb+rzHPcS3AW/9z3aa+B41cv8aKizc8Gc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <003601d65fe4$a4d20da0$ee7628e0$@samsung.com>
References: <CGME20200722045747epcas1p3304644dafc49b5cc877454e51c6ec00a@epcas1p3.samsung.com>
 <003601d65fe4$a4d20da0$ee7628e0$@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <003601d65fe4$a4d20da0$ee7628e0$@samsung.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
 tags/exfat-for-5.8-rc7
X-PR-Tracked-Commit-Id: db415f7aae07cadcabd5d2a659f8ad825c905299
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 071fb1bcd727e306f3e5911e53e7222fc4efab35
Message-Id: <159546450483.19894.730067635713744965.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Jul 2020 00:35:04 +0000
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 22 Jul 2020 13:57:47 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.8-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/071fb1bcd727e306f3e5911e53e7222fc4efab35

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
