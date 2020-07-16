Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43A1222087
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 12:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGPKWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 06:22:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgGPKWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 06:22:38 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89A51204EA;
        Thu, 16 Jul 2020 10:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594894958;
        bh=vzEaE1HWTa7LYtbebB7ritpzkpel2YtikBtG3CEZDzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O7qT433Bf508kbmPUyZtGJ1ha3eKm5yrmKHurnYxiVO1tk+RfIFdFzfIP9a4dEULJ
         cxskKb6f2hESv3IlEBT1RUtZQsbEm8i3bC2eetulC0gX+ABbte+A6hbUMZv5oMxo3Z
         dEeF7i7CvTyJM+Yn2p8YoEk1EHckrb6iEUSt+mB4=
Date:   Thu, 16 Jul 2020 11:22:33 +0100
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     robin.murphy@arm.com, joro@8bytes.org, trivial@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, maz@kernel.org
Subject: Re: [PATCH 0/4] iommu/arm-smmu-v3: Improve cmdq lock efficiency
Message-ID: <20200716102233.GC7036@willie-the-truck>
References: <1592846920-45338-1-git-send-email-john.garry@huawei.com>
 <20200716101940.GA7036@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716101940.GA7036@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 11:19:41AM +0100, Will Deacon wrote:
> On Tue, Jun 23, 2020 at 01:28:36AM +0800, John Garry wrote:
> > As mentioned in [0], the CPU may consume many cycles processing
> > arm_smmu_cmdq_issue_cmdlist(). One issue we find is the cmpxchg() loop to
> > get space on the queue takes approx 25% of the cycles for this function.
> > 
> > This series removes that cmpxchg().
> 
> How about something much simpler like the diff below?

Ah, scratch that, I don't drop the lock if we fail the cas with it held.
Let me hack it some more (I have no hardware so I can only build-test this).

Will
