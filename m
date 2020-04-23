Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA25B1B53F8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 07:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgDWFLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 01:11:08 -0400
Received: from foss.arm.com ([217.140.110.172]:60418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbgDWFLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 01:11:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42B421FB;
        Wed, 22 Apr 2020 22:11:07 -0700 (PDT)
Received: from [10.163.1.9] (unknown [10.163.1.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60FD33F6CF;
        Wed, 22 Apr 2020 22:10:56 -0700 (PDT)
Subject: Re: [PATCH V3 0/3] arm64: Enable vmemmap mapping from device memory
To:     linux-mm@kvack.org
Cc:     robin.murphy@arm.com, dan.j.williams@intel.com, jglisse@redhat.com,
        jgg@mellanox.com, rcampbell@nvidia.com, aneesh.kumar@linux.ibm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1585631387-18819-1-git-send-email-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <ff29a6a3-a75d-878d-75a0-2c458be429f4@arm.com>
Date:   Thu, 23 Apr 2020 10:40:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1585631387-18819-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/31/2020 10:39 AM, Anshuman Khandual wrote:
> This series enables vmemmap backing memory allocation from device memory
> ranges on arm64. But before that, it enables vmemmap_populate_basepages()
> and vmemmap_alloc_block_buf() to accommodate struct vmem_altmap based
> alocation requests.
> 
> This series applies after latest (v14) arm64 memory hot remove series
> (https://lkml.org/lkml/2020/3/3/1746) on Linux 5.6.
> 
> Pending Question:
> 
> altmap_alloc_block_buf() does not have any other remaining users in the
> tree after this change. Should it be converted into a static function and
> it's declaration be dropped from the header (include/linux/mm.h). Avoided
> doing so because I was not sure if there are any off-tree users or not.
> 
> Changes in V3:
> 
> - Dropped comment from free_hotplug_page_range() per Robin
> - Modified comment in unmap_hotplug_range() per Robin
> - Enabled altmap support in vmemmap_alloc_block_buf() per Robin

Just a gentle ping. Any updates on this series ? In particular, is there
any comments or suggestions or concerns with respect to the first two
patches here that change the core MM and relevant call sites on some
platforms. Thank you.

- Anshuman
