Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D12F1F7D8A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 21:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgFLTZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 15:25:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbgFLTZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:25:35 -0400
Subject: Re: [GIT PULL] Devicetree fixes for v5.8-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591989935;
        bh=DcjK10GvDFeAl9mARoMVV4tuAvpVpKVU/efnkMi2GfM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Gq0jNa65zyKidBw9g5liYqzdlMvMwg+E1yD6e48slKnfeJQ6mZ8mTpmWDYId8wbfD
         BvqhnIG7uYIzSstb5iTLuv31QIyAce1vEuNA7fR4LUyyIBWI7tlPrdeINuW1FFg//L
         yYRm4j2Xk2zIqe4KscEhPXHmh/OmbGYuoW4/N5DU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200612174800.GA3459802@bogus>
References: <20200612174800.GA3459802@bogus>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200612174800.GA3459802@bogus>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 tags/devicetree-fixes-for-5.8-1
X-PR-Tracked-Commit-Id: 8440d4a75d90556cfb8fb3e244443f67381aafd6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4071b856afc8a49ec41e98ff45151bb0800bc46d
Message-Id: <159198993544.4050.9158713986979540025.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Jun 2020 19:25:35 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Jun 2020 11:48:00 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.8-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4071b856afc8a49ec41e98ff45151bb0800bc46d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
