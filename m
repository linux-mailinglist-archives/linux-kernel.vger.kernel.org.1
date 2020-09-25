Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128772783AA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 11:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgIYJMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 05:12:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbgIYJL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 05:11:59 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C315206B5;
        Fri, 25 Sep 2020 09:11:58 +0000 (UTC)
Date:   Fri, 25 Sep 2020 10:11:55 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Phil Chang <phil.chang@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        YJ Chiang <yj.chiang@mediatek.com>,
        Alix Wu <alix.wu@mediatek.com>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: Re: [PATCH] [PATCH] ARM64: Setup DMA32 zone size by bootargs
Message-ID: <20200925091154.GA4846@gaia>
References: <20200916133324.6280-1-phil.chang@mediatek.com>
 <20200924141514.23930-1-phil.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924141514.23930-1-phil.chang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 10:15:14PM +0800, Phil Chang wrote:
> Actually, In a embedded system with 3GB memory, the memory bus width is not the same among the 3GB.
> (The first 2GB is 48-bit wide, and the latter 1GB is 16-bit wide.)

So I guess that's the data bus width. Devices can still access the whole
memory, though at different throughputs.

Does this narrow data bus apply only to devices or the CPUs are affected
as well?

> For memory throughput reason of hardware IPs, we need allocate memory from the first 2GB for
> the hardware IPs. And that is why we setup the first 2GB as DMA_ZONE, and use GFP_DMA to allocate
> memory from the range.

If it's only a throughput problem, it looks to me more like a NUMA
configuration. I think you can add the first 2GB and the last GB in
separate nodes and define a "numa-node-id" property per device in DT.

-- 
Catalin
