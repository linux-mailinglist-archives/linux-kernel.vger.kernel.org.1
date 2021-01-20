Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7362FD137
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 14:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733282AbhATNRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:17:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:52336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732539AbhATNI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:08:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A14522210;
        Wed, 20 Jan 2021 13:07:44 +0000 (UTC)
Date:   Wed, 20 Jan 2021 13:07:41 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Chen Zhou <chenzhou10@huawei.com>, ardb@kernel.org,
        akpm@linux-foundation.org, rppt@kernel.org, nsaenzjulienne@suse.de,
        song.bao.hua@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, huawei.libin@huawei.com,
        xiexiuqi@huawei.com
Subject: Re: [PATCH 0/2] arm64: mm: fix kdump broken with ZONE_DMA
 reintroduced
Message-ID: <20210120130741.GB2642@gaia>
References: <20201226033557.116251-1-chenzhou10@huawei.com>
 <20210120124054.GA19504@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120124054.GA19504@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 12:40:55PM +0000, Will Deacon wrote:
> On Sat, Dec 26, 2020 at 11:35:55AM +0800, Chen Zhou wrote:
> > If the memory reserved for crash dump kernel falled in ZONE_DMA32,
> > the devices in crash dump kernel need to use ZONE_DMA will alloc fail.
> >            
> > Fix this by reserving low memory in ZONE_DMA if CONFIG_ZONE_DMA is
> > enabled, otherwise, reserving in ZONE_DMA32.
> > 
> > Patch 1 updates the comments about the ZONE_DMA.
> > Patch 2 fix kdump broken.
> > 
> > Chen Zhou (2):
> >   arm64: mm: update the comments about ZONE_DMA
> >   arm64: mm: fix kdump broken with ZONE_DMA reintroduced
> 
> Please can you repost this if it is still needed after the changes that
> landed in -rc4?

I don't think this series is needed anymore but I'll let Chen confirm.

-- 
Catalin
