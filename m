Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60941F1F6A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 21:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgFHTAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 15:00:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbgFHTA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 15:00:26 -0400
Subject: Re: [git pull] IOMMU Updates for Linux v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591642826;
        bh=TADXkTSQWoa3MyExygYsuGyc5j7G9rmpLPZ8UBV7ETY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EHxoXKabiFXLcYfAz1VttN/HO1JpOj5IcuDx0szV4eVqxyEdtCJIF89kJY8MJkm5o
         uZK8nYmj7pg/W6no3p3D1wg86g2NsMq0XZx9VM/wSsdgQsvdb++tOJcRn9MeNwW5mm
         RIH64HMvsmcK7ughkqD3w75RP/bmDLYUSedgrU1Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200608160502.GA4491@8bytes.org>
References: <20200608160502.GA4491@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200608160502.GA4491@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-updates-v5.8
X-PR-Tracked-Commit-Id: 431275afdc7155415254aef4bd3816a1b8a2ead0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e3a16ee9148e966678bbc713579235422271a63
Message-Id: <159164282645.16000.16082571812872995168.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Jun 2020 19:00:26 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Jun 2020 18:05:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e3a16ee9148e966678bbc713579235422271a63

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
