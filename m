Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A7D2ED6BE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 19:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbhAGSeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 13:34:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:37542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbhAGSeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 13:34:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEFED233CF;
        Thu,  7 Jan 2021 18:34:03 +0000 (UTC)
Date:   Thu, 7 Jan 2021 18:34:01 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     chenzhou <chenzhou10@huawei.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, will@kernel.org,
        ardb@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
        song.bao.hua@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, huawei.libin@huawei.com,
        xiexiuqi@huawei.com
Subject: Re: [PATCH 2/2] arm64: mm: fix kdump broken with ZONE_DMA
 reintroduced
Message-ID: <20210107183400.GB26159@gaia>
References: <20201226033557.116251-1-chenzhou10@huawei.com>
 <20201226033557.116251-3-chenzhou10@huawei.com>
 <653d43ed326e6a3974660c0ca2ad8a847a4ff986.camel@suse.de>
 <deeb19d6-29e2-f76e-9e28-6ad77c7cb1fa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deeb19d6-29e2-f76e-9e28-6ad77c7cb1fa@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 03:32:35PM +0800, chenzhou wrote:
> On 2020/12/26 18:34, Nicolas Saenz Julienne wrote:
> > On Sat, 2020-12-26 at 11:35 +0800, Chen Zhou wrote:
> >> If the memory reserved for crash dump kernel falled in ZONE_DMA32,
> >> the devices in crash dump kernel need to use ZONE_DMA will alloc fail.
> >>
> >> Fix this by reserving low memory in ZONE_DMA if CONFIG_ZONE_DMA is
> >> enabled, otherwise, reserving in ZONE_DMA32.
> >>
> >> Fixes: bff3b04460a8 ("arm64: mm: reserve CMA and crashkernel in ZONE_DMA32")
> > I'm not so sure this counts as a fix, if someone backports it it'll probably
> > break things as it depends on the series that dynamically sizes DMA zones.
> 
> I write this just because kdump is broken from this commit.

Commit bff3b04460a8 actually fixed a regression introduced by the
limited 30-bit ZONE_DMA, under the assumption that RPi4 is the only
platform that cares about this. I agree a kdump kernel will fail to get
memory in the low zone but it's not clear to me whether the regression
you are seeing happened in 5.11-rc1 or you it's been around since 5.5.

We may have got away before because max_zone_phys() assumed an implicit
DMA offset equal to the start of the DRAM (well, power of two). This
assumption was removed in 5.11 by commit 791ab8b2e3db ("arm64: Ignore
any DMA offsets in the max_zone_phys() calculation").

So your patch or the clean-up I posted only makes sense with the dynamic
ZONE_DMA patches in 5.11-rc1. For any earlier version, I don't have any
suggestion other than not enabling CONFIG_ZONE_DMA in the kdump kernel
(or backporting all of Nicolas' patches).

I'll post my clean-up separately to go into 5.11 but won't have a fixes
tag for bff3b04460a8.

-- 
Catalin
