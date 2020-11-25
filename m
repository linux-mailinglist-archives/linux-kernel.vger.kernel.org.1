Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83AC2C3F6A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 12:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgKYL5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 06:57:53 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:58197 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728948AbgKYL5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 06:57:52 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Cgzsk2GfRz9sVY; Wed, 25 Nov 2020 22:57:45 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Cc:     Rashmica Gupta <rashmica.g@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Mackerras <paulus@samba.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20201029162718.29910-1-david@redhat.com>
References: <20201029162718.29910-1-david@redhat.com>
Subject: Re: [PATCH v1 0/4] powernv/memtrace: don't abuse memory hot(un)plug infrastructure for memory allocations
Message-Id: <160630540200.2174375.9298673276341715348.b4-ty@ellerman.id.au>
Date:   Wed, 25 Nov 2020 22:57:45 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Oct 2020 17:27:14 +0100, David Hildenbrand wrote:
> powernv/memtrace is the only in-kernel user that rips out random memory
> it never added (doesn't own) in order to allocate memory without a
> linear mapping. Let's stop abusing memory hot(un)plug infrastructure for
> that - use alloc_contig_pages() for allocating memory and remove the
> linear mapping manually.
> 
> The original idea was discussed in:
>  https://lkml.kernel.org/r/48340e96-7e6b-736f-9e23-d3111b915b6e@redhat.com
> 
> [...]

Applied to powerpc/next.

[1/4] powerpc/mm: factor out creating/removing linear mapping
      https://git.kernel.org/powerpc/c/4abb1e5b63ac3281275315fc6b0cde0b9c2e2e42
[2/4] powerpc/mm: print warning in arch_remove_linear_mapping()
      https://git.kernel.org/powerpc/c/1f73ad3e8d755dbec52fcec98618a7ce4de12af2
[3/4] powerpc/mm: remove linear mapping if __add_pages() fails in arch_add_memory()
      https://git.kernel.org/powerpc/c/ca2c36cae9d48b180ea51259e35ab3d95d327df2
[4/4] powernv/memtrace: don't abuse memory hot(un)plug infrastructure for memory allocations
      https://git.kernel.org/powerpc/c/0bd4b96d99108b7ea9bac0573957483be7781d70

cheers
