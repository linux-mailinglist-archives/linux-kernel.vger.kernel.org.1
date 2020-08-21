Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF6E24D785
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 16:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgHUOno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 10:43:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:52988 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgHUOnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 10:43:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 42071AC82;
        Fri, 21 Aug 2020 14:43:57 +0000 (UTC)
Date:   Fri, 21 Aug 2020 16:43:27 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     iommu@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [Regression] "iommu/amd: Relax locking in dma_ops path" makes
 tg3 ethernet transmit queue timeout
Message-ID: <20200821144327.GN3354@suse.de>
References: <4E9B03FB-9DA5-4831-B4CE-A0AA645D3F22@canonical.com>
 <20200518133209.GM8135@suse.de>
 <381D21C9-C913-4C33-A6F4-0440B5D11670@canonical.com>
 <8D375E06-A763-4B5E-9C6D-DA5EBC62530E@canonical.com>
 <CFC22DE4-E342-4F32-B758-6A690755C498@canonical.com>
 <20200821134300.GM3354@suse.de>
 <5D7A63DF-D360-4453-845C-924F4C13E3DB@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5D7A63DF-D360-4453-845C-924F4C13E3DB@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 09:50:33PM +0800, Kai-Heng Feng wrote:
> Of course, I still have the system at my side.
> 
> The offending commit is 92d420ec028d ("iommu/amd: Relax locking in
> dma_ops path"), however be62dbf554c5 ("iommu/amd: Convert AMD iommu
> driver to the dma-iommu api") removed .map_page entirely so I don't
> know where to start.

I guess you don't see any AMD-Vi page-faults reported in dmesg, right?
That makes things more difficult. As a first step, can you please send
me a complete dmesg after this happened? Also please boot with
amd_iommu_dump on the kernel command line.

Regards,

	Joerg
