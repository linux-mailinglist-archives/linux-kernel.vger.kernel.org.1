Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58DF2C3F71
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 12:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgKYL6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 06:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729105AbgKYL6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 06:58:12 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CC8C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 03:58:12 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Cgzsn1ZjRz9sSf; Wed, 25 Nov 2020 22:57:46 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Cc:     Rashmica Gupta <rashmica.g@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Mackerras <paulus@samba.org>,
        Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20201111145322.15793-1-david@redhat.com>
References: <20201111145322.15793-1-david@redhat.com>
Subject: Re: [PATCH v2 0/8] powernv/memtrace: don't abuse memory hot(un)plug infrastructure for memory allocations
Message-Id: <160630540587.2174375.206172001074703389.b4-ty@ellerman.id.au>
Date:   Wed, 25 Nov 2020 22:57:46 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Nov 2020 15:53:14 +0100, David Hildenbrand wrote:
> Based on latest linux/master
> 
> powernv/memtrace is the only in-kernel user that rips out random memory
> it never added (doesn't own) in order to allocate memory without a
> linear mapping. Let's stop abusing memory hot(un)plug infrastructure for
> that - use alloc_contig_pages() for allocating memory and remove the
> linear mapping manually.
> 
> [...]

Applied to powerpc/next.

[1/8] powerpc/powernv/memtrace: Don't leak kernel memory to user space
      https://git.kernel.org/powerpc/c/c74cf7a3d59a21b290fe0468f5b470d0b8ee37df
[2/8] powerpc/powernv/memtrace: Fix crashing the kernel when enabling concurrently
      https://git.kernel.org/powerpc/c/d6718941a2767fb383e105d257d2105fe4f15f0e
[3/8] powerpc/mm: factor out creating/removing linear mapping
      https://git.kernel.org/powerpc/c/4abb1e5b63ac3281275315fc6b0cde0b9c2e2e42
[4/8] powerpc/mm: protect linear mapping modifications by a mutex
      https://git.kernel.org/powerpc/c/e5b2af044f31bf18defa557a8cd11c23caefa34c
[5/8] powerpc/mm: print warning in arch_remove_linear_mapping()
      https://git.kernel.org/powerpc/c/1f73ad3e8d755dbec52fcec98618a7ce4de12af2
[6/8] powerpc/book3s64/hash: Drop WARN_ON in hash__remove_section_mapping()
      https://git.kernel.org/powerpc/c/d8bd9a121c2f2bc8b36da930dc91b69fd2a705e2
[7/8] powerpc/mm: remove linear mapping if __add_pages() fails in arch_add_memory()
      https://git.kernel.org/powerpc/c/ca2c36cae9d48b180ea51259e35ab3d95d327df2
[8/8] powernv/memtrace: don't abuse memory hot(un)plug infrastructure for memory allocations
      https://git.kernel.org/powerpc/c/0bd4b96d99108b7ea9bac0573957483be7781d70

cheers
