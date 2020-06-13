Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42AB1F851C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jun 2020 22:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgFMUZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jun 2020 16:25:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgFMUZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 16:25:29 -0400
Subject: Re: [GIT PULL] libnvdimm for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592079929;
        bh=p67YCzZtZlltepJbmahkXUTSZ7AlDa28pMxCnf9z3do=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=p92yHx/BsU2vAOOKP35MWGmS9VbjIyEw7MWJyqBYupjHXA5KCnnmwzmji3hWP6+Ql
         6T3YMg5hhw0SHLzjeyfvMHcN3MJRu1fXdEYAcjYXVjCfHmtOFA2x2dOc4+x6r+ZmZN
         zx1/duk3dCEt+rKDaxnKNuPsOU1zsB80kCxGmo0U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4jDQ9VVZJTD=cz+VvPxo6FNQGbW=BYA1Qhix-yQkSWeCQ@mail.gmail.com>
References: <CAPcyv4jDQ9VVZJTD=cz+VvPxo6FNQGbW=BYA1Qhix-yQkSWeCQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4jDQ9VVZJTD=cz+VvPxo6FNQGbW=BYA1Qhix-yQkSWeCQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/libnvdimm-for-5.8
X-PR-Tracked-Commit-Id: 6ec26b8b2d70b41d7c2affd8660d94ce78b3823c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d74b15dbbbd2741f3580d7c884cd285144ae0cab
Message-Id: <159207992896.31508.586656922760504069.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Jun 2020 20:25:28 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Jun 2020 15:46:50 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d74b15dbbbd2741f3580d7c884cd285144ae0cab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
