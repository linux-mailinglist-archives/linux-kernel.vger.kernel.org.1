Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FD52DDAF4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 22:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbgLQVph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 16:45:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:59778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730257AbgLQVpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 16:45:36 -0500
Subject: Re: [GIT PULL] OpenRISC updates for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608241496;
        bh=FO/sl4qm/PokpKSLfou8c22YKPVd/JnKmZjNmTz4SEE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=junlRbabbB+tcm0cP6Xne/z/l6kpaFKI26KGf3H3NLcHQe8guWcrB+LtQKOnyWLte
         Qq/a/vOx5mwltNm3nXEjxcdLjIoTGthxc3ImA6FnVDa1lMMQ4/bTSjqi4a5FqYmdHQ
         4InkxKH6EFdtAD8gfv9nteQr24U4vOV78dRZRNTsUigNE3o4lqijcwAu+dm2YqUSKP
         3dXQ/iFxlgMrr/BUWitHBM9LSkhBbFi2C3lxGA5RWhVe7BEAftX29vbHnfc12ork1r
         nR51uSp3JukA+fHqwlwDs0Fnz++bqyiuC1n9rYw6ljQErz4zWsMv942Zm9TirzOVmK
         mYehv6l/GR7GA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201217204818.GG3168563@lianli.shorne-pla.net>
References: <20201217204818.GG3168563@lianli.shorne-pla.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201217204818.GG3168563@lianli.shorne-pla.net>
X-PR-Tracked-Remote: git@github.com:openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: d8398bf840f8964220508aff7901c924e322f5e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c6c887835b59c10602add88057c9c06f265effe
Message-Id: <160824149632.19561.281687922088779994.pr-tracker-bot@kernel.org>
Date:   Thu, 17 Dec 2020 21:44:56 +0000
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mateusz Holenko <mholenko@antmicro.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Dec 2020 05:48:18 +0900:

> git@github.com:openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c6c887835b59c10602add88057c9c06f265effe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
