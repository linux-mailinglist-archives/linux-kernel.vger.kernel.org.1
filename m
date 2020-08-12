Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA7B242369
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 02:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgHLAe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 20:34:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgHLAe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 20:34:56 -0400
Subject: Re: [GIT PULL] chrome-platform changes for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597192496;
        bh=U5ONr6fJPa1IfxdQumHBJaBRBzsQucQmp1M26QBhku4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NZ2m3NyP2+RQVlijUuDGQYbp2Uz/cqj7fCCCqPxZX2CyZBv8VZ5Qgy32LYKAHactS
         5YszM/+/RhFkwZlmVhx7wWZtQwui/HLZ+lENLnLC8jddLDMJvpOM+UlPzyVFqxpxo9
         ppHMYZfATsQdSSxUVbwXrwG/Ohmm64tgkdg2rlGw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200811224201.GA4099603@google.com>
References: <20200811224201.GA4099603@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200811224201.GA4099603@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v5.9
X-PR-Tracked-Commit-Id: fc8cacf3fc68664e30a6df2b361ae05b9769585e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb893de323e2d39f7a1f6df425703a2edbdf56ea
Message-Id: <159719249637.21709.6216007156743863374.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Aug 2020 00:34:56 +0000
To:     Benson Leung <bleung@google.com>
Cc:     torvalds@linux-foundation.org, bleung@chromium.org,
        bleung@google.com, bleung@kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Aug 2020 15:42:01 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb893de323e2d39f7a1f6df425703a2edbdf56ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
