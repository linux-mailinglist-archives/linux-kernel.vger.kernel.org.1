Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB0E2F46F6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbhAMI5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:57:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:48696 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbhAMI5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:57:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1F116AA6F;
        Wed, 13 Jan 2021 08:56:52 +0000 (UTC)
Date:   Wed, 13 Jan 2021 09:56:49 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v3 1/2] x86/setup: don't remove E820_TYPE_RAM for pfn 0
Message-ID: <20210113085644.GA24816@linux>
References: <20210111194017.22696-1-rppt@kernel.org>
 <20210111194017.22696-2-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111194017.22696-2-rppt@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 09:40:16PM +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The first 4Kb of memory is a BIOS owned area and to avoid its allocation
> for the kernel it was not listed in e820 tables as memory. As the result,
> pfn 0 was never recognised by the generic memory management and it is not a
> part of neither node 0 nor ZONE_DMA.

So, since it never was added to memblock.memory structs, it was not
initialized by init_unavailable_mem, right?

-- 
Oscar Salvador
SUSE L3
