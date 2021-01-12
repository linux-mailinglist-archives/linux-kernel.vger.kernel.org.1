Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D372F28E7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 08:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391988AbhALH1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 02:27:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:60134 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391947AbhALH1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 02:27:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D95D2AC95;
        Tue, 12 Jan 2021 07:26:49 +0000 (UTC)
Date:   Tue, 12 Jan 2021 08:26:47 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
        pasha.tatashin@soleen.com
Subject: Re: [PATCH 1/5] mm: Introduce ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
Message-ID: <20210112072643.GA10774@linux>
References: <20201217130758.11565-1-osalvador@suse.de>
 <20201217130758.11565-2-osalvador@suse.de>
 <21932014-3027-8ad9-2140-f63500c641d7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21932014-3027-8ad9-2140-f63500c641d7@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 05:52:19PM +0100, David Hildenbrand wrote:
> On 17.12.20 14:07, Oscar Salvador wrote:
> > In order to use self-hosted memmap array, the platform needs to have
> > support for CONFIG_SPARSEMEM_VMEMMAP and altmap.
> > Currently, only arm64, PPC and x86_64 have the support, so enable those
> > platforms with ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE.
> 
> "In the first version, only .... will support it".

I will try to be more specific.

> 
> I'd probably split off enabling it per architecture in separate patches
> and the end of the series.

You mean introducing only mm/Kconfig change in this patch, and then
arch/*/Kconfig changes in separate patches at the end of the series?

I can certainly do that, not sure how much will help with the review,
but it might help when bisecting.

> Apart from that looks good.

Thanks for taking a look David!


-- 
Oscar Salvador
SUSE L3
