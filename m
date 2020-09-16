Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC57026C94E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgIPTGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:06:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbgIPRpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:45:42 -0400
Received: from gaia (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 902F222283;
        Wed, 16 Sep 2020 14:56:42 +0000 (UTC)
Date:   Wed, 16 Sep 2020 15:56:40 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Phil Chang <phil.chang@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        YJ Chiang <yj.chiang@mediatek.com>,
        Alix Wu <alix.wu@mediatek.com>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] [PATCH] ARM64: Setup DMA32 zone size by bootargs
Message-ID: <20200916145639.GC3122@gaia>
References: <20200916083703.GA26411@infradead.org>
 <20200916133324.6280-1-phil.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916133324.6280-1-phil.chang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 09:33:24PM +0800, Phil Chang wrote:
> this patch allowing the DMA32 zone be configurable in ARM64.
> For some devices, the main memory split into 2 part due to the memory
> architecture, the efficient and less inefficient part.
> One of the use case is fine-tune the dma32 size to contain all the
> efficient part of memory block on this kind of architecture
> 
> Signed-off-by: Alix Wu <alix.wu@mediatek.com>
> Signed-off-by: YJ Chiang <yj.chiang@mediatek.com>
> Signed-off-by: Phil Chang <phil.chang@mediatek.com>
> ---
> Hi
> 
> supplement the reason of this usage.

That's really not a good enough justification to merge such patch. As
Christoph said, DMA32 is defined as addressing the first 4GB of RAM.

Is the memory inefficient (presumably slow) for device or for the CPU?
Maybe you can pretend it's a separate NUMA node for the CPU.
Alternatively, change your device DMA coherent mask and allocate only
from ZONE_DMA (currently first 1GB on arm64).

-- 
Catalin
