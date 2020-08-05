Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82EE23D30B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 22:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgHEUdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 16:33:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgHEUdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 16:33:10 -0400
Subject: Re: [GIT PULL] Devicetree updates for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596659590;
        bh=mHh1Cq5MAkcpTOCekHQeqlJ3JmplFxonYo4U25F4EB0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TZBTJsl304N6ShrAdtmjJ0VxPgz9M3CWxkhDPf9c3JfZB7GZpFZq0+nREBhOskeiH
         T8pOlNoLBv5wu8ogCbC+iWCKE2JzO0To/DdEhJ7vEP1lMtTsQRN4CJp5NXT41ocaU2
         FuWyJEmL2PZBR1Ue1fJ1ce2rbe8G4+den1X/6M7k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200804222811.GA1222892@bogus>
References: <20200804222811.GA1222892@bogus>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200804222811.GA1222892@bogus>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.9
X-PR-Tracked-Commit-Id: 6f1188b4ac7577c29a4883d5618fa2231396fe9d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 441977979a78bffe51b13932d353919b1fb20c14
Message-Id: <159665958996.13939.5485961666927813325.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Aug 2020 20:33:09 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 4 Aug 2020 16:28:11 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/441977979a78bffe51b13932d353919b1fb20c14

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
