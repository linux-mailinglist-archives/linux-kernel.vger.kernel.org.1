Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D329303BBC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392434AbhAZLep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:34:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:54994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403780AbhAZKNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 05:13:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8220621744;
        Tue, 26 Jan 2021 10:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611655956;
        bh=BROfFJpIRH8LJFhVQkvm8o4ilhu1UZ/b8i19pQZDBU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qs6j8xg8KD+LFQ4ba99/rlxMYwy852TGndWKrQeutD+cmQ7e4e9nbgDexbo7KcmjK
         XOSlgAZyPQFLDmNfCQ6gDrZSSI0t1CNkLbvQAhKq6fgxtdT5FRcK2ein2dDYSo/Ihy
         1VRxAlxScThrtP8c2ii+mQVi8FONx2QuevopN46+AuPiNtg3V/yzO6u6UKV+TO5KpK
         r8yRcmyrP3i/Wo68zk9EStdkPV3HI0kEGSwRcMAVr6dPu0vMGkmXeKFeDAj258uhQQ
         kftvksihNAzk+y1sufWPmA0cm/B0fjh3d21mrUsK+UGzaEfWl9hKxjxr61W+rVEwQJ
         kRsytr8zP5RIg==
Date:   Tue, 26 Jan 2021 10:12:31 +0000
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: add support for BBML
Message-ID: <20210126101230.GA29204@willie-the-truck>
References: <20201126034230.777-1-thunder.leizhen@huawei.com>
 <20210122125132.GB24102@willie-the-truck>
 <aac11411-f6cd-f990-fe53-db0d8c07f3a0@huawei.com>
 <1bfd1ca0-953e-e943-f87e-144d5537bd0c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bfd1ca0-953e-e943-f87e-144d5537bd0c@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 08:23:40PM +0000, Robin Murphy wrote:
> Now we probably will need some degreee of BBML feature awareness for the
> sake of SVA if and when we start using it for CPU pagetables, but I still
> cannot see any need to consider it in io-pgtable.

Agreed; I don't think this is something that io-pgtable should have to care
about.

Will
