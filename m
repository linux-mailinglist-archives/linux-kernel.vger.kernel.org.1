Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596A92725F2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgIUNnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:43:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726471AbgIUNna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:43:30 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D10B52084C;
        Mon, 21 Sep 2020 13:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600695810;
        bh=DmCZ7P6LNdCNVX2iURc2Tv+RTbArR0Kg1mI/ej12EbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eNUZiyd9+5I4cLqEMKfuSXtwPRVFP3NRk7NB0oqya/i5QIDgYnbqfsN9qWw0VpSiO
         J3wuGwe/sY9cVi/OknDUnRC74FuQf99iOQpTLGIF/MyBKc3G4nnCEX9sM2xKK/PSuf
         dID2QWoDSef6LQt4+jkZjo4oEeIB/T/U85CZd3VM=
Date:   Mon, 21 Sep 2020 14:43:25 +0100
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     robin.murphy@arm.com, joro@8bytes.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, maz@kernel.org,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iommu/arm-smmu-v3: Improve cmdq lock efficiency
Message-ID: <20200921134324.GK2139@willie-the-truck>
References: <1598018062-175608-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598018062-175608-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 09:54:20PM +0800, John Garry wrote:
> As mentioned in [0], the CPU may consume many cycles processing
> arm_smmu_cmdq_issue_cmdlist(). One issue we find is the cmpxchg() loop to
> get space on the queue takes a lot of time once we start getting many
> CPUs contending - from experiment, for 64 CPUs contending the cmdq,
> success rate is ~ 1 in 12, which is poor, but not totally awful.
> 
> This series removes that cmpxchg() and replaces with an atomic_add,
> same as how the actual cmdq deals with maintaining the prod pointer.

I'm still not a fan of this. Could you try to adapt the hacks I sent before,
please? I know they weren't quite right (I have no hardware to test on), but
the basic idea is to fall back to a spinlock if the cmpxchg() fails. The
queueing in the spinlock implementation should avoid the contention.

Thanks,

Will
